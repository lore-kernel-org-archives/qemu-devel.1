Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB06C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AB220658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AB220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfNz-0005ru-Mv
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jvfNL-0005L6-4t
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:14:59 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:45588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jvfNJ-0003FB-4r
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:14:58 -0400
Received: from player690.ha.ovh.net (unknown [10.108.35.232])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 04DD598AE6
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 13:14:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 1EF89143C8C84;
 Wed, 15 Jul 2020 11:14:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006291ada97-3e5f-48d6-9e92-59fa6296690f,D756FEFB7EDC1B892B7A3E282F77C60775DBB805)
 smtp.auth=groug@kaod.org
Date: Wed, 15 Jul 2020 13:14:42 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200715131442.2ab70206@bahia.lan>
In-Reply-To: <20200713045330.GK2666@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
 <20200613071804.GE5861@umbus.fritz.box>
 <20200615112031.679512c3@bahia.lan>
 <20200703161924.7131e87f@bahia.lan>
 <20200713045330.GK2666@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IemqJ0HIXiPT4CyeEbOCmij";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 16513573936932297190
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfedvgdegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.251.173; envelope-from=groug@kaod.org;
 helo=1.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 07:14:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/IemqJ0HIXiPT4CyeEbOCmij
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jul 2020 14:53:30 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jul 03, 2020 at 04:19:24PM +0200, Greg Kurz wrote:
> > On Mon, 15 Jun 2020 11:20:31 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Sat, 13 Jun 2020 17:18:04 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> > > > > Nested KVM-HV only works on POWER9.
> > > > >=20
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > > >=20
> > > > Hrm.  I have mixed feelings about this.  It does bring forward an
> > > > error that we'd otherwise only discover when we try to load the kvm
> > > > module in the guest.
> > > >=20
> > > > On the other hand, it's kind of a layering violation - really it's
> > > > KVM's business to report what it can and can't do, rather than havi=
ng
> > > > qemu anticipate it.
> > > >=20
> > >=20
> > > Agreed and it seems that we can probably get KVM to report that
> > > already. I'll have closer look.
> > >=20
> >=20
> > Checking the KVM_CAP_PPC_NESTED_HV extension only reports what the host
> > supports. It can't reasonably take into account that we're going to
> > switch vCPUs in some compat mode later on. KVM could possibly check
> > that it has a vCPU in pre-power9 compat mode when we try to enable
> > the capability and fail... but it would be a layering violation all
> > the same. The KVM that doesn't like pre-power9 CPUs isn't the one in
> > the host, it is the one in the guest, and it's not even directly
> > related to the CPU type but to the MMU mode currently in use:
> >=20
> > long kvmhv_nested_init(void)
> > {
> > 	long int ptb_order;
> > 	unsigned long ptcr;
> > 	long rc;
> >=20
> > 	if (!kvmhv_on_pseries())
> > 		return 0;
> > =3D=3D>	if (!radix_enabled())
> > 		return -ENODEV;
> >=20
> > We cannot know either for sure the MMU mode the guest will run in
> > when we enable the nested cap during the initial machine reset.
> > So it seems we cannot do anything better than denylisting well
> > known broken setups, in which case QEMU seems a better fit than
> > KVM.
> >=20
> > Makes sense ?
>=20
> Yeah, good points.
>=20

So, should I just rebase/repost this or do you think of another
way ?

--Sig_/IemqJ0HIXiPT4CyeEbOCmij
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8O5SIACgkQcdTV5YIv
c9Z2sA/9GHLgpnlHH/KjX6VLmbZ+ziFUxyW5zg08BddJNxnxZFArgZALnk3B0NJB
egbgxpbYOy3INaeYtgtZxvKbwbjKD9NHLSZVMxQuAmP1DBKUBJ40tQEoy+4m6OpY
6jLlWyfciSPi+ZGalTkpsKv27SzCqSNjFwWXiuKdfqvVORX4MGD4FRjZhwDmKdtn
I+sZ7uZEwy87piTBRoDqJwqCzKa/HbIdeuac5jPzHv0ga0SdGOGf4AZjLwu4jQv5
dMIdsdwLdb1QTs9Y6VTSD+UC2+mZsddyN6JX/TY5R2bh2nUKKXKymMqtDlWCaOB5
vhpP8956cU0YUnjth6SOF8beva9SfpPQSTOeBNi7zZdBoKT+vlkOirfNJQEKIc7/
4nODrBoxfAAELYAmK1Yps34bhQiXRsnBrRLrEKZNLqRSbm57XC87Kes2LgB7t98z
KiXur96yf6uCvMVUALvO0zGkNZN5BiQl89WijEC9B9+IrHjj4fk0ojuMsnI+1Rxt
S0cjL6cL9B/qoP5N7IEEGXt3mxVjKi69UbGJzlZzMjMXNr1He5IVJS5Ne/b5SGxm
dGE5UiDkMIFY3y8O1APdLS7E0uTbUr3CxW6Yz2Lh0k3UA4trfmLQsAS1gjpRJbi6
JzfP6RIkAnL/UYIQ9UP57XkiaCpssyJIyrUtXmGbssO32apj82Y=
=/PgY
-----END PGP SIGNATURE-----

--Sig_/IemqJ0HIXiPT4CyeEbOCmij--


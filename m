Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6173CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1EE206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1EE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklJN-0004cK-EP
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jklIL-0003Id-MN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:20:45 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:52956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jklIJ-0002WI-Eh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:20:45 -0400
Received: from player735.ha.ovh.net (unknown [10.110.115.178])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id BCEB61383D0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:20:39 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 5BDE61322C2EB;
 Mon, 15 Jun 2020 09:20:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00314af2b3d-e0f8-42ef-981f-506da9b1af67,F1BB0E26B38E3581C3F8E07DA172D6E56B46BED4)
 smtp.auth=groug@kaod.org
Date: Mon, 15 Jun 2020 11:20:31 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200615112031.679512c3@bahia.lan>
In-Reply-To: <20200613071804.GE5861@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
 <20200613071804.GE5861@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bhc.XnphqwxV_EGbMcqL.6o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4424505161592510950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeggfekuddvuddtgfekkeejleegjeffheduuefhledtteeftdfhffdtgfegiefhvdenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.51.249; envelope-from=groug@kaod.org;
 helo=6.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:20:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/bhc.XnphqwxV_EGbMcqL.6o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jun 2020 17:18:04 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> > Nested KVM-HV only works on POWER9.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Hrm.  I have mixed feelings about this.  It does bring forward an
> error that we'd otherwise only discover when we try to load the kvm
> module in the guest.
>=20
> On the other hand, it's kind of a layering violation - really it's
> KVM's business to report what it can and can't do, rather than having
> qemu anticipate it.
>=20

Agreed and it seems that we can probably get KVM to report that
already. I'll have closer look.

> Allowing POWER8 compat for an L2 is something we hope to have in the
> fairly near future.

Ok but I guess we don't want to start an L2 in compat POWER8 mode
with cap-nested-hv=3Don, do we ?

>  Allowing POWER8 compat for L1, which is what this
> covers, is, I'll admit, likely to never happen.
>=20
>=20
> > ---
> >  HW/ppc/spapr_caps.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 27cf2b38af27..dfe3b419daaa 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -391,6 +391,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSta=
te *spapr,
> >                                      uint8_t val, Error **errp)
> >  {
> >      ERRP_AUTO_PROPAGATE();
> > +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > +
> >      if (!val) {
> >          /* capability disabled by default */
> >          return;
> > @@ -400,6 +402,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineSt=
ate *spapr,
> >          error_setg(errp, "No Nested KVM-HV support in TCG");
> >          error_append_hint(errp, "Try appending -machine cap-nested-hv=
=3Doff\n");
> >      } else if (kvm_enabled()) {
> > +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> > +                              spapr->max_compat_pvr)) {
> > +            error_setg(errp, "Nested KVM-HV only supported on POWER9");
> > +            error_append_hint(errp,
> > +                              "Try appending -machine max-cpu-compat=
=3Dpower9\n");
> > +            return;
> > +        }
> > +
> >          if (!kvmppc_has_cap_nested_kvm_hv()) {
> >              error_setg(errp,
> >                         "KVM implementation does not support Nested KVM=
-HV");
> >=20
> >=20
>=20


--Sig_/bhc.XnphqwxV_EGbMcqL.6o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl7nPV8ACgkQcdTV5YIv
c9b9zA/+IMyWq7i/6dGh1rrB43Id9XOymPMSQrEWyPcajQgeo1arruBMbHZTcj3T
J1z+3oE7eYtuQ0nnOlHIA+g+xJ5NqyyJjM95yg3Lfw3cxLupWBmTzFixfcTmtR+F
ZvCUM0sbASJbUNw70YhSwwC+ZRsDwBiYhKuswpVZC27eCceQXnBkMGpdVsCYPMkI
l3bfGbpk1fK4uhy09YJnNS4hcHiRM/5d1PYsGlEbksaxu6fGHz8EIkuySPU4p/DP
kLvzA3fAHSQy9E4YPmFnWwu+QEj9TMcUUw4tWaFOYR44OFuQx3xZNQqaNVTeLFpt
Hv97DKrlwu2+cFCK7Z8M31YHtZ7vATuz8v+fv6HDq5wVVAfNFkQgs4fGMHIX+peD
4CJH72lnd7MINZNMED0qlk+e/wmtFk9hjPKHnzruX4heX0BHeMLKZEW2DU1OlrvB
mJulpNheKoRxmTxS0F0+Bbm4S0hULeyWhBCK7a3hGDDKRHLDQ6DSMxEU8BEhmjCM
NVnz4uT7cAJLQjVciq5ty9w40l+c4rQ7lUr0tMGh0u6qcVVNCXUQRLoLOk8FyxWc
E1SwM1b7bK5Q0aeXLNJY8k/84rNZkQxWesDqrWflGZw3xcIbVdNVYPKFfkO74QpE
+UWGwui6gnXbsBN7ngWsiRVoi6hJma7GPz3Zo3odcR9x0r1R284=
=sgJO
-----END PGP SIGNATURE-----

--Sig_/bhc.XnphqwxV_EGbMcqL.6o--


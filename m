Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD8C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 10:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BB220936
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 10:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB220936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWd3k-0000LT-VD
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 06:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kWd2D-0008AE-Al; Sun, 25 Oct 2020 06:13:57 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:59065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kWd2A-00050n-RZ; Sun, 25 Oct 2020 06:13:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.136])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 8E3E96EC7C21;
 Sun, 25 Oct 2020 11:13:43 +0100 (CET)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 25 Oct
 2020 11:13:42 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0057ec7792b-6544-4a9e-b9c0-81726e8c62c4,
 5F9C93A9F3AD2D257DE4C2DCE7DBF4E7A6D9743C) smtp.auth=groug@kaod.org
Date: Sun, 25 Oct 2020 11:13:40 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/5] spapr: Error handling fixes and cleanups (round 3)
Message-ID: <20201025111340.48e2a40c@bahia.lan>
In-Reply-To: <20201022041142.GG1821515@yekko.fritz.box>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <20201022041142.GG1821515@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hJGAiGihyLNCxdRq6Cc.Cso";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ec4d4d28-11b7-400c-b27d-a5be8fb11b55
X-Ovh-Tracer-Id: 5752785578270890488
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeeggddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtghisehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuieeujeehheeuiefhleetueeiudevgfdutdejveeifffffeegtdekheehledtvdenucffohhmrghinhepghhnuhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 06:13:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/hJGAiGihyLNCxdRq6Cc.Cso
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2020 15:11:42 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Oct 19, 2020 at 10:47:52AM +0200, Greg Kurz wrote:
> > Hi,
> >=20
> > This is a followup to a previous cleanup for the sPAPR code:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04860.html
> >=20
> > The last two patches had to be dropped because they were wrongly assumi=
ng
> > that object_property_get_uint() returning zero meant failure. This led =
to
> > a discussion in which arose a consensus that most of the time (not to s=
ay
> > always) object property getters should never fail actually, ie. failure
> > is very likely the result of a programming error and QEMU should abort.
> >=20
> > This series aims at demonstrating a revelant case I've found while audi=
ting
> > object property getters (this is patch 4 that I've isolated from a huge
> > 50-patch series I haven't dared to post yet). The sPAPR memory hotplug =
code
> > is tailored to support either regular PC DIMMs or NVDIMMs, which inherit
> > from PC DIMMs. They expect to get some properties from the DIMM object,
> > which happens to be set by default at the PC DIMM class level. It thus
> > doesn't make sense to pass an error object and propagate it when getting
> > them since this would lure the user into thinking they did something wr=
ong.
> >=20
> > Some preliminary cleanup is done on the way, especially dropping an unu=
sed
> > @errp argument of pc_dimm_plug(). This affects several platforms other =
than
> > sPAPR but I guess the patch is trivial enough to go through David's tree
> > if it gets acks from the relevant maintainers.
>=20
> Since this series mostly affects ppc, I've applied it to ppc-for-5.2.
>=20
> It would be nice to have an acked-by from Igor or Michael for the
> first patch, though.
>=20

David,

Igor sent a R-b for patches 1 and 4. He also suggested to call
spapr_drc_attach() at pre-plug time. I'll look into this, so maybe
you can drop patch 5 from ppc-for-5.2 (or the entire series at
your convenience).

Cheers,

--
Greg

> >=20
> > ---
> >=20
> > Greg Kurz (5):
> >       pc-dimm: Drop @errp argument of pc_dimm_plug()
> >       spapr: Use appropriate getter for PC_DIMM_ADDR_PROP
> >       spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
> >       spapr: Pass &error_abort when getting some PC DIMM properties
> >       spapr: Simplify error handling in spapr_memory_plug()
> >=20
> >=20
> >  hw/arm/virt.c                 |    9 +-------
> >  hw/i386/pc.c                  |    8 +------
> >  hw/mem/pc-dimm.c              |    2 +-
> >  hw/ppc/spapr.c                |   48 +++++++++++++++------------------=
--------
> >  hw/ppc/spapr_nvdimm.c         |    5 +++-
> >  include/hw/mem/pc-dimm.h      |    2 +-
> >  include/hw/ppc/spapr_nvdimm.h |    2 +-
> >  7 files changed, 25 insertions(+), 51 deletions(-)
> >=20
>=20


--Sig_/hJGAiGihyLNCxdRq6Cc.Cso
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl+VT9UACgkQcdTV5YIv
c9Yd8A/+JLmBLZJ+6vTgkuguSc2hW21KYilCmaTiU+4LKh2z+PwP7MMkR0r/3+5s
nrKJbw5WCo/NfSnz4dMf0nR69fO/UvLdd/4jaJN/aMo0mcA0wlTTah8grzBUawdl
mQkBT2qF0Y7Vi9gGFMO1jIF7kHCdl8qX469po6gcfbo01aGj3wkp2kSediImUBqk
YfCwfI0lL5hjUdJeOEmvS53QwS7gvinbMcvWCRiPxtG/y5pVOlHbzjzA6Pd5ntlI
3o5327w+py3IdPmS4+RJW4n5ON5F5lsajX1ODNQELDa1V13qBcUYo15HOSt5aVO3
dUIRSHtpQGXzrYROG65KULSHsUcjZqJJb01FGj5MW8sLSXQHz2+tcbKrS9igX37X
+xyViPccFCyPukf0ZiTCb/hTH2qiotWjecrkt1zLmb8jE+eOQz3YNAfVW7eGQ4gi
sFsj8gA9bMn/c8JDPJjtEGLfuHfK7hPTKJfNmdHvSfWH+ZyTg13BtE3xAiGQ3gEd
g/gOVVvJvcBis2CFwuWXIGXt9ePdck5oEPtilFykeap7rtN0xb4zXZRKtmO/6sRn
voG7vDBK+KJ/n6EwvVOaynQuX8VAnjQJ6Rlun7qm5LhEZhLIRFu4WRcetO8mR69d
9Gkmz2CKX+n9y9Yz/lrCkD6ZLvM1R/D77n1uxfYdMcWo33Vmdro=
=VgW+
-----END PGP SIGNATURE-----

--Sig_/hJGAiGihyLNCxdRq6Cc.Cso--


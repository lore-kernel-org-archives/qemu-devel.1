Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7046521D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7046521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDV1J-0002tI-JU
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDV0L-000273-Vu
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDV0K-0000bX-P2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:44:25 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:51312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDV0K-0000Zo-KR
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:44:24 -0400
Received: from player711.ha.ovh.net (unknown [10.108.42.23])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id AC7C9226E1F
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 16:44:20 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 5F5F9A2E053F;
 Thu, 26 Sep 2019 14:44:09 +0000 (UTC)
Date: Thu, 26 Sep 2019 16:44:08 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 11/20] spapr: Fix indexing of XICS irqs
Message-ID: <20190926164408.171c1cb8@bahia.lan>
In-Reply-To: <20190926113218.GZ17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-12-david@gibson.dropbear.id.au>
 <20190925221746.7b497c8c@bahia.lan> <20190926013148.GU17405@umbus>
 <20190926092141.66158590@bahia.lan> <20190926113218.GZ17405@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bA.OK2PQpDMAt/NkjPgD7K1"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 14899033468854311398
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.36
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/bA.OK2PQpDMAt/NkjPgD7K1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2019 21:32:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 26, 2019 at 09:21:41AM +0200, Greg Kurz wrote:
> > On Thu, 26 Sep 2019 11:31:48 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Wed, Sep 25, 2019 at 10:17:46PM +0200, Greg Kurz wrote:
> > > > On Wed, 25 Sep 2019 16:45:25 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > spapr global irq numbers are different from the source numbers on=
 the ICS
> > > > > when using XICS - they're offset by XICS_IRQ_BASE (0x1000).  But
> > > > > spapr_irq_set_irq_xics() was passing through the global irq numbe=
r to
> > > > > the ICS code unmodified.
> > > > >=20
> > > > > We only got away with this because of a counteracting bug - we we=
re
> > > > > incorrectly adjusting the qemu_irq we returned for a requested gl=
obal irq
> > > > > number.
> > > > >=20
> > > > > That approach mostly worked but is very confusing, incorrectly re=
lies on
> > > > > the way the qemu_irq array is allocated, and undermines the inten=
tion of
> > > > > having the global array of qemu_irqs for spapr have a consistent =
meaning
> > > > > regardless of irq backend.
> > > > >=20
> > > > > So, fix both set_irq and qemu_irq indexing.  We rename some param=
eters at
> > > > > the same time to make it clear that they are referring to spapr g=
lobal
> > > > > irq numbers.
> > > > >=20
> > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > ---
> > > >=20
> > > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > >=20
> > > > Further cleanup could be to have the XICS backend to only take glob=
al
> > > > irq numbers and to convert them to ICS source numbers internally. T=
his
> > > > would put an end to the confusion between srcno/irq in the frontend
> > > > code.
> > >=20
> > > Yeah, maybe.  But the local srcnos do actually make sense from within
> > > the perspective of ICS, so I'm not all that keen to do that.
> > >=20
> >=20
> > Not sure to understand what you mean by "within the perspective of ICS".
> >=20
> > My concern is actually to get rid of ics->offset users in spapr_irq.c.
> >=20
> > eg,
> >=20
> > static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> > {
> >     SpaprMachineState *spapr =3D opaque;
> >     uint32_t srcno =3D irq - spapr->ics->offset;
> >=20
> >     ics_set_irq(spapr->ics, srcno, val);
> > }
> >=20
> > It looks like we should do something like:
> >=20
> > static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> > {
> >     SpaprMachineState *spapr =3D opaque;
> >=20
> >     ics_set_irq(spapr->ics, irq, val);
> > }
> >=20
> > and have ics_set_irq() do:
> >=20
> >     uint32_t srcno =3D irq - spapr->ics->offset;
> >=20
> > Are you inferring that it is better to keep the irq to srcno conversions
> > in spapr_irq.c ?
>=20
> Ah, I see what you mean.  So, the reason srcno appears here is that
> ics_set_irq() is arguably an internal xics function that we shouldn't
> be calling directly from here, but do because of.. reasons.
>=20
> As it happens, I have another patch in the works which will move this
> function back into xics_spapr.c and bind it more tightly to the xics
> code, so I think that will address your concern.
>=20

Great ! :)

--Sig_/bA.OK2PQpDMAt/NkjPgD7K1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2MzrgACgkQcdTV5YIv
c9Zwog//e90rPRAnyS2+lRZpQt7DO2N2ASshxoNFmcuH8CcRh2hrr8HUUBt1UcFR
OWRq+gHk3KKzgI1qyisywHj3tyx+p6mX9g3lZHeoMHoTKleb8qJkiRvu2MOlSSnW
l11nXeb+kWqsoFPDKs/gV8v4rFh1NYS0kVD6pwITHVfxeaNh/atM8RYGviC+XeGy
i1FmTQsV1jLLYx8V2vnPbAVsrjwNSHbFsn3bCpqHW03qm4OWIrrdjT8rdkXy6GGU
kqQLVh40ePEd5ytleLdiLIIWPWYjKnlb1dD8ZVhQbxOXnaZJMqnA3aMR4Kn3sXBF
Qq38UYizF+E8QrNKQUz2s+XmmnFC3LKGbBldcImUi8mqUtulV+i5ZiPUOJ1ibLN7
9D0T3jXE6aFq8+5z9DHDfhzMFjWCojqSpCdWiqtUD5TELACBAUczOb1l59Jk3UKv
IhKg/WHEovRNBhyWDBiKB0miSmNgfzpnKWVrjEZNdsdI/Xu7vOnq4qz7hpccA/hn
zVwlJJ4f6F626EjoRehhtqQC7psByP5d51m4TINmluoQGAFpKyv6fHxAAPdMEC/U
J6ZXPtkfkQNJyH3dDqsPG0zOr40d7vC6xtXZYgA+/T/+3q6HOuOA8L8OhLm82/yK
u7/ogxKcb5wHFCBvB+GIIW9UuHNzHq80MtExDN2Expj/GR0E0q8=
=MmEd
-----END PGP SIGNATURE-----

--Sig_/bA.OK2PQpDMAt/NkjPgD7K1--


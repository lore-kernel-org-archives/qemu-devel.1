Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38271C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D63C20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D63C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip954-00015j-9A
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ip93B-0007PU-Qc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ip93A-00036H-6c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:57 -0500
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:55550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ip93A-00034g-16
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:56 -0500
Received: from player756.ha.ovh.net (unknown [10.108.1.15])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2807221E6B2
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 11:58:52 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id CF5D1D25DB30;
 Wed,  8 Jan 2020 10:58:47 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:58:45 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
Message-ID: <20200108115845.07f10453@bahia.lan>
In-Reply-To: <20200108005453.GD2137@umbus.fritz.box>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
 <56272b35-c0ed-65de-310d-f97090e2b8c1@redhat.com>
 <20200108005453.GD2137@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m_bNAq+yORr91jmtoCPXLO/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 13108852616960776678
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehkedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.8
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/m_bNAq+yORr91jmtoCPXLO/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2020 11:54:53 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jan 07, 2020 at 07:32:03PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Greg,
> >=20
> > On 1/7/20 5:32 PM, Greg Kurz wrote:
> > > The proper way to do that would be to use device_class_set_parent_rea=
lize(),
> > > but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_re=
alize
> > > pointer adds a fair amount of code. Calling pnv_psi_realize() explici=
tely
> > > is fine for now.
> > >=20
> > > This should probably be achieved with a device realize hook in the
> > > PSI base class and device_class_set_parent_realize() in the children
> > > classes.
> >=20

I realize that this last paragraph is a leftover. First paragraph already
mentions device_class_set_parent_realize() as being the "proper way".

David,

Can you remove it in your tree ? No big deal if you can't.

> > Can you add a note explaining why the POWER10 PSI doesn't need it?
>=20
> For now, POWER10 uses the Pnv9PsiClass, I believe, so the question
> doesn't arise.
>=20

This is correct and also a bit confusing, as proves Philippe's remark.
Maybe we should come up with a PnvXivePsiClass and specialize it for
POWER9 and POWER10.

> >=20
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > ---
> > >   hw/ppc/pnv_psi.c |   19 ++++++++++++-------
> > >   1 file changed, 12 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > > index 6c94781e377d..546232106756 100644
> > > --- a/hw/ppc/pnv_psi.c
> > > +++ b/hw/ppc/pnv_psi.c
> > > @@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
> > >       device_reset(DEVICE(dev));
> > >   }
> > > +static void pnv_psi_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    PnvPsi *psi =3D PNV_PSI(dev);
> > > +
> > > +    /* Default BAR for MMIO region */
> > > +    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > > +
> > > +    qemu_register_reset(pnv_psi_reset_handler, dev);
> > > +}
> > > +
> > >   static void pnv_psi_power8_instance_init(Object *obj)
> > >   {
> > >       Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> > > @@ -528,9 +538,6 @@ static void pnv_psi_power8_realize(DeviceState *d=
ev, Error **errp)
> > >       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops=
, psi,
> > >                             "psihb", PNV_PSIHB_SIZE);
> > > -    /* Default BAR for MMIO region */
> > > -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > > -
> > >       /* Default sources in XIVR */
> > >       for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
> > >           uint8_t xivr =3D irq_to_xivr[i];
> > > @@ -538,7 +545,7 @@ static void pnv_psi_power8_realize(DeviceState *d=
ev, Error **errp)
> > >               ((uint64_t) i << PSIHB_XIVR_SRC_SH);
> > >       }
> > > -    qemu_register_reset(pnv_psi_reset_handler, dev);
> > > +    pnv_psi_realize(dev, errp);
> > >   }
> > >   static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int =
xscom_offset)
> > > @@ -873,9 +880,7 @@ static void pnv_psi_power9_realize(DeviceState *d=
ev, Error **errp)
> > >       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_m=
mio_ops, psi,
> > >                             "psihb", PNV9_PSIHB_SIZE);
> > > -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > > -
> > > -    qemu_register_reset(pnv_psi_reset_handler, dev);
> > > +    pnv_psi_realize(dev, errp);
> > >   }
> > >   static void pnv_psi_power9_class_init(ObjectClass *klass, void *dat=
a)
> > >=20
> > >=20
> >=20
>=20


--Sig_/m_bNAq+yORr91jmtoCPXLO/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4VteUACgkQcdTV5YIv
c9Yc+w//bIePbGHNqJO4SA9XCp+hQ5ojh4GnSfuFWdjZwmUfIpCV63ntmdhhfUiB
s5QG2cMrnHhoVHkJ3p0dRG3rt+aYiyaZp57CGJjeoRTypDUWgg+zkS0T7+p8b6tx
n2nbgcO50h7tjkYRfe4cNyM/vl+kPqhixucZ35VeB5RzzDP6KQgpnRAC6/sEmaVA
BKxcGoaI4+Py9PZGF9shqVCwrIYVMsPKZVEwUGR7qS2RLCbBsxvI2CnyFb3jhmH0
o+1+wPWCX7azHWZV1mx7JvTy6drEY2wFunVycREXk0z84gPU9v53urSMtWfzTANx
Wm8PZSkwQtevX5Txhqnx5WH0pJDRrkr7/h0g7xcbPq6/CpfUMj/SlImX3yxcbV3i
cJgalt2pQTTTzkTOHvukLZmfRAuQy5Ccvv0XxXmZQauMgrhnRH+oswa5WUSG/Y7h
C7pnuzR6EvYNhPzYllqZLnGJa827pkdaqZcjxTYNnP7h7MRlbcfElsfRZXR9V/Hc
5VtTnc9ac/2SnvTETsyZRIyFupFo8JXlbC017zODt6wbLNEd4qgFEVbhbNY+kqG/
wnJwyWSz8u3BnIDnAT9/wBwn4XQ+zVdIPJIziKnhIN3UdQKC6jLiZxMoNGLt1K96
FbtYERMQUR84JllSjqthknsvc79JlvIEAXRXxD807Vw+M9C/Svw=
=BsGG
-----END PGP SIGNATURE-----

--Sig_/m_bNAq+yORr91jmtoCPXLO/--


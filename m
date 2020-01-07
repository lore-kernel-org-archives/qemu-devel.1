Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE3C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA162081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA162081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolYI-00026K-Uj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iojnd-00072S-CW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iojnb-0001B2-0N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:01:13 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:37252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iojnH-0000sX-Hj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:01:10 -0500
Received: from player695.ha.ovh.net (unknown [10.108.35.122])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8F72112B719
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 09:00:49 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id B88D8DCD3D02;
 Tue,  7 Jan 2020 08:00:44 +0000 (UTC)
Date: Tue, 7 Jan 2020 09:00:42 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 11/12] pnv/psi: Add device reset hook
Message-ID: <20200107090042.225b45d7@bahia.lan>
In-Reply-To: <20200107002344.GG2098@umbus>
References: <20200106145645.4539-1-clg@kaod.org>
 <20200106145645.4539-12-clg@kaod.org> <20200107002344.GG2098@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cRKfVwwo1mjXDKHgTkaVmyw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4229161528811690470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.219
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/cRKfVwwo1mjXDKHgTkaVmyw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2020 11:23:44 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jan 06, 2020 at 03:56:44PM +0100, C=C3=A9dric Le Goater wrote:
> > From: Greg Kurz <groug@kaod.org>
> >=20
> > And call it from a QEMU reset handler. This allows each PNV child class=
 to
> > override the reset hook if needed, eg. POWER8 doesn't but POWER9 does.
> > The proper way to do that would be to use device_class_set_parent_reset=
(),
> > but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_reset
> > pointer adds a fair amount of code. Calling pnv_psi_reset() explicitely=
 is
> > fine for now.
> >=20
> > A subsequent patch will consolidate the call to qemu_register_reset() in
> > a single place.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/pnv_psi.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > index 4da3d2568624..cf21e42d93b7 100644
> > --- a/hw/ppc/pnv_psi.c
> > +++ b/hw/ppc/pnv_psi.c
> > @@ -455,7 +455,7 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
> >      }
> >  };
> > =20
> > -static void pnv_psi_reset(void *dev)
> > +static void pnv_psi_reset(DeviceState *dev)
> >  {
> >      PnvPsi *psi =3D PNV_PSI(dev);
> > =20
> > @@ -464,6 +464,13 @@ static void pnv_psi_reset(void *dev)
> >      psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
> >  }
> > =20
> > +static void pnv_psi_reset_handler(void *dev)
> > +{
> > +    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> > +
> > +    dc->reset(DEVICE(dev));
>=20
> I think it would be better to use device_reset() here rather than
> explicitly accessing the dc->reset pointer yourself.
>=20

Of course ! Not sure why I didn't do that...

> > +}
> > +
> >  static void pnv_psi_power8_instance_init(Object *obj)
> >  {
> >      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> > @@ -526,7 +533,7 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
> >              ((uint64_t) i << PSIHB_XIVR_SRC_SH);
> >      }
> > =20
> > -    qemu_register_reset(pnv_psi_reset, dev);
> > +    qemu_register_reset(pnv_psi_reset_handler, dev);
> >  }
> > =20
> >  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xsc=
om_offset)
> > @@ -809,7 +816,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int=
 irq, bool state)
> >      qemu_set_irq(psi->qirqs[irq], state);
> >  }
> > =20
> > -static void pnv_psi_power9_reset(void *dev)
> > +static void pnv_psi_power9_reset(DeviceState *dev)
> >  {
> >      Pnv9Psi *psi =3D PNV9_PSI(dev);
> > =20
> > @@ -863,7 +870,7 @@ static void pnv_psi_power9_realize(DeviceState *dev=
, Error **errp)
> > =20
> >      pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> > =20
> > -    qemu_register_reset(pnv_psi_power9_reset, dev);
> > +    qemu_register_reset(pnv_psi_reset_handler, dev);
> >  }
> > =20
> >  static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
> > @@ -875,6 +882,7 @@ static void pnv_psi_power9_class_init(ObjectClass *=
klass, void *data)
> > =20
> >      dc->desc    =3D "PowerNV PSI Controller POWER9";
> >      dc->realize =3D pnv_psi_power9_realize;
> > +    dc->reset   =3D pnv_psi_power9_reset;
> > =20
> >      ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
> >      ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
> > @@ -927,6 +935,7 @@ static void pnv_psi_class_init(ObjectClass *klass, =
void *data)
> > =20
> >      dc->desc =3D "PowerNV PSI Controller";
> >      dc->props =3D pnv_psi_properties;
> > +    dc->reset =3D pnv_psi_reset;
> >  }
> > =20
> >  static const TypeInfo pnv_psi_info =3D {
>=20


--Sig_/cRKfVwwo1mjXDKHgTkaVmyw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4UOqoACgkQcdTV5YIv
c9YnOxAAyPBPLcu6qTqKhNWF+F4FTtre8Dh5nPTIdQUIgNDNMSipjDLLnzGGMnu0
WZzPStRlP53RYEQEyxLVaahhy8mtMylghekx4TUdlBw3A1u3y2y23cJGC43QdC9H
GwUPPFc1oJN3GVKkalASppzF+idyrh1h8nEbJTVsFOCNSxw7hnsbWfZS/uZ2/5+g
CZuWIuBS9wdojeXZ21d+Yu/x+Ho/DXzQSzH0aYjlNPLvR7FBSBOpznVY0fYOccHP
dNxrKa0PDXbfVHg1BlHGdSuMlFfAGPO8sAbe6Sy9DPiXFBbpjJz8dhGVrQxJHS3K
6amw9AMFminKlrzoEijO9/1NfMyLZzaFJub6u4Zxnj9vMMICCMHjZDtF8irXFfFo
km/vNyWg+2mylUS8psgJSo+vCdCJdYqpnuKLMTyYx7Gmi7cJiOSyGVloU3U+zbgI
OG+Xz8RY+g/k0XerMPL7YkaQDG2VN1ghnr3dcp/TX12/GQGcwaXyzDYQFXalf9by
1OjxZWeBsDuqos3Jg6oh9lhFefJ7V2+N7hTzmSztRbKGCDDM5lPsqZQWdbPL+4ZF
PSeLCG7/HupX10DeZUt05qx178eNCY55sTLWg4j82NeYpgDBQr5b6M8+ZFufHazE
+XAwGECDfzI8QIfXxVtgJorRi9Alfpd8B3VSDagsk/TVYMJtVMY=
=LHo1
-----END PGP SIGNATURE-----

--Sig_/cRKfVwwo1mjXDKHgTkaVmyw--


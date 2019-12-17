Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93823C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8E624672
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hthN3/2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8E624672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih0lu-0002fL-CT
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 19:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih0kc-0001Km-Pi
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih0ka-0007PS-O6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:30:10 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34411 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih0kZ-0007NI-KN; Mon, 16 Dec 2019 19:30:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cJtz0zLQz9sR8; Tue, 17 Dec 2019 11:30:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576542603;
 bh=Ra5+se8YvhEBh60BruuaSIdgGB3D9qIT9+Lbfy2hSrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hthN3/2HeFF6iXbbhi4NdEw32shxXUsjSMYXq81+Hw7N+0t7vKqTCSPoUK0QsCkFa
 mnHb/r/Eownb9FxTpnmmRMkLRtL1+g07jCnzN6fYTUm2OWFYBVg+tS+Cm9CUXDRE0Y
 KxDsr2HnEH1Mc08i2HGg6GzpKnzU6hPSH+CNJu0I=
Date: Tue, 17 Dec 2019 11:00:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 04/13] ppc/pnv: Introduce PnvMachineClass and
 PnvMachineClass::compat
Message-ID: <20191217000009.GG6242@umbus.fritz.box>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623839085.360005.4046508784077843216.stgit@bahia.lan>
 <5bf40b1e-48cb-5a20-82b2-7cd037003c27@kaod.org>
 <20191216190743.776f1d71@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <20191216190743.776f1d71@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 07:07:43PM +0100, Greg Kurz wrote:
> On Fri, 13 Dec 2019 13:44:48 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 13/12/2019 12:59, Greg Kurz wrote:
> > > The pnv_dt_create() function generates different contents for the
> > > "compatible" property of the root node in the DT, depending on the
> > > CPU type. This is open coded with multiple ifs using pnv_is_powerXX()
> > > helpers.
> > >=20
> > > It seems cleaner to achieve with QOM. Introduce a base class for the
> > > powernv machine and a compat attribute that each child class can use
> > > to provide the value for the "compatible" property.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> >=20
> > > ---
> > >  hw/ppc/pnv.c         |   33 +++++++++++++++++++--------------
> > >  include/hw/ppc/pnv.h |   13 +++++++++++++
> > >  2 files changed, 32 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index 0be0b6b411c3..5ac149b149d8 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -484,9 +484,7 @@ static void pnv_dt_power_mgt(void *fdt)
> > > =20
> > >  static void *pnv_dt_create(MachineState *machine)
> > >  {
> > > -    const char plat_compat8[] =3D "qemu,powernv8\0qemu,powernv\0ibm,=
powernv";
> > > -    const char plat_compat9[] =3D "qemu,powernv9\0ibm,powernv";
> > > -    const char plat_compat10[] =3D "qemu,powernv10\0ibm,powernv";
> > > +    PnvMachineClass *pmc =3D PNV_MACHINE_GET_CLASS(machine);
> > >      PnvMachineState *pnv =3D PNV_MACHINE(machine);
> > >      void *fdt;
> > >      char *buf;
> > > @@ -504,17 +502,8 @@ static void *pnv_dt_create(MachineState *machine)
> > >      _FDT((fdt_setprop_cell(fdt, 0, "#size-cells", 0x2)));
> > >      _FDT((fdt_setprop_string(fdt, 0, "model",
> > >                               "IBM PowerNV (emulated by qemu)")));
> > > -    if (pnv_is_power10(pnv)) {
> > > -        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat10,
> > > -                          sizeof(plat_compat10))));
> > > -    } else if (pnv_is_power9(pnv)) {
> > > -        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat9,
> > > -                          sizeof(plat_compat9))));
> > > -    } else {
> > > -        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat8,
> > > -                          sizeof(plat_compat8))));
> > > -    }
> > > -
> > > +    _FDT((fdt_setprop(fdt, 0, "compatible", pmc->compat,
> > > +                      sizeof(pmc->compat))));
>=20
> Of course the size should be pmc->compat_size ... David, can you fix this
> in your tree or should I post a v2 ?

Ah, yes.  This message came just barely in time - I've folded in the
fix as I've been setting up to to a pull request including it.

>=20
> > > =20
> > >      buf =3D  qemu_uuid_unparse_strdup(&qemu_uuid);
> > >      _FDT((fdt_setprop_string(fdt, 0, "vm,uuid", buf)));
> > > @@ -1692,6 +1681,8 @@ static void pnv_machine_power8_class_init(Objec=
tClass *oc, void *data)
> > >  {
> > >      MachineClass *mc =3D MACHINE_CLASS(oc);
> > >      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> > > +    PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> > > +    static const char compat[] =3D "qemu,powernv8\0qemu,powernv\0ibm=
,powernv";
> > > =20
> > >      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8";
> > >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> > > @@ -1699,26 +1690,39 @@ static void pnv_machine_power8_class_init(Obj=
ectClass *oc, void *data)
> > >      xic->icp_get =3D pnv_icp_get;
> > >      xic->ics_get =3D pnv_ics_get;
> > >      xic->ics_resend =3D pnv_ics_resend;
> > > +
> > > +    pmc->compat =3D compat;
> > > +    pmc->compat_size =3D sizeof(compat);
> > >  }
> > > =20
> > >  static void pnv_machine_power9_class_init(ObjectClass *oc, void *dat=
a)
> > >  {
> > >      MachineClass *mc =3D MACHINE_CLASS(oc);
> > >      XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> > > +    PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> > > +    static const char compat[] =3D "qemu,powernv9\0ibm,powernv";
> > > =20
> > >      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
> > >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
> > >      xfc->match_nvt =3D pnv_match_nvt;
> > > =20
> > >      mc->alias =3D "powernv";
> > > +
> > > +    pmc->compat =3D compat;
> > > +    pmc->compat_size =3D sizeof(compat);
> > >  }
> > > =20
> > >  static void pnv_machine_power10_class_init(ObjectClass *oc, void *da=
ta)
> > >  {
> > >      MachineClass *mc =3D MACHINE_CLASS(oc);
> > > +    PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> > > +    static const char compat[] =3D "qemu,powernv10\0ibm,powernv";
> > > =20
> > >      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER10";
> > >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power10_v1.0");
> > > +
> > > +    pmc->compat =3D compat;
> > > +    pmc->compat_size =3D sizeof(compat);
> > >  }
> > > =20
> > >  static void pnv_machine_class_init(ObjectClass *oc, void *data)
> > > @@ -1796,6 +1800,7 @@ static const TypeInfo types[] =3D {
> > >          .instance_size =3D sizeof(PnvMachineState),
> > >          .instance_init =3D pnv_machine_instance_init,
> > >          .class_init    =3D pnv_machine_class_init,
> > > +        .class_size    =3D sizeof(PnvMachineClass),
> > >          .interfaces =3D (InterfaceInfo[]) {
> > >              { TYPE_INTERRUPT_STATS_PROVIDER },
> > >              { },
> > > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > > index 92f80b1ccead..d534746bd493 100644
> > > --- a/include/hw/ppc/pnv.h
> > > +++ b/include/hw/ppc/pnv.h
> > > @@ -185,6 +185,19 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uin=
t32_t pir);
> > >  #define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
> > >  #define PNV_MACHINE(obj) \
> > >      OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
> > > +#define PNV_MACHINE_GET_CLASS(obj) \
> > > +    OBJECT_GET_CLASS(PnvMachineClass, obj, TYPE_PNV_MACHINE)
> > > +#define PNV_MACHINE_CLASS(klass) \
> > > +    OBJECT_CLASS_CHECK(PnvMachineClass, klass, TYPE_PNV_MACHINE)
> > > +
> > > +typedef struct PnvMachineClass {
> > > +    /*< private >*/
> > > +    MachineClass parent_class;
> > > +
> > > +    /*< public >*/
> > > +    const char *compat;
> > > +    int compat_size;
> > > +} PnvMachineClass;
> > > =20
> > >  typedef struct PnvMachineState {
> > >      /*< private >*/
> > >=20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl34GokACgkQbDjKyiDZ
s5Jubw/+ICeeowTnm2Q0+PAanSAtcGf6xsMO5XPfCorIA5sVgspCDKJJU0jPfWz1
5/zEttq8LiozJUbeNZh0bJtZevriTPtC4H6vrXs+0nSr5K1PQZMWCpHFj/e2qHLC
Fl6Q1jKy9OxllknVEGMXDmTpVJFf4Muqq6XYsSGvcTz4JFMhL12cHNXuIvbJtiJu
FolfzyLwrFLIjQeW4hqbUtFydpi+3NmXlqJnLbvRLsbKa1BMbCj/Er3qnVJFQJIo
BAysFFMhJKcqEsWObthRTjvX/MgsRwFvjfNH694hlirrJ56+tmT7GS3D7IgI2tCR
VJ7Q6Xdi83FjT1Vl6ar2NZ0+4wkTVP+P+rXsF3K3qQPq5HNRrIgBxeYmnQsfXbV5
fWxSB0OqW0+w9/6076UoFUlEW6lfPZEH9Zru4UwDWlhIrOGyqSOnwye2ZTDZtJqz
nmqPAIwrgB68ImlfZqxU4q8exXbpqmqu8Xe2YiX5kq9NWeUfS/HDaCtMEfqE5GGL
bqmsShf+UwNCrYBnHJMj7AMPtaLXreSAQZvspBEc/0UOKArxbV1rlmKE28J6dVlO
3Hgi0uE14w9jShXUXqdlCXOKTURoxuMcOMjipj0S487o6OE163l5aEGgDIF9eca9
eHHBOJAAx5IlG5rGbIm9twXO3MxX8M3msxasayBdlN9Mozx++P8=
=dikC
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--


Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB073C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B376822B48
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VOsQRqyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B376822B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igfIh-0002G8-EF
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 20:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1igfHX-0000me-Ji
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1igfHV-0003w8-SZ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:34:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44959 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1igfHU-0003r8-QY; Sun, 15 Dec 2019 20:34:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47bkMs345sz9sPT; Mon, 16 Dec 2019 12:34:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576460073;
 bh=eWgsKZiu2r938kDT6six1H2pOju+bk3Br+upvmsAb7c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VOsQRqylz0sn5iMTiqtqxOMrKz5kHohRKErxIqew1+fRGf8cSzyyrKIxCNxPaKOxh
 DJxIcfF+70xjODpCgt5+N7hyCRUmqPa0NWJNk8pPVnh4b6FsJoyRdPVPHpMHnD8Bdx
 Z1R0So50pkb8or8nK4L69jokxYF3f4b1YU701RAg=
Date: Mon, 16 Dec 2019 12:28:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 07/13] ppc/pnv: Introduce PnvChipClass::intc_print_info()
 method
Message-ID: <20191216012810.GA3256@umbus.fritz.box>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623840755.360005.5002022339473369934.stgit@bahia.lan>
 <4039344f-eb1c-3ea3-1055-09aeffd28ce7@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <4039344f-eb1c-3ea3-1055-09aeffd28ce7@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 02:00:53PM +0100, C=E9dric Le Goater wrote:
> On 13/12/2019 13:00, Greg Kurz wrote:
> > The pnv_pic_print_info() callback checks the type of the chip in order
> > to forward to the request appropriate interrupt controller. This can
> > be achieved with QOM. Introduce a method for this in the base chip class
> > and implement it in child classes.
> >=20
> > This also prepares ground for the upcoming interrupt controller of POWE=
R10
> > chips.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> One comment below.
>=20
> > ---
> >  hw/ppc/pnv.c         |   30 +++++++++++++++++++++++++-----
> >  include/hw/ppc/pnv.h |    1 +
> >  2 files changed, 26 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index efc00f4cb67a..2a53e99bda2e 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -832,6 +832,12 @@ static void pnv_chip_power8_intc_destroy(PnvChip *=
chip, PowerPCCPU *cpu)
> >      pnv_cpu->intc =3D NULL;
> >  }
> > =20
> > +static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU =
*cpu,
> > +                                            Monitor *mon)
> > +{
> > +    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
> > +}
> > +
> >  /*
> >   *    0:48  Reserved - Read as zeroes
> >   *   49:52  Node ID
> > @@ -889,6 +895,12 @@ static void pnv_chip_power9_intc_destroy(PnvChip *=
chip, PowerPCCPU *cpu)
> >      pnv_cpu->intc =3D NULL;
> >  }
> > =20
> > +static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU =
*cpu,
> > +                                            Monitor *mon)
> > +{
> > +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
> > +}
> > +
> >  static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cp=
u,
> >                                          Error **errp)
> >  {
> > @@ -910,6 +922,11 @@ static void pnv_chip_power10_intc_destroy(PnvChip =
*chip, PowerPCCPU *cpu)
> >      pnv_cpu->intc =3D NULL;
> >  }
> > =20
> > +static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU=
 *cpu,
> > +                                             Monitor *mon)
> > +{
> > +}
> > +
> >  /*
> >   * Allowed core identifiers on a POWER8 Processor Chip :
> >   *
> > @@ -1086,6 +1103,7 @@ static void pnv_chip_power8e_class_init(ObjectCla=
ss *klass, void *data)
> >      k->intc_create =3D pnv_chip_power8_intc_create;
> >      k->intc_reset =3D pnv_chip_power8_intc_reset;
> >      k->intc_destroy =3D pnv_chip_power8_intc_destroy;
> > +    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
> >      k->isa_create =3D pnv_chip_power8_isa_create;
> >      k->dt_populate =3D pnv_chip_power8_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> > @@ -1107,6 +1125,7 @@ static void pnv_chip_power8_class_init(ObjectClas=
s *klass, void *data)
> >      k->intc_create =3D pnv_chip_power8_intc_create;
> >      k->intc_reset =3D pnv_chip_power8_intc_reset;
> >      k->intc_destroy =3D pnv_chip_power8_intc_destroy;
> > +    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
> >      k->isa_create =3D pnv_chip_power8_isa_create;
> >      k->dt_populate =3D pnv_chip_power8_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> > @@ -1128,6 +1147,7 @@ static void pnv_chip_power8nvl_class_init(ObjectC=
lass *klass, void *data)
> >      k->intc_create =3D pnv_chip_power8_intc_create;
> >      k->intc_reset =3D pnv_chip_power8_intc_reset;
> >      k->intc_destroy =3D pnv_chip_power8_intc_destroy;
> > +    k->intc_print_info =3D pnv_chip_power8_intc_print_info;
> >      k->isa_create =3D pnv_chip_power8nvl_isa_create;
> >      k->dt_populate =3D pnv_chip_power8_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> > @@ -1299,6 +1319,7 @@ static void pnv_chip_power9_class_init(ObjectClas=
s *klass, void *data)
> >      k->intc_create =3D pnv_chip_power9_intc_create;
> >      k->intc_reset =3D pnv_chip_power9_intc_reset;
> >      k->intc_destroy =3D pnv_chip_power9_intc_destroy;
> > +    k->intc_print_info =3D pnv_chip_power9_intc_print_info;
> >      k->isa_create =3D pnv_chip_power9_isa_create;
> >      k->dt_populate =3D pnv_chip_power9_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power9_pic_print_info;
> > @@ -1379,6 +1400,7 @@ static void pnv_chip_power10_class_init(ObjectCla=
ss *klass, void *data)
> >      k->intc_create =3D pnv_chip_power10_intc_create;
> >      k->intc_reset =3D pnv_chip_power10_intc_reset;
> >      k->intc_destroy =3D pnv_chip_power10_intc_destroy;
> > +    k->intc_print_info =3D pnv_chip_power10_intc_print_info;
> >      k->isa_create =3D pnv_chip_power10_isa_create;
> >      k->dt_populate =3D pnv_chip_power10_dt_populate;
> >      k->pic_print_info =3D pnv_chip_power10_pic_print_info;
> > @@ -1575,11 +1597,9 @@ static void pnv_pic_print_info(InterruptStatsPro=
vider *obj,
> >      CPU_FOREACH(cs) {
> >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > =20
> > -        if (pnv_chip_is_power9(pnv->chips[0])) {
> > -            xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->int=
c), mon);
> > -        } else {
> > -            icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
> > -        }
> > +        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH()=
 */
>=20
> May be we should introduce a helper such as :=20
>=20
> int pnv_chip_cpu_foreach(PnvChip *chip,
> 	  int (*doit)(PnvChip *chip, PowerPCCPU *cpu, void *opaque), void *opaqu=
e)
> {
>     int i, j;
>     int ret =3D 0;
>=20
>     for (i =3D 0; i < chip->nr_cores; i++) {
>         PnvCore *pc =3D chip->cores[i];
>         CPUCore *cc =3D CPU_CORE(pc);
>=20
>         for (j =3D 0; j < cc->nr_threads; j++) {
>             PowerPCCPU *cpu =3D pc->threads[j];
>             ret =3D doit(chip, cpu, opaque);
>             if (ret) {=20
>                 break;
>             }
>         }
>     }
>     return ret;
> }

What I'd actually like to work towards is just having the interrupt
controllers themselves advertize TYPE_INTERRUPT_STATS_PROVIDER and not
needing anything specific at the machine level to locate them, just
let the generic code in hmp_info_pic handle it.

But this patch is fine in the meantime.

>=20
> > +        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[=
0], cpu,
> > +                                                           mon);
> >      }
> > =20
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index c213bdd5ecd3..7d2402784d4b 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -133,6 +133,7 @@ typedef struct PnvChipClass {
> >      void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
> >      void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
> >      void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
> > +    void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, Monitor *m=
on);
> >      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
> >      void (*dt_populate)(PnvChip *chip, void *fdt);
> >      void (*pic_print_info)(PnvChip *chip, Monitor *mon);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl323acACgkQbDjKyiDZ
s5K49RAAoWMa6iLB4Y+f3bVO7kr4udl/+0I7C14ov4cMd68XMptgGCBJmbX4uA+o
q8H9N6lQPp14DPp0vj/oXtmeRaK6tKiqpUpy720RNwxJacsdnHpkwwaTVUCpFDTK
qzx470is9ALcvMm5y+MsXRT0kdk0aucxqAanCkWVw7sZJqeF1rt+TxpFVXclUhta
5KoGA3ZrvCJD4+D+J3lydlGPvwqQeCBTbJRVYq2WAg203QnjAcXI21J7LurENwSJ
ihfN/hQz2uEZ+qM89nbyI1u5poTpMXg9Yqb6u9lo9gg+eVSig/h7OLo1xTNYoUVJ
COCpvDMvPr3aXqNdZ7SC4lEQySImnoQVDjkkfOnYGDiez1DrNHvzcJg8bQVIPhAe
MkW0ADMDVfMPZCA1Uwao47QzqUd71WU2OnQUzzHAZOwXPUr+Zsh6Yv12WLQ5GWa0
7LMOBdCwRV7BRUd7gFSc0qlnlTvqHtIjFTvrNOaMNSeKL2lD3KIwGWimUPpU0GCP
vJRjcNJ7gDs/6HbgDP7mHyKFQVUVGXelLOora2UQZNFonkMZ0bG17rsyYnerC8iJ
y4LNMMbTHnwWNCumNOi0F/2l/Itj9Uq+/VnnfQcFyBl4a3/ogEJq42ItLjCQrChR
dYbCv/aOlKiPIyfhurQU7B6i+vlHpTA8G8XCGvepeghildCg9zk=
=vgbv
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


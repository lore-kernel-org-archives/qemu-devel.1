Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44DE207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bqffvw8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44DE207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSiM-0006t5-JI
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSdF-0000J8-6K
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSdD-0001zb-Hw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37131 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDSdD-0001x3-5r; Thu, 26 Sep 2019 08:12:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fDLZ2dnVz9sPS; Thu, 26 Sep 2019 22:11:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569499910;
 bh=yE0V37b06eUGKiBUMYzOJ/dKwkx/geBtZDc+qRFj9bw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bqffvw8qO0ye/sNIU6Vuyc5LX+AHZkos/FShFR44Kr4HctG0NB8hdXEUqOyeQiwjq
 v2U341rY8dzH2o1jzAqYMo8PfAw+dAl/lhE6NcCrZgaJfFcZADMWHlWmnXHJ4+6su/
 nJh3ktM9l943wRTelF2nlyoZMpIonwDX3AqVkQ5g=
Date: Thu, 26 Sep 2019 21:36:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 13/20] spapr: Eliminate SpaprIrq:get_nodename method
Message-ID: <20190926113620.GA17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-14-david@gibson.dropbear.id.au>
 <20190926094839.33913bdf@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8BV0TfTmv8nl9Pc"
Content-Disposition: inline
In-Reply-To: <20190926094839.33913bdf@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--n8BV0TfTmv8nl9Pc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 09:48:39AM +0200, Greg Kurz wrote:
> On Wed, 25 Sep 2019 16:45:27 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This method is used to determine the name of the irq backend's node in =
the
> > device tree, so that we can find its phandle (after SLOF may have modif=
ied
> > it from the phandle we initially gave it).
> >=20
> > But, in the two cases the only difference between the node name is the
> > presence of a unit address.  Searching for a node name without consider=
ing
> > unit address is standard practice for the device tree, and
> > fdt_subnode_offset() will do exactly that.
> >=20
> > So, the method is unnecessary.
> >=20
>=20
> So is the XICS_NODENAME macro which was introduced by the same
> commit 743ed566c1d80, and it seems that "interrupt-controller"
> is a well-known string that is used everywhere:
>=20
> [greg@bahia qemu-spapr]$ git grep -E \"interrupt-controller\"
> hw/arm/virt.c:    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-control=
ler", NULL, 0);
> hw/arm/xlnx-versal-virt.c:    qemu_fdt_setprop(s->fdt, nodename, "interru=
pt-controller", NULL, 0);
> hw/intc/sh_intc.c:                          "interrupt-controller", 0x100=
000000ULL);
> hw/intc/spapr_xive.c:    _FDT(fdt_setprop(fdt, node, "interrupt-controlle=
r", NULL, 0));
> hw/intc/xics_spapr.c:    _FDT(fdt_setprop(fdt, node, "interrupt-controlle=
r", NULL, 0));
> hw/pci/pci.c:    { 0x0800, "Interrupt controller", "interrupt-controller"=
},
> hw/ppc/e500.c:    qemu_fdt_setprop(fdt, mpic, "interrupt-controller", NUL=
L, 0);
> hw/ppc/pnv.c:    _FDT((fdt_setprop(fdt, offset, "interrupt-controller", N=
ULL, 0)));
> hw/ppc/spapr_events.c:    _FDT((fdt_setprop(fdt, event_sources, "interrup=
t-controller", NULL, 0)));
> hw/ppc/spapr_irq.c:    const char *nodename =3D "interrupt-controller";
> hw/ppc/spapr_pci.c:    { PCI_CLASS_SYSTEM_PIC, "interrupt-controller", pi=
c_iface },
> hw/ppc/spapr_vio.c:    _FDT(fdt_setprop(fdt, node, "interrupt-controller"=
, NULL, 0));
> hw/riscv/sifive_u.c:        qemu_fdt_setprop(fdt, intc, "interrupt-contro=
ller", NULL, 0);
> hw/riscv/sifive_u.c:    qemu_fdt_setprop(fdt, nodename, "interrupt-contro=
ller", NULL, 0);
> hw/riscv/spike.c:        qemu_fdt_setprop(fdt, intc, "interrupt-controlle=
r", NULL, 0);
> hw/riscv/virt.c:        qemu_fdt_setprop(fdt, intc, "interrupt-controller=
", NULL, 0);
> hw/riscv/virt.c:    qemu_fdt_setprop(fdt, nodename, "interrupt-controller=
", NULL, 0);
> include/hw/ppc/spapr.h: * "interrupt-controller" node has its "#interrupt=
-cells" property set to 2 (ie,
> include/hw/ppc/xics_spapr.h:#define XICS_NODENAME "interrupt-controller"
>=20
> Maybe drop XICS_NODENAME as well while here ?

Fair point, done.

>=20
> With or without that,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_irq.c         | 25 +++----------------------
> >  include/hw/ppc/spapr_irq.h |  1 -
> >  2 files changed, 3 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 038bfffff4..79167ccc68 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -211,11 +211,6 @@ static void spapr_irq_reset_xics(SpaprMachineState=
 *spapr, Error **errp)
> >      }
> >  }
> > =20
> > -static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spap=
r)
> > -{
> > -    return XICS_NODENAME;
> > -}
> > -
> >  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **=
errp)
> >  {
> >      if (kvm_enabled()) {
> > @@ -237,7 +232,6 @@ SpaprIrq spapr_irq_xics =3D {
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > -    .get_nodename =3D spapr_irq_get_nodename_xics,
> >      .init_kvm    =3D spapr_irq_init_kvm_xics,
> >  };
> > =20
> > @@ -362,11 +356,6 @@ static void spapr_irq_set_irq_xive(void *opaque, i=
nt irq, int val)
> >      }
> >  }
> > =20
> > -static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spap=
r)
> > -{
> > -    return spapr->xive->nodename;
> > -}
> > -
> >  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **=
errp)
> >  {
> >      if (kvm_enabled()) {
> > @@ -393,7 +382,6 @@ SpaprIrq spapr_irq_xive =3D {
> >      .post_load   =3D spapr_irq_post_load_xive,
> >      .reset       =3D spapr_irq_reset_xive,
> >      .set_irq     =3D spapr_irq_set_irq_xive,
> > -    .get_nodename =3D spapr_irq_get_nodename_xive,
> >      .init_kvm    =3D spapr_irq_init_kvm_xive,
> >  };
> > =20
> > @@ -538,11 +526,6 @@ static void spapr_irq_set_irq_dual(void *opaque, i=
nt irq, int val)
> >      spapr_irq_current(spapr)->set_irq(spapr, irq, val);
> >  }
> > =20
> > -static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spap=
r)
> > -{
> > -    return spapr_irq_current(spapr)->get_nodename(spapr);
> > -}
> > -
> >  /*
> >   * Define values in sync with the XIVE and XICS backend
> >   */
> > @@ -560,7 +543,6 @@ SpaprIrq spapr_irq_dual =3D {
> >      .post_load   =3D spapr_irq_post_load_dual,
> >      .reset       =3D spapr_irq_reset_dual,
> >      .set_irq     =3D spapr_irq_set_irq_dual,
> > -    .get_nodename =3D spapr_irq_get_nodename_dual,
> >      .init_kvm    =3D NULL, /* should not be used */
> >  };
> > =20
> > @@ -697,13 +679,13 @@ void spapr_irq_reset(SpaprMachineState *spapr, Er=
ror **errp)
> > =20
> >  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error *=
*errp)
> >  {
> > -    const char *nodename =3D spapr->irq->get_nodename(spapr);
> > +    const char *nodename =3D "interrupt-controller";
> >      int offset, phandle;
> > =20
> >      offset =3D fdt_subnode_offset(fdt, 0, nodename);
> >      if (offset < 0) {
> > -        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> > -                   fdt_strerror(offset));
> > +        error_setg(errp, "Can't find node \"%s\": %s",
> > +                   nodename, fdt_strerror(offset));
> >          return -1;
> >      }
> > =20
> > @@ -787,6 +769,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > -    .get_nodename =3D spapr_irq_get_nodename_xics,
> >      .init_kvm    =3D spapr_irq_init_kvm_xics,
> >  };
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index a4e790ef60..9b60378e28 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -52,7 +52,6 @@ typedef struct SpaprIrq {
> >      int (*post_load)(SpaprMachineState *spapr, int version_id);
> >      void (*reset)(SpaprMachineState *spapr, Error **errp);
> >      void (*set_irq)(void *opaque, int srcno, int val);
> > -    const char *(*get_nodename)(SpaprMachineState *spapr);
> >      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
> >  } SpaprIrq;
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n8BV0TfTmv8nl9Pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MorQACgkQbDjKyiDZ
s5KuYBAAjDPnYlY2dBan1AN4x7IKRQScwIX5nRPe/+J9km+N38iLRgcHd31SozWq
qq5Vp/v3NhI9esowoIFGDuNgn/NEKKTtXRPD8LDYCJkqBcTLEe2DV8PhjZZ6T9cO
lf4cADxWHKOuvgHs/rz/fdyzt0QxJnMKHCAwKUqnEK7U8p8WrD8X9/Ewfm7w6IaM
j4y8XzM7jLsgu4fTYvqln+GwHwdcINWJsgT6w/+XiT5YGshIegaBtJ4JQ/61wM77
DeUW0djmaEM9us9Kygduy3IFIoKkOEmcxvcPFkVl3djleST0VNTInTz7ImdvgHzy
LlbqIwo2D1reAK8NCma83cfULyR9VoaW28n4W6CUgEBcawooycHND0RoSS8kEVdK
TPiRfTnZtMZDfA3i66CAaFdYsFe/Pm/6+MD1FOYucqJkP/F3OJZPBo2uU+6kLAE3
+hXgFVU/AmaCwh59NJiIYVSCi+prDO/za10MUSRoLG8A5jzN3lIQbDzXia8w5Tco
hRIk7KL828wnRJo25wwYbD8F6WoeVi4iKLbew348mwrffvYbNeqBLsKIMo5c+Vag
V/b3XGWD9HRME5Nd1KvvvSWd8Z/u65bsUHny4vIHFWA7ZlucHST3z+E1x9msUUS+
fL05EjLEJNonfYJwKH8SoobHIcGE0SulKWvTb8WdaUM719GJ/Hc=
=RbeC
-----END PGP SIGNATURE-----

--n8BV0TfTmv8nl9Pc--


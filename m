Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4634CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136EF21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W/P1gAm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136EF21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOch-0002hM-On
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iLOax-0001CR-9a
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iLOav-0006eV-0o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:30:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59355 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iLOat-0006cT-EE; Fri, 18 Oct 2019 05:30:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46vgkT6nc9z9sPJ; Fri, 18 Oct 2019 20:30:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571391041;
 bh=CrllFX9Yj4Jim06wHOVJCG0btafnhMARMN3EbZlNxgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W/P1gAm8+Sv2h1Hubu6LITum6YOEh74LHJNWQMIrEo/5UQ7G81EgJOkpAnVVjde3i
 hP9xvfq2/MKw6umpPfSZlH6OgxKeShW4rTgRBWreJrrf+zLm/nhRZTudEhjyIRGIYp
 /m+HyoqDJqfxYYwSFmzldBoeMRtNApRVE7sl1Ab0=
Date: Fri, 18 Oct 2019 14:55:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/2] spapr/xive: Set the OS CAM line at reset
Message-ID: <20191018035557.GC2000@umbus.fritz.box>
References: <20191017144241.12522-1-clg@kaod.org>
 <20191017144241.12522-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20191017144241.12522-3-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 04:42:41PM +0200, C=E9dric Le Goater wrote:
> When a Virtual Processor is scheduled to run on a HW thread, the
> hypervisor pushes its identifier in the OS CAM line. When running in
> TCG or kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.
>=20
> Introduce a 'os-cam' property which will be used to set the OS CAM
> line at reset and remove the spapr_xive_set_tctx_os_cam() calls which
> are done when the XIVE interrupt controller are activated.

I'm not immediately seeing the advantage of doing this via a property,
rather than poking it from the PAPR code which already knows the right
values.

Also, let me check my understanding:
  IIUC, on powernv the OS (running in HV mode) can alter the OS CAM
  lines for itself and/or its guests, but for pseries they're fixed in
  place.  Is that right?

> This change also has the benefit to remove the use of CPU_FOREACH()
> which can be unsafe.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_xive.h |  1 -
>  include/hw/ppc/xive.h       |  4 +++-
>  hw/intc/spapr_xive.c        | 31 +++++--------------------------
>  hw/intc/xive.c              | 22 +++++++++++++++++++++-
>  hw/ppc/pnv.c                |  3 ++-
>  5 files changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index d84bd5c229f0..742b7e834f2a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -57,7 +57,6 @@ typedef struct SpaprXive {
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> =20
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
>  void spapr_xive_map_mmio(SpaprXive *xive);
> =20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 99381639f50c..e273069c25a9 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -319,6 +319,7 @@ typedef struct XiveTCTX {
>      qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> +    uint32_t    os_cam;
>  } XiveTCTX;
> =20
>  /*
> @@ -414,7 +415,8 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
>  uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size);
> =20
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> +Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, uint32_t os_cam,
> +                         Error **errp);
>  void xive_tctx_reset(XiveTCTX *tctx);
> =20
>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 0c3acf1a4192..71f138512a1c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -205,21 +205,13 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, b=
ool enable)
>      memory_region_set_enabled(&xive->end_source.esb_mmio, false);
>  }
> =20
> -/*
> - * When a Virtual Processor is scheduled to run on a HW thread, the
> - * hypervisor pushes its identifier in the OS CAM line. Emulate the
> - * same behavior under QEMU.
> - */
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
> +static uint32_t spapr_xive_get_os_cam(PowerPCCPU *cpu)
>  {
>      uint8_t  nvt_blk;
>      uint32_t nvt_idx;
> -    uint32_t nvt_cam;
> -
> -    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
> =20
> -    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, nvt=
_idx));
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
> +    spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
> +    return xive_nvt_cam_line(nvt_blk, nvt_idx);
>  }
> =20
>  static void spapr_xive_end_reset(XiveEND *end)
> @@ -537,19 +529,14 @@ static int spapr_xive_cpu_intc_create(SpaprInterrup=
tController *intc,
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
>      Object *obj;
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +    uint32_t os_cam =3D spapr_xive_get_os_cam(cpu);
> =20
> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
> +    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), os_cam, err=
p);
>      if (!obj) {
>          return -1;
>      }
> =20
>      spapr_cpu->tctx =3D XIVE_TCTX(obj);
> -
> -    /*
> -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> -     * don't beneficiate from the reset of the XIVE IRQ backend
> -     */
> -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
>      return 0;
>  }
> =20
> @@ -650,14 +637,6 @@ static void spapr_xive_dt(SpaprInterruptController *=
intc, uint32_t nr_servers,
>  static int spapr_xive_activate(SpaprInterruptController *intc, Error **e=
rrp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        /* (TCG) Set the OS CAM line of the thread interrupt context. */
> -        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> -    }
> =20
>      if (kvm_enabled()) {
>          int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 0ae3f9b1efe4..be4f2c974178 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -566,6 +566,18 @@ static void xive_tctx_reset_handler(void *dev)
>          ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
>      tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =3D
>          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
> +
> +    /*
> +     * (TCG) Set the OS CAM line of the thread interrupt context.
> +     *
> +     * When a Virtual Processor is scheduled to run on a HW thread,
> +     * the hypervisor pushes its identifier in the OS CAM line.
> +     * Emulate the same behavior under QEMU.
> +     */
> +    if (tctx->os_cam) {
> +        uint32_t qw1w2 =3D cpu_to_be32(TM_QW1W2_VO | tctx->os_cam);
> +        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +    }
>  }
> =20
>  void xive_tctx_reset(XiveTCTX *tctx)
> @@ -667,11 +679,17 @@ static const VMStateDescription vmstate_xive_tctx =
=3D {
>      },
>  };
> =20
> +static Property  xive_tctx_properties[] =3D {
> +    DEFINE_PROP_UINT32("os-cam", XiveTCTX, os_cam, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void xive_tctx_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->desc =3D "XIVE Interrupt Thread Context";
> +    dc->props =3D xive_tctx_properties;
>      dc->realize =3D xive_tctx_realize;
>      dc->unrealize =3D xive_tctx_unrealize;
>      dc->vmsd =3D &vmstate_xive_tctx;
> @@ -689,7 +707,8 @@ static const TypeInfo xive_tctx_info =3D {
>      .class_init    =3D xive_tctx_class_init,
>  };
> =20
> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
> +Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, uint32_t os_cam,
> +                         Error **errp)
>  {
>      Error *local_err =3D NULL;
>      Object *obj;
> @@ -698,6 +717,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
>      object_unref(obj);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> +    object_property_set_int(obj, os_cam, "os-cam", &local_err);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7cf64b6d2533..99c06842573e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -806,7 +806,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>       * controller object is initialized afterwards. Hopefully, it's
>       * only used at runtime.
>       */
> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), &lo=
cal_err);
> +    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), 0,
> +                           &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2pN8oACgkQbDjKyiDZ
s5ITohAAibSM8EYtmTKgC35Pyt9f6Mbfh2e14LdtWoJO5Gvu0VtluJVbPfSbJzCw
XvTHTO3O7S6j0IXZzjiS/QgJttncpPpFm+5+/0uOdPXnaoTltqbP5ZG6wLP2M/Td
0bxe55Kvt0fwSKQiwL5Urfk9vLaefJEdJj0BXq/6i2I98dbal72zy0lE82Jn/+cQ
WguTf0pDC/2gU5XTwyNlI7F/quUa6CMFHzzLCGtN4KPlfUt8pAuq1kFx9bXgfEN2
efbXWXjRUo1aBW6rtsJo6G6vtNhwZqla2JgZLya8wLxXeCvlkrh8iP+z1HoHF15N
1X45j4JARvss3ccXNh47dnX3HLv6nWABSQS5as0beO4quyZzUl6o0tKcwLpY2OR4
aE2ONmtWr0u14uPGvBhOoEDQ4UEtaTu0Ioy7Qqk+QjFL68B/8FjolTlumAs1Bu8l
wCgnaIxdDzjCd2ME/E/dQG4JjuIGmleFfTfkS38Wc8yzI5CDAOyW+QURhsi/9/iw
S40wLynPwZ4lZD6xs8ydnD4dxgHhAfuAE+XRfXqAJ3lhPqe47RrXELT+tjBcxAcD
XEVyNIg++z5C1DP/6Fl2hZX2EkYPvWxPmY7gKKYvX07UlfXCwS0dekJu1lIO2iyt
JcvTyqC2qQMd7uTyYezjsEf9fI5iTmyUWf7luqriDEmm6zdC+Ys=
=ltw3
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--


Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B1BC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DF12168B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DF12168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEoHt-0000dM-GR
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 01:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iEoGR-000899-Fd
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iEoGP-0001Jz-NX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:30:27 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:52332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iEoGP-0001IN-C5
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:30:25 -0400
Received: from player786.ha.ovh.net (unknown [10.108.57.245])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 311B71AD23E
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 07:30:22 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 0C620A6FF335;
 Mon, 30 Sep 2019 05:30:11 +0000 (UTC)
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4a3c123e-ef5c-d1c5-6fef-dcd46e1946f9@kaod.org>
Date: Mon, 30 Sep 2019 07:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927055028.11493-22-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10587399776481217305
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedugdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.182
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
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/09/2019 07:50, David Gibson wrote:
> This method essentially represents code which belongs to the interrupt
> controller, but needs to be called on all possible intcs, rather than
> just the currently active one.  The "dual" version therefore calls
> into the xics and xive versions confusingly.
>=20
> Handle this more directly, by making it instead a method on the intc
> backend, and always calling it on every backend that exists.
>=20
> While we're there, streamline the error reporting a bit.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

With the function declarations removed from spapr_irq.h,

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c       | 25 ++++++++++++
>  hw/intc/xics_spapr.c       | 18 +++++++++
>  hw/ppc/spapr_cpu_core.c    |  3 +-
>  hw/ppc/spapr_irq.c         | 81 +++++++++++---------------------------
>  include/hw/ppc/spapr_irq.h | 16 +++++++-
>  5 files changed, 82 insertions(+), 61 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index b67e9c3245..9338daba3d 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -495,10 +495,33 @@ static Property spapr_xive_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static int spapr_xive_cpu_intc_create(SpaprInterruptController *intc,
> +                                      PowerPCCPU *cpu, Error **errp)
> +{
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> +    Object *obj;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
> +    if (!obj) {
> +        return -1;
> +    }
> +
> +    spapr_cpu->tctx =3D XIVE_TCTX(obj);
> +
> +    /*
> +     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> +     * don't beneficiate from the reset of the XIVE IRQ backend
> +     */
> +    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> +    return 0;
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
> +    SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
> =20
>      dc->desc    =3D "sPAPR XIVE Interrupt Controller";
>      dc->props   =3D spapr_xive_properties;
> @@ -511,6 +534,8 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      xrc->get_nvt =3D spapr_xive_get_nvt;
>      xrc->write_nvt =3D spapr_xive_write_nvt;
>      xrc->get_tctx =3D spapr_xive_get_tctx;
> +
> +    sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 4874e6be55..946311b858 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -330,13 +330,31 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint=
32_t nr_servers, void *fdt,
>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>  }
> =20
> +static int xics_spapr_cpu_intc_create(SpaprInterruptController *intc,
> +                                       PowerPCCPU *cpu, Error **errp)
> +{
> +    ICSState *ics =3D ICS_SPAPR(intc);
> +    Object *obj;
> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> +
> +    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, ics->xics, errp);
> +    if (!obj) {
> +        return -1;
> +    }
> +
> +    spapr_cpu->icp =3D ICP(obj);
> +    return 0;
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICSStateClass *isc =3D ICS_CLASS(klass);
> +    SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
> =20
>      device_class_set_parent_realize(dc, ics_spapr_realize,
>                                      &isc->parent_realize);
> +    sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
>  }
> =20
>  static const TypeInfo ics_spapr_info =3D {
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 1d93de8161..3e4302c7d5 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -237,8 +237,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
> =20
> -    spapr->irq->cpu_intc_create(spapr, cpu, &local_err);
> -    if (local_err) {
> +    if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
>          goto error_unregister;
>      }
> =20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 0603c82fe8..a855dfe4e9 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -138,23 +138,6 @@ static void spapr_irq_print_info_xics(SpaprMachine=
State *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> -static void spapr_irq_cpu_intc_create_xics(SpaprMachineState *spapr,
> -                                           PowerPCCPU *cpu, Error **er=
rp)
> -{
> -    Error *local_err =3D NULL;
> -    Object *obj;
> -    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> -
> -    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
> -                     &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_cpu->icp =3D ICP(obj);
> -}
> -
>  static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int vers=
ion_id)
>  {
>      if (!kvm_irqchip_in_kernel()) {
> @@ -203,7 +186,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .free        =3D spapr_irq_free_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
> -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> @@ -239,28 +221,6 @@ static void spapr_irq_print_info_xive(SpaprMachine=
State *spapr,
>      spapr_xive_pic_print_info(spapr->xive, mon);
>  }
> =20
> -static void spapr_irq_cpu_intc_create_xive(SpaprMachineState *spapr,
> -                                           PowerPCCPU *cpu, Error **er=
rp)
> -{
> -    Error *local_err =3D NULL;
> -    Object *obj;
> -    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> -
> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &l=
ocal_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_cpu->tctx =3D XIVE_TCTX(obj);
> -
> -    /*
> -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> -     * don't beneficiate from the reset of the XIVE IRQ backend
> -     */
> -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> -}
> -
>  static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int vers=
ion_id)
>  {
>      return spapr_xive_post_load(spapr->xive, version_id);
> @@ -316,7 +276,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .free        =3D spapr_irq_free_xive,
>      .print_info  =3D spapr_irq_print_info_xive,
>      .dt_populate =3D spapr_dt_xive,
> -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
>      .set_irq     =3D spapr_irq_set_irq_xive,
> @@ -381,20 +340,6 @@ static void spapr_irq_dt_populate_dual(SpaprMachin=
eState *spapr,
>      spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phan=
dle);
>  }
> =20
> -static void spapr_irq_cpu_intc_create_dual(SpaprMachineState *spapr,
> -                                           PowerPCCPU *cpu, Error **er=
rp)
> -{
> -    Error *local_err =3D NULL;
> -
> -    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
> -}
> -
>  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int vers=
ion_id)
>  {
>      /*
> @@ -460,7 +405,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .free        =3D spapr_irq_free_dual,
>      .print_info  =3D spapr_irq_print_info_dual,
>      .dt_populate =3D spapr_irq_dt_populate_dual,
> -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
>      .set_irq     =3D spapr_irq_set_irq_dual,
> @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachineState *spa=
pr, Error **errp)
>  /*
>   * sPAPR IRQ frontend routines for devices
>   */
> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> +                              PowerPCCPU *cpu, Error **errp)
> +{
> +    if (spapr->xive) {
> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->xive);
> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(i=
ntc);
> +
> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> +            return -1;
> +        }
> +    }
> +
> +    if (spapr->ics) {
> +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->ics);
> +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(i=
ntc);
> +
> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -763,7 +731,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .free        =3D spapr_irq_free_xics,
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_dt_xics,
> -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index b9398e0be3..30d660ff1e 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -43,8 +43,22 @@ typedef struct SpaprInterruptController SpaprInterru=
ptController;
> =20
>  typedef struct SpaprInterruptControllerClass {
>      InterfaceClass parent;
> +
> +    /*
> +     * These methods will typically be called on all intcs, active and
> +     * inactive
> +     */
> +    int (*cpu_intc_create)(SpaprInterruptController *intc,
> +                            PowerPCCPU *cpu, Error **errp);
>  } SpaprInterruptControllerClass;
> =20
> +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
> +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> +                  void *fdt, uint32_t phandle);
> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> +                              PowerPCCPU *cpu, Error **errp);
> +
> +
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
>                          Error **errp);
> @@ -61,8 +75,6 @@ typedef struct SpaprIrq {
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
> -    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> -                            Error **errp);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
>=20



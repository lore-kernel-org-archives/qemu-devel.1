Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F31CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7F420820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7F420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOnt-0003CZ-RJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iLOmS-0002D8-19
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iLOmQ-0002cq-FA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:42:43 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:38165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iLOmQ-0002aL-96
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:42:42 -0400
Received: from player759.ha.ovh.net (unknown [10.109.160.230])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 4D4016D254
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:42:33 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id F2C36B28AE3C;
 Fri, 18 Oct 2019 09:42:26 +0000 (UTC)
Subject: Re: [PATCH 2/2] spapr/xive: Set the OS CAM line at reset
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191017144241.12522-1-clg@kaod.org>
 <20191017144241.12522-3-clg@kaod.org> <20191018035557.GC2000@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cacfb9a2-4bbf-54e6-a493-8b362e4789c0@kaod.org>
Date: Fri, 18 Oct 2019 11:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018035557.GC2000@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 9874142184143752089
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeelgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.80
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

On 18/10/2019 05:55, David Gibson wrote:
> On Thu, Oct 17, 2019 at 04:42:41PM +0200, C=E9dric Le Goater wrote:
>> When a Virtual Processor is scheduled to run on a HW thread, the
>> hypervisor pushes its identifier in the OS CAM line. When running in
>> TCG or kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.
>>
>> Introduce a 'os-cam' property which will be used to set the OS CAM
>> line at reset and remove the spapr_xive_set_tctx_os_cam() calls which
>> are done when the XIVE interrupt controller are activated.
>=20
> I'm not immediately seeing the advantage of doing this via a property,
> rather than poking it from the PAPR code which already knows the right
> values.

we can simplify by passing the OS CAM line value as a parameter of the=20
xive_tctx_reset routine, as suggested by Greg.

>=20
> Also, let me check my understanding:
>   IIUC, on powernv the OS (running in HV mode) can alter the OS CAM
>   lines for itself=20

OPAL only sets the VT bit in the HW cam line.

Linux PowerNV sets the POOL CAM line.

> and/or its guests,=20

KVM sets the OS CAM line when a vCPU is scheduled to run.

> but for pseries they're fixed in place.  Is that right?

QEMU emulates KVM and sets the OS CAM line to a value similar to what KVM
would use. We can consider this value a reset constant.

C.

=20
>> This change also has the benefit to remove the use of CPU_FOREACH()
>> which can be unsafe.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_xive.h |  1 -
>>  include/hw/ppc/xive.h       |  4 +++-
>>  hw/intc/spapr_xive.c        | 31 +++++--------------------------
>>  hw/intc/xive.c              | 22 +++++++++++++++++++++-
>>  hw/ppc/pnv.c                |  3 ++-
>>  5 files changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index d84bd5c229f0..742b7e834f2a 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -57,7 +57,6 @@ typedef struct SpaprXive {
>>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
>> =20
>>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
>> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
>>  void spapr_xive_map_mmio(SpaprXive *xive);
>> =20
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 99381639f50c..e273069c25a9 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -319,6 +319,7 @@ typedef struct XiveTCTX {
>>      qemu_irq    os_output;
>> =20
>>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>> +    uint32_t    os_cam;
>>  } XiveTCTX;
>> =20
>>  /*
>> @@ -414,7 +415,8 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr off=
set, uint64_t value,
>>  uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned si=
ze);
>> =20
>>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)=
;
>> +Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, uint32_t os_c=
am,
>> +                         Error **errp);
>>  void xive_tctx_reset(XiveTCTX *tctx);
>> =20
>>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 0c3acf1a4192..71f138512a1c 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -205,21 +205,13 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive=
, bool enable)
>>      memory_region_set_enabled(&xive->end_source.esb_mmio, false);
>>  }
>> =20
>> -/*
>> - * When a Virtual Processor is scheduled to run on a HW thread, the
>> - * hypervisor pushes its identifier in the OS CAM line. Emulate the
>> - * same behavior under QEMU.
>> - */
>> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
>> +static uint32_t spapr_xive_get_os_cam(PowerPCCPU *cpu)
>>  {
>>      uint8_t  nvt_blk;
>>      uint32_t nvt_idx;
>> -    uint32_t nvt_cam;
>> -
>> -    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
>> =20
>> -    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, =
nvt_idx));
>> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
>> +    spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
>> +    return xive_nvt_cam_line(nvt_blk, nvt_idx);
>>  }
>> =20
>>  static void spapr_xive_end_reset(XiveEND *end)
>> @@ -537,19 +529,14 @@ static int spapr_xive_cpu_intc_create(SpaprInter=
ruptController *intc,
>>      SpaprXive *xive =3D SPAPR_XIVE(intc);
>>      Object *obj;
>>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>> +    uint32_t os_cam =3D spapr_xive_get_os_cam(cpu);
>> =20
>> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
>> +    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), os_cam, =
errp);
>>      if (!obj) {
>>          return -1;
>>      }
>> =20
>>      spapr_cpu->tctx =3D XIVE_TCTX(obj);
>> -
>> -    /*
>> -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as the=
y
>> -     * don't beneficiate from the reset of the XIVE IRQ backend
>> -     */
>> -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
>>      return 0;
>>  }
>> =20
>> @@ -650,14 +637,6 @@ static void spapr_xive_dt(SpaprInterruptControlle=
r *intc, uint32_t nr_servers,
>>  static int spapr_xive_activate(SpaprInterruptController *intc, Error =
**errp)
>>  {
>>      SpaprXive *xive =3D SPAPR_XIVE(intc);
>> -    CPUState *cs;
>> -
>> -    CPU_FOREACH(cs) {
>> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> -
>> -        /* (TCG) Set the OS CAM line of the thread interrupt context.=
 */
>> -        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>> -    }
>> =20
>>      if (kvm_enabled()) {
>>          int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp=
);
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 0ae3f9b1efe4..be4f2c974178 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -566,6 +566,18 @@ static void xive_tctx_reset_handler(void *dev)
>>          ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
>>      tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =3D
>>          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
>> +
>> +    /*
>> +     * (TCG) Set the OS CAM line of the thread interrupt context.
>> +     *
>> +     * When a Virtual Processor is scheduled to run on a HW thread,
>> +     * the hypervisor pushes its identifier in the OS CAM line.
>> +     * Emulate the same behavior under QEMU.
>> +     */
>> +    if (tctx->os_cam) {
>> +        uint32_t qw1w2 =3D cpu_to_be32(TM_QW1W2_VO | tctx->os_cam);
>> +        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
>> +    }
>>  }
>> =20
>>  void xive_tctx_reset(XiveTCTX *tctx)
>> @@ -667,11 +679,17 @@ static const VMStateDescription vmstate_xive_tct=
x =3D {
>>      },
>>  };
>> =20
>> +static Property  xive_tctx_properties[] =3D {
>> +    DEFINE_PROP_UINT32("os-cam", XiveTCTX, os_cam, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>  static void xive_tctx_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>> =20
>>      dc->desc =3D "XIVE Interrupt Thread Context";
>> +    dc->props =3D xive_tctx_properties;
>>      dc->realize =3D xive_tctx_realize;
>>      dc->unrealize =3D xive_tctx_unrealize;
>>      dc->vmsd =3D &vmstate_xive_tctx;
>> @@ -689,7 +707,8 @@ static const TypeInfo xive_tctx_info =3D {
>>      .class_init    =3D xive_tctx_class_init,
>>  };
>> =20
>> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
>> +Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, uint32_t os_c=
am,
>> +                         Error **errp)
>>  {
>>      Error *local_err =3D NULL;
>>      Object *obj;
>> @@ -698,6 +717,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *=
xrtr, Error **errp)
>>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort)=
;
>>      object_unref(obj);
>>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
>> +    object_property_set_int(obj, os_cam, "os-cam", &local_err);
>>      object_property_set_bool(obj, true, "realized", &local_err);
>>      if (local_err) {
>>          goto error;
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 7cf64b6d2533..99c06842573e 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -806,7 +806,8 @@ static void pnv_chip_power9_intc_create(PnvChip *c=
hip, PowerPCCPU *cpu,
>>       * controller object is initialized afterwards. Hopefully, it's
>>       * only used at runtime.
>>       */
>> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), =
&local_err);
>> +    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), =
0,
>> +                           &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>=20



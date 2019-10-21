Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63135CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F3B20684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F3B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUgM-0006Wn-Bi
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMUfM-0005iA-Kn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMUfK-0005BM-OP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:11:56 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:49571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMUfK-00059k-I0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:11:54 -0400
Received: from player732.ha.ovh.net (unknown [10.109.160.12])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id A068022BCEF
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 12:11:44 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 3239EB19100E;
 Mon, 21 Oct 2019 10:11:37 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] spapr: Introduce a interrupt presenter reset
 handler
To: Greg Kurz <groug@kaod.org>
References: <20191018172219.10039-1-clg@kaod.org>
 <20191018172219.10039-2-clg@kaod.org> <20191019080235.7f32dc25@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c570e849-dae0-7a54-4f0c-1d66dbb7bff4@kaod.org>
Date: Mon, 21 Oct 2019 12:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019080235.7f32dc25@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9538624011798874963
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeehgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.162
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2019 08:02, Greg Kurz wrote:
> On Fri, 18 Oct 2019 19:22:18 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> The interrupt presenters are created by a machine handler at the core
>> level and are reseted independently. This is not consistent and it
>> raises some issues when it comes to handle hot-plugged CPUs. These are
>> reseted from the realize handler of the core and the presenters are
>> not. This is less of an issue in XICS, although a zero MFFR could be a
>> concern, but in XIVE, the OS CAM line is not set and this breaks the
>> presenting algorithm. The current code has workarounds which need a
>> global cleanup.
>>
>> Extend the sPAPR IRQ backend with a new cpu_intc_reset() handler which
>> will be called by the CPU reset handler and remove the XiveTCTX reset
>> handler which is redundant.
>>
>> spapr_realize_vcpu() is modified to call the CPU reset only after the
>> intc presenter has been created.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  The change of order of the CPU reset and the intc creation could be
>>  in its own patch for bisect. This is fragile.
>> =20
>=20
> And there's a nit. See below.
>=20
> Otherwise, LGTM.

ok. I will address that in a v3.=20

The CPUs of the PowerNV machine are very similar, (no hotplug though) and=
=20
I also need to add the same kind of intc reset.

Thanks,

C.=20

>=20
>>  include/hw/ppc/spapr_irq.h |  2 ++
>>  include/hw/ppc/xics.h      |  1 +
>>  include/hw/ppc/xive.h      |  1 +
>>  hw/intc/spapr_xive.c       |  7 +++++++
>>  hw/intc/xics.c             |  8 ++------
>>  hw/intc/xics_spapr.c       |  7 +++++++
>>  hw/intc/xive.c             | 12 +-----------
>>  hw/ppc/spapr_cpu_core.c    | 14 ++++++++++----
>>  hw/ppc/spapr_irq.c         | 14 ++++++++++++++
>>  9 files changed, 45 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 5e150a667902..09232999b07e 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -52,6 +52,7 @@ typedef struct SpaprInterruptControllerClass {
>>       */
>>      int (*cpu_intc_create)(SpaprInterruptController *intc,
>>                              PowerPCCPU *cpu, Error **errp);
>> +    void (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU=
 *cpu);
>>      int (*claim_irq)(SpaprInterruptController *intc, int irq, bool ls=
i,
>>                       Error **errp);
>>      void (*free_irq)(SpaprInterruptController *intc, int irq);
>> @@ -68,6 +69,7 @@ void spapr_irq_update_active_intc(SpaprMachineState =
*spapr);
>> =20
>>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>>                                PowerPCCPU *cpu, Error **errp);
>> +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *c=
pu);
>>  void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
>>  void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>>                    void *fdt, uint32_t phandle);
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 1e6a9300eb2b..602173c12250 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -161,6 +161,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
>>  uint32_t icp_accept(ICPState *ss);
>>  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
>>  void icp_eoi(ICPState *icp, uint32_t xirr);
>> +void icp_reset(ICPState *icp);
>> =20
>>  void ics_write_xive(ICSState *ics, int nr, int server,
>>                      uint8_t priority, uint8_t saved_priority);
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index fd3319bd3202..99381639f50c 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -415,6 +415,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr =
offset, unsigned size);
>> =20
>>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)=
;
>> +void xive_tctx_reset(XiveTCTX *tctx);
>> =20
>>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
>>  {
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index ba32d2cc5b0f..258b1c5fb5ff 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -553,6 +553,12 @@ static int spapr_xive_cpu_intc_create(SpaprInterr=
uptController *intc,
>>      return 0;
>>  }
>> =20
>> +static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
>> +                                     PowerPCCPU *cpu)
>> +{
>> +    xive_tctx_reset(spapr_cpu_state(cpu)->tctx);
>> +}
>> +
>>  static void spapr_xive_set_irq(SpaprInterruptController *intc, int ir=
q, int val)
>>  {
>>      SpaprXive *xive =3D SPAPR_XIVE(intc);
>> @@ -697,6 +703,7 @@ static void spapr_xive_class_init(ObjectClass *kla=
ss, void *data)
>>      sicc->activate =3D spapr_xive_activate;
>>      sicc->deactivate =3D spapr_xive_deactivate;
>>      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
>> +    sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
>>      sicc->claim_irq =3D spapr_xive_claim_irq;
>>      sicc->free_irq =3D spapr_xive_free_irq;
>>      sicc->set_irq =3D spapr_xive_set_irq;
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index b5ac408f7b74..6da05763f9db 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -274,10 +274,8 @@ static const VMStateDescription vmstate_icp_serve=
r =3D {
>>      },
>>  };
>> =20
>> -static void icp_reset_handler(void *dev)
>> +void icp_reset(ICPState *icp)
>>  {
>> -    ICPState *icp =3D ICP(dev);
>> -
>>      icp->xirr =3D 0;
>>      icp->pending_priority =3D 0xff;
>>      icp->mfrr =3D 0xff;
>> @@ -288,7 +286,7 @@ static void icp_reset_handler(void *dev)
>>      if (kvm_irqchip_in_kernel()) {
>>          Error *local_err =3D NULL;
>> =20
>> -        icp_set_kvm_state(ICP(dev), &local_err);
>> +        icp_set_kvm_state(icp, &local_err);
>>          if (local_err) {
>>              error_report_err(local_err);
>>          }
>> @@ -351,7 +349,6 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
>>          }
>>      }
>> =20
>> -    qemu_register_reset(icp_reset_handler, dev);
>>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, i=
cp);
>>  }
>> =20
>> @@ -360,7 +357,6 @@ static void icp_unrealize(DeviceState *dev, Error =
**errp)
>>      ICPState *icp =3D ICP(dev);
>> =20
>>      vmstate_unregister(NULL, &vmstate_icp_server, icp);
>> -    qemu_unregister_reset(icp_reset_handler, dev);
>>  }
>> =20
>>  static void icp_class_init(ObjectClass *klass, void *data)
>> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
>> index 4f64b9a9fc66..7418fb9f370c 100644
>> --- a/hw/intc/xics_spapr.c
>> +++ b/hw/intc/xics_spapr.c
>> @@ -346,6 +346,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterr=
uptController *intc,
>>      return 0;
>>  }
>> =20
>> +static void xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
>> +                                     PowerPCCPU *cpu)
>> +{
>> +    icp_reset(spapr_cpu_state(cpu)->icp);
>> +}
>> +
>>  static int xics_spapr_claim_irq(SpaprInterruptController *intc, int i=
rq,
>>                                  bool lsi, Error **errp)
>>  {
>> @@ -433,6 +439,7 @@ static void ics_spapr_class_init(ObjectClass *klas=
s, void *data)
>>      sicc->activate =3D xics_spapr_activate;
>>      sicc->deactivate =3D xics_spapr_deactivate;
>>      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
>> +    sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
>>      sicc->claim_irq =3D xics_spapr_claim_irq;
>>      sicc->free_irq =3D xics_spapr_free_irq;
>>      sicc->set_irq =3D xics_spapr_set_irq;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index d420c6571e14..f066be5eb5e3 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -547,10 +547,8 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Mon=
itor *mon)
>>      }
>>  }
>> =20
>> -static void xive_tctx_reset(void *dev)
>> +void xive_tctx_reset(XiveTCTX *tctx)
>>  {
>> -    XiveTCTX *tctx =3D XIVE_TCTX(dev);
>> -
>>      memset(tctx->regs, 0, sizeof(tctx->regs));
>> =20
>>      /* Set some defaults */
>> @@ -607,13 +605,6 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
>>              return;
>>          }
>>      }
>> -
>> -    qemu_register_reset(xive_tctx_reset, dev);
>> -}
>> -
>> -static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
>> -{
>> -    qemu_unregister_reset(xive_tctx_reset, dev);
>>  }
>> =20
>>  static int vmstate_xive_tctx_pre_save(void *opaque)
>> @@ -668,7 +659,6 @@ static void xive_tctx_class_init(ObjectClass *klas=
s, void *data)
>> =20
>>      dc->desc =3D "XIVE Interrupt Thread Context";
>>      dc->realize =3D xive_tctx_realize;
>> -    dc->unrealize =3D xive_tctx_unrealize;
>>      dc->vmsd =3D &vmstate_xive_tctx;
>>      /*
>>       * Reason: part of XIVE interrupt controller, needs to be wired u=
p
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 3e4302c7d596..d04baa7cde4f 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -33,6 +33,7 @@ static void spapr_cpu_reset(void *opaque)
>>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>>      target_ulong lpcr;
>> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>> =20
>>      cpu_reset(cs);
>> =20
>> @@ -77,9 +78,11 @@ static void spapr_cpu_reset(void *opaque)
>>      spapr_cpu->dtl_addr =3D 0;
>>      spapr_cpu->dtl_size =3D 0;
>> =20
>> -    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
>> +    spapr_caps_cpu_apply(spapr, cpu);
>> =20
>>      kvm_check_mmu(cpu, &error_fatal);
>> +
>> +    spapr_irq_cpu_intc_reset(spapr, cpu);
>>  }
>> =20
>>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, tar=
get_ulong r3)
>> @@ -234,13 +237,16 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, =
SpaprMachineState *spapr,
>>      cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>>      kvmppc_set_papr(cpu);
>> =20
>> -    qemu_register_reset(spapr_cpu_reset, cpu);
>> -    spapr_cpu_reset(cpu);
>> -
>>      if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
>>          goto error_unregister;
>=20
> We no longer need to call qemu_unregister_reset() on rollback then.
> Maybe rename the label as well.
>=20
>>      }
>> =20
>> +    /*
>> +     * Hot-plugged CPUs are not reseted. Do it here.
>> +     */
>> +    qemu_register_reset(spapr_cpu_reset, cpu);
>> +    spapr_cpu_reset(cpu);
>> +
>>      if (!sc->pre_3_0_migration) {
>>          vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_stat=
e,
>>                           cpu->machine_data);
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 234d1073e518..b941608b69ba 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -220,6 +220,20 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *=
spapr,
>>      return 0;
>>  }
>> =20
>> +void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *c=
pu)
>> +{
>> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
>> +    int i;
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
>> +        SpaprInterruptController *intc =3D intcs[i];
>> +        if (intc) {
>> +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CL=
ASS(intc);
>> +            sicc->cpu_intc_reset(intc, cpu);
>> +        }
>> +    }
>> +}
>> +
>>  static void spapr_set_irq(void *opaque, int irq, int level)
>>  {
>>      SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
>=20



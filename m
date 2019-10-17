Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A729FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F51F20820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F51F20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6lq-0002pg-KB
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iL62n-0006E6-RV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iL62l-0006a5-4s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:42:21 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:35661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iL62k-0006Zj-S8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:42:19 -0400
Received: from player759.ha.ovh.net (unknown [10.109.159.7])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 228F11474D9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:42:15 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 92628B1FFEFF;
 Thu, 17 Oct 2019 13:42:07 +0000 (UTC)
Subject: Re: [RFC 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com,
 groug@kaod.org
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-6-david@gibson.dropbear.id.au>
 <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
Message-ID: <2319e683-983c-2c40-3234-c4c43555c657@kaod.org>
Date: Thu, 17 Oct 2019 15:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 8049902861957303104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.78.111
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/2019 10:43, C=C3=A9dric Le Goater wrote:
> On 17/10/2019 07:42, David Gibson wrote:
>> Traditional PCI INTx for vfio devices can only perform well if using
>> an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
>> if an in kernel irqchip is not available.
>>
>> We usually do have an in-kernel irqchip available for pseries machines
>> on POWER hosts.  However, because the platform allows feature
>> negotiation of what interrupt controller model to use, we don't
>> currently initialize it until machine reset.  vfio_intx_update() is
>> called (first) from vfio_realize() before that, so it can issue a
>> spurious warning, even if we will have an in kernel irqchip by the
>> time we need it.
>>
>> To workaround this, make a call to spapr_irq_update_active_intc() from
>> spapr_irq_init() which is called at machine realize time, before the
>> vfio realize.  This call will be pretty much obsoleted by the later
>> call at reset time, but it serves to suppress the spurious warning
>> from VFIO.
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/spapr_irq.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 45544b8976..bb91c61fa0 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -345,6 +345,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
>> =20
>>      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
>>                                        smc->nr_xirqs + SPAPR_XIRQ_BASE=
);
>> +
>> +    /*
>> +     * Mostly we don't actually need this until reset, except that no=
t
>> +     * having this set up can cause VFIO devices to issue a
>> +     * false-positive warning during realize(), because they don't ye=
t
>> +     * have an in-kernel irq chip.
>> +     */
>> +    spapr_irq_update_active_intc(spapr);
>=20
> This will call the de/activate hooks of the irq chip very early=20
> before reset and CAS, and won't call them at reset if the intc
> pointers are the same (xive only for instance). It breaks very=20
> obviously the emulated XIVE device which won't reset the OS CAM=20
> line with the CPU id values and CPU notification will be broken.
>=20
> We have to find something else.

Here is a possible fix for the (re)setting of the OS CAM line.=20

Removing spapr_xive_set_tctx_os_cam() is a good thing but this solution
shows some issues in our modeling of hot-plugged CPUS with a reset()=20
being called at realize().


Thanks,

C.


From eb6086645b1db13a8e021e8a5b8a2c6faba875b3 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
Date: Thu, 17 Oct 2019 15:35:36 +0200
Subject: [PATCH] spapr/xive: Set the OS CAM line at reset
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

When a Virtual Processor is scheduled to run on a HW thread, the
hypervisor pushes its identifier in the OS CAM line. When running in
TCG or kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.

Introduce a 'os-cam' property which will be used to set the OS CAM
line at reset.

Complexity arise with hotplug CPUs which need an extra reset of the
intc presenter of the interrupt controller selected by CAS. The sPAPR
IRQ backend is extended with new handler cpu_intc_reset()

spapr_realize_vcpu() is also modified to call the CPU reset after the
creation of the intc presenter.

This is a combo patch which needs to be splitted.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h  |  4 ++++
 include/hw/ppc/spapr_xive.h |  1 -
 include/hw/ppc/xics.h       |  1 +
 include/hw/ppc/xive.h       |  5 ++++-
 hw/intc/spapr_xive.c        | 37 ++++++++++++-------------------------
 hw/intc/xics.c              |  5 +++++
 hw/intc/xics_spapr.c        |  8 ++++++++
 hw/intc/xive.c              | 33 +++++++++++++++++++++++++++++----
 hw/ppc/pnv.c                |  3 ++-
 hw/ppc/spapr_cpu_core.c     |  8 ++++++--
 hw/ppc/spapr_irq.c          | 21 +++++++++++++++++++++
 11 files changed, 92 insertions(+), 34 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 5e150a667902..78327496c102 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -52,6 +52,8 @@ typedef struct SpaprInterruptControllerClass {
      */
     int (*cpu_intc_create)(SpaprInterruptController *intc,
                             PowerPCCPU *cpu, Error **errp);
+    int (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *cp=
u,
+                          Error **errp);
     int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
                      Error **errp);
     void (*free_irq)(SpaprInterruptController *intc, int irq);
@@ -68,6 +70,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *sp=
apr);
=20
 int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
+int spapr_irq_cpu_intc_reset(SpaprMachineState *spapr,
+                             PowerPCCPU *cpu, Error **errp);
 void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index d84bd5c229f0..742b7e834f2a 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -57,7 +57,6 @@ typedef struct SpaprXive {
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
=20
 void spapr_xive_hcall_init(SpaprMachineState *spapr);
-void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
 void spapr_xive_map_mmio(SpaprXive *xive);
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1e6a9300eb2b..602173c12250 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -161,6 +161,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
 uint32_t icp_accept(ICPState *ss);
 uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
 void icp_eoi(ICPState *icp, uint32_t xirr);
+void icp_reset(ICPState *icp);
=20
 void ics_write_xive(ICSState *ics, int nr, int server,
                     uint8_t priority, uint8_t saved_priority);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fd3319bd3202..e273069c25a9 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -319,6 +319,7 @@ typedef struct XiveTCTX {
     qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+    uint32_t    os_cam;
 } XiveTCTX;
=20
 /*
@@ -414,7 +415,9 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
 uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size)=
;
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
+Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, uint32_t os_cam,
+                         Error **errp);
+void xive_tctx_reset(XiveTCTX *tctx);
=20
 static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
 {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ba32d2cc5b0f..71f138512a1c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -205,21 +205,13 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, b=
ool enable)
     memory_region_set_enabled(&xive->end_source.esb_mmio, false);
 }
=20
-/*
- * When a Virtual Processor is scheduled to run on a HW thread, the
- * hypervisor pushes its identifier in the OS CAM line. Emulate the
- * same behavior under QEMU.
- */
-void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
+static uint32_t spapr_xive_get_os_cam(PowerPCCPU *cpu)
 {
     uint8_t  nvt_blk;
     uint32_t nvt_idx;
-    uint32_t nvt_cam;
=20
-    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
-
-    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, nvt=
_idx));
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
+    spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
+    return xive_nvt_cam_line(nvt_blk, nvt_idx);
 }
=20
 static void spapr_xive_end_reset(XiveEND *end)
@@ -537,19 +529,21 @@ static int spapr_xive_cpu_intc_create(SpaprInterrup=
tController *intc,
     SpaprXive *xive =3D SPAPR_XIVE(intc);
     Object *obj;
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
+    uint32_t os_cam =3D spapr_xive_get_os_cam(cpu);
=20
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), os_cam, err=
p);
     if (!obj) {
         return -1;
     }
=20
     spapr_cpu->tctx =3D XIVE_TCTX(obj);
+    return 0;
+}
=20
-    /*
-     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
-     * don't beneficiate from the reset of the XIVE IRQ backend
-     */
-    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
+static int spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
+                                     PowerPCCPU *cpu, Error **errp)
+{
+    xive_tctx_reset(spapr_cpu_state(cpu)->tctx);
     return 0;
 }
=20
@@ -643,14 +637,6 @@ static void spapr_xive_dt(SpaprInterruptController *=
intc, uint32_t nr_servers,
 static int spapr_xive_activate(SpaprInterruptController *intc, Error **e=
rrp)
 {
     SpaprXive *xive =3D SPAPR_XIVE(intc);
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-
-        /* (TCG) Set the OS CAM line of the thread interrupt context. */
-        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
-    }
=20
     if (kvm_enabled()) {
         int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);
@@ -697,6 +683,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     sicc->activate =3D spapr_xive_activate;
     sicc->deactivate =3D spapr_xive_deactivate;
     sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
+    sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
     sicc->claim_irq =3D spapr_xive_claim_irq;
     sicc->free_irq =3D spapr_xive_free_irq;
     sicc->set_irq =3D spapr_xive_set_irq;
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b5ac408f7b74..652771d6a5a5 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -295,6 +295,11 @@ static void icp_reset_handler(void *dev)
     }
 }
=20
+void icp_reset(ICPState *icp)
+{
+    icp_reset_handler(icp);
+}
+
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 4f64b9a9fc66..c0b2a576effe 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -346,6 +346,13 @@ static int xics_spapr_cpu_intc_create(SpaprInterrupt=
Controller *intc,
     return 0;
 }
=20
+static int xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
+                                     PowerPCCPU *cpu, Error **errp)
+{
+    icp_reset(spapr_cpu_state(cpu)->icp);
+    return 0;
+}
+
 static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
                                 bool lsi, Error **errp)
 {
@@ -433,6 +440,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
     sicc->activate =3D xics_spapr_activate;
     sicc->deactivate =3D xics_spapr_deactivate;
     sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
+    sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
     sicc->claim_irq =3D xics_spapr_claim_irq;
     sicc->free_irq =3D xics_spapr_free_irq;
     sicc->set_irq =3D xics_spapr_set_irq;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d420c6571e14..be4f2c974178 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -547,7 +547,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor=
 *mon)
     }
 }
=20
-static void xive_tctx_reset(void *dev)
+static void xive_tctx_reset_handler(void *dev)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
=20
@@ -566,6 +566,23 @@ static void xive_tctx_reset(void *dev)
         ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
     tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =3D
         ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
+
+    /*
+     * (TCG) Set the OS CAM line of the thread interrupt context.
+     *
+     * When a Virtual Processor is scheduled to run on a HW thread,
+     * the hypervisor pushes its identifier in the OS CAM line.
+     * Emulate the same behavior under QEMU.
+     */
+    if (tctx->os_cam) {
+        uint32_t qw1w2 =3D cpu_to_be32(TM_QW1W2_VO | tctx->os_cam);
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+    }
+}
+
+void xive_tctx_reset(XiveTCTX *tctx)
+{
+    xive_tctx_reset_handler(tctx);
 }
=20
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
@@ -608,12 +625,12 @@ static void xive_tctx_realize(DeviceState *dev, Err=
or **errp)
         }
     }
=20
-    qemu_register_reset(xive_tctx_reset, dev);
+    qemu_register_reset(xive_tctx_reset_handler, dev);
 }
=20
 static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
 {
-    qemu_unregister_reset(xive_tctx_reset, dev);
+    qemu_unregister_reset(xive_tctx_reset_handler, dev);
 }
=20
 static int vmstate_xive_tctx_pre_save(void *opaque)
@@ -662,11 +679,17 @@ static const VMStateDescription vmstate_xive_tctx =3D=
 {
     },
 };
=20
+static Property  xive_tctx_properties[] =3D {
+    DEFINE_PROP_UINT32("os-cam", XiveTCTX, os_cam, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xive_tctx_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->desc =3D "XIVE Interrupt Thread Context";
+    dc->props =3D xive_tctx_properties;
     dc->realize =3D xive_tctx_realize;
     dc->unrealize =3D xive_tctx_unrealize;
     dc->vmsd =3D &vmstate_xive_tctx;
@@ -684,7 +707,8 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
-Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
+Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, uint32_t os_cam,
+                         Error **errp)
 {
     Error *local_err =3D NULL;
     Object *obj;
@@ -693,6 +717,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_int(obj, os_cam, "os-cam", &local_err);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7cf64b6d2533..99c06842573e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -806,7 +806,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
      * controller object is initialized afterwards. Hopefully, it's
      * only used at runtime.
      */
-    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), &lo=
cal_err);
+    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), 0,
+                           &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3e4302c7d596..416aa75e5fba 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -33,6 +33,7 @@ static void spapr_cpu_reset(void *opaque)
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     target_ulong lpcr;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
     cpu_reset(cs);
=20
@@ -77,9 +78,11 @@ static void spapr_cpu_reset(void *opaque)
     spapr_cpu->dtl_addr =3D 0;
     spapr_cpu->dtl_size =3D 0;
=20
-    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
+    spapr_caps_cpu_apply(spapr, cpu);
=20
     kvm_check_mmu(cpu, &error_fatal);
+
+    spapr_irq_cpu_intc_reset(spapr, cpu, &error_fatal);
 }
=20
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
@@ -235,12 +238,13 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
     kvmppc_set_papr(cpu);
=20
     qemu_register_reset(spapr_cpu_reset, cpu);
-    spapr_cpu_reset(cpu);
=20
     if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
         goto error_unregister;
     }
=20
+    spapr_cpu_reset(cpu);
+
     if (!sc->pre_3_0_migration) {
         vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
                          cpu->machine_data);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index bb91c61fa000..5d2b64029cd5 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -220,6 +220,27 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *spa=
pr,
     return 0;
 }
=20
+int spapr_irq_cpu_intc_reset(SpaprMachineState *spapr,
+                             PowerPCCPU *cpu, Error **errp)
+{
+    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
+    int i;
+    int rc;
+
+    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
+        SpaprInterruptController *intc =3D intcs[i];
+        if (intc) {
+            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
+            rc =3D sicc->cpu_intc_reset(intc, cpu, errp);
+            if (rc < 0) {
+                return rc;
+            }
+        }
+    }
+
+    return 0;
+}
+
 static void spapr_set_irq(void *opaque, int irq, int level)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
--=20
2.21.0




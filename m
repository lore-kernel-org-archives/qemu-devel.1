Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D3ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AB4206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AB4206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJzJd-0001fo-Eq
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzN-0005Th-Nq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzK-0003Yg-5l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:13 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:35692)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzJ-0003W3-MK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:10 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id F36106E187;
 Mon, 14 Oct 2019 20:58:08 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 9ADE424008F;
 Mon, 14 Oct 2019 20:58:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v26 14/21] hw/intc: RX62N interrupt controller (ICUa)
Date: Mon, 14 Oct 2019 20:57:50 +0900
Message-Id: <20191014115757.51866-15-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014115757.51866-1-ysato@users.sourceforge.jp>
References: <20191014115757.51866-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, philmd@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implementation supported only ICUa.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607091116.49044-6-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/rx_icu.h |  56 ++++++
 hw/intc/rx_icu.c         | 379 +++++++++++++++++++++++++++++++++++++++
 hw/intc/Kconfig          |   3 +
 hw/intc/Makefile.objs    |   1 +
 4 files changed, 439 insertions(+)
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 hw/intc/rx_icu.c

diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
new file mode 100644
index 0000000000..acfcf06aef
--- /dev/null
+++ b/include/hw/intc/rx_icu.h
@@ -0,0 +1,56 @@
+#ifndef RX_ICU_H
+#define RX_ICU_H
+
+#include "qemu-common.h"
+#include "hw/irq.h"
+
+enum TRG_MODE {
+    TRG_LEVEL =3D 0,
+    TRG_NEDGE =3D 1,      /* Falling */
+    TRG_PEDGE =3D 2,      /* Raising */
+    TRG_BEDGE =3D 3,      /* Both */
+};
+
+struct IRQSource {
+    enum TRG_MODE sense;
+    int level;
+};
+
+enum {
+    /* Software interrupt request */
+    SWI =3D 27,
+    NR_IRQS =3D 256,
+};
+
+struct RXICUState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion memory;
+    struct IRQSource src[NR_IRQS];
+    char *icutype;
+    uint32_t nr_irqs;
+    uint32_t *map;
+    uint32_t nr_sense;
+    uint32_t *init_sense;
+
+    uint8_t ir[NR_IRQS];
+    uint8_t dtcer[NR_IRQS];
+    uint8_t ier[NR_IRQS / 8];
+    uint8_t ipr[142];
+    uint8_t dmasr[4];
+    uint16_t fir;
+    uint8_t nmisr;
+    uint8_t nmier;
+    uint8_t nmiclr;
+    uint8_t nmicr;
+    int req_irq;
+    qemu_irq _irq;
+    qemu_irq _fir;
+    qemu_irq _swi;
+};
+typedef struct RXICUState RXICUState;
+
+#define TYPE_RXICU "rx-icu"
+#define RXICU(obj) OBJECT_CHECK(RXICUState, (obj), TYPE_RXICU)
+
+#endif /* RX_ICU_H */
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
new file mode 100644
index 0000000000..ac4dcbfe37
--- /dev/null
+++ b/hw/intc/rx_icu.c
@@ -0,0 +1,379 @@
+/*
+ * RX Interrupt Control Unit
+ *
+ * Warning: Only ICUa is supported.
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/rx_icu.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG8(IR, 0)
+  FIELD(IR, IR,  0, 1)
+REG8(DTCER, 0x100)
+  FIELD(DTCER, DTCE,  0, 1)
+REG8(IER, 0x200)
+REG8(SWINTR, 0x2e0)
+  FIELD(SWINTR, SWINT, 0, 1)
+REG16(FIR, 0x2f0)
+  FIELD(FIR, FVCT, 0, 8)
+  FIELD(FIR, FIEN, 15, 1)
+REG8(IPR, 0x300)
+  FIELD(IPR, IPR, 0, 4)
+REG8(DMRSR, 0x400)
+REG8(IRQCR, 0x500)
+  FIELD(IRQCR, IRQMD, 2, 2)
+REG8(NMISR, 0x580)
+  FIELD(NMISR, NMIST, 0, 1)
+  FIELD(NMISR, LVDST, 1, 1)
+  FIELD(NMISR, OSTST, 2, 1)
+REG8(NMIER, 0x581)
+  FIELD(NMIER, NMIEN, 0, 1)
+  FIELD(NMIER, LVDEN, 1, 1)
+  FIELD(NMIER, OSTEN, 2, 1)
+REG8(NMICLR, 0x582)
+  FIELD(NMICLR, NMICLR, 0, 1)
+  FIELD(NMICLR, OSTCLR, 2, 1)
+REG8(NMICR, 0x583)
+  FIELD(NMICR, NMIMD, 3, 1)
+
+#define request(icu, n) (icu->ipr[icu->map[n]] << 8 | n)
+
+static void set_irq(RXICUState *icu, int n_IRQ, int req)
+{
+    if ((icu->fir & R_FIR_FIEN_MASK) &&
+        (icu->fir & R_FIR_FVCT_MASK) =3D=3D n_IRQ) {
+        qemu_set_irq(icu->_fir, req);
+    } else {
+        qemu_set_irq(icu->_irq, req);
+    }
+}
+
+static void rxicu_request(RXICUState *icu, int n_IRQ)
+{
+    int enable;
+
+    enable =3D icu->ier[n_IRQ / 8] & (1 << (n_IRQ & 7));
+    if (n_IRQ > 0 && enable !=3D 0 && atomic_read(&icu->req_irq) < 0) {
+        atomic_set(&icu->req_irq, n_IRQ);
+        set_irq(icu, n_IRQ, request(icu, n_IRQ));
+    }
+}
+
+static void rxicu_set_irq(void *opaque, int n_IRQ, int level)
+{
+    RXICUState *icu =3D opaque;
+    struct IRQSource *src;
+    int issue;
+
+    if (n_IRQ >=3D NR_IRQS) {
+        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
+        return;
+    }
+
+    src =3D &icu->src[n_IRQ];
+
+    level =3D (level !=3D 0);
+    switch (src->sense) {
+    case TRG_LEVEL:
+        /* level-sensitive irq */
+        issue =3D level;
+        src->level =3D level;
+        break;
+    case TRG_NEDGE:
+        issue =3D (level =3D=3D 0 && src->level =3D=3D 1);
+        src->level =3D level;
+        break;
+    case TRG_PEDGE:
+        issue =3D (level =3D=3D 1 && src->level =3D=3D 0);
+        src->level =3D level;
+        break;
+    case TRG_BEDGE:
+        issue =3D ((level ^ src->level) & 1);
+        src->level =3D level;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (issue =3D=3D 0 && src->sense =3D=3D TRG_LEVEL) {
+        icu->ir[n_IRQ] =3D 0;
+        if (atomic_read(&icu->req_irq) =3D=3D n_IRQ) {
+            /* clear request */
+            set_irq(icu, n_IRQ, 0);
+            atomic_set(&icu->req_irq, -1);
+        }
+        return;
+    }
+    if (issue) {
+        icu->ir[n_IRQ] =3D 1;
+        rxicu_request(icu, n_IRQ);
+    }
+}
+
+static void rxicu_ack_irq(void *opaque, int no, int level)
+{
+    RXICUState *icu =3D opaque;
+    int i;
+    int n_IRQ;
+    int max_pri;
+
+    n_IRQ =3D atomic_read(&icu->req_irq);
+    if (n_IRQ < 0) {
+        return;
+    }
+    atomic_set(&icu->req_irq, -1);
+    if (icu->src[n_IRQ].sense !=3D TRG_LEVEL) {
+        icu->ir[n_IRQ] =3D 0;
+    }
+
+    max_pri =3D 0;
+    n_IRQ =3D -1;
+    for (i =3D 0; i < NR_IRQS; i++) {
+        if (icu->ir[i]) {
+            if (max_pri < icu->ipr[icu->map[i]]) {
+                n_IRQ =3D i;
+                max_pri =3D icu->ipr[icu->map[i]];
+            }
+        }
+    }
+
+    if (n_IRQ >=3D 0) {
+        rxicu_request(icu, n_IRQ);
+    }
+}
+
+static uint64_t icu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RXICUState *icu =3D opaque;
+    int reg =3D addr & 0xff;
+
+    if ((addr !=3D A_FIR && size !=3D 1) ||
+        (addr =3D=3D A_FIR && size !=3D 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rx_icu: Invalid read size 0x%"
+                      HWADDR_PRIX "\n", addr);
+        return UINT64_MAX;
+    }
+    switch (addr) {
+    case A_IR ... A_IR + 0xff:
+        return icu->ir[reg] & R_IR_IR_MASK;
+    case A_DTCER ... A_DTCER + 0xff:
+        return icu->dtcer[reg] & R_DTCER_DTCE_MASK;
+    case A_IER ... A_IER + 0x1f:
+        return icu->ier[reg];
+    case A_SWINTR:
+        return 0;
+    case A_FIR:
+        return icu->fir & (R_FIR_FIEN_MASK | R_FIR_FVCT_MASK);
+    case A_IPR ... A_IPR + 0x8f:
+        return icu->ipr[reg] & R_IPR_IPR_MASK;
+    case A_DMRSR:
+    case A_DMRSR + 4:
+    case A_DMRSR + 8:
+    case A_DMRSR + 12:
+        return icu->dmasr[reg >> 2];
+    case A_IRQCR ... A_IRQCR + 0x1f:
+        return icu->src[64 + reg].sense << R_IRQCR_IRQMD_SHIFT;
+    case A_NMISR:
+    case A_NMICLR:
+        return 0;
+    case A_NMIER:
+        return icu->nmier;
+    case A_NMICR:
+        return icu->nmicr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rx_icu: Register 0x%" HWADDR_PRIX
+                      " not implemented.\n", addr);
+        break;
+    }
+    return UINT64_MAX;
+}
+
+static void icu_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
+{
+    RXICUState *icu =3D opaque;
+    int reg =3D addr & 0xff;
+
+    if ((addr !=3D A_FIR && size !=3D 1) ||
+        (addr =3D=3D A_FIR && size !=3D 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rx_icu: Invalid write size at 0x=
%"
+                      HWADDR_PRIX "\n", addr);
+        return;
+    }
+    switch (addr) {
+    case A_IR ... A_IR + 0xff:
+        if (icu->src[reg].sense !=3D TRG_LEVEL && val =3D=3D 0) {
+            icu->ir[reg] =3D 0;
+        }
+        break;
+    case A_DTCER ... A_DTCER + 0xff:
+        icu->dtcer[reg] =3D val & R_DTCER_DTCE_MASK;
+        qemu_log_mask(LOG_UNIMP,
+                      "rx_icu: DTC not implemented\n");
+        break;
+    case A_IER ... A_IER + 0x1f:
+        icu->ier[reg] =3D val;
+        break;
+    case A_SWINTR:
+        if (val & R_SWINTR_SWINT_MASK) {
+            qemu_irq_pulse(icu->_swi);
+        }
+        break;
+    case A_FIR:
+        icu->fir =3D val & (R_FIR_FIEN_MASK | R_FIR_FVCT_MASK);
+        break;
+    case A_IPR ... A_IPR + 0x8f:
+        icu->ipr[reg] =3D val & R_IPR_IPR_MASK;
+        break;
+    case A_DMRSR:
+    case A_DMRSR + 4:
+    case A_DMRSR + 8:
+    case A_DMRSR + 12:
+        icu->dmasr[reg >> 2] =3D val;
+        qemu_log_mask(LOG_UNIMP,
+                      "rx_icu: DMAC not implemented\n");
+        break;
+    case A_IRQCR ... A_IRQCR + 0x1f:
+        icu->src[64 + reg].sense =3D val >> R_IRQCR_IRQMD_SHIFT;
+        break;
+    case A_NMICLR:
+        break;
+    case A_NMIER:
+        icu->nmier |=3D val & (R_NMIER_NMIEN_MASK |
+                             R_NMIER_LVDEN_MASK |
+                             R_NMIER_OSTEN_MASK);
+            break;
+    case A_NMICR:
+        if ((icu->nmier & R_NMIER_NMIEN_MASK) =3D=3D 0) {
+            icu->nmicr =3D val & R_NMICR_NMIMD_MASK;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "rx_icu: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps icu_ops =3D {
+    .write =3D icu_write,
+    .read  =3D icu_read,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 2,
+    },
+};
+
+static void rxicu_realize(DeviceState *dev, Error **errp)
+{
+    RXICUState *icu =3D RXICU(dev);
+    int i, j;
+
+    if (icu->init_sense =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rx_icu: trigger-level property must be set.");
+        return;
+    }
+    for (i =3D j =3D 0; i < NR_IRQS; i++) {
+        if (icu->init_sense[j] =3D=3D i) {
+            icu->src[i].sense =3D TRG_LEVEL;
+            if (j < icu->nr_sense) {
+                j++;
+            }
+        } else {
+            icu->src[i].sense =3D TRG_PEDGE;
+        }
+    }
+    icu->req_irq =3D -1;
+}
+
+static void rxicu_init(Object *obj)
+{
+    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
+    RXICUState *icu =3D RXICU(obj);
+
+    memory_region_init_io(&icu->memory, OBJECT(icu), &icu_ops,
+                          icu, "rx-icu", 0x600);
+    sysbus_init_mmio(d, &icu->memory);
+
+    qdev_init_gpio_in(DEVICE(d), rxicu_set_irq, NR_IRQS);
+    qdev_init_gpio_in_named(DEVICE(d), rxicu_ack_irq, "ack", 1);
+    sysbus_init_irq(d, &icu->_irq);
+    sysbus_init_irq(d, &icu->_fir);
+    sysbus_init_irq(d, &icu->_swi);
+}
+
+static void rxicu_fini(Object *obj)
+{
+    RXICUState *icu =3D RXICU(obj);
+    g_free(icu->map);
+    g_free(icu->init_sense);
+}
+
+static const VMStateDescription vmstate_rxicu =3D {
+    .name =3D "rx-icu",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rxicu_properties[] =3D {
+    DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
+                      qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
+                      qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rxicu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D rxicu_realize;
+    dc->props =3D rxicu_properties;
+    dc->vmsd =3D &vmstate_rxicu;
+}
+
+static const TypeInfo rxicu_info =3D {
+    .name       =3D TYPE_RXICU,
+    .parent     =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RXICUState),
+    .instance_init =3D rxicu_init,
+    .instance_finalize =3D rxicu_fini,
+    .class_init =3D rxicu_class_init,
+};
+
+static void rxicu_register_types(void)
+{
+    type_register_static(&rxicu_info);
+}
+
+type_init(rxicu_register_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 5347f8412c..67e9d97464 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -58,3 +58,6 @@ config S390_FLIC_KVM
=20
 config OMPIC
     bool
+
+config RX_ICU
+    bool
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index f726d87532..f17cbd1a9f 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -49,3 +49,4 @@ obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o
 obj-$(CONFIG_NIOS2) +=3D nios2_iic.o
 obj-$(CONFIG_OMPIC) +=3D ompic.o
+obj-$(CONFIG_RX) +=3D rx_icu.o
--=20
2.20.1



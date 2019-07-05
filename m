Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35159C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E377F218BB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E377F218BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjJng-00080L-Rm
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 04:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57059)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hjJdl-0003OH-BY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hjJdf-00062y-Ut
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:32:21 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:37217)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hjJdf-0005mv-Cw
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:32:15 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id B99A649A1F;
 Fri,  5 Jul 2019 17:32:05 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 59746240086;
 Fri,  5 Jul 2019 17:32:05 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:31:35 +0900
Message-Id: <20190705083141.106254-17-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190705083141.106254-1-ysato@users.sourceforge.jp>
References: <20190705083141.106254-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH v22 16/22] hw/char: RX62N serial communication
 interface (SCI)
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This module supported only non FIFO type.
Hardware manual.
https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607091116.49044-8-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/char/renesas_sci.h |  45 ++++++
 hw/char/renesas_sci.c         | 340 ++++++++++++++++++++++++++++++++++++=
++++++
 hw/char/Kconfig               |   3 +
 hw/char/Makefile.objs         |   1 +
 4 files changed, 389 insertions(+)
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 hw/char/renesas_sci.c

diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.=
h
new file mode 100644
index 0000000000..50d1336944
--- /dev/null
+++ b/include/hw/char/renesas_sci.h
@@ -0,0 +1,45 @@
+/*
+ * Renesas Serial Communication Interface
+ *
+ * Copyright (c) 2018 Yoshinori Sato
+ *
+ * This code is licensed under the GPL version 2 or later.
+ *
+ */
+
+#include "chardev/char-fe.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+
+#define TYPE_RENESAS_SCI "renesas-sci"
+#define RSCI(obj) OBJECT_CHECK(RSCIState, (obj), TYPE_RENESAS_SCI)
+
+enum {
+    ERI =3D 0,
+    RXI =3D 1,
+    TXI =3D 2,
+    TEI =3D 3,
+    SCI_NR_IRQ =3D 4,
+};
+
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion memory;
+
+    uint8_t smr;
+    uint8_t brr;
+    uint8_t scr;
+    uint8_t tdr;
+    uint8_t ssr;
+    uint8_t rdr;
+    uint8_t scmr;
+    uint8_t semr;
+
+    uint8_t read_ssr;
+    int64_t trtime;
+    int64_t rx_next;
+    QEMUTimer *timer;
+    CharBackend chr;
+    uint64_t input_freq;
+    qemu_irq irq[SCI_NR_IRQ];
+} RSCIState;
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
new file mode 100644
index 0000000000..6298cbf43a
--- /dev/null
+++ b/hw/char/renesas_sci.c
@@ -0,0 +1,340 @@
+/*
+ * Renesas Serial Communication Interface
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
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/char/renesas_sci.h"
+#include "qemu/error-report.h"
+
+/* SCI register map */
+REG8(SMR, 0)
+  FIELD(SMR, CKS,  0, 2)
+  FIELD(SMR, MP,   2, 1)
+  FIELD(SMR, STOP, 3, 1)
+  FIELD(SMR, PM,   4, 1)
+  FIELD(SMR, PE,   5, 1)
+  FIELD(SMR, CHR,  6, 1)
+  FIELD(SMR, CM,   7, 1)
+REG8(BRR, 1)
+REG8(SCR, 2)
+  FIELD(SCR, CKE, 0, 2)
+  FIELD(SCR, TEIE, 2, 1)
+  FIELD(SCR, MPIE, 3, 1)
+  FIELD(SCR, RE,   4, 1)
+  FIELD(SCR, TE,   5, 1)
+  FIELD(SCR, RIE,  6, 1)
+  FIELD(SCR, TIE,  7, 1)
+REG8(TDR, 3)
+REG8(SSR, 4)
+  FIELD(SSR, MPBT, 0, 1)
+  FIELD(SSR, MPB,  1, 1)
+  FIELD(SSR, TEND, 2, 1)
+  FIELD(SSR, ERR, 3, 3)
+    FIELD(SSR, PER,  3, 1)
+    FIELD(SSR, FER,  4, 1)
+    FIELD(SSR, ORER, 5, 1)
+  FIELD(SSR, RDRF, 6, 1)
+  FIELD(SSR, TDRE, 7, 1)
+REG8(RDR, 5)
+REG8(SCMR, 6)
+  FIELD(SCMR, SMIF, 0, 1)
+  FIELD(SCMR, SINV, 2, 1)
+  FIELD(SCMR, SDIR, 3, 1)
+  FIELD(SCMR, BCP2, 7, 1)
+REG8(SEMR, 7)
+  FIELD(SEMR, ACS0, 0, 1)
+  FIELD(SEMR, ABCS, 4, 1)
+
+static int can_receive(void *opaque)
+{
+    RSCIState *sci =3D RSCI(opaque);
+    if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
+        return 0;
+    } else {
+        return FIELD_EX8(sci->scr, SCR, RE);
+    }
+}
+
+static void receive(void *opaque, const uint8_t *buf, int size)
+{
+    RSCIState *sci =3D RSCI(opaque);
+    sci->rx_next =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime=
;
+    if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, ORER, 1);
+        if (FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_set_irq(sci->irq[ERI], 1);
+        }
+    } else {
+        sci->rdr =3D buf[0];
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, RDRF, 1);
+        if (FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_irq_pulse(sci->irq[RXI]);
+        }
+    }
+}
+
+static void send_byte(RSCIState *sci)
+{
+    if (qemu_chr_fe_backend_connected(&sci->chr)) {
+        qemu_chr_fe_write_all(&sci->chr, &sci->tdr, 1);
+    }
+    timer_mod(sci->timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);
+    sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TEND, 0);
+    sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TDRE, 1);
+    qemu_set_irq(sci->irq[TEI], 0);
+    if (FIELD_EX8(sci->scr, SCR, TIE)) {
+        qemu_irq_pulse(sci->irq[TXI]);
+    }
+}
+
+static void txend(void *opaque)
+{
+    RSCIState *sci =3D RSCI(opaque);
+    if (!FIELD_EX8(sci->ssr, SSR, TDRE)) {
+        send_byte(sci);
+    } else {
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TEND, 1);
+        if (FIELD_EX8(sci->scr, SCR, TEIE)) {
+            qemu_set_irq(sci->irq[TEI], 1);
+        }
+    }
+}
+
+static void update_trtime(RSCIState *sci)
+{
+    /* char per bits */
+    sci->trtime =3D 8 - FIELD_EX8(sci->smr, SMR, CHR);
+    sci->trtime +=3D FIELD_EX8(sci->smr, SMR, PE);
+    sci->trtime +=3D FIELD_EX8(sci->smr, SMR, STOP) + 1;
+    /* x bit transmit time (32 * divrate * brr) / base freq */
+    sci->trtime *=3D 32 * sci->brr;
+    sci->trtime *=3D 1 << (2 * FIELD_EX8(sci->smr, SMR, CKS));
+    sci->trtime *=3D NANOSECONDS_PER_SECOND;
+    sci->trtime /=3D sci->input_freq;
+}
+
+#define IS_TR_ENABLED(scr) \
+    (FIELD_EX8(scr, SCR, TE) || FIELD_EX8(scr, SCR, RE))
+
+static void sci_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
+{
+    hwaddr offset =3D addr & 0x07;
+    RSCIState *sci =3D RSCI(opaque);
+
+    switch (offset) {
+    case A_SMR:
+        if (!IS_TR_ENABLED(sci->scr)) {
+            sci->smr =3D val;
+            update_trtime(sci);
+        }
+        break;
+    case A_BRR:
+        if (!IS_TR_ENABLED(sci->scr)) {
+            sci->brr =3D val;
+            update_trtime(sci);
+        }
+        break;
+    case A_SCR:
+        sci->scr =3D val;
+        if (FIELD_EX8(sci->scr, SCR, TE)) {
+            sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TDRE, 1);
+            sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TEND, 1);
+            if (FIELD_EX8(sci->scr, SCR, TIE)) {
+                qemu_irq_pulse(sci->irq[TXI]);
+            }
+        }
+        if (!FIELD_EX8(sci->scr, SCR, TEIE)) {
+            qemu_set_irq(sci->irq[TEI], 0);
+        }
+        if (!FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_set_irq(sci->irq[ERI], 0);
+        }
+        break;
+    case A_TDR:
+        sci->tdr =3D val;
+        if (FIELD_EX8(sci->ssr, SSR, TEND)) {
+            send_byte(sci);
+        } else {
+            sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TDRE, 0);
+        }
+        break;
+    case A_SSR:
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, MPBT,
+                             FIELD_EX8(val, SSR, MPBT));
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, ERR,
+                             FIELD_EX8(val, SSR, ERR) & 0x07);
+        if (FIELD_EX8(sci->read_ssr, SSR, ERR) &&
+            FIELD_EX8(sci->ssr, SSR, ERR) =3D=3D 0) {
+            qemu_set_irq(sci->irq[ERI], 0);
+        }
+        break;
+    case A_RDR:
+        qemu_log_mask(LOG_GUEST_ERROR, "reneas_sci: RDR is read only.\n"=
);
+        break;
+    case A_SCMR:
+        sci->scmr =3D val; break;
+    case A_SEMR: /* SEMR */
+        sci->semr =3D val; break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX
+                      " not implemented\n", offset);
+    }
+}
+
+static uint64_t sci_read(void *opaque, hwaddr addr, unsigned size)
+{
+    hwaddr offset =3D addr & 0x07;
+    RSCIState *sci =3D RSCI(opaque);
+
+    switch (offset) {
+    case A_SMR:
+        return sci->smr;
+    case A_BRR:
+        return sci->brr;
+    case A_SCR:
+        return sci->scr;
+    case A_TDR:
+        return sci->tdr;
+    case A_SSR:
+        sci->read_ssr =3D sci->ssr;
+        return sci->ssr;
+    case A_RDR:
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, RDRF, 0);
+        return sci->rdr;
+    case A_SCMR:
+        return sci->scmr;
+    case A_SEMR:
+        return sci->semr;
+    default:
+        qemu_log_mask(LOG_UNIMP, "renesas_sci: Register 0x%" HWADDR_PRIX
+                      " not implemented.\n", offset);
+    }
+    return UINT64_MAX;
+}
+
+static const MemoryRegionOps sci_ops =3D {
+    .write =3D sci_write,
+    .read  =3D sci_read,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 1,
+    },
+};
+
+static void rsci_reset(DeviceState *dev)
+{
+    RSCIState *sci =3D RSCI(dev);
+    sci->smr =3D sci->scr =3D 0x00;
+    sci->brr =3D 0xff;
+    sci->tdr =3D 0xff;
+    sci->rdr =3D 0x00;
+    sci->ssr =3D 0x84;
+    sci->scmr =3D 0x00;
+    sci->semr =3D 0x00;
+    sci->rx_next =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static void sci_event(void *opaque, int event)
+{
+    RSCIState *sci =3D RSCI(opaque);
+    if (event =3D=3D CHR_EVENT_BREAK) {
+        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, FER, 1);
+        if (FIELD_EX8(sci->scr, SCR, RIE)) {
+            qemu_set_irq(sci->irq[ERI], 1);
+        }
+    }
+}
+
+static void rsci_realize(DeviceState *dev, Error **errp)
+{
+    RSCIState *sci =3D RSCI(dev);
+
+    if (sci->input_freq =3D=3D 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "renesas_sci: input-freq property must be set.");
+        return;
+    }
+    qemu_chr_fe_set_handlers(&sci->chr, can_receive, receive,
+                             sci_event, NULL, sci, NULL, true);
+}
+
+static void rsci_init(Object *obj)
+{
+    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
+    RSCIState *sci =3D RSCI(obj);
+    int i;
+
+    memory_region_init_io(&sci->memory, OBJECT(sci), &sci_ops,
+                          sci, "renesas-sci", 0x8);
+    sysbus_init_mmio(d, &sci->memory);
+
+    for (i =3D 0; i < SCI_NR_IRQ; i++) {
+        sysbus_init_irq(d, &sci->irq[i]);
+    }
+    sci->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, txend, sci);
+}
+
+static const VMStateDescription vmstate_rcmt =3D {
+    .name =3D "renesas-sci",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property rsci_properties[] =3D {
+    DEFINE_PROP_UINT64("input-freq", RSCIState, input_freq, 0),
+    DEFINE_PROP_CHR("chardev", RSCIState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rsci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D rsci_realize;
+    dc->props =3D rsci_properties;
+    dc->vmsd =3D &vmstate_rcmt;
+    dc->reset =3D rsci_reset;
+}
+
+static const TypeInfo rsci_info =3D {
+    .name       =3D TYPE_RENESAS_SCI,
+    .parent     =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RSCIState),
+    .instance_init =3D rsci_init,
+    .class_init =3D rsci_class_init,
+};
+
+static void rsci_register_types(void)
+{
+    type_register_static(&rsci_info);
+}
+
+type_init(rsci_register_types)
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 40e7a8b8bb..874627520c 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -46,3 +46,6 @@ config SCLPCONSOLE
=20
 config TERMINAL3270
     bool
+
+config RENESAS_SCI
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66925..4472d563b5 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
 obj-$(CONFIG_DIGIC) +=3D digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
+obj-$(CONFIG_RENESAS_SCI) +=3D renesas_sci.o
=20
 common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
--=20
2.11.0



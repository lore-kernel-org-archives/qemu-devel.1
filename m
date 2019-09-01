Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D8CC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED4E2190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiPDoFy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED4E2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GOs-00016N-RY
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzu-0007km-35
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzs-0006nC-Ar
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:45 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzq-0006jR-GM; Sat, 31 Aug 2019 22:53:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id w16so6922180pfn.7;
 Sat, 31 Aug 2019 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=s0hdwxErfd3dbl9Eml9TR44u7LGWwXVYyYGZbAXqeJI=;
 b=WiPDoFy6Zgjqo/7lEb2fm58c3dUgXvb4H7hhbuFUB+hfQnbI4oi/8WBAi6sxEAWHoc
 jozolu5z3U3xy750Ckxj58xswtEVP4ZFV8/OrsyFIslmvbuR/wPIK9fn/fBIktGBCpQ5
 cvBSCp5GdnNFFxc87hGvKcd+3rd0fiFzui71WiZ7b6KI9urG5sjX4dEHpBX/qR1Qs8Iv
 IVyL3ZJ7r7ooc3Iax3LtLcEopSi8VKGCpNeja1tK0iZ7pjgfGSwiibPDiRZ7k2OD6lMN
 MS3dIw5CrINKD/cMf2rM3KQi0kCeZ38o7Pcgh2UAJkpLu4vM10kgMpIvo6qgAru3fKF3
 /c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=s0hdwxErfd3dbl9Eml9TR44u7LGWwXVYyYGZbAXqeJI=;
 b=osrJLOZzz6sDM44pGEX/cZ9wvu0QgjKAechoxhTUzXCHBhOJzd8rnyXOuo3/x2Ht8a
 xXYuuxXA5He+DDJYA02mnYPDYXCkj0MbYujc3B+6HXS+7Wda3Cd67gY/Nxr4G9AQDHwa
 WCE9Y9d8CSGRPKDiVu1DzkBP2twBSwqM1w5pQgBi3nzRa84SXLUMqu0U2C/Kjd+1tXaM
 5rTjovDu5o1/6SpjQehquzQtGdkN5eZzrZxw5fpx6BobTEQytLcmLjPGE018eNuqlUe7
 yzPj9EEBh0NOnEtGD7geFS/FEXJLGYg8QkufzUi7bSYU9mfLzh3xOADNkZNNTn84oHKN
 KBOA==
X-Gm-Message-State: APjAAAXoFt4uKYM3kWpWo0jelVab1ocvSXxHpvAFf2E85Li3JfYF/P1s
 qWgBs+LzDIgjqsbdjsWjjM8=
X-Google-Smtp-Source: APXvYqymapOD4nboweDXGWhv88duTrYW/sEqsSSaZTmwWQUl31xhVBeQGeOTE4rjNMUOS9ut2rRugw==
X-Received: by 2002:a17:90a:3aa6:: with SMTP id
 b35mr1533929pjc.94.1567306421680; 
 Sat, 31 Aug 2019 19:53:41 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.40
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:41 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:53:02 -0700
Message-Id: <1567306391-2682-22-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 21/30] riscv: sifive_u: Add PRCI block to
 the SoC
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add PRCI mmio base address and size mappings to sifive_u machine,
and generate the corresponding device tree node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5:
- create sifive_u_prci block directly in the machine codes, instead
  of calling sifive_u_prci_create()

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 24 +++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f048806..da8ee64 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -9,6 +9,7 @@
  * 0) UART
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
+ * 3) PRCI (Power, Reset, Clock, Interrupt)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -60,6 +61,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
+    [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
@@ -77,7 +79,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk\0tx_clk";
-    uint32_t plic_phandle, ethclk_phandle, phandle = 1;
+    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
     uint32_t uartclk_phandle;
     uint32_t hfclk_phandle, rtcclk_phandle;
 
@@ -188,6 +190,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    prci_phandle = phandle++;
+    nodename = g_strdup_printf("/soc/clock-controller@%lx",
+        (long)memmap[SIFIVE_U_PRCI].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", prci_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x1);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        hfclk_phandle, rtcclk_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_PRCI].base,
+        0x0, memmap[SIFIVE_U_PRCI].size);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "sifive,fu540-c000-prci");
+    g_free(nodename);
+
     plic_phandle = phandle++;
     cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
@@ -402,6 +419,8 @@ static void riscv_sifive_u_soc_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
 
+    sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
+                          TYPE_SIFIVE_U_PRCI);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
@@ -475,6 +494,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
 
+    object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
+
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
     }
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index debbf28..2a023be 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -21,6 +21,7 @@
 
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/sifive_cpu.h"
+#include "hw/riscv/sifive_u_prci.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
@@ -36,6 +37,7 @@ typedef struct SiFiveUSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    SiFiveUPRCIState prci;
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
@@ -54,6 +56,7 @@ enum {
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
     SIFIVE_U_PLIC,
+    SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
     SIFIVE_U_DRAM,
-- 
2.7.4



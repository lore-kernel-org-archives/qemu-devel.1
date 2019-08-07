Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9521CC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BED22BED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgq9VRSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BED22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGhp-0001BA-KV
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdo-0000xv-NN
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdm-00083v-7L
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdh-00080f-Kc; Wed, 07 Aug 2019 03:45:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id ay6so39528890plb.9;
 Wed, 07 Aug 2019 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=a1+dgctFYeYPIqDhGZ2ZM4HbB/6UXgiwmP8EAP0bHbM=;
 b=rgq9VRSnkSKPG07D1jg2rDxWY4EPyqp1s1BugPW9Bg49oUaJkz6hcaOjvnW0s7Wqim
 OsvoewlDT4IbGeTp2Ju/1xYS1JRQAyX73vzFSOc7kY7jzaZkb9IbSxLziKJUip7aq4UB
 7g83T4YZ8FMNkXwcqBn2FcqGHKb0mbAvsngoNQJTzyt/9TasHaaTqUazSbrVzoAfT5Ug
 bXETcmn/AMjx6F4RkWfvp+l/sdTJu4b8Y4tI6MVQfgMyN+ReGjYpsgzbctKrCQ7uujLy
 HS2fQcWXcLdzmiosX/L7e5NcrvY8tOx2J79ozBPZT0EPhPjukQnAZKOQzv+6vj9IanKn
 BYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=a1+dgctFYeYPIqDhGZ2ZM4HbB/6UXgiwmP8EAP0bHbM=;
 b=MSuD6PoauIABK+I7Ggsxjtc/v7XbV6xnFJmGk7zVkORNx8uea3r/3J9oGc9x7xcl0z
 Xd54C6biWzCOL3iWx3/E9pmT2Dlo0oyrtwL0h5dADGl5pofQcD6rA6+3UvCgq7I85Yv6
 i5A5vMdN8yV2zWQXTQ7YDSc7d+YTCFs4SWZr8/dsc4dEjJ4roXzAQ49hJPGBa5fo7bHz
 23PQAdwpdAybp51Axw4XXwtRPhdbcHqXr3lUTudHy4xfZEMqHB7BQoj2wukLOCX1dm4V
 UyAt6nOif+cAUwiCl81TR4HJ0gs/OP0IwvGRCdNCE4y+em3YVEmSuwLK+fdIQ6n+y+qN
 RAOQ==
X-Gm-Message-State: APjAAAUDEbcvZZWhbc9OllNSv7TGr78ynQXh14WaiJjd0c9YU4VkOOtZ
 TP43qWOyDaLwKMqFoFT7FxU=
X-Google-Smtp-Source: APXvYqyLNtEIvyokci+YzAH2Hxe+0jqB56nVUJx8TIDlVmuJwk84Fkh12VOqTzqYU/8psJH8JoPJ6w==
X-Received: by 2002:a17:902:aa83:: with SMTP id
 d3mr6756941plr.74.1565163936971; 
 Wed, 07 Aug 2019 00:45:36 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.35
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:36 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:02 -0700
Message-Id: <1565163924-18621-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 06/28] riscv: sifive_u: Update hart
 configuration to reflect the real FU540 SoC
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

The FU540-C000 includes a 64-bit E51 RISC-V core and four 64-bit U54
RISC-V cores. Currently the sifive_u machine only populates 4 U54
cores. Update the max cpu number to 5 to reflect the real hardware,
and pass "cpu-type" to populate heterogeneous harts.

The cpu nodes in the generated DTS have been updated as well.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v2:
- fixed the "interrupts-extended" property size

 hw/riscv/sifive_u.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 623ee64..821f1d5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,7 +10,8 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  *
- * This board currently uses a hardcoded devicetree that indicates one hart.
+ * This board currently generates devicetree dynamically that indicates at most
+ * five harts.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -26,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -117,7 +119,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_add_subnode(fdt, nodename);
         qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
                               SIFIVE_U_CLOCK_FREQ);
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+        /* cpu 0 is the management hart that does not have mmu */
+        if (cpu != 0) {
+            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+        }
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
@@ -157,15 +162,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     plic_phandle = phandle++;
-    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
+    cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4 - 2);
     for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
         nodename =
             g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+        /* cpu 0 is the management hart that does not have S-mode */
+        if (cpu == 0) {
+            cells[0] = cpu_to_be32(intc_phandle);
+            cells[1] = cpu_to_be32(IRQ_M_EXT);
+        } else {
+            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
+            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
+        }
         g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
@@ -175,7 +186,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
+        cells, (s->soc.cpus.num_harts * 4 - 2) * sizeof(uint32_t));
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
@@ -315,10 +326,16 @@ static void riscv_sifive_u_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
+    char cpu_type[64];
+
+    /* create cpu type representing SiFive FU540 SoC */
+    pstrcpy(cpu_type, sizeof(cpu_type), SIFIVE_E_CPU);
+    pstrcat(cpu_type, sizeof(cpu_type), ",");
+    pstrcat(cpu_type, sizeof(cpu_type), SIFIVE_U_CPU);
 
     object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->cpus), cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
@@ -407,10 +424,11 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
     mc->init = riscv_sifive_u_init;
-    /* The real hardware has 5 CPUs, but one of them is a small embedded power
+    /*
+     * The real hardware has 5 CPUs, but one of them is a small embedded power
      * management CPU.
      */
-    mc->max_cpus = 4;
+    mc->max_cpus = 5;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
-- 
2.7.4



Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90040C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5341C2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5vT01D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5341C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAebk-00026e-FY
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVk-0006lZ-9q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVh-00064Q-JE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iziBeC1FL8POtp6/HbuV/srM0mcOu3WrXXS2RTvte7U=;
 b=N5vT01D+Zj/xfgNJGUJhgy1h7ppMmhnohLXTXgN6Z1fFnlwDbkQLJo4DisTZ93arYOT5M6
 qBiyYr6F1jBu4/p19KSwnTdcsNv5TSCbZO1CdYoYMRHTgzwPOnQzuBYiWEzEQxEl03P5hb
 dapvd8iZ5Y7+tMXIUg7AEIE50QtRtO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-6sLyf2mENCGdNhtb9i5DRw-1; Tue, 25 Aug 2020 15:21:30 -0400
X-MC-Unique: 6sLyf2mENCGdNhtb9i5DRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF3191853DA5;
 Tue, 25 Aug 2020 19:21:28 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A9AF5D9E4;
 Tue, 25 Aug 2020 19:21:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/74] sifive_u: Rename memmap enum constants
Date: Tue, 25 Aug 2020 15:20:05 -0400
Message-Id: <20200825192110.3528606-10-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the enum constant names conflict with the QOM type check
macros (SIFIVE_U_OTP, SIFIVE_U_PRCI).  This needs to be addressed
to allow us to transform the QOM type check macros into functions
generated by OBJECT_DECLARE_TYPE().

Rename all the constants to SIFIVE_U_DEV_*, to avoid conflicts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3:
* Solved conflicts on rebase to latest qemu.git
* As this is a new patch, Reviewed-by lines from Alistair Francis
  and Daniel P. Berrangé were dropped

Changes v1 -> v2:
* Added more details to commit message

---
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/riscv/sifive_u.h |  32 ++++----
 hw/riscv/sifive_u.c         | 146 ++++++++++++++++++------------------
 2 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index d3c0c00d10..2cefc611dd 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -68,22 +68,22 @@ typedef struct SiFiveUState {
 } SiFiveUState;
 
 enum {
-    SIFIVE_U_DEBUG,
-    SIFIVE_U_MROM,
-    SIFIVE_U_CLINT,
-    SIFIVE_U_L2CC,
-    SIFIVE_U_L2LIM,
-    SIFIVE_U_PLIC,
-    SIFIVE_U_PRCI,
-    SIFIVE_U_UART0,
-    SIFIVE_U_UART1,
-    SIFIVE_U_GPIO,
-    SIFIVE_U_OTP,
-    SIFIVE_U_DMC,
-    SIFIVE_U_FLASH0,
-    SIFIVE_U_DRAM,
-    SIFIVE_U_GEM,
-    SIFIVE_U_GEM_MGMT
+    SIFIVE_U_DEV_DEBUG,
+    SIFIVE_U_DEV_MROM,
+    SIFIVE_U_DEV_CLINT,
+    SIFIVE_U_DEV_L2CC,
+    SIFIVE_U_DEV_L2LIM,
+    SIFIVE_U_DEV_PLIC,
+    SIFIVE_U_DEV_PRCI,
+    SIFIVE_U_DEV_UART0,
+    SIFIVE_U_DEV_UART1,
+    SIFIVE_U_DEV_GPIO,
+    SIFIVE_U_DEV_OTP,
+    SIFIVE_U_DEV_DMC,
+    SIFIVE_U_DEV_FLASH0,
+    SIFIVE_U_DEV_DRAM,
+    SIFIVE_U_DEV_GEM,
+    SIFIVE_U_DEV_GEM_MGMT
 };
 
 enum {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 18301e6fa5..b0555a2f7a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -69,22 +69,22 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } sifive_u_memmap[] = {
-    [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
-    [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
-    [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
-    [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
-    [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
-    [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
-    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
-    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
-    [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
-    [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
-    [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
-    [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
-    [SIFIVE_U_DMC] =      { 0x100b0000,    0x10000 },
-    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
-    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
+    [SIFIVE_U_DEV_DEBUG] =    {        0x0,      0x100 },
+    [SIFIVE_U_DEV_MROM] =     {     0x1000,     0xf000 },
+    [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
+    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,  0x2000000 },
+    [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
+    [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
+    [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },
+    [SIFIVE_U_DEV_UART1] =    { 0x10011000,     0x1000 },
+    [SIFIVE_U_DEV_GPIO] =     { 0x10060000,     0x1000 },
+    [SIFIVE_U_DEV_OTP] =      { 0x10070000,     0x1000 },
+    [SIFIVE_U_DEV_GEM] =      { 0x10090000,     0x2000 },
+    [SIFIVE_U_DEV_GEM_MGMT] = { 0x100a0000,     0x1000 },
+    [SIFIVE_U_DEV_DMC] =      { 0x100b0000,    0x10000 },
+    [SIFIVE_U_DEV_FLASH0] =   { 0x20000000, 0x10000000 },
+    [SIFIVE_U_DEV_DRAM] =     { 0x80000000,        0x0 },
 };
 
 #define OTP_SERIAL          1
@@ -143,10 +143,10 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SIFIVE_U_DRAM].base);
+        (long)memmap[SIFIVE_U_DEV_DRAM].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        memmap[SIFIVE_U_DRAM].base >> 32, memmap[SIFIVE_U_DRAM].base,
+        memmap[SIFIVE_U_DEV_DRAM].base >> 32, memmap[SIFIVE_U_DEV_DRAM].base,
         mem_size >> 32, mem_size);
     qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
     g_free(nodename);
@@ -201,39 +201,39 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[SIFIVE_U_CLINT].base);
+        (long)memmap[SIFIVE_U_DEV_CLINT].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_CLINT].base,
-        0x0, memmap[SIFIVE_U_CLINT].size);
+        0x0, memmap[SIFIVE_U_DEV_CLINT].base,
+        0x0, memmap[SIFIVE_U_DEV_CLINT].size);
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
         cells, ms->smp.cpus * sizeof(uint32_t) * 4);
     g_free(cells);
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/otp@%lx",
-        (long)memmap[SIFIVE_U_OTP].base);
+        (long)memmap[SIFIVE_U_DEV_OTP].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cell(fdt, nodename, "fuse-count", SIFIVE_U_OTP_REG_SIZE);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_OTP].base,
-        0x0, memmap[SIFIVE_U_OTP].size);
+        0x0, memmap[SIFIVE_U_DEV_OTP].base,
+        0x0, memmap[SIFIVE_U_DEV_OTP].size);
     qemu_fdt_setprop_string(fdt, nodename, "compatible",
         "sifive,fu540-c000-otp");
     g_free(nodename);
 
     prci_phandle = phandle++;
     nodename = g_strdup_printf("/soc/clock-controller@%lx",
-        (long)memmap[SIFIVE_U_PRCI].base);
+        (long)memmap[SIFIVE_U_DEV_PRCI].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", prci_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x1);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         hfclk_phandle, rtcclk_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_PRCI].base,
-        0x0, memmap[SIFIVE_U_PRCI].size);
+        0x0, memmap[SIFIVE_U_DEV_PRCI].base,
+        0x0, memmap[SIFIVE_U_DEV_PRCI].size);
     qemu_fdt_setprop_string(fdt, nodename, "compatible",
         "sifive,fu540-c000-prci");
     g_free(nodename);
@@ -257,7 +257,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
-        (long)memmap[SIFIVE_U_PLIC].base);
+        (long)memmap[SIFIVE_U_DEV_PLIC].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
@@ -265,8 +265,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
         cells, (ms->smp.cpus * 4 - 2) * sizeof(uint32_t));
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_PLIC].base,
-        0x0, memmap[SIFIVE_U_PLIC].size);
+        0x0, memmap[SIFIVE_U_DEV_PLIC].base,
+        0x0, memmap[SIFIVE_U_DEV_PLIC].size);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
@@ -275,7 +275,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     gpio_phandle = phandle++;
     nodename = g_strdup_printf("/soc/gpio@%lx",
-        (long)memmap[SIFIVE_U_GPIO].base);
+        (long)memmap[SIFIVE_U_DEV_GPIO].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", gpio_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
@@ -285,8 +285,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "#gpio-cells", 2);
     qemu_fdt_setprop(fdt, nodename, "gpio-controller", NULL, 0);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_GPIO].base,
-        0x0, memmap[SIFIVE_U_GPIO].size);
+        0x0, memmap[SIFIVE_U_DEV_GPIO].base,
+        0x0, memmap[SIFIVE_U_DEV_GPIO].size);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GPIO_IRQ0,
         SIFIVE_U_GPIO_IRQ1, SIFIVE_U_GPIO_IRQ2, SIFIVE_U_GPIO_IRQ3,
         SIFIVE_U_GPIO_IRQ4, SIFIVE_U_GPIO_IRQ5, SIFIVE_U_GPIO_IRQ6,
@@ -304,11 +304,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/cache-controller@%lx",
-        (long)memmap[SIFIVE_U_L2CC].base);
+        (long)memmap[SIFIVE_U_DEV_L2CC].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_L2CC].base,
-        0x0, memmap[SIFIVE_U_L2CC].size);
+        0x0, memmap[SIFIVE_U_DEV_L2CC].base,
+        0x0, memmap[SIFIVE_U_DEV_L2CC].size);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
         SIFIVE_U_L2CC_IRQ0, SIFIVE_U_L2CC_IRQ1, SIFIVE_U_L2CC_IRQ2);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
@@ -323,15 +323,15 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
-        (long)memmap[SIFIVE_U_GEM].base);
+        (long)memmap[SIFIVE_U_DEV_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible",
         "sifive,fu540-c000-gem");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_GEM].base,
-        0x0, memmap[SIFIVE_U_GEM].size,
-        0x0, memmap[SIFIVE_U_GEM_MGMT].base,
-        0x0, memmap[SIFIVE_U_GEM_MGMT].size);
+        0x0, memmap[SIFIVE_U_DEV_GEM].base,
+        0x0, memmap[SIFIVE_U_DEV_GEM].size,
+        0x0, memmap[SIFIVE_U_DEV_GEM_MGMT].base,
+        0x0, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
     qemu_fdt_setprop_cell(fdt, nodename, "phy-handle", phy_phandle);
@@ -352,19 +352,19 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/ethernet@%lx/ethernet-phy@0",
-        (long)memmap[SIFIVE_U_GEM].base);
+        (long)memmap[SIFIVE_U_DEV_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", phy_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
     nodename = g_strdup_printf("/soc/serial@%lx",
-        (long)memmap[SIFIVE_U_UART0].base);
+        (long)memmap[SIFIVE_U_DEV_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SIFIVE_U_UART0].base,
-        0x0, memmap[SIFIVE_U_UART0].size);
+        0x0, memmap[SIFIVE_U_DEV_UART0].base,
+        0x0, memmap[SIFIVE_U_DEV_UART0].size);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         prci_phandle, PRCI_CLK_TLCLK);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
@@ -396,7 +396,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
-    target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
+    target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
     uint32_t start_addr_hi32 = 0x00000000;
     int i;
     uint32_t fdt_load_addr;
@@ -411,13 +411,13 @@ static void sifive_u_machine_init(MachineState *machine)
     /* register RAM */
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
                            machine->ram_size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_DRAM].base,
                                 main_mem);
 
     /* register QSPI0 Flash */
     memory_region_init_ram(flash0, NULL, "riscv.sifive.u.flash0",
-                           memmap[SIFIVE_U_FLASH0].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
+                           memmap[SIFIVE_U_DEV_FLASH0].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_FLASH0].base,
                                 flash0);
 
     /* register gpio-restart */
@@ -443,14 +443,14 @@ static void sifive_u_machine_init(MachineState *machine)
 
     switch (s->msel) {
     case MSEL_MEMMAP_QSPI0_FLASH:
-        start_addr = memmap[SIFIVE_U_FLASH0].base;
+        start_addr = memmap[SIFIVE_U_DEV_FLASH0].base;
         break;
     case MSEL_L2LIM_QSPI0_FLASH:
     case MSEL_L2LIM_QSPI2_SD:
-        start_addr = memmap[SIFIVE_U_L2LIM].base;
+        start_addr = memmap[SIFIVE_U_DEV_L2LIM].base;
         break;
     default:
-        start_addr = memmap[SIFIVE_U_DRAM].base;
+        start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
         break;
     }
 
@@ -478,7 +478,7 @@ static void sifive_u_machine_init(MachineState *machine)
     }
 
     /* Compute the fdt load address in dram */
-    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
+    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DEV_DRAM].base,
                                    machine->ram_size, s->fdt);
     #if defined(TARGET_RISCV64)
     start_addr_hi32 = start_addr >> 32;
@@ -510,10 +510,10 @@ static void sifive_u_machine_init(MachineState *machine)
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SIFIVE_U_MROM].base, &address_space_memory);
+                          memmap[SIFIVE_U_DEV_MROM].base, &address_space_memory);
 
-    riscv_rom_copy_firmware_info(memmap[SIFIVE_U_MROM].base,
-                                 memmap[SIFIVE_U_MROM].size,
+    riscv_rom_copy_firmware_info(memmap[SIFIVE_U_DEV_MROM].base,
+                                 memmap[SIFIVE_U_DEV_MROM].size,
                                  sizeof(reset_vec), kernel_entry);
 }
 
@@ -653,8 +653,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     /* boot rom */
     memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
-                           memmap[SIFIVE_U_MROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
+                           memmap[SIFIVE_U_DEV_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_MROM].base,
                                 mask_rom);
 
     /*
@@ -667,8 +667,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
      * too generous to misbehaving guests.
      */
     memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
-                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
+                           memmap[SIFIVE_U_DEV_L2LIM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_L2LIM].base,
                                 l2lim_mem);
 
     /* create PLIC hart topology configuration string */
@@ -686,7 +686,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
+    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
         plic_hart_config,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
@@ -696,26 +696,26 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_U_PLIC_ENABLE_STRIDE,
         SIFIVE_U_PLIC_CONTEXT_BASE,
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
-        memmap[SIFIVE_U_PLIC].size);
+        memmap[SIFIVE_U_DEV_PLIC].size);
     g_free(plic_hart_config);
-    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
-    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_DEV_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
-    sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
-        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
+    sifive_clint_create(memmap[SIFIVE_U_DEV_CLINT].base,
+        memmap[SIFIVE_U_DEV_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_DEV_PRCI].base);
 
     qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_GPIO].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_DEV_GPIO].base);
 
     /* Pass all GPIOs to the SOC layer so they are available to the board */
     qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
@@ -731,7 +731,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_DEV_OTP].base);
 
     /* FIXME use qdev NIC properties instead of nd_table[] */
     if (nd->used) {
@@ -743,18 +743,18 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_DEV_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
-        memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
+        memmap[SIFIVE_U_DEV_GEM_MGMT].base, memmap[SIFIVE_U_DEV_GEM_MGMT].size);
 
     create_unimplemented_device("riscv.sifive.u.dmc",
-        memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
+        memmap[SIFIVE_U_DEV_DMC].base, memmap[SIFIVE_U_DEV_DMC].size);
 
     create_unimplemented_device("riscv.sifive.u.l2cc",
-        memmap[SIFIVE_U_L2CC].base, memmap[SIFIVE_U_L2CC].size);
+        memmap[SIFIVE_U_DEV_L2CC].base, memmap[SIFIVE_U_DEV_L2CC].size);
 }
 
 static Property sifive_u_soc_props[] = {
-- 
2.26.2



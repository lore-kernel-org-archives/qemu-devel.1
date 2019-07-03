Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E611FC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28DF20665
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28DF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibFE-00070v-US
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq9-0006TQ-NH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0008IM-Qf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0007wx-Fc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so1442448ljg.13
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=KdUinYphzGQDVuTLX+/ZSu8nDN42cj53AMC4AE9KtVs=;
 b=Pjbr1BznpyNeg8qVVNFNE8JpGBYw/5XPQlLg1f9uS1dvPG2KzLKQdbH/3MxDkjhHdq
 NjuRZL7zjh29kjRSD+1gQtEqBRdDfvOrhfvohOYMOyTrQtS3Q55K4FHgkNqkcWj4D4H+
 eX4OYO5Urr9f8qF+JKU4hLXsF/AZuKARdpJTO+JJGrqhHhTZslzc4sqSTPZRPl5Tquwd
 VJmZcf7Z4O/nUwz2Td8lp2D0u/BuHg38dHMZq9PO93dUnttjk9SG1n0fV+4zB8uQJxvO
 Qu9gxrX5O+5TokCLCercny6sAnxflD6MBroeak0ML+HFidFYrB0c/DjkeavAovmRz+tM
 PAzQ==
X-Gm-Message-State: APjAAAW8eR1LxA8Hn17pi/BTxcjAvJbMkHs5nMQGhZjoXmYufQSSQFYx
 W3Z1b4mvRvcGFGdjt06zKH0T+gQfqelfXg==
X-Google-Smtp-Source: APXvYqydcDtnVQuKd0gDMWB5wzuGQh09aeOwyrXV7Cj7sc4WuKU6YEV1CfJRk1+LIlOIDbb0q+NWUQ==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr18884931ljj.17.1562143319439; 
 Wed, 03 Jul 2019 01:41:59 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id q6sm342969lji.70.2019.07.03.01.41.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:58 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:44 -0700
Message-Id: <20190703084048.6980-29-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.196
Subject: [Qemu-devel] [PULL 28/32] riscv: sifive_u: Do not create hard-coded
 phandles in DT
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

At present the cpu, plic and ethclk nodes' phandles are hard-coded
to 1/2/3 in DT. If we configure more than 1 cpu for the machine,
all cpu nodes' phandles conflict with each other as they are all 1.
Fix it by removing the hardcode.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5ecc47cea35d..e2120ac7a5d3 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -86,7 +86,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk\0tx_clk";
-    uint32_t plic_phandle, ethclk_phandle;
+    uint32_t plic_phandle, ethclk_phandle, phandle = 1;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -121,6 +121,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
     for (cpu = s->soc.cpus.num_harts - 1; cpu >= 0; cpu--) {
+        int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.cpus.harts[cpu]);
@@ -134,8 +135,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", 1);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
+        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -167,6 +168,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    plic_phandle = phandle++;
     cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4);
     for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
         nodename =
@@ -192,20 +194,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
-    qemu_fdt_setprop_cells(fdt, nodename, "phandle", 2);
-    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", 2);
+    qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
 
+    ethclk_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethclk");
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
         SIFIVE_U_GEM_CLOCK_FREQ);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", 3);
-    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", 3);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", ethclk_phandle);
     ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
-- 
2.21.0



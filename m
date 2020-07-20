Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 06:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893EB22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 06:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/oH57DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893EB22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxPe7-0003Qu-QB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 02:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jxPdH-0002xD-5a; Mon, 20 Jul 2020 02:50:39 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:32842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jxPdF-0006LF-B2; Mon, 20 Jul 2020 02:50:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id m9so8580166pfh.0;
 Sun, 19 Jul 2020 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Od730M3ahusjI/M47BKltZBPGr/5VHQrawcyQ5Cis6g=;
 b=A/oH57DQV7unOM5hfxQ0V9uYyOBdZjlqxs48f9sKXu45C7Wv4uU+ocolcArU3hQwx6
 088HN8bRgZS4DrcUFiPoutA0xocCdzlDAghUG4g55F7nGxuuFZMIEvmH2eJ95YQklqPK
 /+HaU4fPx06h2YP0Nd5k+nM3uyt7bJQXv3mHtoUkE8DBxQzztD2AmUbTnofbTgm3djRL
 lFkUv4+AWKUHprmOtxbeoEomKL96SR2jXrz46S4ETMyRuh1DFDpbNETpiRMEI/g5I/yx
 sOEUimcyUnZ9NdkyJSxoh2sv/K7auUGS5Zy3NcsComPLAR4Y3O61gDoZoLBEzdY8Vl2n
 3OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Od730M3ahusjI/M47BKltZBPGr/5VHQrawcyQ5Cis6g=;
 b=OVQ9sNHUzsA6Q2qGIqVB5KJiB48+nfrWbimoWto2AenBJ3mwbJ7efarLG/cRBv3DoF
 4qwctALkbWZ7rV/ZIqoaV4/Ue1FeHFty/C6YQJqbKiY605qn0U8Do8erXYcUOe8zpCOJ
 b0jYy1lEesr4uyWa3JyqygXR1fs3mcmaU1WsZxQXygNmTKDC21I0VDfpsUfErwTNFoHH
 FuN8E46bUMMNyIlghQCquemDUqlr9F9koy8q3Cpr15i7CI8pJzH2JgxejGQx+bzwivrD
 OL93zIwQ8vOe3tiBzmQesvo4uT6nkeWfmI3xEC8ysMQp0ieqI0cGXQKxmi4glmyXgApN
 xoEA==
X-Gm-Message-State: AOAM533BMNZA8WuwxknvP+GCE3S6Oiyh7XDYrEH2E9MH825KMNiG19RT
 j+/TQTSO3O/wtoFS2zeWe2c=
X-Google-Smtp-Source: ABdhPJyxShjW3d5cSVoDa6jUtm0gvmECk//ZMMCSWcrtKypAox/pJ5PKr/gjYS4R8oEa5cF8jIOkYg==
X-Received: by 2002:a62:3582:: with SMTP id
 c124mr18395534pfa.288.1595227832776; 
 Sun, 19 Jul 2020 23:50:32 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id m140sm15592562pfd.195.2020.07.19.23.50.31
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 19 Jul 2020 23:50:32 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] hw/riscv: sifive_u: Add a dummy L2 cache controller device
Date: Sun, 19 Jul 2020 23:49:08 -0700
Message-Id: <1595227748-24720-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

It is enough to simply map the SiFive FU540 L2 cache controller
into the MMIO space using create_unimplemented_device(), with an
FDT fragment generated, to make the latest upstream U-Boot happy.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c         | 22 ++++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6487d5e..f771cb0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -72,6 +72,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
     [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
@@ -302,6 +303,24 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/cache-controller@%lx",
+        (long)memmap[SIFIVE_U_L2CC].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_L2CC].base,
+        0x0, memmap[SIFIVE_U_L2CC].size);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+        SIFIVE_U_L2CC_IRQ0, SIFIVE_U_L2CC_IRQ1, SIFIVE_U_L2CC_IRQ2);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop(fdt, nodename, "cache-unified", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-size", 2097152);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-sets", 1024);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-level", 2);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-block-size", 64);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "sifive,fu540-c000-ccache");
+    g_free(nodename);
+
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -732,6 +751,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     create_unimplemented_device("riscv.sifive.u.dmc",
         memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
+
+    create_unimplemented_device("riscv.sifive.u.l2cc",
+        memmap[SIFIVE_U_L2CC].base, memmap[SIFIVE_U_L2CC].size);
 }
 
 static Property sifive_u_soc_props[] = {
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index aba4d01..d3c0c00 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -71,6 +71,7 @@ enum {
     SIFIVE_U_DEBUG,
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
+    SIFIVE_U_L2CC,
     SIFIVE_U_L2LIM,
     SIFIVE_U_PLIC,
     SIFIVE_U_PRCI,
@@ -86,6 +87,9 @@ enum {
 };
 
 enum {
+    SIFIVE_U_L2CC_IRQ0 = 1,
+    SIFIVE_U_L2CC_IRQ1 = 2,
+    SIFIVE_U_L2CC_IRQ2 = 3,
     SIFIVE_U_UART0_IRQ = 4,
     SIFIVE_U_UART1_IRQ = 5,
     SIFIVE_U_GPIO_IRQ0 = 7,
-- 
2.7.4



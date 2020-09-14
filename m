Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6289321741
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUiaAkYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpMB-0004wq-DY
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8a-0003K6-IH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8Y-0007eV-Ks
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id y15so213106wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dqPPrPHJgJDMWHoXI6mWvGdfcu+Si5HtoBw1DUmpkko=;
 b=VUiaAkYu1Ags3NBYO3LO1v+A9DoFFNLg/h2IQKhBkDiROdUK49aCCHE8wdMex4MxUC
 4Kz5EwJdfIz/OiPktLL7zgq+0pNs+fIZ1gMCgz39LwjtilllWWTPevaXZrBkMlfXPzGC
 D6pZatujdP+bOVKNIMtDhVBWffi6uD4A43e38ahfBMj2HAhGYYh9XuDmVlV6ON8zUUFN
 jItCtSQaPU3d0YT5h7CCYYCAS9lT8tz/EOrJzYhPTCnTxVuQZxBsXumTKbRrXZJzibQ1
 im+5N6QimbmOkFhbqfGFevXXuXv8sCVwVHsOQCIqhvw7Cp9nphlogLvsVMiCOp8xTMA1
 gN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dqPPrPHJgJDMWHoXI6mWvGdfcu+Si5HtoBw1DUmpkko=;
 b=LUaCfx4YD6LtLRcs9gzPC62EnL85G8s7+Go+8Ln0j7MPhPfp3gOp991vlQcpXjaO/j
 cl5bTSsdCiziNVBqAyyyUdPSaOnAd6mxzsUu0x53mgIDuTWEJKIYN/ayPudKOiFTd8+5
 CfpV0r/SHO2WmIO9VlyHaCWYCvaIJfEAp0e+5OUy4g3JwboB/fiKeaG/auYFNEIGWUZP
 8SS8diTh9aP2RTfug2wQnL3Rf6xXwZM9kPKOmqnDU23cZcZ7JUGbXfyS+pL8qdeyjYhg
 QhyLl1E8T1LQIIGJfLi8V3ofu1h0qUuH/CLQXXd5ZT/O9NyFFoZWWQdb0Se3gupjrTgh
 yWYg==
X-Gm-Message-State: AOAM531XYRVP7XKjKFfo0ZNNPvltsJBMq5tfqRO/qSCV+B/GNc3GXOxo
 K1ohNxn+SOQnm5UMzbb0eZp2QMATYQSKi552
X-Google-Smtp-Source: ABdhPJxVNA8mvCsbPuUE25QHQkIc2AmtEf9OZ+9x2n0EN82kuZ7onMnSFxH8AG9WsTjDtzwo1lvZ+g==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr14853031wma.81.1600092436923; 
 Mon, 14 Sep 2020 07:07:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/36] hw/arm/npcm7xx: add board setup stub for CPU and UART
 clocks
Date: Mon, 14 Sep 2020 15:06:35 +0100
Message-Id: <20200914140641.21369-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Havard Skinnemoen <hskinnemoen@google.com>

When booting directly into a kernel, bypassing the boot loader, the CPU and
UART clocks are not set up correctly. This makes the system appear very
slow, and causes the initrd boot test to fail when optimization is off.

The UART clock must run at 24 MHz. The default 25 MHz reference clock
cannot achieve this, so switch to PLL2/2 @ 480 MHz, which works
perfectly with the default /20 divider.

The CPU clock should run at 800 MHz, so switch it to PLL1/2. PLL1 runs
at 800 MHz by default, so we need to double the feedback divider as well
to make it run at 1600 MHz (so PLL1/2 runs at 800 MHz).

We don't bother checking for PLL lock because we know our emulated PLLs
lock instantly.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-13-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm7xx.h |  1 +
 hw/arm/npcm7xx.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 78d0d78c522..13106af2151 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -37,6 +37,7 @@
 #define NPCM7XX_SMP_LOADER_START        (0xffff0000)  /* Boot ROM */
 #define NPCM7XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
 #define NPCM7XX_GIC_CPU_IF_ADDR         (0xf03fe100)  /* GIC within A9 */
+#define NPCM7XX_BOARD_SETUP_ADDR        (0xffff1000)  /* Boot ROM */
 
 typedef struct NPCM7xxMachine {
     MachineState        parent;
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 7884b2b03d5..037f3a26f2e 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -55,6 +55,13 @@
 #define NPCM7XX_ROM_BA          (0xffff0000)
 #define NPCM7XX_ROM_SZ          (64 * KiB)
 
+/* Clock configuration values to be fixed up when bypassing bootloader */
+
+/* Run PLL1 at 1600 MHz */
+#define NPCM7XX_PLLCON1_FIXUP_VAL   (0x00402101)
+/* Run the CPU from PLL1 and UART from PLL2 */
+#define NPCM7XX_CLKSEL_FIXUP_VAL    (0x004aaba9)
+
 /*
  * Interrupt lines going into the GIC. This does not include internal Cortex-A9
  * interrupts.
@@ -132,6 +139,29 @@ static const struct {
     },
 };
 
+static void npcm7xx_write_board_setup(ARMCPU *cpu,
+                                      const struct arm_boot_info *info)
+{
+    uint32_t board_setup[] = {
+        0xe59f0010,     /* ldr r0, clk_base_addr */
+        0xe59f1010,     /* ldr r1, pllcon1_value */
+        0xe5801010,     /* str r1, [r0, #16] */
+        0xe59f100c,     /* ldr r1, clksel_value */
+        0xe5801004,     /* str r1, [r0, #4] */
+        0xe12fff1e,     /* bx lr */
+        NPCM7XX_CLK_BA,
+        NPCM7XX_PLLCON1_FIXUP_VAL,
+        NPCM7XX_CLKSEL_FIXUP_VAL,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(board_setup); i++) {
+        board_setup[i] = tswap32(board_setup[i]);
+    }
+    rom_add_blob_fixed("board-setup", board_setup, sizeof(board_setup),
+                       info->board_setup_addr);
+}
+
 static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
                                          const struct arm_boot_info *info)
 {
@@ -170,6 +200,8 @@ static struct arm_boot_info npcm7xx_binfo = {
     .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
     .write_secondary_boot   = npcm7xx_write_secondary_boot,
     .board_id               = -1,
+    .board_setup_addr       = NPCM7XX_BOARD_SETUP_ADDR,
+    .write_board_setup      = npcm7xx_write_board_setup,
 };
 
 void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
-- 
2.20.1



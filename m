Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F00C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DC4206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq0ooVIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DC4206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8cU-000736-3v
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZP-0001dB-N2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZO-0006zL-FA
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id i15so10961029wrx.10
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=StLU2CfUIhim1LoWHHxgyFkd3H5dmMx4AUAfUWESJ6c=;
 b=Wq0ooVIMNvdhavW5QD0xnUpYPMjqNi/EY51Bv9oGWh+P8zXlEJSY5MXK2KEFprCiOw
 xcaOmIjqAOypqWkHph9is2Kt2spl4NQ313oz2i5eKckFY+Utaji1ZoLBdg7zhiZQaHrs
 2nDoCDDgpETwbgcEpZ6j6gVueR2W5jNrIenY7XYKX+C9mk3ZADLTSqkvYr8nJijmuAQk
 6Gz364ZDcUs0DKjCYQCvXSPn+5JQT1XZGDNdSkDdUStgNSg5rtNqCi0RVtoPwdCndWCj
 zpGLfQ9e48IqNrPULg/WecK3g6C++dVOIR98juQYQziAuzcmKv5k2cFUNu7r01i1hcPJ
 2Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=StLU2CfUIhim1LoWHHxgyFkd3H5dmMx4AUAfUWESJ6c=;
 b=CbhcYW0ada2pF2w9LjZhmtqCq1ClS3Au5VnjQDtf8L19suO+WwxeRnTmNCG+DBFYkI
 DB9ytjT3EzHVEonl9XsU/9sIDe91LwxyKzvU77A8zDFTMx0hsQJsL6b1Y8OmKhyqvCnl
 4dpDs1rXsbTOjnlq9mJYfObF20iFs3qd5JgHlkqb+hprUglQ/OpIYMWZy4JsMCGhb+Xk
 DOf2OQBcKSEx80e2ZzXLO0ZeWUbt+KEXfS7MpGsxEUnU2uxR/r9EYmHh5Zus3qKhqOrL
 e76TXBprUSzSKXKy2YuQyH/QIdeGpbD1SP+uxY029K5X8Kk1k5yjmsziN3XlVH+XWf2w
 E2CQ==
X-Gm-Message-State: AGi0Pua9iP3v+fGsawcV9GEOo8+U3mDiA1dcHX5ZeS8DbFsX/mfnh6V8
 xWFhV5bQTIbTNtlq/p4ZSYUbIzuizfPpsw==
X-Google-Smtp-Source: APiQypJoq7LtFUWPamONC7UtRsJckGpafAecNjbbdqAGArYmTBTWVDP7KtqHdUoL0OlbUh7G6BYhzg==
X-Received: by 2002:adf:c381:: with SMTP id p1mr19628146wrf.148.1589204048474; 
 Mon, 11 May 2020 06:34:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/34] aspeed: Add boot stub for smp booting
Date: Mon, 11 May 2020 14:33:32 +0100
Message-Id: <20200511133405.5275-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Joel Stanley <joel@jms.id.au>

This is a boot stub that is similar to the code u-boot runs, allowing
the kernel to boot the secondary CPU.

u-boot works as follows:

 1. Initialises the SMP mailbox area in the SCU at 0x1e6e2180 with default values

 2. Copies a stub named 'mailbox_insn' from flash to the SCU, just above the
    mailbox area

 3. Sets AST_SMP_MBOX_FIELD_READY to a magic value to indicate the
    secondary can begin execution from the stub

 4. The stub waits until the AST_SMP_MBOX_FIELD_GOSIGN register is set to
    a magic value

 5. Jumps to the address in AST_SMP_MBOX_FIELD_ENTRY, starting Linux

Linux indicates it is ready by writing the address of its entrypoint
function to AST_SMP_MBOX_FIELD_ENTRY and the 'go' magic number to
AST_SMP_MBOX_FIELD_GOSIGN. The secondary CPU sees this at step 4 and
breaks out of it's loop.

To be compatible, a fixed qemu stub is loaded into the mailbox area. As
qemu can ensure the stub is loaded before execution starts, we do not
need to emulate the AST_SMP_MBOX_FIELD_READY behaviour of u-boot. The
secondary CPU's program counter points to the beginning of the stub,
allowing qemu to start secondaries at step four.

Reboot behaviour is preserved by resetting AST_SMP_MBOX_FIELD_GOSIGN
when the secondaries are reset.

This is only configured when the system is booted with -kernel and qemu
does not execute u-boot first.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a6a2102a93c..a3a8cd0a58a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -116,6 +116,58 @@ static const MemoryRegionOps max_ram_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+#define AST_SMP_MAILBOX_BASE            0x1e6e2180
+#define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
+#define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
+#define AST_SMP_MBOX_FIELD_READY        (AST_SMP_MAILBOX_BASE + 0x8)
+#define AST_SMP_MBOX_FIELD_POLLINSN     (AST_SMP_MAILBOX_BASE + 0xc)
+#define AST_SMP_MBOX_CODE               (AST_SMP_MAILBOX_BASE + 0x10)
+#define AST_SMP_MBOX_GOSIGN             0xabbaab00
+
+static void aspeed_write_smpboot(ARMCPU *cpu,
+                                 const struct arm_boot_info *info)
+{
+    static const uint32_t poll_mailbox_ready[] = {
+        /*
+         * r2 = per-cpu go sign value
+         * r1 = AST_SMP_MBOX_FIELD_ENTRY
+         * r0 = AST_SMP_MBOX_FIELD_GOSIGN
+         */
+        0xee100fb0,  /* mrc     p15, 0, r0, c0, c0, 5 */
+        0xe21000ff,  /* ands    r0, r0, #255          */
+        0xe59f201c,  /* ldr     r2, [pc, #28]         */
+        0xe1822000,  /* orr     r2, r2, r0            */
+
+        0xe59f1018,  /* ldr     r1, [pc, #24]         */
+        0xe59f0018,  /* ldr     r0, [pc, #24]         */
+
+        0xe320f002,  /* wfe                           */
+        0xe5904000,  /* ldr     r4, [r0]              */
+        0xe1520004,  /* cmp     r2, r4                */
+        0x1afffffb,  /* bne     <wfe>                 */
+        0xe591f000,  /* ldr     pc, [r1]              */
+        AST_SMP_MBOX_GOSIGN,
+        AST_SMP_MBOX_FIELD_ENTRY,
+        AST_SMP_MBOX_FIELD_GOSIGN,
+    };
+
+    rom_add_blob_fixed("aspeed.smpboot", poll_mailbox_ready,
+                       sizeof(poll_mailbox_ready),
+                       info->smp_loader_start);
+}
+
+static void aspeed_reset_secondary(ARMCPU *cpu,
+                                   const struct arm_boot_info *info)
+{
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+    CPUState *cs = CPU(cpu);
+
+    /* info->smp_bootreg_addr */
+    address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
+    cpu_set_pc(cs, info->smp_loader_start);
+}
+
 #define FIRMWARE_ADDR 0x0
 
 static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
@@ -270,6 +322,19 @@ static void aspeed_machine_init(MachineState *machine)
         }
     }
 
+    if (machine->kernel_filename && bmc->soc.num_cpus > 1) {
+        /* With no u-boot we must set up a boot stub for the secondary CPU */
+        MemoryRegion *smpboot = g_new(MemoryRegion, 1);
+        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot",
+                               0x80, &error_abort);
+        memory_region_add_subregion(get_system_memory(),
+                                    AST_SMP_MAILBOX_BASE, smpboot);
+
+        aspeed_board_binfo.write_secondary_boot = aspeed_write_smpboot;
+        aspeed_board_binfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
+        aspeed_board_binfo.smp_loader_start = AST_SMP_MBOX_CODE;
+    }
+
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
     aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
-- 
2.20.1



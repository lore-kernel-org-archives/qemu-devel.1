Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8058DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4002074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsk+Ex30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4002074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkzqr-0002Ho-Kh
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 20:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoW-00075L-PY; Mon, 15 Jun 2020 20:50:56 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoU-0006K1-Ts; Mon, 15 Jun 2020 20:50:56 -0400
Received: by mail-pl1-x641.google.com with SMTP id n9so7615099plk.1;
 Mon, 15 Jun 2020 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lByZzsvrmeZSUi8soJNprK8GTj2Qp1TxmnGIOqa+YTY=;
 b=lsk+Ex30HBF1gyQ8Pb+VYTeLypsJixZpwGz9w89664cysRlyYDk0YEtwD45eCeXcjG
 On2mS+NT/AJ6GtexbrMWIlcxS8uzdd8HJObvWFSAYI1sygBVWRJ+4X2NO6Tgn+zvQLwt
 UbZvTPtRLppm/elPJbyk1ljWQjMwEUZQs4Wcwdon4LnkaMZ5QriDOWwEB+TWP+pdbCCH
 vpq34wVi1N0LG9uOrCJ6vaQ+x82e6NcKJ77J/XfxLm3q1Z/8oTzLQlFwN5fMMJlNkZ0o
 BYd2c1JwG7yxUgVi5o/2hgUoIbNPACffQxWgwJxLsUIKIGU2T8+crVHYkOgV/3RQabcK
 h6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lByZzsvrmeZSUi8soJNprK8GTj2Qp1TxmnGIOqa+YTY=;
 b=Dtxakmnd6Y6v2DA9IcM8Y+Y6o5ttBtdCbqWiloHYUOEe9BhKG4CS5eT3akJAwAAg9P
 1vmUgucDdPsj/mJ1H1giKqnIax//6qe958GwWvFlpPauyxrIvw6hnkFn9Arp/Nr0FV/q
 h2l2cI0T+/IG3ccWIoEHXtPOnAjcJyZQh5SD4zHaZ8bZV2dlioGOOoYlKalB5Ir+tVL/
 JNirG1MxuA+XRqt6rcsBaZub0AWImPJH32svfXsXkAKfAfmr7ou4GloOqzM+PO6ZMqPs
 mmqh5zieFbnkAWHpt8o1pOUNlYBj9F00Sk7GPpRQqp6XOBMif0OJrHE+rX4TibyO11Sf
 n9xw==
X-Gm-Message-State: AOAM530KEfHYpBOeK+EA+EfnDlZtLzodTC8eVD7+YfVsS5oUaHkLDqGA
 s4Zoj0P40EMVkHn/pl6uPbQ=
X-Google-Smtp-Source: ABdhPJxQ0PEYmoD4Ao/mU1LnEDceHf6XnWmwe7M5yHdeepmV9rcpn+0d9Zpc5ur9jCp0VSShLQRkRw==
X-Received: by 2002:a17:90a:7446:: with SMTP id
 o6mr303490pjk.217.1592268653119; 
 Mon, 15 Jun 2020 17:50:53 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i20sm15210539pfd.81.2020.06.15.17.50.52
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 15 Jun 2020 17:50:52 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 3/5] hw/riscv: sifive_u: Support different boot source per
 MSEL pin state
Date: Mon, 15 Jun 2020 17:50:39 -0700
Message-Id: <1592268641-7478-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
References: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

SiFive FU540 SoC supports booting from several sources, which are
controlled using the Mode Select (MSEL[3:0]) pins on the chip.
Typically, the boot process runs through several stages before it
begins execution of user-provided programs.

The SoC supports booting from memory-mapped QSPI flash, which is
how start_in_flash property is used for at present. This matches
MSEL = 1 configuration (QSPI0).

Typical booting flows involve the Zeroth Stage Boot Loader (ZSBL).
It's not necessary for QEMU to implement the full ZSBL ROM codes,
because we know ZSBL downloads the next stage program into the L2
LIM at address 0x8000000 and executes from there. We can bypass
the whole ZSBL execution and use "-bios" to load the next stage
program directly if MSEL indicates a ZSBL booting flow.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/sifive_u.c         | 39 +++++++++++++++++++++++++++++++--------
 include/hw/riscv/sifive_u.h |  6 ++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0a86ffc..f64aa52 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -408,8 +408,34 @@ static void sifive_u_machine_init(MachineState *machine)
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[SIFIVE_U_DRAM].base, NULL);
+    if (s->start_in_flash) {
+        /*
+         * If start_in_flash property is given, assign s->msel to a value
+         * that representing booting from QSPI0 memory-mapped flash.
+         *
+         * This also means that when both start_in_flash and msel properties
+         * are given, start_in_flash takes the precedence over msel.
+         *
+         * Note this is to keep backward compatibility not to break existing
+         * users that use start_in_flash property.
+         */
+        s->msel = MSEL_MEMMAP_QSPI0_FLASH;
+    }
+
+    switch (s->msel) {
+    case MSEL_MEMMAP_QSPI0_FLASH:
+        start_addr = memmap[SIFIVE_U_FLASH0].base;
+        break;
+    case MSEL_L2LIM_QSPI0_FLASH:
+    case MSEL_L2LIM_QSPI2_SD:
+        start_addr = memmap[SIFIVE_U_L2LIM].base;
+        break;
+    default:
+        start_addr = memmap[SIFIVE_U_DRAM].base;
+        break;
+    }
+
+    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
@@ -427,13 +453,9 @@ static void sifive_u_machine_init(MachineState *machine)
         }
     }
 
-    if (s->start_in_flash) {
-        start_addr = memmap[SIFIVE_U_FLASH0].base;
-    }
-
     /* reset vector */
     uint32_t reset_vec[8] = {
-        0x00000000,
+        s->msel,                       /* MSEL pin state */
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
         0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
@@ -505,7 +527,8 @@ static void sifive_u_machine_instance_init(Object *obj)
                              sifive_u_machine_set_start_in_flash);
     object_property_set_description(obj, "start-in-flash",
                                     "Set on to tell QEMU's ROM to jump to "
-                                    "flash. Otherwise QEMU will jump to DRAM");
+                                    "flash. Otherwise QEMU will jump to DRAM "
+                                    "or L2LIM depending on the msel value");
 
     s->msel = 0;
     object_property_add(obj, "msel", "uint32",
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index d82cfe0..5d80f91 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -111,6 +111,12 @@ enum {
     SIFIVE_U_RTCCLK_FREQ = 1000000
 };
 
+enum {
+    MSEL_MEMMAP_QSPI0_FLASH = 1,
+    MSEL_L2LIM_QSPI0_FLASH = 6,
+    MSEL_L2LIM_QSPI2_SD = 11
+};
+
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
 #define SIFIVE_U_COMPUTE_CPU_COUNT      4
 
-- 
2.7.4



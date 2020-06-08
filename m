Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB32EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A722053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jw8t/eVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A722053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIlb-0008Vr-96
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbh-0001PE-U5; Mon, 08 Jun 2020 10:18:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbg-0004WE-QH; Mon, 08 Jun 2020 10:18:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id bg4so6721790plb.3;
 Mon, 08 Jun 2020 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FHQ9AhCMfHdHOxLhqMzAe14kJHhPNfUz/e/XtuYi54A=;
 b=jw8t/eVvhojQH4+kouoFE7qizeykXEk3eGBcgfrtkBUJ9Sg69MEbqPpLlesm4YGvtT
 BFHCTqbFlqWti9uxQrbJmHG0SEAG2iylYTngB4A9W5/yNfwaIJqLrGzd642oHLNjUHy4
 JyrZCa4eHZdjH5NmMqej5q/cHwgiNZZtOH3CxGcGw8W3W4LIcQIZNsqi4l0fEZ/WQxXF
 3+86GpALZhiMIymtbtcWZt/AqKzqy0YBVISI3/ZnSWEUcoJq/AT4rwi6olhPN+DdfQOL
 vNpz0bObMlCdedRGQM3ifYdfSuYNM/Lvtw7N9Cc9veEkX4YGelj1is7DYKoybyqwSeOg
 URJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FHQ9AhCMfHdHOxLhqMzAe14kJHhPNfUz/e/XtuYi54A=;
 b=PQB2oc1+JOr97l2SktT6qU3t8G9Jovx41wsOTggarCOi9ZFShWV1zK/9Wv0ZluRIua
 utz+eTYM1iCrib8P7vpPgQ27i3jt4GOY/vU1gQzZcD9mJJ31lblj27Ym2t9MMmc+U0mK
 EmjRvRRfY5gKpSwfcUWxlaQ5B3gQy14aPvTmzRmdN/xDxFsT/AqjrgjWqO+FDFcqdI6X
 yAXEvf4uwYNrl1MF9QKw9vvoCSyKkgIT13+GZy9+H3VR6SGQJ/Kb1H7uil31zx4hkecJ
 D6HlxujBDPIZXA0jna88OYi67Lypp5LsNmq/zm2pAIMYFliiVV5KwpoQpy0e38CFwvSO
 409w==
X-Gm-Message-State: AOAM531ey7JZtIUPf1bLXLhQ2gengH3dP0yG7XG7Nyl7FSMofpHL/1PH
 y9fmMo6X3lWz6D0tYbX7Pig=
X-Google-Smtp-Source: ABdhPJw+pjdrzzK19a2YtS0Z2+EhgOepBGUs0keqCvo+xxEQmsthtT7kYImbKs0RydhveJEEinyNAw==
X-Received: by 2002:a17:90b:e8f:: with SMTP id
 fv15mr11839458pjb.47.1591625911028; 
 Mon, 08 Jun 2020 07:18:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.30
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 13/15] hw/riscv: sifive_u: Support different boot source per
 MSEL pin state
Date: Mon,  8 Jun 2020 07:17:42 -0700
Message-Id: <1591625864-31494-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
---

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



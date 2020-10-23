Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13096C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678C32168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HLLNxssj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678C32168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzbq-00089I-59
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyz-0004Kl-3H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyv-0001Y4-Bq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466873; x=1635002873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cHLv6Xa/Mv6eHkYaJhgq25XI2qqlc+Or3T2F3M6qC9c=;
 b=HLLNxssjxeTDBPqNOWWhulH7BhNOi7abuK3/4LVExDdPQh8GpRDEY0to
 Gz7turfQsN9U9jHVNHUrzZlT8AxKLjwVyheHNMgBXZ7B4J6SuWWHb8gWO
 u5JkG+iwnepf3DZ1KICp5O1SVNBh+GCHQYTwsbNtYQJEOPQxg2yz0mZMa
 J0LcQrwWw8tkee5DhzLWfK+RCD/jrInSIuo7i/tYhxqg+SReWmofwt5cV
 ilfzbE43HCZsNI9F/RlUrzsVLrYr+2lYdpSrpFuy4UeHEbFHSdkr6Voqg
 sae10O6EN219259NvfNJit938TU3P/uh1qfb7xfKm4FQIiswB7zsBpxe1 A==;
IronPort-SDR: hlf1f3EYlArM6YNBdkFhdY2wKQ0c4ZSgV0SAcBnDUlxNavbiHHBlrQKJT/umx3ilBlssbeAdrC
 hsHGHud1dZZrIl5vEWHCKG7x8eqXQITUX4odetFEm080l8Vn+GFYB+XT4ZQ8r2r4dqjR0WfiPl
 i9JNPT2iyciYWcrRWe4Nh3rv+Ct1Jfzt/1C2eVfsE4jYBWCwnCrOY/4K2jMFMIFbY3m+VSZcM2
 6n+G14J9jjtFCg6KWVauM7TeEoJrsHfhNCKVtlWU83cYOXEC6Xdm/QuHmMaT/QL0wyBrnFh1bb
 dwA=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652323"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:44 +0800
IronPort-SDR: 6/Jc7hSM2D06k3QU+/2tNVxZgo//lt7sUWuFJy17QzrO5seRcGhZV5fwjCBvoMBCN++SCNruGD
 usr2s3R4MFusfvmh6G6j3yFdLwvq0tYdNVsqNzX9wcMHlcTjKiYWJMv8NukhZQND8l5NljtaiJ
 AE9puQw+yQST5LGZ4M4FYCBCDcVL4LbRo48jfKGmHrOYK0blB/TLaoko4mHnnCMvPxO+8WBiLY
 sO+uiDZKduVUAePZf1rxFDyxGCoPFG856SbQbfmDfLOHe/fM+OSiIaFT/gbazgFvdFaeRVt78J
 9K+NHhjAaPFBy/PU5UW2857X
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:59 -0700
IronPort-SDR: A7XZXZVrV5KsdZGuYjVAiBL0D+/f2Yd4FNfc3DGOWzxUfUoqmjJO+kk501Fwv9brjl3tkzN1u4
 6qfA1UZyIhRxhlq/smgtrwQI6GRgS2/37L3XlAPCB5fB0zxQ3ByuR42XpkIGzV00A2fgLGSD7E
 /C70T7uz9m2PQp6ioN3Mz/5YaZUbNB5UsdPF4JDC6qIRduA6TmUY0gOKYyhon6j3H9GVlkVsXI
 Zb+impGNCSeIfqI554piNhi90qDs3G53StYJcpxNYtH/FCyY4qXG4q1zzokUUogSzCP8n0f1zi
 278=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 07/12] hw/riscv: Return the end address of the loaded firmware
Date: Fri, 23 Oct 2020 08:16:14 -0700
Message-Id: <20201023151619.3175155-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, alistair23@gmail.com,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of returning the unused entry address from riscv_load_firmware()
instead return the end address. Also return the end address from
riscv_find_and_load_firmware().

This tells the caller if a firmware was loaded and how big it is. This
can be used to determine the load address of the next image (usually the
kernel).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-id: 558cf67162342d65a23262248b040563716628b2.1602634524.git.alistair.francis@wdc.com
---
 include/hw/riscv/boot.h |  8 ++++----
 hw/riscv/boot.c         | 28 +++++++++++++++++-----------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 451338780a..0acbd8aa6e 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -23,10 +23,10 @@
 #include "exec/cpu-defs.h"
 #include "hw/loader.h"
 
-void riscv_find_and_load_firmware(MachineState *machine,
-                                  const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr,
-                                  symbol_fn_t sym_cb);
+target_ulong riscv_find_and_load_firmware(MachineState *machine,
+                                          const char *default_machine_firmware,
+                                          hwaddr firmware_load_addr,
+                                          symbol_fn_t sym_cb);
 char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 21adaae56e..fa699308a0 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,12 +40,13 @@
 #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
-void riscv_find_and_load_firmware(MachineState *machine,
-                                  const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr,
-                                  symbol_fn_t sym_cb)
+target_ulong riscv_find_and_load_firmware(MachineState *machine,
+                                          const char *default_machine_firmware,
+                                          hwaddr firmware_load_addr,
+                                          symbol_fn_t sym_cb)
 {
     char *firmware_filename = NULL;
+    target_ulong firmware_end_addr = firmware_load_addr;
 
     if ((!machine->firmware) || (!strcmp(machine->firmware, "default"))) {
         /*
@@ -60,9 +61,12 @@ void riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
+        firmware_end_addr = riscv_load_firmware(firmware_filename,
+                                                firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
+
+    return firmware_end_addr;
 }
 
 char *riscv_find_firmware(const char *firmware_filename)
@@ -91,17 +95,19 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr,
                                  symbol_fn_t sym_cb)
 {
-    uint64_t firmware_entry;
+    uint64_t firmware_entry, firmware_size, firmware_end;
 
     if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
-                         &firmware_entry, NULL, NULL, NULL,
+                         &firmware_entry, NULL, &firmware_end, NULL,
                          0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
-        return firmware_entry;
+        return firmware_end;
     }
 
-    if (load_image_targphys_as(firmware_filename, firmware_load_addr,
-                               ram_size, NULL) > 0) {
-        return firmware_load_addr;
+    firmware_size = load_image_targphys_as(firmware_filename,
+                                           firmware_load_addr, ram_size, NULL);
+
+    if (firmware_size > 0) {
+        return firmware_load_addr + firmware_size;
     }
 
     error_report("could not load firmware '%s'", firmware_filename);
-- 
2.28.0



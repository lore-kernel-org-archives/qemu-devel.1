Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C91ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E842168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E842168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7y5c-00010k-3s
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvm-0007VR-W6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvl-0006SM-Sw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvl-0006S1-NE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so10677559wrq.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=4YRrInDZ0nZMnqkxeYbaNMMDWGEYLAY0VfYbuezaFh4=;
 b=NdgX08xvlfXtmG66MRv20BfDr5vvnjAfuTfDYapZZnOQj4SYisAxVYEk7sFCDn3prd
 OYrYUyVXF0dLUeyR/FrBdGfhxzT4BAzOKQqL1wiUBK4anw4PrD6enMMMALFmvO0Zs4Jf
 2PRPTX717cZyDqpwgcjP2CB9AuYFz4w7h8r2p+EY5BTFXxSHe8R2D2kJLGHlDvDr3pSO
 fkWn8n74VHRF1/zcwKf2pcQwpDScjMjhtmGJ+EPB2P8+d4/1MtcS6WQnafJ/Uq7taYj2
 UnfjNPDs7b9+jP7WVsQFyExNq53XjLUV36N+lgOBOIrsmJG8srOPYIguv9/xCxcfL9JG
 rhOA==
X-Gm-Message-State: APjAAAUvFE6xwM5OBgpVFBtaYljY8ll8gTE6S4ELAuAtSua+rQSs1Qnx
 dVYpQrLIFXkxPW81peU5B27JNg==
X-Google-Smtp-Source: APXvYqxv0C4mt0fovfgKEk29/h6jDH0gnmoSegp+CN/TXUs3DZpXOUpI3znU1rNs9l9j3hPClu01EQ==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr31264999wrn.142.1568190288501; 
 Wed, 11 Sep 2019 01:24:48 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id z21sm2012852wmf.30.2019.09.11.01.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:48 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:36 -0700
Message-Id: <20190910190513.21160-11-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: [Qemu-devel] [PULL 10/47] riscv: Add a helper routine for finding
 firmware
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

This adds a helper routine for finding firmware. It is currently
used only for "-bios default" case.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c         | 22 +++++++++++++++-------
 include/hw/riscv/boot.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4c63b5cf8a..10f7991490 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -69,13 +69,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
          * so then in the future we can make "-bios default" the default option
          * if no -bios option is set without breaking anything.
          */
-        firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
-                                           default_machine_firmware);
-        if (firmware_filename == NULL) {
-            error_report("Unable to load the default RISC-V firmware \"%s\"",
-                         default_machine_firmware);
-            exit(1);
-        }
+        firmware_filename = riscv_find_firmware(default_machine_firmware);
     } else {
         firmware_filename = machine->firmware;
     }
@@ -90,6 +84,20 @@ void riscv_find_and_load_firmware(MachineState *machine,
     }
 }
 
+char *riscv_find_firmware(const char *firmware_filename)
+{
+    char *filename;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware_filename);
+    if (filename == NULL) {
+        error_report("Unable to load the RISC-V firmware \"%s\"",
+                     firmware_filename);
+        exit(1);
+    }
+
+    return filename;
+}
+
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr)
 {
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 1f21c2bef1..66075d0e57 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -25,6 +25,7 @@
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
                                   hwaddr firmware_load_addr);
+char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr);
 target_ulong riscv_load_kernel(const char *kernel_filename);
-- 
2.21.0



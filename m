Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC5C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D462133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwlypChB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D462133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyc0N-0000NX-Iu
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hybzF-0007iu-Og
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hybzE-00007Y-OF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:09:45 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hybzE-000072-Iy; Fri, 16 Aug 2019 09:09:44 -0400
Received: by mail-pl1-x642.google.com with SMTP id g4so2452660plo.3;
 Fri, 16 Aug 2019 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=yuaXKmmLPWfovkIgluBK48pRtWPxELyUrBylOTt4Png=;
 b=KwlypChBtTjRMWOA27Qq29c/ToSklS6i+kJe+d8qDlmmJ5gvOHp+J3V2XHcg0m47tV
 gLhR32m0Am6pgP9DP1cCfO/ys9NmjMUcPnaKRpKTEcTDyh0X9xFua3Wq7iC16jl7ogzQ
 FAx2qLU7PtBjk44Vd6oyfWaE9s/y6KbpaH2jCVvu7lwiddzr6ZZU/NvJfsNMUuOMpA5/
 hQNB19tos9RKsXyWOH71vhwwMqw2ybYlwRx5yE7i/p205lm6jfjBMF/hzubX+9MV/nGu
 oGeXbwtyg0//MzY6+Iv2RYBZThH6VWUwptYOzhSWFgcNVN2UXNDB6yLrlgJoh10vANZ5
 uwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=yuaXKmmLPWfovkIgluBK48pRtWPxELyUrBylOTt4Png=;
 b=XkSBCCwO5WVzYG3FjkMEchPa9FPs6Gn+uCp8+MUwebtCJ8yGtt1j6DSTcRHSoqnhOC
 kY7549E7xFEJ425FbHqlbKmZVdRAYcVe0gsr7hCNs+QbwV13ggl3T7Vvvh47J4c9yvRZ
 8hsUe8+HNr0vkx1aBavtJBs9kEScoDyQV+CSaKh27u39QRZHsOPti/6Swx8nGk3O6FkS
 6XnA3A2v2Xl8lmMrx1PNOe7sGihf/IrBCJr14GhkNERtEimfLlPVMoBk/i9dqaLszidD
 k+jkWAkkDEKwgxqJYnKSo0othsWwne2yaoDyugEgXuQ2CXz4BIkWwHK/t6NAjn2GtkRP
 1sJw==
X-Gm-Message-State: APjAAAVvL6YM30eZSLwcpRzv8jWov1FFdFKLW9p2ZxoJ0yDe8gQUKHew
 MMiXvjBMLKkhEXEgNs69B88IxQ4N
X-Google-Smtp-Source: APXvYqyw0mjtn7hcDhNeS0gixQT4mlj6BYEUuFZrWIx0zqHUx7CQVaAD+E6vz8h+nSC6m9OizNU6fw==
X-Received: by 2002:a17:902:b698:: with SMTP id
 c24mr9292930pls.28.1565960983750; 
 Fri, 16 Aug 2019 06:09:43 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id t7sm6122743pfh.101.2019.08.16.06.09.42
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 16 Aug 2019 06:09:43 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri, 16 Aug 2019 06:09:35 -0700
Message-Id: <1565960976-6693-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565960976-6693-1-git-send-email-bmeng.cn@gmail.com>
References: <1565960976-6693-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 1/2] riscv: Add a helper routine for finding
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a helper routine for finding firmware. It is currently
used only for "-bios default" case.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/boot.c         | 22 +++++++++++++++-------
 include/hw/riscv/boot.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 6b7d322..a122846 100644
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
index d56f2ae..1718a8f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -23,6 +23,7 @@
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
                                   hwaddr firmware_load_addr);
+char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr);
 target_ulong riscv_load_kernel(const char *kernel_filename);
-- 
2.7.4



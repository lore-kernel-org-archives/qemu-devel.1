Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787ED206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+MNGZ+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787ED206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5u7i-0001T4-UD
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i5u6X-0000Ml-0S
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i5u6V-0004eA-Ox
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:55:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:33443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i5u6V-0004dI-J4; Thu, 05 Sep 2019 11:55:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id t11so1517891plo.0;
 Thu, 05 Sep 2019 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=AJQpNWcSAo4RkweDJuqLwKMc7Co8pkQh7Ml6FPpTVcc=;
 b=o+MNGZ+6gWNnEUBuC7wYMWVhAzeBFgqnd7wHxD9Vl20juv4vRGd5SXBKkJsjEVrdo7
 LnB/LYfhC6u6E54cai96E8c66+WFy/oONIYDkAEC90cOTfM8eZRzIFzLksaS22h3ejCa
 6kxlKo7Wpzs/Cd6ko0YwPIYsvQ56FqKXl1OV178AVs67M9s1Pk7LntK1emxPAB+wBcZy
 adPdcCUnal+aqf/b/92mF5MiBNnVlS92LM84OaEFLf+yrgQzeBShsFcmBG+JIoM3QZcj
 eaRe4MEeN6LjHdUUuWm8DUwgZ8ech0XL373oLXyAi5CaFqR0hziy1MpccUUjdVH2GO85
 LxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=AJQpNWcSAo4RkweDJuqLwKMc7Co8pkQh7Ml6FPpTVcc=;
 b=nvnu//vTEn6lGEU6vBS7CFCgxmfMQQx3yf9eCeX9f/23vcgIYLCLF01tmQ9y/8DV6h
 g0b0zAczvIhTIQ85q93373VtXuElE3hWqCyiatNdoXjzOqx7JabRHefkvImeMuRjjSUx
 0gl47D86Ahn/1Gb4zaBeJ0wjSkMJCNhFOQzE4lh1LyZ0d60xvFfQZY6r0VLrFx0lVAaF
 vniVB/c7kKagHuzz/nM1RhvXOXeNT++mBUieeOQ/mxl4bzZ98eIyUCgaHYvPSwDlkM6C
 SKAswDWJ5U4ZPUAVQLe2dCY5+2IEEwMpDZXfvsMf777L3xXaOLcKias99mpZ9bSP6UiE
 rZ2g==
X-Gm-Message-State: APjAAAXMed40858anwOTsvpW+Pnks1d/VfBzgH2bhz/lsGu79aNNukDi
 RwOfLg+zbG99rdBkRK7Dd1w=
X-Google-Smtp-Source: APXvYqyNwJYRCgjGPBEdQ66gRM7HqA0t6CtS6vHR9CYxcou0kqlV+WMJzQSACYJ2sZ3Mr1AbgiZYbQ==
X-Received: by 2002:a17:902:e506:: with SMTP id
 ck6mr4322585plb.132.1567698922685; 
 Thu, 05 Sep 2019 08:55:22 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id m19sm5712114pff.108.2019.09.05.08.55.21
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 05 Sep 2019 08:55:21 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu,  5 Sep 2019 08:55:16 -0700
Message-Id: <1567698916-28260-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
Subject: [Qemu-devel] [PATCH v2] riscv: sifive_test: Add reset functionality
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

This adds a reset opcode for sifive_test device to trigger a system
reset for testing purpose.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

---

Changes in v2:
- fix build error in the "for-master" branch of Palmer's RISC-V repo
  that was rebased on QEMU master

 hw/riscv/sifive_test.c         | 4 ++++
 include/hw/riscv/sifive_test.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index afbb3aa..3557e16 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -22,6 +22,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_test.h"
@@ -42,6 +43,9 @@ static void sifive_test_write(void *opaque, hwaddr addr,
             exit(code);
         case FINISHER_PASS:
             exit(0);
+        case FINISHER_RESET:
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            return;
         default:
             break;
         }
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
index 3a603a6..1ec416a 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -36,7 +36,8 @@ typedef struct SiFiveTestState {
 
 enum {
     FINISHER_FAIL = 0x3333,
-    FINISHER_PASS = 0x5555
+    FINISHER_PASS = 0x5555,
+    FINISHER_RESET = 0x7777
 };
 
 DeviceState *sifive_test_create(hwaddr addr);
-- 
2.7.4



Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A93FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C174521019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2BX6BdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkzc-00018T-AL
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:30:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkuy-0005SL-4U
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkut-0000z7-Dq
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkuo-0000uC-5Z
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so5650892wrs.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3N082WaIffsJbYXIZ0a/9GfiR46w16xaqgWtZJxN1co=;
	b=k2BX6BdL7AfVBVZGvxR6I1W5YQyw97rfN8y982CROeZA6WA5nEUyu0LNZ381uVK3mK
	TEtZ0H7yj/B/AYZ7U3O24ZAej2MQM+RmX6gq6keUVDmGPEobLe1afslliZWeUcudmPFO
	epO9GMf3Nbtq7cf9pryxXssNASaX2oR16yfEvQ3SPnI5AyrS12XSLGTDN3LuVxP+q/OL
	hdI+/2zIUl1DiG6/Fn9UYaxCbybEHlTVeGrUKoLVvGGAxttNVkHxcqz48YVsR/HbWvpz
	f3hj8UrsvPotAGg9UsxjNbAV/G5k+BesvT95b1BFgf2yS+TO4PA3UDR3YxqRl7WAyyjC
	83nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3N082WaIffsJbYXIZ0a/9GfiR46w16xaqgWtZJxN1co=;
	b=P3PheMlv5H0QaZBHz52Zz3MCmBi8iJwGfyz1cr48OGtI1tzT+eL2/gGkef2ceu3t2c
	AXKUHHn+hueENVZv3pbTq8OvXkV5tsXpDKH2i3UR2UjG9Quvo+n2Ov4gqy12Rr/mBKdq
	4YmoRm1OKcuFZDvuH+ylbLG61u+ByNvB+M6jitbrMeDI93LHwbXKGw1MknNF4pYW2Cek
	WeCGgCbhPPsDmCO71GS6ZtPpRSsbJgmqQ1+wDjb4GLmSqEFAsuOWu/5l5SGM4Brjo2Cu
	dwHB2mUxOmwCjqM6rLwRAxJkZljJy9xxn0Uc2gHf7KgqgiGOmGO01xkiyhws7wzEuRPl
	FELQ==
X-Gm-Message-State: APjAAAWaHNyEl1+AzucP7LEVYfeASoL1GwRmpcYCaOrLTbC+Zgh9fcAp
	TI9QfhUBFPYtt2LUr2e7GqSdWQ==
X-Google-Smtp-Source: APXvYqzC5S1Os0KrZPLLqGnEcwfWecgVbIk8pHnT+ppk7+B+jAuIjYOBtAu+lDxr4kntsVZPMJNHdw==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr44958922wrn.241.1558607136866; 
	Thu, 23 May 2019 03:25:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 19sm9345962wmk.3.2019.05.23.03.25.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0B3E71FF93;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:10 +0100
Message-Id: <20190523102532.10486-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 06/28] target/arm: use the common interface
 for WRITE0/WRITEC in arm-semi
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have a common semihosting console interface use that for our
string output. However ARM is currently unique in also supporting
semihosting for linux-user so we need to replicate the API in
linux-user. If other architectures gain this support we can move the
file later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/Makefile.objs  |  2 ++
 linux-user/arm/semihost.c | 24 ++++++++++++++++++++++++
 target/arm/arm-semi.c     | 31 ++++++-------------------------
 3 files changed, 32 insertions(+), 25 deletions(-)
 create mode 100644 linux-user/arm/semihost.c

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 769b8d83362..285c5dfa17a 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -6,4 +6,6 @@ obj-y = main.o syscall.o strace.o mmap.o signal.o \
 obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
 obj-$(TARGET_ARM) += arm/nwfpe/
+obj-$(TARGET_ARM) += arm/semihost.o
+obj-$(TARGET_AARCH64) += arm/semihost.o
 obj-$(TARGET_M68K) += m68k-sim.o
diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
new file mode 100644
index 00000000000..9554102a855
--- /dev/null
+++ b/linux-user/arm/semihost.c
@@ -0,0 +1,24 @@
+/*
+ * ARM Semihosting Console Support
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * Currently ARM is unique in having support for semihosting support
+ * in linux-user. So for now we implement the common console API but
+ * just for arm linux-user.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/semihosting/console.h"
+#include "qemu.h"
+
+int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+{
+    void *s = lock_user_string(addr);
+    len = write(STDERR_FILENO, s, len ? len : strlen(s));
+    unlock_user(s, addr, 0);
+    return len;
+}
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 9e5a414dd89..253c66b172a 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -27,6 +27,7 @@
 
 #include "cpu.h"
 #include "hw/semihosting/semihost.h"
+#include "hw/semihosting/console.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
@@ -314,32 +315,12 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, close(arg0));
         }
     case TARGET_SYS_WRITEC:
-        {
-          char c;
-
-          if (get_user_u8(c, args))
-              /* FIXME - should this error code be -TARGET_EFAULT ? */
-              return (uint32_t)-1;
-          /* Write to debug console.  stderr is near enough.  */
-          if (use_gdb_syscalls()) {
-                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1", args);
-          } else {
-                return write(STDERR_FILENO, &c, 1);
-          }
-        }
+    {
+        qemu_semihosting_console_out(env, args, 1);
+        return 0xdeadbeef;
+    }
     case TARGET_SYS_WRITE0:
-        if (!(s = lock_user_string(args)))
-            /* FIXME - should this error code be -TARGET_EFAULT ? */
-            return (uint32_t)-1;
-        len = strlen(s);
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
-                                   args, len);
-        } else {
-            ret = write(STDERR_FILENO, s, len);
-        }
-        unlock_user(s, args, 0);
-        return ret;
+        return qemu_semihosting_console_out(env, args, 0);
     case TARGET_SYS_WRITE:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1



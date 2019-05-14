Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326D4C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20A72085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWm6ndFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20A72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZoC-0000Jv-4e
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:57:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjp-0004mA-QZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjo-0006EP-HC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjo-0006Cw-AS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id n25so3320466wmk.4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=3N082WaIffsJbYXIZ0a/9GfiR46w16xaqgWtZJxN1co=;
	b=TWm6ndFPJjrhVd500ZU3j6de33SOsREWIeUSOAwFl7svBlfqtCC5IlKv25kowmtJyN
	IeuQmMftUaJ00eblCmL5OCQYtn1xxUz6CtM2FilQ7FEI6bFOSeiN2sbXapAjL3K3OuJv
	7qOS5903Yuu/bMfUee7i3w7SAVg1o2Pl/Ixw3sFXyZR3rpOLn1ScrUNjhfSehhUGnVTG
	XBj8LVQlqgatf06DtMSlxwStQHfrCzlfwKeJcbmGdHR8IUykxWK2dvVaZEyN32GhbUIT
	KJoqpsGL7YU4fbC8QVJeFpgJ8Zjw4VeKR2Ay0jzxIMRXe+WGgKDzp6ohKkTYUfsu6G+U
	EI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3N082WaIffsJbYXIZ0a/9GfiR46w16xaqgWtZJxN1co=;
	b=L6Dxw2vXWWZ6oLFVxhKfG2xMPFJrx5L0MdOuGt0yJAj79fJ+1yYBsGBspm/rQrZgpf
	P/ZDcU8tdztOO3ZICicaoG5RZ3zoqMDn3mbMgZpFuegtu75217YmAuKuUFbSTI2s903p
	JBeX32IuLNVbiVyg7ICR6LnYlBMwbdzFhhdARHyPZMoOAeF9F/1LH5K0LTVZgAKAQB/X
	bCjl549rA7FPiwelAEMHyfn0yXI8UIrFjRpzzevNUFV/eU1PmnvvXsT6//rLNYpMu1Nt
	PoN/Mm+VcyxGuknkjr7b9eWC8Ec+FYKf9krbQiNQTtkIimfHZe1APOQtGRUqcUTImPPM
	dgmg==
X-Gm-Message-State: APjAAAVqKK/zY1kvJQAW3gxwgniu+zQfW5TUi0CHaBPcFPTr4ZDuxalm
	je4Sn8igvunNYsXH9eGq/3iRJ5BlRwk=
X-Google-Smtp-Source: APXvYqy8RDCcybQqgxR7z2iPevXlX/bR3opsy/0GIGL/nAk5Lw/KGaeqNNZPtw8oFiATN64njtVpkA==
X-Received: by 2002:a1c:7d04:: with SMTP id y4mr18978347wmc.123.1557849187283; 
	Tue, 14 May 2019 08:53:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id j9sm6786562wrr.90.2019.05.14.08.53.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 8F7AF1FF93;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:52:56 +0100
Message-Id: <20190514155301.16123-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common interface
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



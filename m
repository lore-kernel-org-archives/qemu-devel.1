Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262DC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B058B208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrqP2ZLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYqk-0003OB-0M
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:56:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk7-0006EV-OJ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk4-0008WI-Da
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk4-0008VJ-6t
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id t5so2090269wmh.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xTfU1HgK0Yu+Mt8wiwSgiAOdcAiaYW/8Jaw7M5Np27U=;
	b=xrqP2ZLF1RQm05hRnkS4H3RsDflCKr4NLGZCVHQxxRCKUM9pMmnkGFLisIFYmmQyqz
	KdYtiTWrjvgDOAdE+sc6M88XgHNSTjyBiP+f9PZVIdcALVKCyk2hcxVw5KLJkOtBktXr
	NltHWTMhrl0QneFICQ9lQC7fgHaIB8qD6V85UQJhh4PV7KOGbA+yN5eAktj7p87/uMMi
	X2eEzsUGQvCZzUsHkB6ex5VOdW7fjlf36fNuTrV+DHBN4iLmovQ1U5yEjLHY4GSt87kE
	Z6TqUtvfQn6bPIUtf2VJyQYinMbv46aR0AysUTeJViIPXuWbHhoDuEocCK6T+a7H3rg8
	ioeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xTfU1HgK0Yu+Mt8wiwSgiAOdcAiaYW/8Jaw7M5Np27U=;
	b=sqdxkl7zd2WCq0pCL/uM+HITPipyMcZzLve8w0kMs1Bb4xj+Y1zm3FNrk40Qv8X2/Z
	iDEcZaBBqWunJPK9HNnNiw6LHvcREutU8xF/T3N+5tOK5XHVjiRk1ObwmGrBQZDdiPre
	mjIKYxIPnoW1Y2u1j+li3tQF/s/eJ3XvmYk2gUVSdqGUOzuFp5vRzOMwyxqBpQoRM2bs
	Zd5g+75DxUeVgdwWeyloNYckvMoO/J5NbYkJkRaj67zimHsfV0rtfPHFGjUCacaNwdBU
	QccdMCPOzYf9lyiNWyjXPRvopIq6HkKFeA0CSsX8AcC1OW3bduvXDgd2dnEupTDeFUpl
	aHvQ==
X-Gm-Message-State: APjAAAX6H5gUpSPMRs42fZLWlhbPtovdT2mPx6xOKel9Na83IHAWa5tC
	8Sli8YrqkKlyqrA9NWFpV1SRhA==
X-Google-Smtp-Source: APXvYqzNqz3Smq4D7AfOO7DMTIhOPiPttoIFD1qJhn/Fqyh0H2UqcQr9dSImxlyNxDSSRRt+DgGBQw==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr2454551wmh.55.1559036999128; 
	Tue, 28 May 2019 02:49:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j123sm3589694wmb.32.2019.05.28.02.49.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 029EC1FF93;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:31 +0100
Message-Id: <20190528094953.14898-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 06/28] target/arm: use the common interface for
 WRITE0/WRITEC in arm-semi
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	"open list:ARM" <qemu-arm@nongnu.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have a common semihosting console interface use that for our
string output. However ARM is currently unique in also supporting
semihosting for linux-user so we need to replicate the API in
linux-user. If other architectures gain this support we can move the
file later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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
index d812eef1519..384b01124e1 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -27,6 +27,7 @@
 
 #include "cpu.h"
 #include "hw/semihosting/semihost.h"
+#include "hw/semihosting/console.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
@@ -313,32 +314,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
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
+        qemu_semihosting_console_out(env, args, 1);
+        return 0xdeadbeef;
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



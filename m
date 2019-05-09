Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E429C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19849205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiBWJLQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19849205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmTT-0002xa-AT
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:04:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO8-0006zP-H6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO7-0004tA-0y
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO6-0004s5-QP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:18 -0400
Received: by mail-wm1-x343.google.com with SMTP id b203so4153637wmb.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=OpvEU2mddt+GIEBclmCB/up2u9bmndzrghYWbyOx7a4=;
	b=aiBWJLQZO3EkGYv6kP7hHdprELwVPbY0I2KN6yJXCAGigCqRp+8zJN6iqYkx7ykbX3
	mfEau5E+UinD92HCzN/FsUai3ioTH9u0Je69LEg2veIiOLtXanuhwoBplRDc2rugqWEP
	ZuM89h+B+wObjJUxTZiooI7mWvGA58oeMSRnOMm4sR2srrzaAlV0ubgylpnhFnyU7o+G
	nH2EE0IkAx6pveSUov/H2IkLgd/EUdXwbrnhHBPK/TGJKKv8RQs4Qma80+dABE/FpSoN
	Wi9NSLDK0guWRUVRRuC9ReLLP4CzQcRDbb/l2ah45Ilpe7tg6XwbGAV7ltgxQ39EvC9i
	kb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=OpvEU2mddt+GIEBclmCB/up2u9bmndzrghYWbyOx7a4=;
	b=Rbeu6EVWmqMRT+8MgB5HKja8cRS27zKjpRSDCfcCofYM9zluAKFN2A/hbrlCUNw/kr
	ltRukK0eHaoyWkm8wRTu12gpAJC64XdYomJ1t6ROxWD3lB+SCkadwcG2nIaWySa1SC1I
	yPQ9AVQqh197en2NNigL91whhXsLf8Cv1gbKstGMl+udvpFJyum99FuCApjjpRMc4tNn
	IsrMYMNnmbpCJ7Cc1R9ZoxGDhaGTqgQdckBx1KrKUj2FIAfuL02usffckKL+HRhsohLR
	A+s+Vph594gGz2ucOOAO28APVhVX909wpxwKlD1napXUofx2M6xJqcZ2vLIAvg38HWOn
	DD5Q==
X-Gm-Message-State: APjAAAXhq1w018xFmF5iRI8w+jPEyqwxOVdoURu2RqO3BuZIg62bwT9s
	+hU1UKL+s5DP+2QB/ee1FvPT2j/BUuE=
X-Google-Smtp-Source: APXvYqzj/XSAhxqIvkepM+gpCgYDrEIAmr14/zc1EdEmoA9bWueupuC4g6mU6un2sIYBsurQmal9fw==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr3635272wmm.2.1557421157743;
	Thu, 09 May 2019 09:59:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id u20sm24373wmu.34.2019.05.09.09.59.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 75EC81FF92;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:53 +0100
Message-Id: <20190509165912.10512-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev backed
 output
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For running system tests we want to be able to re-direct output to a
file like we do with serial output. This does the wiring to allow us
to treat semihosting like just another character output device.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/semihost.h |  6 ++++++
 qemu-options.hx         |  6 ++++--
 target/arm/arm-semi.c   | 21 +++++++++++++++++++--
 vl.c                    | 23 +++++++++++++++++++++++
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/exec/semihost.h b/include/exec/semihost.h
index 5980939c7b8..f5cc9ad2759 100644
--- a/include/exec/semihost.h
+++ b/include/exec/semihost.h
@@ -51,12 +51,18 @@ static inline const char *semihosting_get_cmdline(void)
 {
     return NULL;
 }
+
+static inline Chardev *semihosting_get_chardev(void)
+{
+    return NULL;
+}
 #else
 bool semihosting_enabled(void);
 SemihostingTarget semihosting_get_target(void);
 const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
+Chardev *semihosting_get_chardev(void);
 #endif
 
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb266..6aa3a08c2fb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3975,12 +3975,12 @@ STEXI
 Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
 ETEXI
 DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
-    "-semihosting-config [enable=on|off][,target=native|gdb|auto][,arg=str[,...]]\n" \
+    "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,arg=str[,...]]\n" \
     "                semihosting configuration\n",
 QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
 QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)
 STEXI
-@item -semihosting-config [enable=on|off][,target=native|gdb|auto][,arg=str[,...]]
+@item -semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,arg=str[,...]]
 @findex -semihosting-config
 Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
 @table @option
@@ -3988,6 +3988,8 @@ Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
 Defines where the semihosting calls will be addressed, to QEMU (@code{native})
 or to GDB (@code{gdb}). The default is @code{auto}, which means @code{gdb}
 during debug sessions and @code{native} otherwise.
+@item chardev=@var{str1}
+Send the output to a chardev backend output for native or auto output when not in gdb
 @item arg=@var{str1},arg=@var{str2},...
 Allows the user to pass input arguments, and can be used multiple times to build
 up a list. The old-style @code{-kernel}/@code{-append} method of passing a
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 8b5fd7bc6e3..4c326fdc2fb 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -32,6 +32,7 @@
 #include "hw/arm/arm.h"
 #include "qemu/cutils.h"
 #endif
+#include "chardev/char.h"
 
 #define TARGET_SYS_OPEN        0x01
 #define TARGET_SYS_CLOSE       0x02
@@ -310,7 +311,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
           if (use_gdb_syscalls()) {
                 return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1", args);
           } else {
-                return write(STDERR_FILENO, &c, 1);
+#ifdef CONFIG_SOFTMMU
+              Chardev *chardev = semihosting_get_chardev();
+              if (chardev) {
+                  return qemu_chr_write_all(chardev, (uint8_t *) &c, 1);
+              } else
+#endif
+              {
+                  return write(STDERR_FILENO, &c, 1);
+              }
           }
         }
     case TARGET_SYS_WRITE0:
@@ -322,7 +331,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
                                    args, len);
         } else {
-            ret = write(STDERR_FILENO, s, len);
+#ifdef CONFIG_SOFTMMU
+            Chardev *chardev = semihosting_get_chardev();
+            if (chardev) {
+                ret = qemu_chr_write_all(chardev, (uint8_t *) s, len);
+            } else
+#endif
+            {
+                ret = write(STDERR_FILENO, s, len);
+            }
         }
         unlock_user(s, args, 0);
         return ret;
diff --git a/vl.c b/vl.c
index b6709514c1b..34bbb4df865 100644
--- a/vl.c
+++ b/vl.c
@@ -511,6 +511,9 @@ static QemuOptsList qemu_semihosting_config_opts = {
         }, {
             .name = "target",
             .type = QEMU_OPT_STRING,
+        }, {
+            .name = "chardev",
+            .type = QEMU_OPT_STRING,
         }, {
             .name = "arg",
             .type = QEMU_OPT_STRING,
@@ -1356,6 +1359,7 @@ static void configure_msg(QemuOpts *opts)
 typedef struct SemihostingConfig {
     bool enabled;
     SemihostingTarget target;
+    Chardev *chardev;
     const char **argv;
     int argc;
     const char *cmdline; /* concatenated argv */
@@ -1386,6 +1390,11 @@ int semihosting_get_argc(void)
     return semihosting.argc;
 }
 
+Chardev *semihosting_get_chardev(void)
+{
+    return semihosting.chardev;
+}
+
 const char *semihosting_get_cmdline(void)
 {
     if (semihosting.cmdline == NULL && semihosting.argc > 0) {
@@ -3027,6 +3036,7 @@ int main(int argc, char **argv, char **envp)
     int display_remote = 0;
     const char *log_mask = NULL;
     const char *log_file = NULL;
+    const char *semihost_chardev = NULL;
     char *trace_file = NULL;
     ram_addr_t maxram_size;
     uint64_t ram_slots = 0;
@@ -3744,6 +3754,8 @@ int main(int argc, char **argv, char **envp)
                     semihosting.enabled = qemu_opt_get_bool(opts, "enable",
                                                             true);
                     const char *target = qemu_opt_get(opts, "target");
+                    /* setup of chardev is deferred until they are initialised */
+                    semihost_chardev = qemu_opt_get(opts, "chardev");
                     if (target != NULL) {
                         if (strcmp("native", target) == 0) {
                             semihosting.target = SEMIHOSTING_TARGET_NATIVE;
@@ -4277,6 +4289,17 @@ int main(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
 
+    /* We had to defer this until chardevs were created */
+    if (semihost_chardev) {
+        Chardev *chr = qemu_chr_find(semihost_chardev);
+        if (chr == NULL) {
+            error_report("semihosting chardev '%s' not found",
+                         semihost_chardev);
+            exit(1);
+        }
+        semihosting.chardev = chr;
+    }
+
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
                       fsdev_init_func, NULL, &error_fatal);
-- 
2.20.1



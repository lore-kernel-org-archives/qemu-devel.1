Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86AFC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1DD208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veEzCpEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1DD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59983 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYp8-0001uV-Mf
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:55:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk3-0006E8-Tw
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk2-0008TK-Ay
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk2-0008Rt-4n
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id t4so11187655wrx.7
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=t82Ise9y5EQdUowZAI8bltqiROUMDt8BIZRgYkgKnHs=;
	b=veEzCpEUBpRlAIHwS7A47/4RtGReJZ4q2kPRloAA355Nbs5xf/VdNmppHiliCm5V3V
	MzaT80Cx9KMnAzX56av7rdYzbvuWprceGe5mJtOONpt84U8Iwoewxv+GiHKv5IgfkmcK
	qTjNtXCslhmz+Cm1wrhArT86II4Ax8csO5EKmga5T8ydeWzduSfadLzWboE6OXLEv+Gx
	xHdw/Do4B62WRgqMRRauBKV/N/SHwqwybcc7CB+qYna0ZOnOYf3SRPm57YfGYfcYbZI0
	8GbSojI5LN/JxcqlSFU65jM2H592Vhn8urJ9DkmqfvyleseER9K3hh4ljAIxroPyXWbW
	MZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=t82Ise9y5EQdUowZAI8bltqiROUMDt8BIZRgYkgKnHs=;
	b=iGVlHLMWGEjb/qg2BOcAsRTHtcH83yODwmQMEE+wm3XnRSF40H0C9qF0/+ztiZPANz
	HWvn8TryLm/SDzUomgnBMw5sZ8l0L7GjOqAkVb7GLJqBmOQ1ms3CNTrAa9ZVSRrTmCsV
	11xoz/vMbsa+jeNkg3TgLFx7MxdnUdGPL133iSuWKVxdzbJGUTljM9Bavmkp5sSDDbzN
	0WdRSW/1IjX8+XmrXqDmaj4vmQlnI2YM0dWbxidDvbCIzj62kjwVs7BHQdSFjYx9CTsW
	lRnVo98/6uQy7ae3xfYbv/1OOTODCE27ZRHMMyvAKNRTeIFjeI9wU5id8JxkUsAVn+FP
	2avw==
X-Gm-Message-State: APjAAAWcafRd7+FITkbyk98ZvpdrBCE8cLcJL/YawiVpo3ZGBpWPD7N+
	58+P4h0tWwqOj+Ed8RiO9Ty9bQ==
X-Google-Smtp-Source: APXvYqxTa6GHOx+ljaavaQAYQLIT02UAu5Fov/8x0IfdWAiwAXtqK3Ul8GqqLGdLj8eBhSQ3bdjy3w==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr38452101wrv.268.1559036996785; 
	Tue, 28 May 2019 02:49:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n10sm12997964wrr.11.2019.05.28.02.49.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:54 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CA33B1FF91;
	Tue, 28 May 2019 10:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:29 +0100
Message-Id: <20190528094953.14898-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 04/28] semihosting: enable chardev backed output
 for console
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will be useful for a number of use-cases to be able to re-direct
output to a file like we do with serial output. This does the wiring
to allow us to treat then semihosting console like just another
character output device.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/semihosting/config.c b/hw/semihosting/config.c
index f1d3fe1e4c6..2a8e7e1045a 100644
--- a/hw/semihosting/config.c
+++ b/hw/semihosting/config.c
@@ -23,6 +23,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "hw/semihosting/semihost.h"
+#include "chardev/char.h"
 
 QemuOptsList qemu_semihosting_config_opts = {
     .name = "semihosting-config",
@@ -35,6 +36,9 @@ QemuOptsList qemu_semihosting_config_opts = {
         }, {
             .name = "target",
             .type = QEMU_OPT_STRING,
+        }, {
+            .name = "chardev",
+            .type = QEMU_OPT_STRING,
         }, {
             .name = "arg",
             .type = QEMU_OPT_STRING,
@@ -46,12 +50,14 @@ QemuOptsList qemu_semihosting_config_opts = {
 typedef struct SemihostingConfig {
     bool enabled;
     SemihostingTarget target;
+    Chardev *chardev;
     const char **argv;
     int argc;
     const char *cmdline; /* concatenated argv */
 } SemihostingConfig;
 
 static SemihostingConfig semihosting;
+static const char *semihost_chardev;
 
 bool semihosting_enabled(void)
 {
@@ -115,6 +121,11 @@ void semihosting_arg_fallback(const char *file, const char *cmd)
     }
 }
 
+Chardev *semihosting_get_chardev(void)
+{
+    return semihosting.chardev;
+}
+
 void qemu_semihosting_enable(void)
 {
     semihosting.enabled = true;
@@ -132,6 +143,8 @@ int qemu_semihosting_config_options(const char *optarg)
         semihosting.enabled = qemu_opt_get_bool(opts, "enable",
                                                 true);
         const char *target = qemu_opt_get(opts, "target");
+        /* setup of chardev is deferred until they are initialised */
+        semihost_chardev = qemu_opt_get(opts, "chardev");
         if (target != NULL) {
             if (strcmp("native", target) == 0) {
                 semihosting.target = SEMIHOSTING_TARGET_NATIVE;
@@ -158,3 +171,16 @@ int qemu_semihosting_config_options(const char *optarg)
     return 0;
 }
 
+void qemu_semihosting_connect_chardevs(void)
+{
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
+}
diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 01826bd6879..466ea6dade7 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -17,13 +17,20 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "hw/semihosting/semihost.h"
 #include "hw/semihosting/console.h"
 #include "exec/gdbstub.h"
 #include "qemu/log.h"
+#include "chardev/char.h"
 
 int qemu_semihosting_log_out(const char *s, int len)
 {
-    return write(STDERR_FILENO, s, len);
+    Chardev *chardev = semihosting_get_chardev();
+    if (chardev) {
+        return qemu_chr_write_all(chardev, (uint8_t *) s, len);
+    } else {
+        return write(STDERR_FILENO, s, len);
+    }
 }
 
 /*
diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/semihost.h
index 07ea40a322f..60fc42d851e 100644
--- a/include/hw/semihosting/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -51,6 +51,11 @@ static inline const char *semihosting_get_cmdline(void)
 {
     return NULL;
 }
+
+static inline Chardev *semihosting_get_chardev(void)
+{
+    return NULL;
+}
 #else /* !CONFIG_USER_ONLY */
 bool semihosting_enabled(void);
 SemihostingTarget semihosting_get_target(void);
@@ -58,9 +63,11 @@ const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
+Chardev *semihosting_get_chardev(void);
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *opt);
+void qemu_semihosting_connect_chardevs(void);
 #endif /* CONFIG_USER_ONLY */
 
 #endif /* SEMIHOST_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 7ae3373a009..39dc1704296 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4025,12 +4025,12 @@ STEXI
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
@@ -4038,6 +4038,8 @@ Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
 Defines where the semihosting calls will be addressed, to QEMU (@code{native})
 or to GDB (@code{gdb}). The default is @code{auto}, which means @code{gdb}
 during debug sessions and @code{native} otherwise.
+@item chardev=@var{str1}
+Send the output to a chardev backend output for native or auto output when not in gdb
 @item arg=@var{str1},arg=@var{str2},...
 Allows the user to pass input arguments, and can be used multiple times to build
 up a list. The old-style @code{-kernel}/@code{-append} method of passing a
diff --git a/stubs/semihost.c b/stubs/semihost.c
index 1a4e88e5326..4d5b3c06530 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -64,3 +64,7 @@ const char *semihosting_get_cmdline(void)
 void semihosting_arg_fallback(const char *file, const char *cmd)
 {
 }
+
+void qemu_semihosting_connect_chardevs(void)
+{
+}
diff --git a/vl.c b/vl.c
index be8963b2705..2e69c9fef2f 100644
--- a/vl.c
+++ b/vl.c
@@ -4170,6 +4170,8 @@ int main(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
-- 
2.20.1



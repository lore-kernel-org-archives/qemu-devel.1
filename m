Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB9C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1162E2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOs+csmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1162E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZlh-00067k-8A
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:55:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjo-0004kw-VU
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZjn-0006CA-4P
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZjm-0006Ai-RY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:53:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id w12so19833306wrp.2
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0r9ufJMae12rSUNpWxfw8a5ZPlWsKe8VRtl/4yp8eAw=;
	b=TOs+csmWpgVedvpRRe9hbcGHBcQNBNd1rj9kFqMBbMtUy3gBgYWCdSrVmCfxFVnGp9
	Mc7h1UfTJLkjLmGxPBEJfLZa7ZaaPspohHLJP2DCV/KwVn6DZO9E0KjXAqGNipEVkCXr
	f/9+BjRHG5C5ihMQGJFCfT2WJgZmQmIafWeIGOeJpHIt5R+cwL5p7KsvRUy8cjAjb/6g
	xqjjIAlaC5SkmO/lX5yRgxamvOUk/jb4ip0RR2ynyYDTyZmfaBmz+o3dotIJkgnFyniB
	LzZM8UK8kvV3uqGLf5Jvm45UaiYLfLBSIeYR9FDpKU/UbhC7RXDRq5yn8GntTROcOjrr
	96TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0r9ufJMae12rSUNpWxfw8a5ZPlWsKe8VRtl/4yp8eAw=;
	b=t6kG4fZSI5lwacj4mRLtfhsgZ/7hO/q4/Vu2X2IKc4hzbSTzyFfIprEaJwEuirbPRZ
	+PmU30yKnTOBBEmZ0kbpGG1FjliyMcjsbySuRa4HPhCNYr6mkgIhzURU8K/EH2K+r/iW
	YuOtO3cXLkEu/5n+HNNGZkbENIcDMnJf9aH7Ibkv8e3P/z2VbZWUCvXLkjCWJ6keS0Yo
	90BKmP30lhWA9HPEb8/S0H2WeTq0YPKhfdj4FNUh/Yf6eHGEVGTlqH+mcNV8WqCWBv6w
	HnY7BP5TTz8e6WhX8t1O7yojhJepE6Aig8v/ySe5E3wbqxWn6dyltbNUvewyrP9GWaPV
	Hwmw==
X-Gm-Message-State: APjAAAXpbo6DHvmEQM6mMcMdAyJE5GNBxZ/5hcloN/EPUXoQu4hyos+Y
	1X6K/0DlOFq0weNJ8qB1jHjD+Q==
X-Google-Smtp-Source: APXvYqwWjaavofNnBQsErbLmfCKLTcxH1FXJIayOnngIux+/xirkfsKAaKZLYFN0MN+M+z/dCmg9xA==
X-Received: by 2002:a5d:6610:: with SMTP id n16mr14087056wru.250.1557849185778;
	Tue, 14 May 2019 08:53:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id d6sm16564890wrp.9.2019.05.14.08.53.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:53:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 64DB11FF91;
	Tue, 14 May 2019 16:53:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 16:52:54 +0100
Message-Id: <20190514155301.16123-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514155301.16123-1-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [RFC PATCH 04/11] semihosting: enable chardev backed
 output for console
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will be useful for a number of use-cases to be able to re-direct
output to a file like we do with serial output. This does the wiring
to allow us to treat then semihosting console like just another
character output device.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/semihosting/config.c           | 26 ++++++++++++++++++++++++++
 hw/semihosting/console.c          |  9 ++++++++-
 include/hw/semihosting/semihost.h |  7 +++++++
 qemu-options.hx                   |  6 ++++--
 stubs/semihost.c                  |  4 ++++
 vl.c                              |  2 ++
 6 files changed, 51 insertions(+), 3 deletions(-)

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
index ad6f67ecc71..2fa440eb32a 100644
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
index fba48b565c9..49878a2a1bf 100644
--- a/vl.c
+++ b/vl.c
@@ -4156,6 +4156,8 @@ int main(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
-- 
2.20.1



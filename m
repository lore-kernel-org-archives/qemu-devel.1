Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E03C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919FB21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xai7+mHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919FB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl26-0003Z7-RK
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:33:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvA-0005gO-Ll
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkv4-0001Bz-9H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv0-0000t1-L4
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:52 -0400
Received: by mail-wm1-x342.google.com with SMTP id c77so5229933wmd.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ubw9I71sjpfwvHzR2UuoEnPw3tj8WSm8sBEUKtfQT7Q=;
	b=Xai7+mHrsX9qzZJRm6WOBdTGNXV+M0y/MpGwt/8Nfv0H1rMbQpFkH1UC9IyWNXv7sd
	Ppm1eDd4Wpq5H7n7V+F9Fv4QAvi+59PRRd574AQ+VL8U6DjQ8EODOHNHcpdZzyfAFh79
	VIX1A8Z1Yrsu/6vQ2UOAMiOSpePSuqh3Zws0j48ygNVlkWnrLFH7g/YbP6uwjnSYz7xS
	UsGzMDjHMUlK/t2n8ToB1lxKzU0aZxyM42BqJUFljadAaFTFJI38/TK28tzncki7csQ2
	86J94UpldTHOu7pwd2ki0ViuuFwB1xyOLIQ/fL5yrhbk5KIAzhGOaKnAg0IDp+zX81R8
	MLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ubw9I71sjpfwvHzR2UuoEnPw3tj8WSm8sBEUKtfQT7Q=;
	b=cQyBM9kCyZf5UpNbh+2+UX/8fHq3ps2myufbnqfLDLMqkNZAwl/8nvyj9kHKnFfg1l
	ehMzwSax/PQB4GkC8HzXL5JuxdU5kUo/5f6V81npWPPqvfP74OjLM5xegYkbCb/YnzO1
	5CeqwHJ1g5E9NSYbfL5h4PnYg4I1D9imG35Kbmkmt1Ay+ivEpCZxiXAJrxe6OH4t7PVE
	ivK32egOtHkNnhY5CwFGirePVJDMQD7Ag2yF6ZlPh2R5+usH8WHeo/R9CZaUE7MiNufA
	ButD1SWpaOfxv08seagLDQIEKfjWSCabgv/FT76izOrQt1SxgXjmMefhKs6+aLOQ81/y
	PKvg==
X-Gm-Message-State: APjAAAWnpggEP5K6XL4ACPimVfxiQFhwnu8t9YLxR6q7FYuOYsmf+4CG
	X5/cyqC9Q6ej+GBmbsHICTD1ncHPkPI=
X-Google-Smtp-Source: APXvYqxZqzKuXt3KMMww3iJIoam1EUVv0I5Vq8TAsQoowuq3c1wechGwSbIs1xTd/GWKWcBbM9PuyQ==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr11027550wmb.13.1558607135043; 
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i15sm32072270wre.30.2019.05.23.03.25.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:33 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D0C241FF91;
	Thu, 23 May 2019 11:25:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:08 +0100
Message-Id: <20190523102532.10486-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 04/28] semihosting: enable chardev backed
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
index 5daa5a8fb0a..ce36048ef31 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4015,12 +4015,12 @@ STEXI
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
@@ -4028,6 +4028,8 @@ Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
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
index 6b19ea42bfe..17f912166ce 100644
--- a/vl.c
+++ b/vl.c
@@ -4166,6 +4166,8 @@ int main(int argc, char **argv, char **envp)
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
 
 #ifdef CONFIG_VIRTFS
     qemu_opts_foreach(qemu_find_opts("fsdev"),
-- 
2.20.1



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD9C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25211217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPF7u3U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25211217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9UT-0006Dh-Bu
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:39:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MT-0007RV-5g
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MR-00066X-Qy
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MR-000663-Kp
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id g9so3564953pfo.11
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ceT2r+izts3PAZf3K2FbPyiFmzlKg5cF+haJm18PT78=;
	b=GPF7u3U1LVBVDG6A5rXKtsYXh8+nXr/1DELjYbkrEtTUnrIco4/YzrXTE3q2l4rtgV
	+xlrrDeJPySMHxSICNsvSwqPR1kWsJq7M6jfQrCdGdODs0TWhpl90wj2OCqH42TG6Bes
	oIG67b/oeNe/LPY2cR8i2wZ/ATmie7/aYc8DbfjxbBMUjzZdsqblMYSiLIEuatqdR0y1
	TIKz/YF7b5cfTmbKR8cphfOC7RqaQSKdNg3P5Px7sJRhrl8b+S/FzJV2tck9DZqvNuO6
	foHmxL0w7w4PyNUQNCo1km6NeSOU7cdhX86YUKQpeWJKkJG9Ew5NJOUOa/4Viv3H4uP0
	/a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ceT2r+izts3PAZf3K2FbPyiFmzlKg5cF+haJm18PT78=;
	b=bg9x8tDkC6UOFZH8vjLEDzaEUGIhL1LaS6IoAcAVaXW1eHmL3iEdtSq4dYb+U5eTte
	yxUNN+sRg5i+jZmcpm4c5KAY4PqM5WbgVruw2N0SKMR85pJ2Vg0tNklGl08SMGrqZAwP
	f7YCV9eh9JP2ymGIcu0hQG8nGHDvbJjczBQwt86s3tUW/pxCJqNA9Dzxpo53wbS4wRjv
	HbnZ7p1olC8mHU6CI9CSw8kfzamewHKSnNiWriINcI21Pd+t9Nfd0CP4oNsUxeVRTkjb
	+nlDl5WGeF2Avt9PCfzjvgkpcTtciodeaagK/nM7ep1ZmZ6ov0HMvzj7IfwfLkM7Vjfs
	WsxA==
X-Gm-Message-State: APjAAAWG0pR5OHN3AGC3Mn8zRZsb0V+onmZ/UfnoXa+CfMoOHOSHEDai
	GkfcDMkpPrgmbs/UU522MPTROM7JZgI=
X-Google-Smtp-Source: APXvYqzCuoRwqLORJFN15VuXKDXKAMtEA2gVgtK7ltvqctptf2gSXbQR4SiTzCq0TSIBopXnOdQ14w==
X-Received: by 2002:aa7:9148:: with SMTP id 8mr15706393pfi.176.1557509466384; 
	Fri, 10 May 2019 10:31:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:36 -0700
Message-Id: <20190510173049.28171-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v6 12/25] linux-user: Initialize pseudo-random
 seeds for all guest cpus
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the -seed option is given, call qemu_guest_random_seed_main,
putting the subsystem into deterministic mode.  Pass derived seeds
to each cpu created during clone; which is a no-op unless the
subsystem is in deterministic mode.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Retain srand() until last user goes away.
---
 linux-user/main.c    | 30 +++++++++++++++++++-----------
 linux-user/syscall.c |  3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3d2230320b..7e704845c0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -34,6 +34,7 @@
 #include "tcg.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
+#include "qemu/guest-random.h"
 #include "elf.h"
 #include "trace/control.h"
 #include "target_elf.h"
@@ -48,6 +49,7 @@ static int gdbstub_port;
 static envlist_t *envlist;
 static const char *cpu_model;
 static const char *cpu_type;
+static const char *seed_optarg;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
@@ -290,15 +292,9 @@ static void handle_arg_pagesize(const char *arg)
     }
 }
 
-static void handle_arg_randseed(const char *arg)
+static void handle_arg_seed(const char *arg)
 {
-    unsigned long long seed;
-
-    if (parse_uint_full(arg, &seed, 0) != 0 || seed > UINT_MAX) {
-        fprintf(stderr, "Invalid seed number: %s\n", arg);
-        exit(EXIT_FAILURE);
-    }
-    srand(seed);
+    seed_optarg = arg;
 }
 
 static void handle_arg_gdb(const char *arg)
@@ -433,7 +429,7 @@ static const struct qemu_argument arg_table[] = {
      "",           "run in singlestep mode"},
     {"strace",     "QEMU_STRACE",      false, handle_arg_strace,
      "",           "log system calls"},
-    {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_randseed,
+    {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_seed,
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
@@ -689,8 +685,20 @@ int main(int argc, char **argv, char **envp)
         do_strace = 1;
     }
 
-    if (getenv("QEMU_RAND_SEED")) {
-        handle_arg_randseed(getenv("QEMU_RAND_SEED"));
+    if (seed_optarg == NULL) {
+        seed_optarg = getenv("QEMU_RAND_SEED");
+    }
+    if (seed_optarg != NULL) {
+        unsigned long long seed;
+
+        /* This will go away with the last user of rand(). */
+        if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
+            fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
+            exit(EXIT_FAILURE);
+        }
+        srand(seed);
+
+        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
     }
 
     target_environ = envlist_to_environ(envlist, NULL);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5ff6f5dc8..96f20886ce 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -107,6 +107,7 @@
 #include "uname.h"
 
 #include "qemu.h"
+#include "qemu/guest-random.h"
 #include "fd-trans.h"
 
 #ifndef CLONE_IO
@@ -5482,6 +5483,7 @@ static void *clone_func(void *arg)
         put_user_u32(info->tid, info->child_tidptr);
     if (info->parent_tidptr)
         put_user_u32(info->tid, info->parent_tidptr);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
     /* Enable signals.  */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready.  */
@@ -5568,6 +5570,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
            initializing, so temporarily block all signals.  */
         sigfillset(&sigmask);
         sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+        cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
         /* If this is our first additional thread, we need to ensure we
          * generate code for parallel execution and flush old translations.
-- 
2.17.1



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED434C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74532182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWSrTqIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74532182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuPI-0004pX-U5
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:33:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHm-0006Jt-81
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-00016y-JH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHk-00015O-B6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: by mail-pl1-x642.google.com with SMTP id d21so2000876plr.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I3gtAlIWwDdw8etvrF0cUhXO78/4AJyRaaREgjfC74k=;
	b=lWSrTqIGyEpoxCi5qCJh3C98tzIqCjZHmhq/gwqJWOcc4vawGnvQI+fLvSNkizm8PN
	1CnRNl37I5h2vyYkwxLPa4/Lo37E5AZyGQnQWKynsP6n57pO5F6+TVC9l1PM0WMHNlpK
	Xsccb/mWv1Xw9PvfI64hLDP7oeiVomDRyOryMbjeIKFcIAhT2uXYF+x6tNSxq7Qmlzem
	SwlGUgHW0Jx4XgbVtqKmhK9XNF8hxgsVzZZqRBg5Ovpj7p3eCh0LHkUQtGXROUcGafw0
	4iggZlf4uRgWJAnP1P3mkZ9PT0UFQPC9IJdX9tMbEdU3rKEv1o7qVzEzeM9/UECI4AXR
	B18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=I3gtAlIWwDdw8etvrF0cUhXO78/4AJyRaaREgjfC74k=;
	b=aRVRHi763scAL3ZfglgsyeCYhbhzjrc3hyscA2b/Gi4XncCcGlfw0ncNR5866S939p
	2xwgu4+DgP7+g2jUykDCdJZJb9V2rR0VJXTDgW3NhDhxVWwNsjRu48c7xec80Z7CcE4F
	kzq4n85hDCf2MFThDV4ntZ13wEEqeFn89fEPY0ILCSPOS1MEZh+y2FWelJGUcWHF1KvJ
	qd5uNq/0VZZEBExsJtPp01Pf9cQxcud5c0h+3GHBjM4a4ZDqsZ3a0Sg7i7RmUBL22EQr
	2EzkCDV4fU1THs9u30zuzfAK/80AJeHHlH492XoXAkNMccBMwXqHTNQIeepnUkIq7coK
	yuVQ==
X-Gm-Message-State: APjAAAVwhy1xxv//xwvzjs6Rl4K7wOra5d80kThHXfvjzr1+sHzsLL/4
	cnUytTLKHM7dN2A3b9Fe/t7Mvt50obg=
X-Google-Smtp-Source: APXvYqxWbhY5Y+/+/46EvfhQA6Nepdw7orV61T6+WiIMk+4yfUtiYU0l0ZorcdPHwRIEjSOzMQiMJg==
X-Received: by 2002:a17:902:868b:: with SMTP id
	g11mr9342202plo.273.1557451514950; 
	Thu, 09 May 2019 18:25:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:46 -0700
Message-Id: <20190510012458.22706-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v5 12/24] linux-user: Initialize pseudo-random
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the -seed option is given, call qemu_guest_random_seed_main,
putting the subsystem into deterministic mode.  Pass derived seeds
to each cpu created during clone; which is a no-op unless the
subsystem is in deterministic mode.

Cc: Laurent Vivier <laurent@vivier.eu>
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
index 96cd4bf86d..ce377b2fc1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -110,6 +110,7 @@
 #include "uname.h"
 
 #include "qemu.h"
+#include "qemu/guest-random.h"
 #include "fd-trans.h"
 
 #ifndef CLONE_IO
@@ -5441,6 +5442,7 @@ static void *clone_func(void *arg)
         put_user_u32(info->tid, info->child_tidptr);
     if (info->parent_tidptr)
         put_user_u32(info->tid, info->parent_tidptr);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
     /* Enable signals.  */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready.  */
@@ -5527,6 +5529,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
            initializing, so temporarily block all signals.  */
         sigfillset(&sigmask);
         sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+        cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
         /* If this is our first additional thread, we need to ensure we
          * generate code for parallel execution and flush old translations.
-- 
2.17.1



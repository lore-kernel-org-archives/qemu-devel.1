Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B9C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC6B20815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTAz/z6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC6B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSsV-00022h-NR
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:45:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmh-0005YC-7J
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmd-000287-7L
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmd-00027k-1I
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id w22so2513691pgi.6
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xy1OktLeK7/mJWPw/JMSGUFtW6+kUG05ru+wLl6Tmjo=;
	b=fTAz/z6SLnzaFKL6OjNX5K5jhKFebfdhYcbMaxJpeXFSQxfyJ4f/CEglCNW9+auXtN
	3sXqsbiWwHo49IVD8Xxxj3P2XEJbylVNnrJEcLjFwAcZEeI05GGXAuWWtJ7UVDaQ95n6
	WNXMf3JGjqwkcCltsoT4jN0ThVOGZPMcLmBzjwzEBrvSAK5CmjJyvwEA032Thgy0LgQq
	7Gp4AT4CWrXmiQnJVsND0yVCgaAdgtOvUPGG1SlLITHfQ43JXWOjwg5TdUDna4rvjxBi
	s7vqg4k/xAAwpFqHYKvR0NB4NzPAQSlzV8XZnQsg5nJGswyK5eJ0q9NpFkeNdopj01Yz
	AfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xy1OktLeK7/mJWPw/JMSGUFtW6+kUG05ru+wLl6Tmjo=;
	b=mauYh/lBS5MU0Ebm4xRRMvMx2bktCxrDKU7Ngr0e58+wAQ4PQYIm5wQHwDVa7kSQJl
	bl9bUHuJCrRatkXq7hTXfLKzhYC8ZnfYFU9OOg8YENnY6u8XBZnI7Offou96Fo8A65Cb
	pVaUEHUUj8LSw3m5TFcWkS3ANB9Egqas69esygfrIiupOR6ZNqmWRyGWJesQqagpJpbY
	8ZHIP/CHoEd9P5cRVT12iemu5TrCJkwyfY3nZNCg3/0YNkih24aCfg1GztBrdBo4Pbs1
	4E4147mcKFFNkVaVJsxsnP5NuTKmHu62mQS5sJgE1mrZvf6uWAMk4Yqjv7gvZqZQ+41O
	k6og==
X-Gm-Message-State: APjAAAUOM/Fabi6w3aXzEQW5OqLcNbh2KEmHvW5Y9cq09IbtYr84Dtk/
	erWAVMeMUgOlBG4E/ax+4OJvad3KRK8=
X-Google-Smtp-Source: APXvYqyKMFwCDbWftO7x8in2vL0rm4GBC5qBEHRpa32sTcNF9Hwey8h9mKckYgD1p92kC21RfMGlCw==
X-Received: by 2002:a63:e408:: with SMTP id a8mr54178798pgi.146.1558060781792; 
	Thu, 16 May 2019 19:39:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:11 -0700
Message-Id: <20190517023924.1686-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v8 12/25] linux-user: Initialize pseudo-random
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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



Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD5C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E60120879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNQKJAXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E60120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWhv-0000Hc-9b
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:15:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOp-00086d-7L
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCJ-000872-U9
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:45 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:41715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCJ-00085w-PR
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:43 -0400
Received: by mail-yw1-xc44.google.com with SMTP id o65so1240637ywd.8
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2ZOvSlCVstHsIxkY3rXu99Q7piqIwzQbJ9bkZ8lPHXs=;
	b=vNQKJAXQml5IIJRBkmHYQ+UeFXIUV8TEpCEEKufTkfAsYrCezZrlQQ7OyRa1ywZUzM
	DULL2P7etXtYfwO7wxNAeWIhNqoBx8xw5ADTYEMnOCGjetRckZ+wCLI5Br6CO+8cVSTH
	od6/2OafJLl6h3ALRkMVK8+LRH4z0KxRuGdCRat1DWIhWHv9VpJhUY7e9OAVtrqYNDXW
	CiSeYCggnbilXbk5l20ia7okflcyv2w+V4+8aQKAp/2unbX2XX4Yc8+T5IdMWUZPvri5
	r8rQpEk2qSitgCvMmrma/w13tBWHJgTgiYKCAxJLO8g5jmDbjJPaSAqOVYRZIVAc6qkr
	Cu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2ZOvSlCVstHsIxkY3rXu99Q7piqIwzQbJ9bkZ8lPHXs=;
	b=T3o9tkhOKEkFN/mA96wTIbUQe4jQ9Q0RgNPvhrcu0NQmgAYuBxA/VgTh8Jaao5ULus
	jAiJJiekExUPfcwXounSTKWyBJQKqWIjvqE6sI3X3f/BZbbde3pebD5HDN3CkihrYF0c
	0nWJArEbv8agDe98og4xU0GKdfDnjmQ+ROgmANnga1vjhpqrhqWGVuuKoUpbBEUcQ6Ko
	9SP6ZY71tZETuB12N92rBjjUG2mFy9yCqtXrzq7dh22/fXell2RcV9eZx8CDBBqbi0MI
	YvK+ilqKJZwZapDO/fIyaQZlRtHNky3kmSMlFz8VW4PlvVNhYD83EoXMPrz50jutrLI4
	j1tA==
X-Gm-Message-State: APjAAAXG8JV5EhXqZTE//gyrNzQa7UOz7IQEpbvOKoVl1wkH6oTaeab6
	dvUy2b0EuipygzueXVsZCrOAFO93fKQ=
X-Google-Smtp-Source: APXvYqxV99IxULJ3fzKB+PmFJoYxFkyF3tbtcFqJfC9Rs+BzZwVoGOb/riw9pVZPk5v0SoK/ILSngg==
X-Received: by 2002:a81:9294:: with SMTP id
	j142mr15313237ywg.157.1558550561235; 
	Wed, 22 May 2019 11:42:41 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:13 -0400
Message-Id: <20190522184226.17871-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [PULL 12/25] linux-user: Initialize pseudo-random
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
Cc: peter.maydell@linaro.org
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
index efa3ec2837..f3ea9cac21 100644
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



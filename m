Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE4C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6F720873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llixhV8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6F720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd0R-0006f9-4E
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:22:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvI-0002W8-TC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvH-0006sg-Pm
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvH-0006rT-JI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:11 -0400
Received: by mail-pf1-x442.google.com with SMTP id b76so5329pfb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xy1OktLeK7/mJWPw/JMSGUFtW6+kUG05ru+wLl6Tmjo=;
	b=llixhV8s2IXNRYJyRFtKp14FjEtBz7C44GLPCmGS70qLY5BIDc0Pgwhek+5l0GJD2b
	GZD4F76T6qPe3RKOFELuf5+aWqIaZzgfke9bXCHJxNcr8bmZu2FqzSg6h2es1eDtBGxz
	PNV0JNX+o8nhp7y5y3vPiglzXelbBQSxJCY9847n2iykzuD8RK/LRDjvZ2P57wU7wzrV
	xQ/A4lvbGszCGWwMi8kganW0l0VDm7ARww5rr9l4quubcar4IsF35ZpEHk16zKOCjOFw
	MUPuKxZy5HsbMSVgaAtQBvoWDAjH8jKH5BPswX4Ge6d1r2wOnrT+OuIrA4pmNE2PCeD8
	EsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xy1OktLeK7/mJWPw/JMSGUFtW6+kUG05ru+wLl6Tmjo=;
	b=mkyRK7kb3nCBUf/IyAFI4LasQWR7FME23wcsoywcq7qG/puMtOLjwnCdwUMtD/dUaD
	O4j7tUoW22nVXTwBBmodaAO8wocVO9EgCpJkQiIjljk2Hb0Lo/CwpuLux8iDfwuRZKTi
	RmajtfBpArnG8H3J7t4JhbF3IGgUEYsvWBJlzysbnPxkYfIyvoLgTWeedTa9FQqlVIn9
	3IJrTaRzgiSCKuC3RBugovVWNYUj2v5tnIvb7PKqCUfQJCx6yebfiEi5IkjO6PLPY6xo
	gjmNc2zBSeMQ1CA1cDKpwzrV4YJ4AuY/UsjoaWnauPHMCTEyuJjfqe/I5FUwiWFsnzb7
	e6Tg==
X-Gm-Message-State: APjAAAV6tiaRzbiY9ug3ser9GgYZs+EYdH7WVnEZuqhYgDd2m6K/CZ7X
	85kPi82QkibohI85P5UIVuyJb5qvTrc=
X-Google-Smtp-Source: APXvYqyMIVejzT99QMaP8Q3TIHEsbmTk2As5aX4etKVj03AkFzT/B4ckMGGki7YjTZigBB66OpdgVw==
X-Received: by 2002:a62:1b85:: with SMTP id
	b127mr14346929pfb.165.1557861430208; 
	Tue, 14 May 2019 12:17:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:40 -0700
Message-Id: <20190514191653.31488-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 11/24] linux-user: Initialize pseudo-random
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



Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A99C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E150420674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPRpokFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E150420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasVQ-0002ZL-1K
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 23:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOd-0005mh-Bh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:46616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOc-0002XL-2Y
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id 145so5851239pfw.13
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7oeS1yq+JuN20j7v7YlPjXCqUmCXhfYGwbcqS/Ex0lQ=;
 b=iPRpokFCK6wQcIorE/5znHNzBns5F8QhUi/eWDuUptzms0PHkODWyIbYVqxtwwktIm
 PlNAN7WNt293oK9k1AuTMZfp4Hg/E3D6NqVUhQHm/ghahTFPO1CL+REgj3MTwRr+KDpn
 u8yE1blINsgBpTdlbINjfATn7iIP4FJUuMbqK8erfqp4fN2e2plnv+4JmtfLBkDtgFOm
 SSwBUWxI4CtWsoZBQ8FlLz50xt57rt4YbE/gFcCkuh4Ndy1RfIVKZjGgrneD5ttHLkEy
 ZbD3rnGnaVUUtyphXOVTpV6OWpl1UpFAgzDL0orpiijBMFvfE/c9fl8Qmz9raAhI2TAB
 KQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7oeS1yq+JuN20j7v7YlPjXCqUmCXhfYGwbcqS/Ex0lQ=;
 b=ktybrfxp4qz5i+3EcI9X9fGmqby7GmkFttdeITMXStfpJNMbeJjfiTEdaYCTvy+YHy
 2fuvYnKjhuFF7mrAXqkPPA+dNsFoz13RGkONXMMiU+Zcpby39BfGtsR4SL26A0A9BRJu
 5rCt0YNQA/fSbrZFT+loeNbOeoX4il1YtAgA93hsKWJgxUvuBHVa3nk9pLhBiCio0+TF
 JHWoH5vg5iD2YtUQzxh2sO39/LjzF2/rKVyqzSQajpwq1bin2gph66us03mijsDr3Ulb
 EGYUC4GQiVaWt5Ula1CZkGLwz0Y9wp/RJvVh+eN8r/7mxPkAQh3AH1s8PAi58O7Zj7zq
 +oWQ==
X-Gm-Message-State: AOAM5327z6X4sUyk3j5PxhMpF0vmYmJcR30/5YBurVMkwItLzZUy2eIL
 ZisNuaN0P3pBkOvA+QsToyve1aVaPto=
X-Google-Smtp-Source: ABdhPJytF1N+m1lqm7ajke1BaElmisfGDMoSrO7KgH4x4sfrdnVvBl+zuDoQn7tVHa8dB4Q/rb2FEQ==
X-Received: by 2002:a63:c146:: with SMTP id p6mr11521519pgi.55.1589856860213; 
 Mon, 18 May 2020 19:54:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 17/17] Add --dump option to inspect trace files
Date: Mon, 18 May 2020 19:53:55 -0700
Message-Id: <20200519025355.4420-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adjust some of the aarch64 code to look at the reginfo struct
instead of looking at test_sve, so that we do not need to pass
the --test-sve option in order to dump sve trace files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                 |   1 +
 risu.c                 | 108 ++++++++++++++++++++++++++++++++++++++++-
 risu_reginfo_aarch64.c |  55 +++++++++++++--------
 risu_reginfo_arm.c     |   4 ++
 risu_reginfo_i386.c    |   4 ++
 risu_reginfo_m68k.c    |   4 ++
 risu_reginfo_ppc64.c   |   4 ++
 7 files changed, 159 insertions(+), 21 deletions(-)

diff --git a/risu.h b/risu.h
index 054cef7..3bfe765 100644
--- a/risu.h
+++ b/risu.h
@@ -23,6 +23,7 @@
 extern const struct option * const arch_long_opts;
 extern const char * const arch_extra_help;
 void process_arch_opt(int opt, const char *arg);
+void arch_init(void);
 #define FIRST_ARCH_OPT   0x100
 
 /* GCC computed include to pull in the correct risu_reginfo_*.h for
diff --git a/risu.c b/risu.c
index 95b4674..d7c7556 100644
--- a/risu.c
+++ b/risu.c
@@ -249,6 +249,93 @@ static int apprentice(void)
     }
 }
 
+static int dump_trace(void)
+{
+    trace_header_t header;
+    union {
+        struct reginfo ri;
+        unsigned char memblock[MEMBLOCKLEN];
+    } u;
+    const char *op_name;
+
+    while (1) {
+        if (read_buffer(&header, sizeof(header))) {
+            fprintf(stderr, "Trace header read failed\n");
+            return EXIT_FAILURE;
+        }
+
+        if (header.magic != RISU_MAGIC) {
+            fprintf(stderr, "Unexpected header magic (%#x)\n", header.magic);
+            return EXIT_FAILURE;
+        }
+
+        switch (header.risu_op) {
+        case OP_COMPARE:
+           op_name = "COMPARE";
+           break;
+        case OP_TESTEND:
+           op_name = "TESTEND";
+           break;
+        case OP_SETMEMBLOCK:
+           op_name = "SETMEMBLOCK";
+           break;
+        case OP_GETMEMBLOCK:
+           op_name = "GETMEMBLOCK";
+           break;
+        case OP_COMPAREMEM:
+           op_name = "COMPAREMEM";
+           break;
+        case OP_SIGILL:
+           op_name = "SIGILL";
+           break;
+        default:
+           op_name = "<unknown>";
+           break;
+        }
+
+        switch (header.risu_op) {
+        case OP_COMPARE:
+        case OP_TESTEND:
+        case OP_SIGILL:
+            if (header.size > sizeof(u.ri)) {
+                fprintf(stderr, "Unexpected trace size (%u)\n", header.size);
+                return EXIT_FAILURE;
+            }
+            if (read_buffer(&u.ri, header.size)) {
+                fprintf(stderr, "Reginfo read failed\n");
+                return EXIT_FAILURE;
+            }
+            if (header.size != reginfo_size(&u.ri)) {
+                fprintf(stderr, "Unexpected trace size (%u)\n", header.size);
+                return EXIT_FAILURE;
+            }
+            printf("%s: (pc %#lx)\n", op_name, (unsigned long)header.pc);
+            reginfo_dump(&u.ri, stdout);
+            putchar('\n');
+            if (header.risu_op == OP_TESTEND) {
+                return EXIT_SUCCESS;
+            }
+            break;
+
+        case OP_COMPAREMEM:
+            if (header.size != MEMBLOCKLEN) {
+                fprintf(stderr, "Unexpected trace size (%u)\n", header.size);
+                return EXIT_FAILURE;
+            }
+            if (read_buffer(&u.memblock, MEMBLOCKLEN)) {
+                fprintf(stderr, "Memblock read failed\n");
+                return EXIT_FAILURE;
+            }
+            /* TODO: Dump 8k of data? */
+            /* fall through */
+
+        default:
+            printf("%s\n", op_name);
+            break;
+        }
+    }
+}
+
 static int ismaster;
 
 static void usage(void)
@@ -261,6 +348,7 @@ static void usage(void)
     fprintf(stderr, "between master and apprentice risu processes.\n\n");
     fprintf(stderr, "Options:\n");
     fprintf(stderr, "  --master          Be the master (server)\n");
+    fprintf(stderr, "  -d, --dump=FILE   Dump " TRACE_TYPE " trace file\n");
     fprintf(stderr, "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n");
     fprintf(stderr,
             "  -h, --host=HOST   Specify master host machine (apprentice only)"
@@ -281,11 +369,12 @@ static struct option * setup_options(char **short_opts)
         {"host", required_argument, 0, 'h'},
         {"port", required_argument, 0, 'p'},
         {"trace", required_argument, 0, 't'},
+        {"dump", required_argument, 0, 'd'},
         {0, 0, 0, 0}
     };
     struct option *lopts = &default_longopts[0];
 
-    *short_opts = "h:p:t:";
+    *short_opts = "d:h:p:t:";
 
     if (arch_long_opts) {
         const size_t osize = sizeof(struct option);
@@ -316,6 +405,7 @@ int main(int argc, char **argv)
     char *trace_fn = NULL;
     struct option *longopts;
     char *shortopts;
+    bool dump = false;
 
     longopts = setup_options(&shortopts);
 
@@ -330,6 +420,10 @@ int main(int argc, char **argv)
         case 0:
             /* flag set by getopt_long, do nothing */
             break;
+        case 'd':
+            trace_fn = optarg;
+            trace = dump = true;
+            break;
         case 't':
             trace_fn = optarg;
             trace = true;
@@ -351,6 +445,11 @@ int main(int argc, char **argv)
         }
     }
 
+    if (dump && ismaster) {
+        usage();
+        exit(1);
+    }
+
     if (trace) {
         if (strcmp(trace_fn, "-") == 0) {
             comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
@@ -366,6 +465,10 @@ int main(int argc, char **argv)
         }
     }
 
+    if (dump) {
+        return dump_trace();
+    }
+
     imgfile = argv[optind];
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
@@ -375,6 +478,9 @@ int main(int argc, char **argv)
 
     load_image(imgfile);
 
+    /* Select requested SVE vector length. */
+    arch_init();
+
     if (ismaster) {
         if (!trace) {
             fprintf(stderr, "master port %d\n", port);
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index a1020ac..fb8e11a 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -44,8 +44,6 @@ const char * const arch_extra_help
 void process_arch_opt(int opt, const char *arg)
 {
 #ifdef SVE_MAGIC
-    long want, got;
-
     assert(opt == FIRST_ARCH_OPT);
     test_sve = strtol(arg, 0, 10);
 
@@ -53,22 +51,37 @@ void process_arch_opt(int opt, const char *arg)
         fprintf(stderr, "Invalid value for VQ (1-%d)\n", SVE_VQ_MAX);
         exit(EXIT_FAILURE);
     }
-    want = sve_vl_from_vq(test_sve);
-    got = prctl(PR_SVE_SET_VL, want);
-    if (want != got) {
-        if (got < 0) {
-            perror("prctl PR_SVE_SET_VL");
-        } else {
-            fprintf(stderr, "Unsupported value for VQ (%d != %d)\n",
-                    test_sve, (int)sve_vq_from_vl(got));
-        }
-        exit(EXIT_FAILURE);
-    }
 #else
     abort();
 #endif
 }
 
+void arch_init(void)
+{
+#ifdef SVE_MAGIC
+    long want, got1, got2;
+
+    if (test_sve == 0) {
+        return;
+    }
+
+    want = sve_vl_from_vq(test_sve);
+    asm(".arch_extension sve\n\trdvl %0, #1" : "=r"(got1));
+    if (want != got1) {
+        got2 = prctl(PR_SVE_SET_VL, want);
+        if (want != got2) {
+            if (got2 < 0) {
+                perror("prctl PR_SVE_SET_VL");
+                got2 = got1;
+            }
+            fprintf(stderr, "Unsupported value for VQ (%d != %d)\n",
+                    test_sve, (int)sve_vq_from_vl(got1));
+            exit(EXIT_FAILURE);
+        }
+    }
+#endif
+}
+
 int reginfo_size(struct reginfo *ri)
 {
 #ifdef SVE_MAGIC
@@ -170,6 +183,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
         if (sve->head.size < SVE_SIG_CONTEXT_SIZE(vq)) {
             if (sve->head.size == sizeof(*sve)) {
                 /* SVE state is empty -- not an error.  */
+                goto do_simd;
             } else {
                 fprintf(stderr, "risu_reginfo_aarch64: "
                         "failed to get complete SVE state\n");
@@ -182,6 +196,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
                SVE_SIG_CONTEXT_SIZE(vq) - SVE_SIG_REGS_OFFSET);
         return;
     }
+ do_simd:
 #endif /* SVE_MAGIC */
 
     for (i = 0; i < 32; i++) {
@@ -260,8 +275,9 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  fpcr   : %08x\n", ri->fpcr);
 
 #ifdef SVE_MAGIC
-    if (test_sve) {
-        int q, vq = test_sve;
+    if (ri->sve_vl) {
+        int vq = sve_vq_from_vl(ri->sve_vl);
+        int q;
 
         fprintf(f, "  vl     : %d\n", ri->sve_vl);
 
@@ -339,13 +355,12 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
     }
 
 #ifdef SVE_MAGIC
-    if (test_sve) {
+    if (m->sve_vl != a->sve_vl) {
+        fprintf(f, "  vl    : %d vs %d\n", m->sve_vl, a->sve_vl);
+    }
+    if (m->sve_vl) {
         int vq = sve_vq_from_vl(m->sve_vl);
 
-        if (m->sve_vl != a->sve_vl) {
-            fprintf(f, "  vl    : %d vs %d\n", m->sve_vl, a->sve_vl);
-        }
-
         for (i = 0; i < SVE_NUM_ZREGS; i++) {
             uint64_t *zm = reginfo_zreg(m, vq, i);
             uint64_t *za = reginfo_zreg(a, vq, i);
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 3832e27..2982435 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -36,6 +36,10 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 902d33e..68f2323 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -74,6 +74,10 @@ void process_arch_opt(int opt, const char *arg)
     }
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 361f172..499fdc4 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -23,6 +23,10 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index c86313c..3b04747 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -32,6 +32,10 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+void arch_init(void)
+{
+}
+
 int reginfo_size(struct reginfo *ri)
 {
     return sizeof(struct reginfo);
-- 
2.20.1



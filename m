Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD17C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB49205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVxX5j5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB49205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYw06-0003r9-Mz
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpc-0003vV-7P
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:36629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpZ-0000NC-Pv
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id z1so104466pfn.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NLyUmEZ5i6oZApVfDSFYVtzokpBFXsLQ3SNKAJFbA44=;
 b=jVxX5j5LyRLS0DrRPjvuhoE7z2M1L0tjIIJuQ64bdi7yqih7+KWZqf/t37HtF+5H/6
 DBJLXN1rbhhtoDyj5CwrPd+SAFfh5kiled4mJmekfee1Iid07BNMluryy7VqIirSH49t
 jX9E8jL/iAarOnuj/R/wxrU1YU5tcWqvQBa6LE3P7zaxhIBsh2KTDnmCcedbnA5Q4ijX
 YiCr+uQxRXYrPXVEvueuGms8OdoF+VCkMmRRoG4yXOO/kG18I97mlUk3W1Dv8X3hq8EZ
 /nIiYff4oLIPX5Q/YJd+xj7dGJ6p6Uyitb9m0opDp5teBnQL1mdBLBcwsEE8y9M+DnER
 q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NLyUmEZ5i6oZApVfDSFYVtzokpBFXsLQ3SNKAJFbA44=;
 b=RmMew+ipvmleTQBM9zQEsqEmVIe0p/X45VDCDwYhddcd1fbIk5IgwJYS5COzy5TCdr
 VwU7rRWvzJjhv7PoqXmAxRAsCnyH9IRxrzHBd9WQOMBmvP4K4jLWKJOPmWWfm/c11yoN
 lOwEwUZ2UMWYDiYLnShjK4Bx6L2S1qVepAcNuMG3OPt955ciPDb29dZ81UuCLi8grZ1A
 /rznhd3iOm981dXiO9DiRJceRz1VcKDPPyUFj26dp12SzUlqQdXePDdGL/ZyqKisQ9Yo
 L5xMIwigQmw1VuzhuvN7sqor0zwLhQP/VvuTJZ8OhnFSPgi+075Jx1E6MxPeoSJUYLCB
 tHEA==
X-Gm-Message-State: AOAM531OC20bvQS4GAstSvuaiNY75frQUNAwBYfWhCXzLrZcOlh+A6iQ
 uFdbb6ao8UTm82Zk1jnJtjz7wIs77uQ=
X-Google-Smtp-Source: ABdhPJz9bTowWW2/MORGr/yqj0c93Nq3mAwJa8A0xxX6Vqvt/4gW1JC+rFwFsW7QnKjpVbG9uxuYSA==
X-Received: by 2002:a63:5542:: with SMTP id f2mr489628pgm.384.1589393407686;
 Wed, 13 May 2020 11:10:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:10:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 9/9] Add --dump option to inspect trace files
Date: Wed, 13 May 2020 11:09:53 -0700
Message-Id: <20200513180953.20376-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 risu.c                 | 111 ++++++++++++++++++++++++++++++++++++++++-
 risu_reginfo_aarch64.c |  55 ++++++++++++--------
 risu_reginfo_arm.c     |   4 ++
 risu_reginfo_i386.c    |   4 ++
 risu_reginfo_m68k.c    |   4 ++
 risu_reginfo_ppc64.c   |   4 ++
 7 files changed, 161 insertions(+), 22 deletions(-)

diff --git a/risu.h b/risu.h
index 0ae7fa9..515e5c2 100644
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
index 979341c..6410b2f 100644
--- a/risu.c
+++ b/risu.c
@@ -261,6 +261,94 @@ int apprentice(void)
     return EXIT_FAILURE;
 }
 
+int dump_trace(void)
+{
+    trace_header_t header;
+    union {
+        struct reginfo ri;
+        unsigned char memblock[MEMBLOCKLEN];
+    } u;
+    const char *op_name;
+
+    while (1) {
+        if (read_trace(&header, sizeof(header))) {
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
+        case -1:
+           op_name = "FAULT";
+           break;
+        default:
+           op_name = "<unknown>";
+           break;
+        }
+
+        switch (header.risu_op) {
+        case OP_COMPARE:
+        case OP_TESTEND:
+        default:
+            if (header.size > sizeof(u.ri)) {
+                fprintf(stderr, "Unexpected trace size (%u)\n", header.size);
+                return EXIT_FAILURE;
+            }
+            if (read_trace(&u.ri, header.size)) {
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
+            if (read_trace(&u.memblock, MEMBLOCKLEN)) {
+                fprintf(stderr, "Memblock read failed\n");
+                return EXIT_FAILURE;
+            }
+            /* TODO: Dump 8k of data? */
+            /* fall through */
+
+        case OP_SETMEMBLOCK:
+        case OP_GETMEMBLOCK:
+            printf("%s\n", op_name);
+            break;
+        }
+    }
+}
+
 int ismaster;
 
 void usage(void)
@@ -273,6 +361,7 @@ void usage(void)
     fprintf(stderr, "between master and apprentice risu processes.\n\n");
     fprintf(stderr, "Options:\n");
     fprintf(stderr, "  --master          Be the master (server)\n");
+    fprintf(stderr, "  -d, --dump=FILE   Dump " TRACE_TYPE " trace file\n");
     fprintf(stderr, "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n");
     fprintf(stderr,
             "  -h, --host=HOST   Specify master host machine (apprentice only)"
@@ -293,11 +382,12 @@ static struct option * setup_options(char **short_opts)
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
@@ -328,6 +418,7 @@ int main(int argc, char **argv)
     char *trace_fn = NULL;
     struct option *longopts;
     char *shortopts;
+    bool dump = false;
 
     longopts = setup_options(&shortopts);
 
@@ -342,6 +433,10 @@ int main(int argc, char **argv)
         case 0:
             /* flag set by getopt_long, do nothing */
             break;
+        case 'd':
+            trace_fn = optarg;
+            dump = true;
+            break;
         case 't':
             trace_fn = optarg;
             trace = true;
@@ -363,7 +458,12 @@ int main(int argc, char **argv)
         }
     }
 
-    if (trace) {
+    if (dump && ismaster) {
+        usage();
+        exit(1);
+    }
+
+    if (trace || dump) {
         if (strcmp(trace_fn, "-") == 0) {
             comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
         } else {
@@ -378,6 +478,10 @@ int main(int argc, char **argv)
         }
     }
 
+    if (dump) {
+        return dump_trace();
+    }
+
     imgfile = argv[optind];
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
@@ -387,6 +491,9 @@ int main(int argc, char **argv)
 
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



Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475B82072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjRPDEFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475B82072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxfp-0008LB-Gb
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWc-0002p5-Ne
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:06 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWb-000587-Cq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id x2so4471664pfx.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q/LihqsBffCSl3YlGCBIwjGGFgT5Kwzo71qJstw4oL4=;
 b=qjRPDEFul5/Adm96hM0EHUYCOuBjT9SZ691NHvNBVSKhOsvqdR5Uoxoikm/8H3FsFp
 crqDo8OL+xzK7o3gqMvKl8aQd/F8aG4N1X6ukgrvagK3nTcwsKf4vEh4SSC804cKK6J/
 h5TC6KsR8Rzr6vSnaFd1bTr88jCYiA9xU5ySMHLKS8lofG0dInuse1SHwdezzengmRpM
 +Bxr3SMO+hSeiA28wQBiLDTUb3GTnVwU5rjF8XwMEQ8O3PLIctRtdgaZMExxepw8+4pG
 stFTb9fHAGQ70/u0EedrcO/XgyHv5Th20EH9mpHLd1S8sGSbzOITq8L1B7J0gtCRpJmb
 cYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q/LihqsBffCSl3YlGCBIwjGGFgT5Kwzo71qJstw4oL4=;
 b=YwkyWdUegwgyAms1rtAK1v98YAAx9jXODf1v+QXKZxkR8wg7NBlIoTcnetVLpyK4u1
 /jhtcf2SqWaq7GJvvivxjfTbQ5jIaEi6zBmhxVcmrTiyCjZGRKVvnqrlKgc1vZrcR7gF
 RIMDdDvsp6cNJvrQFunmp2+KdYs1yYcJXOqttZrygmGoXeJvJWiwyqKk6dhWOPUewzwg
 5PaDpIOtLkEhSX+hEtLJ+ziZLYkexPP2Wh0ydsJrgzi5rn2Jb5dpgTH5N2YjKp5FG+gw
 mfTvMGzZPSjDnEkyptnSImPRQivhLDsUu2tzNmRGtAUacARbbBSAOXA6N+vZ9dxbJpZT
 LX1g==
X-Gm-Message-State: AOAM530O/GsbmOyqXzgBBk6jMd8l0LyHjjZIVM9nEE6JdiyuAxcSKN15
 HYX8IdTH5Ow16LXavqA4/oZA3Y4vWUo=
X-Google-Smtp-Source: ABdhPJxJQ56WBJi08qNr2sCwbLalMz7I31qiKJwvRYne9qRDqvBQmqRGPwvLP+b8fv8csmGbv8zPNA==
X-Received: by 2002:a63:8f03:: with SMTP id n3mr11461146pgd.352.1590114903508; 
 Thu, 21 May 2020 19:35:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/25] Add magic and size to the trace header
Date: Thu, 21 May 2020 19:34:32 -0700
Message-Id: <20200522023440.26261-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sanity check that we're not getting out of sync with
the trace stream.  This will be especially bad with
the change in size of the sve save data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h |  10 +++-
 risu.c | 162 ++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 136 insertions(+), 36 deletions(-)

diff --git a/risu.h b/risu.h
index dd9fda5..bfcf0af 100644
--- a/risu.h
+++ b/risu.h
@@ -55,7 +55,11 @@ typedef enum {
     RES_END,
     RES_MISMATCH_REG,
     RES_MISMATCH_MEM,
+    RES_MISMATCH_OP,
     RES_BAD_IO,
+    RES_BAD_MAGIC,
+    RES_BAD_SIZE,
+    RES_BAD_OP,
 } RisuResult;
 
 /* The memory block should be this long */
@@ -69,10 +73,14 @@ typedef enum {
 struct reginfo;
 
 typedef struct {
-   uintptr_t pc;
+   uint32_t magic;
+   uint32_t size;
    uint32_t risu_op;
+   uintptr_t pc;
 } trace_header_t;
 
+#define RISU_MAGIC  (('R' << 24) | ('I' << 16) | ('S' << 8) | 'U')
+
 /* Socket related routines */
 int master_connect(int port);
 int apprentice_connect(const char *hostname, int port);
diff --git a/risu.c b/risu.c
index 80bc3b1..a248db1 100644
--- a/risu.c
+++ b/risu.c
@@ -111,32 +111,54 @@ static RisuResult send_register_info(void *uc)
     uint64_t paramreg;
     RisuResult res;
     RisuOp op;
+    void *extra;
 
     reginfo_init(&ri[MASTER], uc);
     op = get_risuop(&ri[MASTER]);
 
     /* Write a header with PC/op to keep in sync */
+    header.magic = RISU_MAGIC;
     header.pc = get_pc(&ri[MASTER]);
     header.risu_op = op;
+
+    switch (op) {
+    case OP_TESTEND:
+    case OP_COMPARE:
+    case OP_SIGILL:
+        header.size = reginfo_size();
+        extra = &ri[MASTER];
+        break;
+    case OP_COMPAREMEM:
+        header.size = MEMBLOCKLEN;
+        extra = memblock;
+        break;
+    case OP_SETMEMBLOCK:
+    case OP_GETMEMBLOCK:
+        header.size = 0;
+        extra = NULL;
+        break;
+    default:
+        abort();
+    }
+
     res = write_buffer(&header, sizeof(header));
     if (res != RES_OK) {
         return res;
     }
+    if (extra) {
+        res = write_buffer(extra, header.size);
+        if (res != RES_OK) {
+            return res;
+        }
+    }
 
     switch (op) {
     case OP_COMPARE:
-    case OP_TESTEND:
     case OP_SIGILL:
-        /*
-         * Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        res = write_buffer(&ri[MASTER], reginfo_size());
-        /* For OP_TEST_END, force exit. */
-        if (res == RES_OK && op == OP_TESTEND) {
-            res = RES_END;
-        }
+    case OP_COMPAREMEM:
         break;
+    case OP_TESTEND:
+        return RES_END;
     case OP_SETMEMBLOCK:
         paramreg = get_reginfo_paramreg(&ri[MASTER]);
         memblock = (void *)(uintptr_t)paramreg;
@@ -145,12 +167,10 @@ static RisuResult send_register_info(void *uc)
         paramreg = get_reginfo_paramreg(&ri[MASTER]);
         set_ucontext_paramreg(uc, paramreg + (uintptr_t)memblock);
         break;
-    case OP_COMPAREMEM:
-        return write_buffer(memblock, MEMBLOCKLEN);
     default:
         abort();
     }
-    return res;
+    return RES_OK;
 }
 
 static void master_sigill(int sig, siginfo_t *si, void *uc)
@@ -175,22 +195,35 @@ static RisuResult recv_register_info(struct reginfo *ri)
         return res;
     }
 
-    /* send OK for the header */
-    respond(RES_OK);
+    if (header.magic != RISU_MAGIC) {
+        /* If the magic number is wrong, we can't trust the rest. */
+        return RES_BAD_MAGIC;
+    }
 
     switch (header.risu_op) {
     case OP_COMPARE:
     case OP_TESTEND:
     case OP_SIGILL:
-        return read_buffer(ri, reginfo_size());
+        /* If we can't store the data, report invalid size. */
+        if (header.size > sizeof(*ri)) {
+            return RES_BAD_SIZE;
+        }
+        respond(RES_OK);
+        return read_buffer(ri, header.size);
+
     case OP_COMPAREMEM:
+        if (header.size != MEMBLOCKLEN) {
+            return RES_BAD_SIZE;
+        }
+        respond(RES_OK);
         return read_buffer(other_memblock, MEMBLOCKLEN);
+
     case OP_SETMEMBLOCK:
     case OP_GETMEMBLOCK:
-        return RES_OK;
+        return header.size == 0 ? RES_OK : RES_BAD_SIZE;
+
     default:
-        /* TODO: Create a better error message. */
-        return RES_BAD_IO;
+        return RES_BAD_OP;
     }
 }
 
@@ -204,48 +237,71 @@ static RisuResult recv_and_compare_register_info(void *uc)
 
     res = recv_register_info(&ri[MASTER]);
     if (res != RES_OK) {
-        /* I/O error.  Tell master to exit. */
-        respond(RES_END);
-        return res;
+        goto done;
     }
 
     op = get_risuop(&ri[APPRENTICE]);
-    if (header.risu_op != op) {
-        /* We are out of sync.  Tell master to exit. */
-        respond(RES_END);
-        return RES_BAD_IO;
-    }
 
     switch (op) {
     case OP_COMPARE:
     case OP_TESTEND:
     case OP_SIGILL:
-        if (!reginfo_is_eq(&ri[MASTER], &ri[APPRENTICE])) {
+        /*
+         * If we have nothing to compare against, report an op mismatch.
+         * Otherwise allow the compare to continue, and assume that
+         * something in the reginfo will be different.
+         */
+        if (header.risu_op != OP_COMPARE &&
+            header.risu_op != OP_TESTEND &&
+            header.risu_op != OP_SIGILL) {
+            res = RES_MISMATCH_OP;
+        } else if (!reginfo_is_eq(&ri[MASTER], &ri[APPRENTICE])) {
             /* register mismatch */
             res = RES_MISMATCH_REG;
+        } else if (op != header.risu_op) {
+            /* The reginfo matched.  We should have matched op. */
+            res = RES_MISMATCH_OP;
         } else if (op == OP_TESTEND) {
             res = RES_END;
         }
-        respond(res == RES_OK ? RES_OK : RES_END);
         break;
+
     case OP_SETMEMBLOCK:
+        if (op != header.risu_op) {
+            res = RES_MISMATCH_OP;
+            break;
+        }
         paramreg = get_reginfo_paramreg(&ri[APPRENTICE]);
         memblock = (void *)(uintptr_t)paramreg;
         break;
+
     case OP_GETMEMBLOCK:
+        if (op != header.risu_op) {
+            res = RES_MISMATCH_OP;
+            break;
+        }
         paramreg = get_reginfo_paramreg(&ri[APPRENTICE]);
         set_ucontext_paramreg(uc, paramreg + (uintptr_t)memblock);
         break;
+
     case OP_COMPAREMEM:
+        if (op != header.risu_op) {
+            res = RES_MISMATCH_OP;
+            break;
+        }
         if (memcmp(memblock, other_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
             res = RES_MISMATCH_MEM;
         }
-        respond(res == RES_OK ? RES_OK : RES_END);
         break;
+
     default:
         abort();
     }
+
+ done:
+    /* On error, tell master to exit. */
+    respond(res == RES_OK ? RES_OK : RES_END);
     return res;
 }
 
@@ -346,6 +402,25 @@ static int master(void)
     }
 }
 
+static const char *op_name(RisuOp op)
+{
+    switch (op) {
+    case OP_SIGILL:
+        return "SIGILL";
+    case OP_COMPARE:
+        return "COMPARE";
+    case OP_TESTEND:
+        return "TESTEND";
+    case OP_SETMEMBLOCK:
+        return "SETMEMBLOCK";
+    case OP_GETMEMBLOCK:
+        return "GETMEMBLOCK";
+    case OP_COMPAREMEM:
+        return "COMPAREMEM";
+    }
+    abort();
+}
+
 static int apprentice(void)
 {
     RisuResult res = sigsetjmp(jmpbuf, 1);
@@ -364,7 +439,7 @@ static int apprentice(void)
         return EXIT_SUCCESS;
 
     case RES_MISMATCH_REG:
-        fprintf(stderr, "mismatch reg after %zd checkpoints\n", signal_count);
+        fprintf(stderr, "Mismatch reg after %zd checkpoints\n", signal_count);
         fprintf(stderr, "master reginfo:\n");
         reginfo_dump(&ri[MASTER], stderr);
         fprintf(stderr, "apprentice reginfo:\n");
@@ -373,15 +448,32 @@ static int apprentice(void)
         return EXIT_FAILURE;
 
     case RES_MISMATCH_MEM:
-        fprintf(stderr, "mismatch mem after %zd checkpoints\n", signal_count);
+        fprintf(stderr, "Mismatch mem after %zd checkpoints\n", signal_count);
+        return EXIT_FAILURE;
+
+    case RES_MISMATCH_OP:
+        /* Out of sync, but both opcodes are known valid. */
+        fprintf(stderr, "Mismatch header after %zd checkpoints\n"
+                "mismatch detail (master : apprentice):\n"
+                "  opcode: %s vs %s\n",
+                signal_count, op_name(header.risu_op),
+                op_name(get_risuop(&ri[APPRENTICE])));
         return EXIT_FAILURE;
 
     case RES_BAD_IO:
-        fprintf(stderr, "i/o error after %zd checkpoints\n", signal_count);
+        fprintf(stderr, "I/O error\n");
+        return EXIT_FAILURE;
+    case RES_BAD_MAGIC:
+        fprintf(stderr, "Unexpected magic number: %#08x\n", header.magic);
+        return EXIT_FAILURE;
+    case RES_BAD_SIZE:
+        fprintf(stderr, "Unexpected payload size: %u\n", header.size);
+        return EXIT_FAILURE;
+    case RES_BAD_OP:
+        fprintf(stderr, "Unexpected opcode: %d\n", header.risu_op);
         return EXIT_FAILURE;
-
     default:
-        fprintf(stderr, "unexpected result %d\n", res);
+        fprintf(stderr, "Unexpected result %d\n", res);
         return EXIT_FAILURE;
     }
 }
-- 
2.20.1



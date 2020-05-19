Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D75C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EC3207D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="im9OAiLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EC3207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasV7-00025H-Ut
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 23:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOZ-0005ap-9G
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:19 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:46372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOX-0002Ur-N1
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:18 -0400
Received: by mail-pg1-x534.google.com with SMTP id p21so5721614pgm.13
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ryftU8k2hkpE8SBKJnjLqyziikg8zbnLkzl+yDCUuSA=;
 b=im9OAiLamHIqOafI3tQsbysVXK8ot/8ZbuSUFqTn9R6Rb+StXyuOfV7yA+4Eu2x4lm
 mYeTJggiGdxC1GfX9Og90vqS4XXvwxpu3Q9rBP5yA5QKAup7/oLB6y8XSFweP+T4BF8f
 P0JckyFsavmmG0KbZWuTO8RmTH4uVg31dypak3+BEbtXbR4l33cKOemnLiA9G7BxrLKB
 bWVKQassqREJEzsF2J1T1keHfG1V7YxGwMdGJNayTc08P8+UI7Zrp3+7pOt9GvNonnBp
 FoqjzjDvrR9lPE3BR4lVzfp+fXcvgm31xjb+dk2bjE0gUYzAX+buYeMCynkTJYuG2Y80
 vG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ryftU8k2hkpE8SBKJnjLqyziikg8zbnLkzl+yDCUuSA=;
 b=FKUDOjn/G2EzLdMUj7HmSNak8XWjcJavSmvqQp+VG3rHHDG81ZX+4ltH3G4vmWOznE
 SVB/Jj7VUjtMR93UO6UjRtHZPyZkwMwg+It+VyOM7GZ97cjFUn67qVr/CtfHIGve5ere
 vbEoo970pNFfpbZx4sE0WXjCUOUoD1Fh2bkCYfwO7afHFUwCfi47+/5VJN+2rA/Ac7xW
 HZbUCgQTaz9OkZc7YS/aWgjAV0yNw6hWBd6niP+b5dTiCgwoCWZHTMfTpYorTBNs+uGf
 AvDMmx7kMuG2r5M2LL8Zd/8MJk4tZ60lGvGgwZyp9rweqlVygCi0M1gMMvwRDtLFivUn
 s9wA==
X-Gm-Message-State: AOAM530Rgc7rlKerVFL0Aj2e4mMqOYtaGn/uWtgqRw56GhrpbItx4COq
 NZFIu2G7MCcZtzI3WWxUU4kHsEbBGNI=
X-Google-Smtp-Source: ABdhPJyF49Z7/O/2cC18RRTPDQM6TUXj84tp3jGmn3gmHpEYYGMW6zWKcV+Tbxvu1kmIwsL5RAw8Ww==
X-Received: by 2002:a63:f90a:: with SMTP id h10mr17788269pgi.57.1589856855815; 
 Mon, 18 May 2020 19:54:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 14/17] Add magic and size to the trace header
Date: Mon, 18 May 2020 19:53:52 -0700
Message-Id: <20200519025355.4420-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Sanity check that we're not getting out of sync with
the trace stream.  This will be especially bad with
the change in size of the sve save data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    |   8 ++-
 reginfo.c | 160 ++++++++++++++++++++++++++++++++++++++++++++----------
 risu.c    |   6 ++
 3 files changed, 143 insertions(+), 31 deletions(-)

diff --git a/risu.h b/risu.h
index b234f93..eeb6775 100644
--- a/risu.h
+++ b/risu.h
@@ -56,6 +56,7 @@ typedef enum {
     RES_END,
     RES_MISMATCH_REG,
     RES_MISMATCH_MEM,
+    RES_MISMATCH_HEAD,
     RES_BAD_IO,
 } RisuResult;
 
@@ -70,10 +71,14 @@ typedef enum {
 struct reginfo;
 
 typedef struct {
-   uintptr_t pc;
+   uint32_t magic;
+   uint32_t size;
    uint32_t risu_op;
+   uintptr_t pc;
 } trace_header_t;
 
+#define RISU_MAGIC  (('R' << 24) | ('i' << 16) | ('S' << 8) | 'u')
+
 /* Socket related routines */
 int master_connect(int port);
 int apprentice_connect(const char *hostname, int port);
@@ -111,6 +116,7 @@ RisuResult recv_and_compare_register_info(void *uc);
  * done in recv_and_compare_register_info().
  */
 void report_mismatch_reg(void);
+void report_mismatch_header(void);
 
 /* Interface provided by CPU-specific code: */
 
diff --git a/reginfo.c b/reginfo.c
index a007f16..f187d9c 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -16,6 +16,7 @@
 
 static struct reginfo master_ri, apprentice_ri;
 static uint8_t master_memblock[MEMBLOCKLEN];
+static trace_header_t master_header;
 
 RisuResult send_register_info(void *uc)
 {
@@ -23,32 +24,57 @@ RisuResult send_register_info(void *uc)
     trace_header_t header;
     RisuResult res;
     RisuOp op;
+    void *extra;
 
     reginfo_init(&ri, uc);
     op = get_risuop(&ri);
 
     /* Write a header with PC/op to keep in sync */
+    header.magic = RISU_MAGIC;
     header.pc = get_pc(&ri);
     header.risu_op = op;
+
+    switch (op) {
+    case OP_TESTEND:
+    case OP_COMPARE:
+    case OP_SIGILL:
+        header.size = reginfo_size();
+        extra = &ri;
+        break;
+
+    case OP_SETMEMBLOCK:
+    case OP_GETMEMBLOCK:
+        header.size = 0;
+        extra = NULL;
+        break;
+
+    case OP_COMPAREMEM:
+        header.size = MEMBLOCKLEN;
+        extra = memblock;
+        break;
+
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
-        res = write_buffer(&ri, reginfo_size());
-        /* For OP_TEST_END, force exit. */
-        if (res == RES_OK && op == OP_TESTEND) {
-            res = RES_END;
-        }
+    case OP_COMPAREMEM:
         break;
+    case OP_TESTEND:
+        return RES_END;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
         break;
@@ -56,12 +82,10 @@ RisuResult send_register_info(void *uc)
         set_ucontext_paramreg(uc,
                               get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
         break;
-    case OP_COMPAREMEM:
-        return write_buffer(memblock, MEMBLOCKLEN);
     default:
         abort();
     }
-    return res;
+    return RES_OK;
 }
 
 /* Read register info from the socket and compare it with that from the
@@ -75,34 +99,48 @@ RisuResult send_register_info(void *uc)
 RisuResult recv_and_compare_register_info(void *uc)
 {
     RisuResult res;
-    trace_header_t header;
+    size_t extra_size;
     RisuOp op;
 
     reginfo_init(&apprentice_ri, uc);
     op = get_risuop(&apprentice_ri);
 
-    res = read_buffer(&header, sizeof(header));
-    if (res != RES_OK) {
-        return res;
+    switch (op) {
+    case OP_TESTEND:
+    case OP_COMPARE:
+    case OP_SIGILL:
+        extra_size = reginfo_size();
+        break;
+    case OP_SETMEMBLOCK:
+    case OP_GETMEMBLOCK:
+        extra_size = 0;
+        break;
+    case OP_COMPAREMEM:
+        extra_size = MEMBLOCKLEN;
+        break;
+    default:
+        abort();
     }
 
-    if (header.risu_op != op) {
-        /* We are out of sync.  Tell master to exit. */
-        respond(RES_END);
-        return RES_BAD_IO;
+    res = read_buffer(&master_header, sizeof(master_header));
+    if (res != RES_OK) {
+        goto fail_header;
+    }
+    if (master_header.magic != RISU_MAGIC ||
+        master_header.risu_op != op ||
+        master_header.size != extra_size) {
+        res = RES_MISMATCH_HEAD;
+        goto fail_header;
     }
 
     /* send OK for the header */
     respond(RES_OK);
 
     switch (op) {
-    case OP_COMPARE:
     case OP_TESTEND:
+    case OP_COMPARE:
     case OP_SIGILL:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        res = read_buffer(&master_ri, reginfo_size());
+        res = read_buffer(&master_ri, extra_size);
         if (res != RES_OK) {
             /* fail */
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
@@ -111,15 +149,17 @@ RisuResult recv_and_compare_register_info(void *uc)
         } else if (op == OP_TESTEND) {
             res = RES_END;
         }
-        respond(res == RES_OK ? RES_OK : RES_END);
         break;
+
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&apprentice_ri);
-        break;
+        return RES_OK;
+
     case OP_GETMEMBLOCK:
         set_ucontext_paramreg(uc, get_reginfo_paramreg(&apprentice_ri) +
                               (uintptr_t)memblock);
-        break;
+        return RES_OK;
+
     case OP_COMPAREMEM:
         res = read_buffer(master_memblock, MEMBLOCKLEN);
         if (res != RES_OK) {
@@ -128,12 +168,14 @@ RisuResult recv_and_compare_register_info(void *uc)
             /* memory mismatch */
             res = RES_MISMATCH_MEM;
         }
-        respond(res == RES_OK ? RES_OK : RES_END);
         break;
+
     default:
         abort();
     }
 
+ fail_header:
+    respond(res == RES_OK ? RES_OK : RES_END);
     return res;
 }
 
@@ -149,3 +191,61 @@ void report_mismatch_reg(void)
     reginfo_dump(&apprentice_ri, stderr);
     reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
 }
+
+void report_mismatch_header(void)
+{
+    fprintf(stderr, "header mismatch detail (master : apprentice):\n");
+    if (master_header.magic != RISU_MAGIC) {
+        fprintf(stderr, "  magic: %08x vs %08x\n",
+                master_header.magic, RISU_MAGIC);
+        /* If the magic number is wrong, everything else is garbage too. */
+        return;
+    }
+
+    RisuOp a_op = get_risuop(&apprentice_ri);
+    RisuOp m_op = master_header.risu_op;
+    if (a_op != m_op) {
+        fprintf(stderr, "  op   : %d != %d\n", m_op, a_op);
+        /* If the opcode is mismatched, we can't compute size. */
+    } else {
+        const char *kind;
+        size_t m_sz = master_header.size;
+        size_t a_sz;
+
+        switch (a_op) {
+        case OP_TESTEND:
+        case OP_COMPARE:
+        case OP_SIGILL:
+            kind = "reginfo";
+            a_sz = reginfo_size();
+            break;
+        case OP_SETMEMBLOCK:
+        case OP_GETMEMBLOCK:
+            kind = "unexpected";
+            a_sz = 0;
+            break;
+        case OP_COMPAREMEM:
+            kind = "memblock";
+            a_sz = MEMBLOCKLEN;
+            break;
+        default:
+            abort();
+        }
+        if (a_sz != m_sz) {
+            fprintf(stderr, " size : %zd != %zd (%s)\n",
+                    m_sz, a_sz, kind);
+        } else {
+            /* If magic, op, and size are the same, how did we get here? */
+            abort();
+        }
+    }
+
+    uint64_t a_pc = get_pc(&apprentice_ri);
+    uint64_t m_pc = master_header.pc;
+    if (a_pc != m_pc) {
+        fprintf(stderr, "  pc   : %016" PRIx64 " vs %016" PRIx64 "\n",
+                m_pc, a_pc);
+    } else {
+        fprintf(stderr, "  pc   : %016" PRIx64 "\n", a_pc);
+    }
+}
diff --git a/risu.c b/risu.c
index 398faac..95b4674 100644
--- a/risu.c
+++ b/risu.c
@@ -233,6 +233,12 @@ static int apprentice(void)
         fprintf(stderr, "mismatch mem after %zd checkpoints\n", signal_count);
         return EXIT_FAILURE;
 
+    case RES_MISMATCH_HEAD:
+        fprintf(stderr, "mismatch header after %zd checkpoints\n",
+                signal_count);
+        report_mismatch_header();
+        return EXIT_FAILURE;
+
     case RES_BAD_IO:
         fprintf(stderr, "i/o error after %zd checkpoints\n", signal_count);
         return EXIT_FAILURE;
-- 
2.20.1



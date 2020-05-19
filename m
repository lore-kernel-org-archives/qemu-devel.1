Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E2F207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEbelyIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E2F207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasRx-0005CX-Mf
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOT-0005Me-I9
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:13 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:33039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOS-0002QL-CZ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:13 -0400
Received: by mail-pg1-x52f.google.com with SMTP id s10so3478902pgm.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGQGSgIKAGAYHQLVIaGjpxZ5J/uu0s5INYdsdKfSe6k=;
 b=tEbelyISa2Td5QL3ptJBzS69jUBLnvB3eTn4Nhmm/Cg6kcokuAL6Oi9Uvp0Au83sLo
 +utu+E2t2EafnibCvaKO/zmfYywRkmE7t1wiaLimM6WzlQiaKPjubNDbebVv01Y67N20
 jAsZ4fU5V8uGy8+aEThZ+d5oz6kIdpDj3l1P5BUSr1wwmse0GtWlOXgTrDjfr6u/s5US
 zzAiuidp9REHIwMQKESCurq1rxTyMhsCZN2Kgvm4oLhNg/pso3xchwoLwR/eHQ8Qj/Qi
 FeqnlSxqGqI38u4AWpjq6wIn6Hhj2mrhrUKe9wYx0NaEOyI31ctYAPsZLFCpmBPo57OU
 mRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGQGSgIKAGAYHQLVIaGjpxZ5J/uu0s5INYdsdKfSe6k=;
 b=UbhFlBUOfpm6H+c0HHZqdc3NqLr0gP+pDfqbWcdGzUec+JBbAIXGpS3xxtReiwBQ+M
 ooxuAIzwR7Jql+irrTu5NeYX3BBSxGQQZ77CUngmHzruSYBR62909c7eDoGGGPfx7dA/
 WiN6ZJzPyazycPgb/PyuU9y0lJyfGCVJIz1gbVQRhgWYQjy6E2/dIt2bnDqh8Imasupn
 7PkMHir19OT2gcT87u6jkkBGwazml6EsudFuAMIqAgLXS/2QlqPKYHI/IIskdzinZMiD
 Buzs0qbOvZLyP/trWr/CsHa/nCHa9qVWLeDT0y0VGO0Hg8vjr/UF+PSJIkI0xNtWBwnF
 TgSQ==
X-Gm-Message-State: AOAM531TqwXubnH9fDZ87DfGdtAAbb6EW/r8tYEyOUzw64aIBVptM5R4
 F56zl/jODPYqBD08y8UDvXXzCKC4GeY=
X-Google-Smtp-Source: ABdhPJxmngS5K9GLgj6eUqVRESljF6gReLcCln1U8oB5YT4t78eTUgKziI693+dRCNGps0TndO8eAw==
X-Received: by 2002:a63:63c6:: with SMTP id x189mr6919598pgb.36.1589856846455; 
 Mon, 18 May 2020 19:54:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 07/17] Add enum RisuOp
Date: Mon, 18 May 2020 19:53:45 -0700
Message-Id: <20200519025355.4420-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Formalize the set of defines, plus -1, into an enum.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h         | 23 +++++++++++++++--------
 reginfo.c      | 32 +++++++++++++++++++-------------
 risu_aarch64.c |  6 +++---
 risu_arm.c     |  6 +++---
 risu_i386.c    |  4 ++--
 risu_m68k.c    |  4 ++--
 risu_ppc64.c   |  4 ++--
 7 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/risu.h b/risu.h
index e2b4508..a7aa929 100644
--- a/risu.h
+++ b/risu.h
@@ -45,11 +45,17 @@ extern uintptr_t image_start_address;
 extern void *memblock;
 
 /* Ops code under test can request from risu: */
-#define OP_COMPARE 0
-#define OP_TESTEND 1
-#define OP_SETMEMBLOCK 2
-#define OP_GETMEMBLOCK 3
-#define OP_COMPAREMEM 4
+typedef enum {
+    /* Any other sigill besides the destignated undefined insn.  */
+    OP_SIGILL = -1,
+
+    /* These are generated by the designated undefined insn. */
+    OP_COMPARE = 0,
+    OP_TESTEND = 1,
+    OP_SETMEMBLOCK = 2,
+    OP_GETMEMBLOCK = 3,
+    OP_COMPAREMEM = 4,
+} RisuOp;
 
 /* The memory block should be this long */
 #define MEMBLOCKLEN 8192
@@ -114,10 +120,11 @@ void set_ucontext_paramreg(void *vuc, uint64_t value);
 /* Return the value of the parameter register from a reginfo. */
 uint64_t get_reginfo_paramreg(struct reginfo *ri);
 
-/* Return the risu operation number we have been asked to do,
- * or -1 if this was a SIGILL for a non-risuop insn.
+/*
+ * Return the risu operation number we have been asked to do,
+ * or OP_SIGILL if this was a SIGILL for a non-risuop insn.
  */
-int get_risuop(struct reginfo *ri);
+RisuOp get_risuop(struct reginfo *ri);
 
 /* Return the PC from a reginfo */
 uintptr_t get_pc(struct reginfo *ri);
diff --git a/reginfo.c b/reginfo.c
index 1b2a821..2d67c93 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -11,7 +11,7 @@
 
 #include <stdio.h>
 #include <string.h>
-
+#include <stdlib.h>
 #include "risu.h"
 
 struct reginfo master_ri, apprentice_ri;
@@ -25,7 +25,7 @@ int send_register_info(write_fn write_fn, void *uc)
 {
     struct reginfo ri;
     trace_header_t header;
-    int op;
+    RisuOp op;
 
     reginfo_init(&ri, uc);
     op = get_risuop(&ri);
@@ -38,11 +38,18 @@ int send_register_info(write_fn write_fn, void *uc)
     }
 
     switch (op) {
+    case OP_COMPARE:
     case OP_TESTEND:
-        write_fn(&ri, reginfo_size());
-        /* if we are tracing write_fn will return 0 unlike a remote
-           end, hence we force return of 1 here */
-        return 1;
+    case OP_SIGILL:
+        /*
+         * Do a simple register compare on (a) explicit request
+         * (b) end of test (c) a non-risuop UNDEF
+         */
+        if (write_fn(&ri, reginfo_size()) != 0) {
+            return -1;
+        }
+        /* For OP_TEST_END, force return 1 to exit. */
+        return op == OP_TESTEND;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
         break;
@@ -53,12 +60,8 @@ int send_register_info(write_fn write_fn, void *uc)
     case OP_COMPAREMEM:
         return write_fn(memblock, MEMBLOCKLEN);
         break;
-    case OP_COMPARE:
     default:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        return write_fn(&ri, reginfo_size());
+        abort();
     }
     return 0;
 }
@@ -74,8 +77,9 @@ int send_register_info(write_fn write_fn, void *uc)
 int recv_and_compare_register_info(read_fn read_fn,
                                    respond_fn resp_fn, void *uc)
 {
-    int resp = 0, op;
+    int resp = 0;
     trace_header_t header;
+    RisuOp op;
 
     reginfo_init(&master_ri, uc);
     op = get_risuop(&master_ri);
@@ -97,7 +101,7 @@ int recv_and_compare_register_info(read_fn read_fn,
     switch (op) {
     case OP_COMPARE:
     case OP_TESTEND:
-    default:
+    case OP_SIGILL:
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
@@ -130,6 +134,8 @@ int recv_and_compare_register_info(read_fn read_fn,
         }
         resp_fn(resp);
         break;
+    default:
+        abort();
     }
 
     return resp;
diff --git a/risu_aarch64.c b/risu_aarch64.c
index 492d141..f8a8412 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -29,16 +29,16 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->regs[0];
 }
 
-int get_risuop(struct reginfo *ri)
+RisuOp get_risuop(struct reginfo *ri)
 {
     /* Return the risuop we have been asked to do
-     * (or -1 if this was a SIGILL for a non-risuop insn)
+     * (or OP_SIGILL if this was a SIGILL for a non-risuop insn)
      */
     uint32_t insn = ri->faulting_insn;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = 0x00005af0;
-    return (key != risukey) ? -1 : op;
+    return (key != risukey) ? OP_SIGILL : op;
 }
 
 uintptr_t get_pc(struct reginfo *ri)
diff --git a/risu_arm.c b/risu_arm.c
index 5fcb2a5..a20bf73 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -56,17 +56,17 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gpreg[0];
 }
 
-int get_risuop(struct reginfo *ri)
+RisuOp get_risuop(struct reginfo *ri)
 {
     /* Return the risuop we have been asked to do
-     * (or -1 if this was a SIGILL for a non-risuop insn)
+     * (or OP_SIGILL if this was a SIGILL for a non-risuop insn)
      */
     uint32_t insn = ri->faulting_insn;
     int isz = ri->faulting_insn_size;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = (isz == 2) ? 0xdee0 : 0xe7fe5af0;
-    return (key != risukey) ? -1 : op;
+    return (key != risukey) ? OP_SIGILL : op;
 }
 
 uintptr_t get_pc(struct reginfo *ri)
diff --git a/risu_i386.c b/risu_i386.c
index 9962b8f..127e816 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -38,12 +38,12 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gregs[REG_E(AX)];
 }
 
-int get_risuop(struct reginfo *ri)
+RisuOp get_risuop(struct reginfo *ri)
 {
     if ((ri->faulting_insn & 0xf8ffff) == 0xc0b90f) { /* UD1 %xxx,%eax */
         return (ri->faulting_insn >> 16) & 7;
     }
-    return -1;
+    return OP_SIGILL;
 }
 
 uintptr_t get_pc(struct reginfo *ri)
diff --git a/risu_m68k.c b/risu_m68k.c
index 1056eef..acdd57a 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -25,13 +25,13 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gregs[R_A0];
 }
 
-int get_risuop(struct reginfo *ri)
+RisuOp get_risuop(struct reginfo *ri)
 {
     uint32_t insn = ri->faulting_insn;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = 0x4afc7000;
-    return (key != risukey) ? -1 : op;
+    return (key != risukey) ? OP_SIGILL : op;
 }
 
 uintptr_t get_pc(struct reginfo *ri)
diff --git a/risu_ppc64.c b/risu_ppc64.c
index a3028f7..9df8d58 100644
--- a/risu_ppc64.c
+++ b/risu_ppc64.c
@@ -32,13 +32,13 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gregs[0];
 }
 
-int get_risuop(struct reginfo *ri)
+RisuOp get_risuop(struct reginfo *ri)
 {
     uint32_t insn = ri->faulting_insn;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = 0x00005af0;
-    return (key != risukey) ? -1 : op;
+    return (key != risukey) ? OP_SIGILL : op;
 }
 
 uintptr_t get_pc(struct reginfo *ri)
-- 
2.20.1



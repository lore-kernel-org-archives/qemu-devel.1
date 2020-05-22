Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EBFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517712072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnU+TE2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517712072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxfM-0006km-Gm
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWZ-0002eL-FW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWY-00057e-GD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id r10so4276458pgv.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4k4BKg+4kQ/VDRH4oFHB0FxFiaeSR3tTozfgNRDGtM=;
 b=hnU+TE2v4VAx0UyvUVtYx6ZQZiJtFXRSjvf/pQnGPK9BCEfmzw639GBMShVNsq5oQv
 OutNvyMPe3qwsC5X6ci08u5IBsfwq4Qab3ejcVBN28tK5wgMyV2CoZPexNwjt2rArITV
 E0dpBowl0bW7SQSw7jWnpngHWK1oXX7GomPGoNpA5hjrtMOMFxDOD81+ob1DwtfzLwVE
 JYMJJ0+RxleW+dx2FBLtFOy9HHQI1S1mITz9mHvb97I2PNixv9zNcJvARsetrV72qcHw
 gs++JIyYT2wheE6xIqXZPDsfxufzfNzrFsoP5qMqY/tR/BxBOTQRR31nGKQGjwNElOci
 wl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4k4BKg+4kQ/VDRH4oFHB0FxFiaeSR3tTozfgNRDGtM=;
 b=Cl+mHTEF3fH38z7r3uovayvJO4WSvJVHBniYo9ylXCYfL+bSpPlXC/cL8O2lS6cCfr
 CLtHunWR8+FYEnxN6A3SWBuB4GYiYMgSlywz0O46hgff8EuKz7rtOLs7+lsqD0TIi1oj
 RklhDwI11zhtR/ykjqoL+CmgkNC7GA8Z25rRJec+1W5WC0qGIRDXPXlDg2wzKueVLFY3
 uRJOHyBgPg+Wk81ZOT9ECGTxYkMbEHH8GqOdN7dNcoddD2vpcbA6BxdFEAlcYD++nUON
 fiXgRNc1TbsJcsmJGg5z0m0MN45GxPMKCwQKSj0ITgVxcIKamakLEP69WCcyxHW3LG/F
 ghAQ==
X-Gm-Message-State: AOAM530U3J1DtQv80ap6qgDyZyE9jtpR9VzLXS9LurzXAG6bV0VZzf2e
 agY3t2nnBJjG1GLf1RKVlRGdd+mo5lQ=
X-Google-Smtp-Source: ABdhPJwaBpWaB5ypcqtOh756e5bt6NZFz89tn7l3RxtQe9aKjb1tvstE9QmFqQgpvdTtyzREwcsg7g==
X-Received: by 2002:a63:ab0b:: with SMTP id p11mr1527746pgf.278.1590114900853; 
 Thu, 21 May 2020 19:35:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/25] Rearrange reginfo and memblock buffers
Date: Thu, 21 May 2020 19:34:30 -0700
Message-Id: <20200522023440.26261-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

For send_register_info from master_sigill, do not keep a
reginfo buffer on the stack.  At the moment, this struct
is quite large for aarch64.

Put the two reginfo buffers into an array, for the benefit
of future dumping.  For recv_and_compare_register_info,
index this array with constants, so it's a simple rename.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 58 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/risu.c b/risu.c
index a0e20d5..b91ad38 100644
--- a/risu.c
+++ b/risu.c
@@ -28,10 +28,16 @@
 #include "config.h"
 #include "risu.h"
 
-static void *memblock;
-static struct reginfo master_ri, apprentice_ri;
-static uint8_t master_memblock[MEMBLOCKLEN];
+enum {
+    MASTER = 0, APPRENTICE = 1
+};
 
+static struct reginfo ri[2];
+static uint8_t other_memblock[MEMBLOCKLEN];
+static trace_header_t header;
+
+/* Memblock pointer into the execution image. */
+static void *memblock;
 
 static int comm_fd;
 static bool trace;
@@ -102,16 +108,15 @@ static void respond(RisuResult r)
 
 static RisuResult send_register_info(void *uc)
 {
-    struct reginfo ri;
-    trace_header_t header;
+    uint64_t paramreg;
     RisuResult res;
     RisuOp op;
 
-    reginfo_init(&ri, uc);
-    op = get_risuop(&ri);
+    reginfo_init(&ri[MASTER], uc);
+    op = get_risuop(&ri[MASTER]);
 
     /* Write a header with PC/op to keep in sync */
-    header.pc = get_pc(&ri);
+    header.pc = get_pc(&ri[MASTER]);
     header.risu_op = op;
     res = write_buffer(&header, sizeof(header));
     if (res != RES_OK) {
@@ -126,18 +131,19 @@ static RisuResult send_register_info(void *uc)
          * Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        res = write_buffer(&ri, reginfo_size());
+        res = write_buffer(&ri[MASTER], reginfo_size());
         /* For OP_TEST_END, force exit. */
         if (res == RES_OK && op == OP_TESTEND) {
             res = RES_END;
         }
         break;
     case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
+        paramreg = get_reginfo_paramreg(&ri[MASTER]);
+        memblock = (void *)(uintptr_t)paramreg;
         break;
     case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc,
-                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
+        paramreg = get_reginfo_paramreg(&ri[MASTER]);
+        set_ucontext_paramreg(uc, paramreg + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         return write_buffer(memblock, MEMBLOCKLEN);
@@ -162,12 +168,12 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
 
 static RisuResult recv_and_compare_register_info(void *uc)
 {
+    uint64_t paramreg;
     RisuResult res;
-    trace_header_t header;
     RisuOp op;
 
-    reginfo_init(&apprentice_ri, uc);
-    op = get_risuop(&apprentice_ri);
+    reginfo_init(&ri[APPRENTICE], uc);
+    op = get_risuop(&ri[APPRENTICE]);
 
     res = read_buffer(&header, sizeof(header));
     if (res != RES_OK) {
@@ -190,10 +196,10 @@ static RisuResult recv_and_compare_register_info(void *uc)
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        res = read_buffer(&master_ri, reginfo_size());
+        res = read_buffer(&ri[MASTER], reginfo_size());
         if (res != RES_OK) {
             /* fail */
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+        } else if (!reginfo_is_eq(&ri[MASTER], &ri[APPRENTICE])) {
             /* register mismatch */
             res = RES_MISMATCH_REG;
         } else if (op == OP_TESTEND) {
@@ -202,17 +208,18 @@ static RisuResult recv_and_compare_register_info(void *uc)
         respond(res == RES_OK ? RES_OK : RES_END);
         break;
     case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&apprentice_ri);
+        paramreg = get_reginfo_paramreg(&ri[APPRENTICE]);
+        memblock = (void *)(uintptr_t)paramreg;
         break;
     case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc, get_reginfo_paramreg(&apprentice_ri) +
-                              (uintptr_t)memblock);
+        paramreg = get_reginfo_paramreg(&ri[APPRENTICE]);
+        set_ucontext_paramreg(uc, paramreg + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        res = read_buffer(master_memblock, MEMBLOCKLEN);
+        res = read_buffer(other_memblock, MEMBLOCKLEN);
         if (res != RES_OK) {
             /* fail */
-        } else if (memcmp(memblock, master_memblock, MEMBLOCKLEN) != 0) {
+        } else if (memcmp(memblock, other_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
             res = RES_MISMATCH_MEM;
         }
@@ -221,7 +228,6 @@ static RisuResult recv_and_compare_register_info(void *uc)
     default:
         abort();
     }
-
     return res;
 }
 
@@ -342,10 +348,10 @@ static int apprentice(void)
     case RES_MISMATCH_REG:
         fprintf(stderr, "mismatch reg after %zd checkpoints\n", signal_count);
         fprintf(stderr, "master reginfo:\n");
-        reginfo_dump(&master_ri, stderr);
+        reginfo_dump(&ri[MASTER], stderr);
         fprintf(stderr, "apprentice reginfo:\n");
-        reginfo_dump(&apprentice_ri, stderr);
-        reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
+        reginfo_dump(&ri[APPRENTICE], stderr);
+        reginfo_dump_mismatch(&ri[MASTER], &ri[APPRENTICE], stderr);
         return EXIT_FAILURE;
 
     case RES_MISMATCH_MEM:
-- 
2.20.1



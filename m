Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C3B2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G44V/9L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C3B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasTL-0007nt-L4
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOX-0005Vp-Sc
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:17 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOW-0002U8-SI
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id z26so5739008pfk.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DPjUnZGFzA9RASEgo9moUEv2ECNWzhiHEuAoKuGlTe8=;
 b=G44V/9L3H6GlDY8K03/NMUj7y57rehEklPX2f0wzMsUH4H8YQdQcWoUsmKu/pynlbr
 CQTRPyCtWQyVTLHpDLnPl4y2AF28/wB1m+slD2E64dFxB1wjMU5U4fPweM5fr6LELCHU
 3ZM3RdfFku607Qz91jnOYZIxbyYGlBukIliP5ncyoK2G/h7T03hHgGiAaJEJGZcqiNBc
 XKb3QjB6NKOtOk3wMgFL6C7NYzn0ISYSo2yYcigZsBvLv0dAO63X8rWVdFnsq2FbibBU
 c1dC8VmqUfSmzM4bmZ8NucYzGF70QpGlxpqtoqQEW0C3G3GS1F/eoOKYGNQ4+biBwBfx
 QalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DPjUnZGFzA9RASEgo9moUEv2ECNWzhiHEuAoKuGlTe8=;
 b=B2uUa18TKzAJvXviF/RIOyIgj1hWiCPUYh+2O7crRBD6ZrQJvpoKW5Rhykq6vTS1CZ
 rPgZhqmU6tWLaDv4ZOHXPKS9g4yCwBDnZiOi8Ky2jWhZAoTEhYk/EEVe/+hdUxTr0BFr
 CWdi/1PxwwH2Dplem3j8r0/XfmxXpz1611RBup2UuesimA3XtKMGzVLxuZhS4XtKYghG
 hdTXbo7dpTlYTwWfhKCgj/qVPcL5E15//V3rRSXrbXWDly/c0Ui65ct3zSl1QQt47sSr
 t6nX/QBHi6O6B1oPfU5OWxayrNE1CZlsZXDtATS38m/YptFuZaX79hqA7TaZxwP/g4Fc
 Nd3Q==
X-Gm-Message-State: AOAM533fby5wU5cS6T/3mt1NAAlyZ4XgX/B4B2cB8P0tro4v7ckMUXqt
 vVAk2l1kEtQDdT4K1bHf5cb2UEpC1so=
X-Google-Smtp-Source: ABdhPJygCfWcHJSGmSBWl3f8oeq7VakRbKRYbcjTVmxF4ZXjHKHzweI2tkWwOwXZUIVMHI5Pnaph1Q==
X-Received: by 2002:a63:c90f:: with SMTP id o15mr17191655pgg.67.1589856854446; 
 Mon, 18 May 2020 19:54:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 13/17] Split RES_MISMATCH for registers and memory
Date: Mon, 18 May 2020 19:53:51 -0700
Message-Id: <20200519025355.4420-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

By remembering the specific comparison that failed, we do not
have to try again when it comes time to report.  This makes
the mem_used flag redundant.  Also, packet_mismatch is now
redundant with RES_BAD_IO.

This means that the only thing that report_match_status does
is to report on register status, so rename to report_mismatch_reg.
Also, we know there is a failure, so don't return a status from
the report.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    | 13 ++++++-------
 reginfo.c | 45 ++++++++-------------------------------------
 risu.c    | 10 +++++++---
 3 files changed, 21 insertions(+), 47 deletions(-)

diff --git a/risu.h b/risu.h
index 2ded5c4..b234f93 100644
--- a/risu.h
+++ b/risu.h
@@ -54,7 +54,8 @@ typedef enum {
 typedef enum {
     RES_OK = 0,
     RES_END,
-    RES_MISMATCH,
+    RES_MISMATCH_REG,
+    RES_MISMATCH_MEM,
     RES_BAD_IO,
 } RisuResult;
 
@@ -105,13 +106,11 @@ RisuResult send_register_info(void *uc);
  */
 RisuResult recv_and_compare_register_info(void *uc);
 
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
+/*
+ * Print a useful report on the status of the last reg comparison
+ * done in recv_and_compare_register_info().
  */
-int report_match_status(void);
+void report_mismatch_reg(void);
 
 /* Interface provided by CPU-specific code: */
 
diff --git a/reginfo.c b/reginfo.c
index 31bc699..a007f16 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -17,9 +17,6 @@
 static struct reginfo master_ri, apprentice_ri;
 static uint8_t master_memblock[MEMBLOCKLEN];
 
-static int mem_used;
-static int packet_mismatch;
-
 RisuResult send_register_info(void *uc)
 {
     struct reginfo ri;
@@ -107,10 +104,10 @@ RisuResult recv_and_compare_register_info(void *uc)
          */
         res = read_buffer(&master_ri, reginfo_size());
         if (res != RES_OK) {
-            packet_mismatch = 1;
+            /* fail */
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
             /* register mismatch */
-            res = RES_MISMATCH;
+            res = RES_MISMATCH_REG;
         } else if (op == OP_TESTEND) {
             res = RES_END;
         }
@@ -124,13 +121,12 @@ RisuResult recv_and_compare_register_info(void *uc)
                               (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        mem_used = 1;
         res = read_buffer(master_memblock, MEMBLOCKLEN);
         if (res != RES_OK) {
-            packet_mismatch = 1;
+            /* fail */
         } else if (memcmp(memblock, master_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
-            res = RES_MISMATCH;
+            res = RES_MISMATCH_MEM;
         }
         respond(res == RES_OK ? RES_OK : RES_END);
         break;
@@ -141,40 +137,15 @@ RisuResult recv_and_compare_register_info(void *uc)
     return res;
 }
 
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
+/*
+ * Print a useful report on the status of the last reg comparison
+ * done in recv_and_compare_register_info().
  */
-int report_match_status(void)
+void report_mismatch_reg(void)
 {
-    int resp = 0;
-    fprintf(stderr, "match status...\n");
-    if (packet_mismatch) {
-        fprintf(stderr, "packet mismatch (probably disagreement "
-                "about UNDEF on load/store)\n");
-        return 1;
-    }
-    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-        fprintf(stderr, "mismatch on regs!\n");
-        resp = 1;
-    }
-    if (mem_used
-        && memcmp(memblock, &master_memblock, MEMBLOCKLEN) != 0) {
-        fprintf(stderr, "mismatch on memory!\n");
-        resp = 1;
-    }
-    if (!resp) {
-        fprintf(stderr, "match!\n");
-        return 0;
-    }
-
     fprintf(stderr, "master reginfo:\n");
     reginfo_dump(&master_ri, stderr);
     fprintf(stderr, "apprentice reginfo:\n");
     reginfo_dump(&apprentice_ri, stderr);
-
     reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-    return resp;
 }
diff --git a/risu.c b/risu.c
index ea4b4d3..398faac 100644
--- a/risu.c
+++ b/risu.c
@@ -224,9 +224,13 @@ static int apprentice(void)
     case RES_END:
         return EXIT_SUCCESS;
 
-    case RES_MISMATCH:
-        fprintf(stderr, "mismatch after %zd checkpoints\n", signal_count);
-        report_match_status();
+    case RES_MISMATCH_REG:
+        fprintf(stderr, "mismatch reg after %zd checkpoints\n", signal_count);
+        report_mismatch_reg();
+        return EXIT_FAILURE;
+
+    case RES_MISMATCH_MEM:
+        fprintf(stderr, "mismatch mem after %zd checkpoints\n", signal_count);
         return EXIT_FAILURE;
 
     case RES_BAD_IO:
-- 
2.20.1



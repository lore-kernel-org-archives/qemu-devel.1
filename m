Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B10C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C182072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYzFDTzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C182072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxbY-0006J5-7o
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWQ-0002ML-Vz
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWP-00056d-U2
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:54 -0400
Received: by mail-pl1-x643.google.com with SMTP id u22so3800107plq.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3G4PJj+ygy8yy6dNKzxkyDjb06D6oXBdXQgauyjKNKc=;
 b=VYzFDTzEPy0A2kxWMWYkLaRVXsZ//5tFKncxAGUD2ZuPjx+xpuwaOLVyCAtQXz4x6R
 GU5gN9YV3x7Ps2RlJHECsvuN6s0hzf6vVXOwRm0XV3Vy6tmfCD3TJ4sYc6b0auV3SXmB
 ltNs1MVKO6EasxaMRKzr+V6LTB0WX2hjEbgj+ceE81l2QHJ5gaqogLB72a6mIzXKZLg5
 rb+KG98p+9mZaU9mYK2iyQpyl3wIEZEi1O6Ef4CU6CS6df2Ht59HT2WWzrwsY4zhIq/T
 NLQ3+0z67jT76lybRHgvsYegfVVyIjeLzLYTpeoF1Hg/p9qdPjKuSMVSqEVufgVuAS2R
 +bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3G4PJj+ygy8yy6dNKzxkyDjb06D6oXBdXQgauyjKNKc=;
 b=O8ZM50MJvry9y/uG6xWrUBL0uIBM4y9Og6/lC29SI6OgTAI8duhCjhnAmyjlEh7orw
 J+OCgWisl6hLET2KbdoleF0KiBOvjVxnUDYu+ISE7osof75zg8NwvxheZR0xefDlgM5G
 xtRxiPU5n6Zuq1Suit2Iq9ZIS3Wxns04IHWyoN2cAQkLh/u8liuz7LILI+8ONZbxlJpb
 VvfqfrFeWakC7seCI5dyuffzCnRbwXK3/Q7lvbnMublxB2EO0DXrRgAlYVqFnUvILhtE
 H7N8wB2d4fnL+UrtEeF+bEWS5cDMFHhE26FROhoRxr0DiFdsILEWomJZCecAXzRKnJRo
 hK3Q==
X-Gm-Message-State: AOAM530lY357J8keqYCkTxkzCJKbJJUxWeiBuHRgEoCOyMWMzfBAkFz0
 Y6heWq2z43Jzp9MhgjewXvpGt6talPU=
X-Google-Smtp-Source: ABdhPJxFBBdYzijXj7TZFnL3HNltBPk4vblwyk7sEyKUZH8yKKdmEDbwLp7jV7ubIKSxP1pE0vhUzg==
X-Received: by 2002:a17:90a:7087:: with SMTP id
 g7mr1902831pjk.70.1590114892095; 
 Thu, 21 May 2020 19:34:52 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/25] Add enum RisuResult
Date: Thu, 21 May 2020 19:34:23 -0700
Message-Id: <20200522023440.26261-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

Formalize the random set of numbers into an enum.  Doing this
makes it easy to see that one of the responses in
recv_and_compare_register_info was inconsistent.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    | 25 +++++++++++++++++--------
 reginfo.c | 32 ++++++++++++++++----------------
 risu.c    | 18 +++++++++---------
 3 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/risu.h b/risu.h
index a7aa929..e6d07eb 100644
--- a/risu.h
+++ b/risu.h
@@ -57,6 +57,14 @@ typedef enum {
     OP_COMPAREMEM = 4,
 } RisuOp;
 
+/* Result of operation */
+typedef enum {
+    RES_OK = 0,
+    RES_END,
+    RES_MISMATCH,
+    RES_BAD_IO,
+} RisuResult;
+
 /* The memory block should be this long */
 #define MEMBLOCKLEN 8192
 
@@ -82,20 +90,21 @@ typedef struct {
  */
 typedef int (*write_fn) (void *ptr, size_t bytes);
 typedef int (*read_fn) (void *ptr, size_t bytes);
-typedef void (*respond_fn) (int response);
+typedef void (*respond_fn) (RisuResult response);
 
-/* Send the register information from the struct ucontext down the socket.
- * Return the response code from the master.
+/*
+ * Send the register information from the struct ucontext down the socket.
  * NB: called from a signal handler.
  */
-int send_register_info(write_fn write_fn, void *uc);
+RisuResult send_register_info(write_fn write_fn, void *uc);
 
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
+/*
+ * Read register info from the socket and compare it with that from the
+ * ucontext.
  * NB: called from a signal handler.
  */
-int recv_and_compare_register_info(read_fn read_fn,
-                                   respond_fn respond, void *uc);
+RisuResult recv_and_compare_register_info(read_fn read_fn,
+                                          respond_fn respond, void *uc);
 
 /* Print a useful report on the status of the last comparison
  * done in recv_and_compare_register_info(). This is called on
diff --git a/reginfo.c b/reginfo.c
index 2d67c93..b909a1f 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -21,7 +21,7 @@ uint8_t apprentice_memblock[MEMBLOCKLEN];
 static int mem_used;
 static int packet_mismatch;
 
-int send_register_info(write_fn write_fn, void *uc)
+RisuResult send_register_info(write_fn write_fn, void *uc)
 {
     struct reginfo ri;
     trace_header_t header;
@@ -34,7 +34,7 @@ int send_register_info(write_fn write_fn, void *uc)
     header.pc = get_pc(&ri);
     header.risu_op = op;
     if (write_fn(&header, sizeof(header)) != 0) {
-        return -1;
+        return RES_BAD_IO;
     }
 
     switch (op) {
@@ -46,10 +46,10 @@ int send_register_info(write_fn write_fn, void *uc)
          * (b) end of test (c) a non-risuop UNDEF
          */
         if (write_fn(&ri, reginfo_size()) != 0) {
-            return -1;
+            return RES_BAD_IO;
         }
         /* For OP_TEST_END, force return 1 to exit. */
-        return op == OP_TESTEND;
+        return op == OP_TESTEND ? RES_END : RES_OK;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
         break;
@@ -63,7 +63,7 @@ int send_register_info(write_fn write_fn, void *uc)
     default:
         abort();
     }
-    return 0;
+    return RES_OK;
 }
 
 /* Read register info from the socket and compare it with that from the
@@ -74,10 +74,10 @@ int send_register_info(write_fn write_fn, void *uc)
  * that says whether it is register or memory data, so if the two
  * sides get out of sync then we will fail obscurely.
  */
-int recv_and_compare_register_info(read_fn read_fn,
-                                   respond_fn resp_fn, void *uc)
+RisuResult recv_and_compare_register_info(read_fn read_fn,
+                                          respond_fn resp_fn, void *uc)
 {
-    int resp = 0;
+    RisuResult resp = RES_OK;
     trace_header_t header;
     RisuOp op;
 
@@ -85,18 +85,18 @@ int recv_and_compare_register_info(read_fn read_fn,
     op = get_risuop(&master_ri);
 
     if (read_fn(&header, sizeof(header)) != 0) {
-        return -1;
+        return RES_BAD_IO;
     }
 
     if (header.risu_op != op) {
         /* We are out of sync */
-        resp = 2;
+        resp = RES_BAD_IO;
         resp_fn(resp);
         return resp;
     }
 
     /* send OK for the header */
-    resp_fn(0);
+    resp_fn(RES_OK);
 
     switch (op) {
     case OP_COMPARE:
@@ -107,12 +107,12 @@ int recv_and_compare_register_info(read_fn read_fn,
          */
         if (read_fn(&apprentice_ri, reginfo_size())) {
             packet_mismatch = 1;
-            resp = 2;
+            resp = RES_BAD_IO;
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
             /* register mismatch */
-            resp = 2;
+            resp = RES_MISMATCH;
         } else if (op == OP_TESTEND) {
-            resp = 1;
+            resp = RES_END;
         }
         resp_fn(resp);
         break;
@@ -127,10 +127,10 @@ int recv_and_compare_register_info(read_fn read_fn,
         mem_used = 1;
         if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
             packet_mismatch = 1;
-            resp = 2;
+            resp = RES_BAD_IO;
         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
-            resp = 2;
+            resp = RES_MISMATCH;
         }
         resp_fn(resp);
         break;
diff --git a/risu.c b/risu.c
index ab17c71..7b14f72 100644
--- a/risu.c
+++ b/risu.c
@@ -69,7 +69,7 @@ int write_trace(void *ptr, size_t bytes)
     return (res == bytes) ? 0 : 1;
 }
 
-void respond_sock(int r)
+void respond_sock(RisuResult r)
 {
     send_response_byte(comm_fd, r);
 }
@@ -98,11 +98,11 @@ int read_trace(void *ptr, size_t bytes)
     return (res == bytes) ? 0 : 1;
 }
 
-void respond_trace(int r)
+void respond_trace(RisuResult r)
 {
     switch (r) {
-    case 0: /* test ok */
-    case 1: /* end of test */
+    case RES_OK:
+    case RES_END:
         break;
     default:
         /* mismatch - if tracing we need to report, otherwise barf */
@@ -115,7 +115,7 @@ void respond_trace(int r)
 
 static void master_sigill(int sig, siginfo_t *si, void *uc)
 {
-    int r;
+    RisuResult r;
     signal_count++;
 
     if (trace) {
@@ -125,7 +125,7 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     }
 
     switch (r) {
-    case 0:
+    case RES_OK:
         /* match OK */
         advance_pc(uc);
         return;
@@ -137,7 +137,7 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
 
 static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
-    int r;
+    RisuResult r;
     signal_count++;
 
     if (trace) {
@@ -147,11 +147,11 @@ static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
     }
 
     switch (r) {
-    case 0:
+    case RES_OK:
         /* match OK */
         advance_pc(uc);
         return;
-    case 1:
+    case RES_END:
         /* end of test */
         exit(EXIT_SUCCESS);
     default:
-- 
2.20.1



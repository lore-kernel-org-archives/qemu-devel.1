Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367D1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D072072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8oq2nft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D072072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxcw-0001C1-5C
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWS-0002Pp-Gb
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:41330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWR-00056m-6y
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id a13so3818050pls.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hXiDJogXpOZ8s/dlpDZsG+PYSCUe+WH+1ZPNXE4fyIc=;
 b=y8oq2nftNUkDv7Z2gNTLbZATHAmWJH/x/kF1QBHHzAzZBMEUmX1crqzdmdBk3Qcr/K
 5K4TA5o/UnBMxhowtYzwILfpvLB/Mz2RtepAvwNW9tw4NnaoU87rE10GI5pWfWfgPOYl
 xg01RVrJ4hrNZX1EZy9aJAY47yh/hEAOGF+SPZrFuXZYP9ueQNcMpj8QvUhzmWMagZFg
 iTboUdcVpRdEye8u7XvbTEp9dUmD9Hbu1KPLzfaDThCMFuqeTyhWCB0ADkra1gBFPgdY
 2I9UITnAf7/w2y0WqEvlIOKhpY5DinzbwBsRfBnpoSB1NzFd807iJBaArymPxtBGgITV
 F0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hXiDJogXpOZ8s/dlpDZsG+PYSCUe+WH+1ZPNXE4fyIc=;
 b=C/KnhE0XqQkmsXRUjpJ/Pi8R47+TEvb08pzeoHjHjpz9/sYssGKWbDHZz8Emc/D8a0
 VeuI5DpxV9NkQXG/AvQkTnJaHBYq22rf6pjTHw1GET+WDU7sznhQLqWKvEmE5M6lJ+fE
 7t5Akt9hBde4wK2a6QXU8RUv/GXSuC5MjC7waO7wxpiNfYVGPQxOG7Nywj+TS+3FraAi
 LT3ogihlho968PrInY0TJ1NIzBrdB+RSun+CxCpY/XXLjP2F6vN+z2MbOA8ZmyqD6ndX
 D7CgVHgMgIZgHRHgT1lDEOk4RCzepF7iUoq2EjduPHInfzp3RKL48iDBhuJuaKDGP5PZ
 OikQ==
X-Gm-Message-State: AOAM5312/7g0nREDKvidFMXxHbd/xrnXs/sRTJqMTThA5E5W2U/fAf8B
 BZbeMiiu7pBsT2sOGGLUJJT3441Evfc=
X-Google-Smtp-Source: ABdhPJwhB0kmesTA1qj6vV/wvb4hszrS/bxHTVUFvRKehEJuZPlbqEl4Qp3RO4lLJRX8tl2V86EWLQ==
X-Received: by 2002:a17:90b:344d:: with SMTP id
 lj13mr1869879pjb.160.1590114893353; 
 Thu, 21 May 2020 19:34:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/25] Unify i/o functions and use RisuResult
Date: Thu, 21 May 2020 19:34:24 -0700
Message-Id: <20200522023440.26261-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Push the trace check down from the function calling the reginfo
function down into the i/o function.  This means we don't have
to pass a function pointer.

Return a RisuResult from the i/o functions.  This fixes a minor bug
in send_register_info (even before the conversion to RisuResult),
which returned the write_fn result directly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    | 32 +++++++++-------------
 comms.c   |  8 +++---
 reginfo.c | 60 ++++++++++++++++++++--------------------
 risu.c    | 82 ++++++++++++++++++++++---------------------------------
 4 files changed, 81 insertions(+), 101 deletions(-)

diff --git a/risu.h b/risu.h
index e6d07eb..c83b803 100644
--- a/risu.h
+++ b/risu.h
@@ -34,13 +34,6 @@ void process_arch_opt(int opt, const char *arg);
 
 #include REGINFO_HEADER(ARCH)
 
-/* Socket related routines */
-int master_connect(int port);
-int apprentice_connect(const char *hostname, int port);
-int send_data_pkt(int sock, void *pkt, int pktlen);
-int recv_data_pkt(int sock, void *pkt, int pktlen);
-void send_response_byte(int sock, int resp);
-
 extern uintptr_t image_start_address;
 extern void *memblock;
 
@@ -80,31 +73,32 @@ typedef struct {
    uint32_t risu_op;
 } trace_header_t;
 
+/* Socket related routines */
+int master_connect(int port);
+int apprentice_connect(const char *hostname, int port);
+RisuResult send_data_pkt(int sock, void *pkt, int pktlen);
+RisuResult recv_data_pkt(int sock, void *pkt, int pktlen);
+void send_response_byte(int sock, int resp);
+
 /* Functions operating on reginfo */
 
-/* Function prototypes for read/write helper functions.
- *
- * We pass the helper function to send_register_info and
- * recv_and_compare_register_info which can either be backed by the
- * traditional network socket or a trace file.
- */
-typedef int (*write_fn) (void *ptr, size_t bytes);
-typedef int (*read_fn) (void *ptr, size_t bytes);
-typedef void (*respond_fn) (RisuResult response);
+/* Function prototypes for read/write helper functions. */
+RisuResult write_buffer(void *ptr, size_t bytes);
+RisuResult read_buffer(void *ptr, size_t bytes);
+void respond(RisuResult response);
 
 /*
  * Send the register information from the struct ucontext down the socket.
  * NB: called from a signal handler.
  */
-RisuResult send_register_info(write_fn write_fn, void *uc);
+RisuResult send_register_info(void *uc);
 
 /*
  * Read register info from the socket and compare it with that from the
  * ucontext.
  * NB: called from a signal handler.
  */
-RisuResult recv_and_compare_register_info(read_fn read_fn,
-                                          respond_fn respond, void *uc);
+RisuResult recv_and_compare_register_info(void *uc);
 
 /* Print a useful report on the status of the last comparison
  * done in recv_and_compare_register_info(). This is called on
diff --git a/comms.c b/comms.c
index 861e845..21968da 100644
--- a/comms.c
+++ b/comms.c
@@ -168,7 +168,7 @@ ssize_t safe_writev(int fd, struct iovec *iov_in, int iovcnt)
  * Note that both ends must agree on the length of the
  * block of data.
  */
-int send_data_pkt(int sock, void *pkt, int pktlen)
+RisuResult send_data_pkt(int sock, void *pkt, int pktlen)
 {
     unsigned char resp;
     /* First we send the packet length as a network-order 32 bit value.
@@ -196,7 +196,7 @@ int send_data_pkt(int sock, void *pkt, int pktlen)
     return resp;
 }
 
-int recv_data_pkt(int sock, void *pkt, int pktlen)
+RisuResult recv_data_pkt(int sock, void *pkt, int pktlen)
 {
     uint32_t net_pktlen;
     recv_bytes(sock, &net_pktlen, sizeof(net_pktlen));
@@ -206,10 +206,10 @@ int recv_data_pkt(int sock, void *pkt, int pktlen)
          * a response back.
          */
         recv_and_discard_bytes(sock, net_pktlen);
-        return 1;
+        return RES_BAD_IO;
     }
     recv_bytes(sock, pkt, pktlen);
-    return 0;
+    return RES_OK;
 }
 
 void send_response_byte(int sock, int resp)
diff --git a/reginfo.c b/reginfo.c
index b909a1f..fee025e 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -21,10 +21,11 @@ uint8_t apprentice_memblock[MEMBLOCKLEN];
 static int mem_used;
 static int packet_mismatch;
 
-RisuResult send_register_info(write_fn write_fn, void *uc)
+RisuResult send_register_info(void *uc)
 {
     struct reginfo ri;
     trace_header_t header;
+    RisuResult res;
     RisuOp op;
 
     reginfo_init(&ri, uc);
@@ -33,8 +34,9 @@ RisuResult send_register_info(write_fn write_fn, void *uc)
     /* Write a header with PC/op to keep in sync */
     header.pc = get_pc(&ri);
     header.risu_op = op;
-    if (write_fn(&header, sizeof(header)) != 0) {
-        return RES_BAD_IO;
+    res = write_buffer(&header, sizeof(header));
+    if (res != RES_OK) {
+        return res;
     }
 
     switch (op) {
@@ -45,11 +47,12 @@ RisuResult send_register_info(write_fn write_fn, void *uc)
          * Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        if (write_fn(&ri, reginfo_size()) != 0) {
-            return RES_BAD_IO;
+        res = write_buffer(&ri, reginfo_size());
+        /* For OP_TEST_END, force exit. */
+        if (res == RES_OK && op == OP_TESTEND) {
+            res = RES_END;
         }
-        /* For OP_TEST_END, force return 1 to exit. */
-        return op == OP_TESTEND ? RES_END : RES_OK;
+        break;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
         break;
@@ -58,12 +61,11 @@ RisuResult send_register_info(write_fn write_fn, void *uc)
                               get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        return write_fn(memblock, MEMBLOCKLEN);
-        break;
+        return write_buffer(memblock, MEMBLOCKLEN);
     default:
         abort();
     }
-    return RES_OK;
+    return res;
 }
 
 /* Read register info from the socket and compare it with that from the
@@ -74,29 +76,29 @@ RisuResult send_register_info(write_fn write_fn, void *uc)
  * that says whether it is register or memory data, so if the two
  * sides get out of sync then we will fail obscurely.
  */
-RisuResult recv_and_compare_register_info(read_fn read_fn,
-                                          respond_fn resp_fn, void *uc)
+RisuResult recv_and_compare_register_info(void *uc)
 {
-    RisuResult resp = RES_OK;
+    RisuResult res;
     trace_header_t header;
     RisuOp op;
 
     reginfo_init(&master_ri, uc);
     op = get_risuop(&master_ri);
 
-    if (read_fn(&header, sizeof(header)) != 0) {
-        return RES_BAD_IO;
+    res = read_buffer(&header, sizeof(header));
+    if (res != RES_OK) {
+        return res;
     }
 
     if (header.risu_op != op) {
         /* We are out of sync */
-        resp = RES_BAD_IO;
-        resp_fn(resp);
-        return resp;
+        res = RES_BAD_IO;
+        respond(res);
+        return res;
     }
 
     /* send OK for the header */
-    resp_fn(RES_OK);
+    respond(RES_OK);
 
     switch (op) {
     case OP_COMPARE:
@@ -105,16 +107,16 @@ RisuResult recv_and_compare_register_info(read_fn read_fn,
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        if (read_fn(&apprentice_ri, reginfo_size())) {
+        res = read_buffer(&apprentice_ri, reginfo_size());
+        if (res != RES_OK) {
             packet_mismatch = 1;
-            resp = RES_BAD_IO;
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
             /* register mismatch */
-            resp = RES_MISMATCH;
+            res = RES_MISMATCH;
         } else if (op == OP_TESTEND) {
-            resp = RES_END;
+            res = RES_END;
         }
-        resp_fn(resp);
+        respond(res);
         break;
     case OP_SETMEMBLOCK:
         memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
@@ -125,20 +127,20 @@ RisuResult recv_and_compare_register_info(read_fn read_fn,
         break;
     case OP_COMPAREMEM:
         mem_used = 1;
-        if (read_fn(apprentice_memblock, MEMBLOCKLEN)) {
+        res = read_buffer(apprentice_memblock, MEMBLOCKLEN);
+        if (res != RES_OK) {
             packet_mismatch = 1;
-            resp = RES_BAD_IO;
         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
-            resp = RES_MISMATCH;
+            res = RES_MISMATCH;
         }
-        resp_fn(resp);
+        respond(res);
         break;
     default:
         abort();
     }
 
-    return resp;
+    return res;
 }
 
 /* Print a useful report on the status of the last comparison
diff --git a/risu.c b/risu.c
index 7b14f72..1917311 100644
--- a/risu.c
+++ b/risu.c
@@ -46,44 +46,15 @@ static sigjmp_buf jmpbuf;
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 
-/* Master functions */
+/* I/O functions */
 
-int read_sock(void *ptr, size_t bytes)
-{
-    return recv_data_pkt(comm_fd, ptr, bytes);
-}
-
-int write_trace(void *ptr, size_t bytes)
+RisuResult read_buffer(void *ptr, size_t bytes)
 {
     size_t res;
 
-#ifdef HAVE_ZLIB
-    if (comm_fd == STDOUT_FILENO) {
-#endif
-        res = write(comm_fd, ptr, bytes);
-#ifdef HAVE_ZLIB
-    } else {
-        res = gzwrite(gz_trace_file, ptr, bytes);
+    if (!trace) {
+        return recv_data_pkt(comm_fd, ptr, bytes);
     }
-#endif
-    return (res == bytes) ? 0 : 1;
-}
-
-void respond_sock(RisuResult r)
-{
-    send_response_byte(comm_fd, r);
-}
-
-/* Apprentice function */
-
-int write_sock(void *ptr, size_t bytes)
-{
-    return send_data_pkt(comm_fd, ptr, bytes);
-}
-
-int read_trace(void *ptr, size_t bytes)
-{
-    size_t res;
 
 #ifdef HAVE_ZLIB
     if (comm_fd == STDIN_FILENO) {
@@ -95,21 +66,34 @@ int read_trace(void *ptr, size_t bytes)
     }
 #endif
 
-    return (res == bytes) ? 0 : 1;
+    return res == bytes ? RES_OK : RES_BAD_IO;
 }
 
-void respond_trace(RisuResult r)
+RisuResult write_buffer(void *ptr, size_t bytes)
 {
-    switch (r) {
-    case RES_OK:
-    case RES_END:
-        break;
-    default:
-        /* mismatch - if tracing we need to report, otherwise barf */
-        if (!trace) {
-            abort();
-        }
-        break;
+    size_t res;
+
+    if (!trace) {
+        return send_data_pkt(comm_fd, ptr, bytes);
+    }
+
+#ifdef HAVE_ZLIB
+    if (comm_fd == STDOUT_FILENO) {
+#endif
+        res = write(comm_fd, ptr, bytes);
+#ifdef HAVE_ZLIB
+    } else {
+        res = gzwrite(gz_trace_file, ptr, bytes);
+    }
+#endif
+
+    return res == bytes ? RES_OK : RES_BAD_IO;
+}
+
+void respond(RisuResult r)
+{
+    if (!trace) {
+        send_response_byte(comm_fd, r);
     }
 }
 
@@ -119,9 +103,9 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     signal_count++;
 
     if (trace) {
-        r = send_register_info(write_trace, uc);
+        r = send_register_info(uc);
     } else {
-        r = recv_and_compare_register_info(read_sock, respond_sock, uc);
+        r = recv_and_compare_register_info(uc);
     }
 
     switch (r) {
@@ -141,9 +125,9 @@ static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
     signal_count++;
 
     if (trace) {
-        r = recv_and_compare_register_info(read_trace, respond_trace, uc);
+        r = recv_and_compare_register_info(uc);
     } else {
-        r = send_register_info(write_sock, uc);
+        r = send_register_info(uc);
     }
 
     switch (r) {
-- 
2.20.1



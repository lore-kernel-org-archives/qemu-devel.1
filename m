Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F71C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DCC20657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROiaR31o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DCC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasQp-000294-0k
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOU-0005Pb-Im
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:14 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:46370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOS-0002Qa-Cx
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:14 -0400
Received: by mail-pg1-x532.google.com with SMTP id p21so5721508pgm.13
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i6cN+V0oyKOXcFzwj12P4di1SZQuQTGDgSJO64rVCwQ=;
 b=ROiaR31orw2RW3U4tEeg/VJDeewODccnoD9B1iUPsw4wXgaO2J0YF5aIXil3ZTkYuX
 3QA/vVU13JsLYPA9n+B5tVDPxB4cbXTqnEdh+qCbL2AmhIu1qZ6ooB60ACnJlFGQTzQE
 b3vFuyPX0JHu41y9ADcldb5YlytGwZpT3pz82lE4U+AYCb64u5Sb/VHplzipZnSezWed
 w1E8sxa12bg0Fg9Y4KIi1DPPIRLB+hGt6Ct0axhk8glOL4V/JB5HmO6BryoNTcAd/+rS
 lHVebDPnGZ2iNIKwO8G0ztjldVu7AnDNZCujS8eKpM5liJlgMsQJ3r0eDW8ecy4ntNUV
 P1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i6cN+V0oyKOXcFzwj12P4di1SZQuQTGDgSJO64rVCwQ=;
 b=jfOFLCo4f2VW4NYGXGZ0dx3uuly8QkLklF8YYu8+nO7ULP99U21Ug22ueb6v7Ki/Vo
 CMglNru9oocjOiGRnmGYghhxczSLJcAC8l7gchK+rdATqXbI0FafWukplgQJ3sJJNb0r
 1CTa2CnAFB6OAdpow/qyL4uVGweqfVP/WhiY2u51EjQp1XvDisKWU4eTlx0ZGgHdEij8
 1dCRkdjtraFBV4xCT35fz0Lnv0CFGZPIhJFDQZjICXLKVuNXyuQTgnKl74OnApDG6B97
 Ax9yoMgMSrgUpqlWhpz/2dZ7j2kADZnbvcobDW9JvqBY2DyAwAZ9NXNO5nM8B3m5sEUf
 Q54w==
X-Gm-Message-State: AOAM533GXq6pqhAUqLFRG8X7UN8z236lMox1slHnOSuQC2BAaKoY34vS
 a5Wim8IcQOKbVHmis4J+seOcJfDuPDc=
X-Google-Smtp-Source: ABdhPJwagflODUIfoYLsyWoyOIbyRbp3OAQ1BUCwDJx10gyzkHijKu9l6eyYavebln1LbOYJwehmRg==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr20575485pfh.297.1589856849122; 
 Mon, 18 May 2020 19:54:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 09/17] Unify i/o functions and use RisuResult
Date: Mon, 18 May 2020 19:53:47 -0700
Message-Id: <20200519025355.4420-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Push the trace check down from the function calling the reginfo
function down into the i/o function.  This means we don't have
to pass a function pointer.

Return a RisuResult from the i/o functions.  This fixes a minor bug
in send_register_info (even before the conversion to RisuResult),
which returned the write_fn result directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    | 25 ++++++++---------
 comms.c   |  8 +++---
 reginfo.c | 60 ++++++++++++++++++++--------------------
 risu.c    | 82 ++++++++++++++++++++++---------------------------------
 4 files changed, 80 insertions(+), 95 deletions(-)

diff --git a/risu.h b/risu.h
index e6d07eb..f44b781 100644
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
 
@@ -80,6 +73,13 @@ typedef struct {
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
 
 /* Function prototypes for read/write helper functions.
@@ -88,23 +88,22 @@ typedef struct {
  * recv_and_compare_register_info which can either be backed by the
  * traditional network socket or a trace file.
  */
-typedef int (*write_fn) (void *ptr, size_t bytes);
-typedef int (*read_fn) (void *ptr, size_t bytes);
-typedef void (*respond_fn) (RisuResult response);
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
index 8796975..78c6b8f 100644
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



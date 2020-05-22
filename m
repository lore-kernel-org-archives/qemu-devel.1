Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C28AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0423207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUtufOGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0423207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxXT-00055v-35
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWZ-0002el-Sl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:03 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWX-00057X-Dg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id j21so4275588pgb.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TXAASNAhxxCZnrmhR/019xFA1WSxX4Hf5mCh0xMRPmU=;
 b=AUtufOGfzGkjlfkqqxb794wZpat78KRsybJft61LmYhClncza5WibhmGMSUo0t5KF2
 0fk1SW80/fxljjgayPa757/OA0kpTohm2lcfsuZrVEI3EtCGHkuLU41Z06jX1ITQDEfj
 Ir05GmGj7sdNcFzLu006gwS9tVN/Oa7fHj4sfiM1yVQW9CO0zSt8jxgMC0Is8sxfmjPw
 iVYt+Hjo/rwmUwf5IRXTjEsrYrUfiEQnxgjP2V+Ip7quBTke6gVPsuC4RNNVRcX1bTz3
 w/cEQnHAaWd+D0UYvoPET5wzT/XvNiJ48HdEvGeqTqDQl9DEDnTB/DKLjYzidLa3qF0/
 leRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TXAASNAhxxCZnrmhR/019xFA1WSxX4Hf5mCh0xMRPmU=;
 b=keaUoLu6tJ7zK+eUKekKqvyzHVzBrXBIPCYoZCskn3C5+qtWYo1j/ergASjjDeolY+
 fpw2NnMLLrj82H3It9+Nx4BXbIWZbTjE7ZQ1Xdqjl0pJdrKpbIGGB7xv4GHZzhGheKq1
 muiwbxaQU61eni/TU57aS+lg0nRwu0Pb+qoLdznHD80NCaEPhRvGnnl/QeQngHmzzEjU
 MaqlgJ/7iwXFuhCxtS9dC94MUz0IyAbRTra31jjpgRB/m284GOKq6fQwF6FmAqQ0kr60
 i+9+YctJ78k3Je7aBChq5lhxWRRThHQ+LZq71P3HRJ7DIKoRKL4AS9RLdMrtNYxwmt37
 7SRw==
X-Gm-Message-State: AOAM533JxcRkMCqnlXRHIxV2OtCnxWcC4lhkVvU72pEwf4ArraOjCZIV
 lzYkW5/22LVtowwdVvh0BtIYFvYLnxk=
X-Google-Smtp-Source: ABdhPJx/GZb6UhzimSRuhBSJ/LmssiaSAnmOwWkIX0h68wNDr4ch3a7+9bmvFWvWeFm689eMYhWUgA==
X-Received: by 2002:a63:6e8a:: with SMTP id
 j132mr10248319pgc.301.1590114899535; 
 Thu, 21 May 2020 19:34:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/25] Merge reginfo.c into risu.c
Date: Thu, 21 May 2020 19:34:29 -0700
Message-Id: <20200522023440.26261-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

The distinction between the two is artificial.  Following
patches will rearrange the functions involved to make it
easier for dumping of the trace file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile  |   2 +-
 risu.h    |  28 +---------
 reginfo.c | 151 ------------------------------------------------------
 risu.c    | 129 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 126 insertions(+), 184 deletions(-)
 delete mode 100644 reginfo.c

diff --git a/Makefile b/Makefile
index 6ab014a..ad7f879 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@ CFLAGS ?= -g
 ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) -U$(ARCH) $(BUILD_INC) $(CFLAGS) $(EXTRA_CFLAGS)
 
 PROG=risu
-SRCS=risu.c comms.c reginfo.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
+SRCS=risu.c comms.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
 HDRS=risu.h risu_reginfo_$(ARCH).h
 BINS=test_$(ARCH).bin
 
diff --git a/risu.h b/risu.h
index 77d6128..dd9fda5 100644
--- a/risu.h
+++ b/risu.h
@@ -35,7 +35,6 @@ void process_arch_opt(int opt, const char *arg);
 #include REGINFO_HEADER(ARCH)
 
 extern uintptr_t image_start_address;
-extern void *memblock;
 
 /* Ops code under test can request from risu: */
 typedef enum {
@@ -83,34 +82,9 @@ void send_response_byte(int sock, int resp);
 
 /* Functions operating on reginfo */
 
-/* Function prototypes for read/write helper functions. */
-RisuResult write_buffer(void *ptr, size_t bytes);
-RisuResult read_buffer(void *ptr, size_t bytes);
-void respond(RisuResult response);
-
-/*
- * Send the register information from the struct ucontext down the socket.
- * NB: called from a signal handler.
- */
-RisuResult send_register_info(void *uc);
-
-/*
- * Read register info from the socket and compare it with that from the
- * ucontext.
- * NB: called from a signal handler.
- */
-RisuResult recv_and_compare_register_info(void *uc);
-
-/*
- * Print a useful report on the status of the last reg comparison
- * done in recv_and_compare_register_info().
- */
-void report_mismatch_reg(void);
-
 /* Interface provided by CPU-specific code: */
 
-/* Move the PC past this faulting insn by adjusting ucontext
- */
+/* Move the PC past this faulting insn by adjusting ucontext. */
 void advance_pc(void *uc);
 
 /* Set the parameter register in a ucontext_t to the specified value.
diff --git a/reginfo.c b/reginfo.c
deleted file mode 100644
index a007f16..0000000
--- a/reginfo.c
+++ /dev/null
@@ -1,151 +0,0 @@
-/******************************************************************************
- * Copyright (c) 2017 Linaro Limited
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * which accompanies this distribution, and is available at
- * http://www.eclipse.org/legal/epl-v10.html
- *
- * Contributors:
- *     Peter Maydell (Linaro) - initial implementation
- *****************************************************************************/
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include "risu.h"
-
-static struct reginfo master_ri, apprentice_ri;
-static uint8_t master_memblock[MEMBLOCKLEN];
-
-RisuResult send_register_info(void *uc)
-{
-    struct reginfo ri;
-    trace_header_t header;
-    RisuResult res;
-    RisuOp op;
-
-    reginfo_init(&ri, uc);
-    op = get_risuop(&ri);
-
-    /* Write a header with PC/op to keep in sync */
-    header.pc = get_pc(&ri);
-    header.risu_op = op;
-    res = write_buffer(&header, sizeof(header));
-    if (res != RES_OK) {
-        return res;
-    }
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    case OP_SIGILL:
-        /*
-         * Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        res = write_buffer(&ri, reginfo_size());
-        /* For OP_TEST_END, force exit. */
-        if (res == RES_OK && op == OP_TESTEND) {
-            res = RES_END;
-        }
-        break;
-    case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc,
-                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        return write_buffer(memblock, MEMBLOCKLEN);
-    default:
-        abort();
-    }
-    return res;
-}
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- *
- * We don't have any kind of identifying info in the incoming data
- * that says whether it is register or memory data, so if the two
- * sides get out of sync then we will fail obscurely.
- */
-RisuResult recv_and_compare_register_info(void *uc)
-{
-    RisuResult res;
-    trace_header_t header;
-    RisuOp op;
-
-    reginfo_init(&apprentice_ri, uc);
-    op = get_risuop(&apprentice_ri);
-
-    res = read_buffer(&header, sizeof(header));
-    if (res != RES_OK) {
-        return res;
-    }
-
-    if (header.risu_op != op) {
-        /* We are out of sync.  Tell master to exit. */
-        respond(RES_END);
-        return RES_BAD_IO;
-    }
-
-    /* send OK for the header */
-    respond(RES_OK);
-
-    switch (op) {
-    case OP_COMPARE:
-    case OP_TESTEND:
-    case OP_SIGILL:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        res = read_buffer(&master_ri, reginfo_size());
-        if (res != RES_OK) {
-            /* fail */
-        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-            /* register mismatch */
-            res = RES_MISMATCH_REG;
-        } else if (op == OP_TESTEND) {
-            res = RES_END;
-        }
-        respond(res == RES_OK ? RES_OK : RES_END);
-        break;
-    case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&apprentice_ri);
-        break;
-    case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc, get_reginfo_paramreg(&apprentice_ri) +
-                              (uintptr_t)memblock);
-        break;
-    case OP_COMPAREMEM:
-        res = read_buffer(master_memblock, MEMBLOCKLEN);
-        if (res != RES_OK) {
-            /* fail */
-        } else if (memcmp(memblock, master_memblock, MEMBLOCKLEN) != 0) {
-            /* memory mismatch */
-            res = RES_MISMATCH_MEM;
-        }
-        respond(res == RES_OK ? RES_OK : RES_END);
-        break;
-    default:
-        abort();
-    }
-
-    return res;
-}
-
-/*
- * Print a useful report on the status of the last reg comparison
- * done in recv_and_compare_register_info().
- */
-void report_mismatch_reg(void)
-{
-    fprintf(stderr, "master reginfo:\n");
-    reginfo_dump(&master_ri, stderr);
-    fprintf(stderr, "apprentice reginfo:\n");
-    reginfo_dump(&apprentice_ri, stderr);
-    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-}
diff --git a/risu.c b/risu.c
index d6c2deb..a0e20d5 100644
--- a/risu.c
+++ b/risu.c
@@ -28,7 +28,10 @@
 #include "config.h"
 #include "risu.h"
 
-void *memblock;
+static void *memblock;
+static struct reginfo master_ri, apprentice_ri;
+static uint8_t master_memblock[MEMBLOCKLEN];
+
 
 static int comm_fd;
 static bool trace;
@@ -48,7 +51,7 @@ static sigjmp_buf jmpbuf;
 
 /* I/O functions */
 
-RisuResult read_buffer(void *ptr, size_t bytes)
+static RisuResult read_buffer(void *ptr, size_t bytes)
 {
     size_t res;
 
@@ -69,7 +72,7 @@ RisuResult read_buffer(void *ptr, size_t bytes)
     return res == bytes ? RES_OK : RES_BAD_IO;
 }
 
-RisuResult write_buffer(void *ptr, size_t bytes)
+static RisuResult write_buffer(void *ptr, size_t bytes)
 {
     size_t res;
 
@@ -90,13 +93,60 @@ RisuResult write_buffer(void *ptr, size_t bytes)
     return res == bytes ? RES_OK : RES_BAD_IO;
 }
 
-void respond(RisuResult r)
+static void respond(RisuResult r)
 {
     if (!trace) {
         send_response_byte(comm_fd, r);
     }
 }
 
+static RisuResult send_register_info(void *uc)
+{
+    struct reginfo ri;
+    trace_header_t header;
+    RisuResult res;
+    RisuOp op;
+
+    reginfo_init(&ri, uc);
+    op = get_risuop(&ri);
+
+    /* Write a header with PC/op to keep in sync */
+    header.pc = get_pc(&ri);
+    header.risu_op = op;
+    res = write_buffer(&header, sizeof(header));
+    if (res != RES_OK) {
+        return res;
+    }
+
+    switch (op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    case OP_SIGILL:
+        /*
+         * Do a simple register compare on (a) explicit request
+         * (b) end of test (c) a non-risuop UNDEF
+         */
+        res = write_buffer(&ri, reginfo_size());
+        /* For OP_TEST_END, force exit. */
+        if (res == RES_OK && op == OP_TESTEND) {
+            res = RES_END;
+        }
+        break;
+    case OP_SETMEMBLOCK:
+        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
+        break;
+    case OP_GETMEMBLOCK:
+        set_ucontext_paramreg(uc,
+                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
+        break;
+    case OP_COMPAREMEM:
+        return write_buffer(memblock, MEMBLOCKLEN);
+    default:
+        abort();
+    }
+    return res;
+}
+
 static void master_sigill(int sig, siginfo_t *si, void *uc)
 {
     RisuResult r;
@@ -110,6 +160,71 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     }
 }
 
+static RisuResult recv_and_compare_register_info(void *uc)
+{
+    RisuResult res;
+    trace_header_t header;
+    RisuOp op;
+
+    reginfo_init(&apprentice_ri, uc);
+    op = get_risuop(&apprentice_ri);
+
+    res = read_buffer(&header, sizeof(header));
+    if (res != RES_OK) {
+        return res;
+    }
+
+    if (header.risu_op != op) {
+        /* We are out of sync.  Tell master to exit. */
+        respond(RES_END);
+        return RES_BAD_IO;
+    }
+
+    /* send OK for the header */
+    respond(RES_OK);
+
+    switch (op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    case OP_SIGILL:
+        /* Do a simple register compare on (a) explicit request
+         * (b) end of test (c) a non-risuop UNDEF
+         */
+        res = read_buffer(&master_ri, reginfo_size());
+        if (res != RES_OK) {
+            /* fail */
+        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+            /* register mismatch */
+            res = RES_MISMATCH_REG;
+        } else if (op == OP_TESTEND) {
+            res = RES_END;
+        }
+        respond(res == RES_OK ? RES_OK : RES_END);
+        break;
+    case OP_SETMEMBLOCK:
+        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&apprentice_ri);
+        break;
+    case OP_GETMEMBLOCK:
+        set_ucontext_paramreg(uc, get_reginfo_paramreg(&apprentice_ri) +
+                              (uintptr_t)memblock);
+        break;
+    case OP_COMPAREMEM:
+        res = read_buffer(master_memblock, MEMBLOCKLEN);
+        if (res != RES_OK) {
+            /* fail */
+        } else if (memcmp(memblock, master_memblock, MEMBLOCKLEN) != 0) {
+            /* memory mismatch */
+            res = RES_MISMATCH_MEM;
+        }
+        respond(res == RES_OK ? RES_OK : RES_END);
+        break;
+    default:
+        abort();
+    }
+
+    return res;
+}
+
 static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
     RisuResult r;
@@ -226,7 +341,11 @@ static int apprentice(void)
 
     case RES_MISMATCH_REG:
         fprintf(stderr, "mismatch reg after %zd checkpoints\n", signal_count);
-        report_mismatch_reg();
+        fprintf(stderr, "master reginfo:\n");
+        reginfo_dump(&master_ri, stderr);
+        fprintf(stderr, "apprentice reginfo:\n");
+        reginfo_dump(&apprentice_ri, stderr);
+        reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
         return EXIT_FAILURE;
 
     case RES_MISMATCH_MEM:
-- 
2.20.1



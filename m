Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC99C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818232072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kjg0V1fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818232072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxcu-00019P-PJ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWV-0002VI-0h
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWT-000574-RG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id d10so4292409pgn.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mjhuvlUCpOP50NjRcK3iFgBHX3wIurn+3a+Fa5MAOOk=;
 b=Kjg0V1faLSnT5254nz637RsvJ73jyNX4cA0CjlrSQFZqAgYF4dv5WVl/Ak+fV7Z9DN
 PEFMynQjcqS8Pn8jgw9BxRweI0b8szlERetMze1/WxlPXc90Jvym79uO0h6gi8WU7PuR
 tkVRZCHxFPTPoIZOLwX5YTPsqLA9EyXT00LohDOZf63dPZTj3F6wYe/VgGZGtrWV9Qxr
 fjOOcQA8VjZ+xxxg54blahtEuopQYVe4iSv2Eb48FCsbax98kmNj4GM1zWpBXKyYSPI7
 JW0Fr/n47EorY1YM6KcUo9mjWEyYyVRkkafaVuMLE14ObXMkG4+Wcjtx0/1BLEk8ozQz
 v36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mjhuvlUCpOP50NjRcK3iFgBHX3wIurn+3a+Fa5MAOOk=;
 b=kE21hhyNZZYzbM4gZJ+rk687Zz2np6huNvcmEs5ukcKkuqHwMRDBXtF7EPtxzxMZr2
 it+kbWFm875htyiGKlheZd+uYNhe8CwN2mwIMTUO+RK4/lKHeOj897ShwYjPEdPfeEnz
 P0QVBnNPwya9IAjn0foYSLp+YXvtcR3+nb4l/vAuNVaoi/7i89BzYXhi28CROB7W+ikh
 zjZdE8WvIM6GvTHLesBjrgqCbCBoYX0qztlXz9oczjJfHzGFR+ck1nL79IFn+nHG06ut
 u1I1NKpwGc8YLmGBMExy+1b6jyBumqcaDwZLRaLkQsVJimcGJr8M/l1LEh0lxtYQHToC
 PnhA==
X-Gm-Message-State: AOAM531MyszpnhTobbmfe2c/em7Jx8nlCTPeMX1BbQxmFp3S5ubqImCI
 4nDtye1ic6rfjUA/Osduun4Bag7Ry+A=
X-Google-Smtp-Source: ABdhPJySN4B+mLqUYkXuClPUy70v207Ij6siWSOIXx2EYb3E/QUb2Y2hzz7FYz5QccpiZUagMnC0iw==
X-Received: by 2002:a63:3814:: with SMTP id f20mr11520301pga.266.1590114896004; 
 Thu, 21 May 2020 19:34:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/25] Always write for --master
Date: Thu, 21 May 2020 19:34:26 -0700
Message-Id: <20200522023440.26261-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For trace, master of course must write to the file we create.

For sockets, we can report mismatches from either end.  At present,
we are reporting mismatches from master.  Reverse that so that we
report mismatches from the apprentice, just as we do for trace.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    |  2 +-
 reginfo.c | 38 ++++++++--------------
 risu.c    | 96 ++++++++++++++++++++++++++-----------------------------
 3 files changed, 61 insertions(+), 75 deletions(-)

diff --git a/risu.h b/risu.h
index c83b803..f383b64 100644
--- a/risu.h
+++ b/risu.h
@@ -106,7 +106,7 @@ RisuResult recv_and_compare_register_info(void *uc);
  * Should return 0 if it was a good match (ie end of test)
  * and 1 for a mismatch.
  */
-int report_match_status(bool trace);
+int report_match_status(void);
 
 /* Interface provided by CPU-specific code: */
 
diff --git a/reginfo.c b/reginfo.c
index fee025e..c37c5df 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -14,9 +14,8 @@
 #include <stdlib.h>
 #include "risu.h"
 
-struct reginfo master_ri, apprentice_ri;
-
-uint8_t apprentice_memblock[MEMBLOCKLEN];
+static struct reginfo master_ri, apprentice_ri;
+static uint8_t master_memblock[MEMBLOCKLEN];
 
 static int mem_used;
 static int packet_mismatch;
@@ -82,8 +81,8 @@ RisuResult recv_and_compare_register_info(void *uc)
     trace_header_t header;
     RisuOp op;
 
-    reginfo_init(&master_ri, uc);
-    op = get_risuop(&master_ri);
+    reginfo_init(&apprentice_ri, uc);
+    op = get_risuop(&apprentice_ri);
 
     res = read_buffer(&header, sizeof(header));
     if (res != RES_OK) {
@@ -107,7 +106,7 @@ RisuResult recv_and_compare_register_info(void *uc)
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        res = read_buffer(&apprentice_ri, reginfo_size());
+        res = read_buffer(&master_ri, reginfo_size());
         if (res != RES_OK) {
             packet_mismatch = 1;
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
@@ -119,18 +118,18 @@ RisuResult recv_and_compare_register_info(void *uc)
         respond(res);
         break;
     case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
+        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&apprentice_ri);
         break;
     case OP_GETMEMBLOCK:
-        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+        set_ucontext_paramreg(uc, get_reginfo_paramreg(&apprentice_ri) +
                               (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
         mem_used = 1;
-        res = read_buffer(apprentice_memblock, MEMBLOCKLEN);
+        res = read_buffer(master_memblock, MEMBLOCKLEN);
         if (res != RES_OK) {
             packet_mismatch = 1;
-        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+        } else if (memcmp(memblock, master_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
             res = RES_MISMATCH;
         }
@@ -149,18 +148,13 @@ RisuResult recv_and_compare_register_info(void *uc)
  * Should return 0 if it was a good match (ie end of test)
  * and 1 for a mismatch.
  */
-int report_match_status(bool trace)
+int report_match_status(void)
 {
     int resp = 0;
     fprintf(stderr, "match status...\n");
     if (packet_mismatch) {
         fprintf(stderr, "packet mismatch (probably disagreement "
                 "about UNDEF on load/store)\n");
-        /* We don't have valid reginfo from the apprentice side
-         * so stop now rather than printing anything about it.
-         */
-        fprintf(stderr, "%s reginfo:\n", trace ? "this" : "master");
-        reginfo_dump(&master_ri, stderr);
         return 1;
     }
     if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
@@ -168,7 +162,7 @@ int report_match_status(bool trace)
         resp = 1;
     }
     if (mem_used
-        && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
+        && memcmp(memblock, &master_memblock, MEMBLOCKLEN) != 0) {
         fprintf(stderr, "mismatch on memory!\n");
         resp = 1;
     }
@@ -177,15 +171,11 @@ int report_match_status(bool trace)
         return 0;
     }
 
-    fprintf(stderr, "%s reginfo:\n", trace ? "this" : "master");
+    fprintf(stderr, "master reginfo:\n");
     reginfo_dump(&master_ri, stderr);
-    fprintf(stderr, "%s reginfo:\n", trace ? "trace" : "apprentice");
+    fprintf(stderr, "apprentice reginfo:\n");
     reginfo_dump(&apprentice_ri, stderr);
 
-    if (trace) {
-        reginfo_dump_mismatch(&apprentice_ri, &master_ri, stderr);
-    } else {
-        reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-    }
+    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
     return resp;
 }
diff --git a/risu.c b/risu.c
index f238117..199f697 100644
--- a/risu.c
+++ b/risu.c
@@ -102,11 +102,7 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     RisuResult r;
     signal_count++;
 
-    if (trace) {
-        r = send_register_info(uc);
-    } else {
-        r = recv_and_compare_register_info(uc);
-    }
+    r = send_register_info(uc);
     if (r == RES_OK) {
         advance_pc(uc);
     } else {
@@ -119,11 +115,7 @@ static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
     RisuResult r;
     signal_count++;
 
-    if (trace) {
-        r = recv_and_compare_register_info(uc);
-    } else {
-        r = send_register_info(uc);
-    }
+    r = recv_and_compare_register_info(uc);
     if (r == RES_OK) {
         advance_pc(uc);
     } else {
@@ -186,61 +178,65 @@ static int master(void)
 {
     RisuResult res = sigsetjmp(jmpbuf, 1);
 
-    if (res != RES_OK) {
+    switch (res) {
+    case RES_OK:
+        set_sigill_handler(&master_sigill);
+        fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n",
+                image_start_address);
+        fprintf(stderr, "starting image\n");
+        image_start();
+        fprintf(stderr, "image returned unexpectedly\n");
+        return EXIT_FAILURE;
+
+    case RES_END:
 #ifdef HAVE_ZLIB
         if (trace && comm_fd != STDOUT_FILENO) {
             gzclose(gz_trace_file);
         }
 #endif
         close(comm_fd);
-        if (trace) {
-            fprintf(stderr, "trace complete after %zd checkpoints\n",
-                    signal_count);
-            return EXIT_SUCCESS;
-        } else {
-            return report_match_status(false);
-        }
+        return EXIT_SUCCESS;
+
+    case RES_BAD_IO:
+        fprintf(stderr, "i/o error after %zd checkpoints\n", signal_count);
+        return EXIT_FAILURE;
+
+    default:
+        fprintf(stderr, "unexpected result %d\n", res);
+        return EXIT_FAILURE;
     }
-    set_sigill_handler(&master_sigill);
-    fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n",
-            image_start_address);
-    fprintf(stderr, "starting image\n");
-    image_start();
-    fprintf(stderr, "image returned unexpectedly\n");
-    return EXIT_FAILURE;
 }
 
 static int apprentice(void)
 {
     RisuResult res = sigsetjmp(jmpbuf, 1);
 
-    if (res != RES_OK) {
-#ifdef HAVE_ZLIB
-        if (trace && comm_fd != STDIN_FILENO) {
-            gzclose(gz_trace_file);
-        }
-#endif
-        close(comm_fd);
+    switch (res) {
+    case RES_OK:
+        set_sigill_handler(&apprentice_sigill);
+        fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
+                image_start_address);
+        fprintf(stderr, "starting image\n");
+        image_start();
+        fprintf(stderr, "image returned unexpectedly\n");
+        return EXIT_FAILURE;
 
-        switch (res) {
-        case RES_END:
-            return EXIT_SUCCESS;
-        default:
-            if (!trace) {
-                return EXIT_FAILURE;
-            }
-            fprintf(stderr, "finished early after %zd checkpoints\n",
-                    signal_count);
-            return report_match_status(true);
-        }
+    case RES_END:
+        return EXIT_SUCCESS;
+
+    case RES_MISMATCH:
+        fprintf(stderr, "mismatch after %zd checkpoints\n", signal_count);
+        report_match_status();
+        return EXIT_FAILURE;
+
+    case RES_BAD_IO:
+        fprintf(stderr, "i/o error after %zd checkpoints\n", signal_count);
+        return EXIT_FAILURE;
+
+    default:
+        fprintf(stderr, "unexpected result %d\n", res);
+        return EXIT_FAILURE;
     }
-    set_sigill_handler(&apprentice_sigill);
-    fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
-            image_start_address);
-    fprintf(stderr, "starting image\n");
-    image_start();
-    fprintf(stderr, "image returned unexpectedly\n");
-    return EXIT_FAILURE;
 }
 
 static int ismaster;
-- 
2.20.1



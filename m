Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613952072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuQZV024"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613952072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxbW-0006I5-IV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWT-0002RP-EL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWS-00056x-GX
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id f21so1284011pgg.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=08GYkLDINQo3JCs7twtHmTIyHJC0TnW/vsw/vZ50A4I=;
 b=WuQZV024ez9Hv4PfFJq+w6udDFdwJhqjrR+DfehK0/yV/87MVeYs8eQRxqZpxnhoGE
 rtFuyCG4Oo+6yxMOyCxXXUVmq93EfR+QoRxNGu4ArljYAkvJd0SQMap8IaMsqjRrm3AE
 mrbcWFA52Mu6hLRQCp0Gp7qTVp7QfgphD8X+jePZ+AQ+QZJ+lc3kgb9SoMKK4Uhhnm1h
 RJFgD3wPysfehwxkP1EZERi3immiYYQFClAFEGga44NElH8/6qkb4Z3kJrOEnomP4QzJ
 6f7pGI57m/slKYSvyc5fh8D39+jcVCgsBV2k45pTuAlJgIBXlFd/NT8+k2Q0vmqYlSAp
 LJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=08GYkLDINQo3JCs7twtHmTIyHJC0TnW/vsw/vZ50A4I=;
 b=IeMeWjljLmYjWwein7QaJByHlixJpW+LelwYIfz52OmokqL8Tq5dFv+YIu3jgjW5iw
 61wQYx8nXhxFmPfXyJr6BJ/BDo0z+MEpvXUbqyNCv3ZxWUV+RgrS1YmIWcVEWlEzgHzm
 3H4yuc9YeTa9Oowx1ieRs2JCwoFi0X/LPwQoIWGEYU1wzJAwWzQUUhX9wYqH4GEf2o2y
 9i82RuiPHP8C0Fb7zQi4g8d2tPKd+tymxtJqg3xjKeU8l2Lp+AxWTUEDUSYPUnpUZVi9
 2G1ScyXLi+X4ibJ5LSQ3FnyeMDAGTZ1eU+RqdaVHZVzUhRY3noUXjTiTR2C70pLVUoOC
 RC4A==
X-Gm-Message-State: AOAM531mO07SN97HDFIC3OkrujyKyVMcdohpPvQVqDlyrgLPh0SnE+YJ
 MEbnVJubBYREMOjM4pbZOBKh3HGRaQw=
X-Google-Smtp-Source: ABdhPJxDzT2gh1OaCZiDl69141AgiPDVboEWhttSyGqkcrb98O+tGVus7l2fQPJK2DKaUTtc3ByH4w==
X-Received: by 2002:a62:3383:: with SMTP id z125mr1684956pfz.271.1590114894796; 
 Thu, 21 May 2020 19:34:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/25] Pass non-OK result back through siglongjmp
Date: Thu, 21 May 2020 19:34:25 -0700
Message-Id: <20200522023440.26261-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rather than doing some work in the signal handler and
some work outside, move all of the non-resume work outside.
This works because we arranged for RES_OK to be 0, which
is the normal return from sigsetjmp.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/risu.c b/risu.c
index 1917311..f238117 100644
--- a/risu.c
+++ b/risu.c
@@ -107,15 +107,10 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     } else {
         r = recv_and_compare_register_info(uc);
     }
-
-    switch (r) {
-    case RES_OK:
-        /* match OK */
+    if (r == RES_OK) {
         advance_pc(uc);
-        return;
-    default:
-        /* mismatch, or end of test */
-        siglongjmp(jmpbuf, 1);
+    } else {
+        siglongjmp(jmpbuf, r);
     }
 }
 
@@ -129,21 +124,10 @@ static void apprentice_sigill(int sig, siginfo_t *si, void *uc)
     } else {
         r = send_register_info(uc);
     }
-
-    switch (r) {
-    case RES_OK:
-        /* match OK */
+    if (r == RES_OK) {
         advance_pc(uc);
-        return;
-    case RES_END:
-        /* end of test */
-        exit(EXIT_SUCCESS);
-    default:
-        /* mismatch */
-        if (trace) {
-            siglongjmp(jmpbuf, 1);
-        }
-        exit(EXIT_FAILURE);
+    } else {
+        siglongjmp(jmpbuf, r);
     }
 }
 
@@ -200,7 +184,9 @@ static void load_image(const char *imgfile)
 
 static int master(void)
 {
-    if (sigsetjmp(jmpbuf, 1)) {
+    RisuResult res = sigsetjmp(jmpbuf, 1);
+
+    if (res != RES_OK) {
 #ifdef HAVE_ZLIB
         if (trace && comm_fd != STDOUT_FILENO) {
             gzclose(gz_trace_file);
@@ -226,15 +212,27 @@ static int master(void)
 
 static int apprentice(void)
 {
-    if (sigsetjmp(jmpbuf, 1)) {
+    RisuResult res = sigsetjmp(jmpbuf, 1);
+
+    if (res != RES_OK) {
 #ifdef HAVE_ZLIB
         if (trace && comm_fd != STDIN_FILENO) {
             gzclose(gz_trace_file);
         }
 #endif
         close(comm_fd);
-        fprintf(stderr, "finished early after %zd checkpoints\n", signal_count);
-        return report_match_status(true);
+
+        switch (res) {
+        case RES_END:
+            return EXIT_SUCCESS;
+        default:
+            if (!trace) {
+                return EXIT_FAILURE;
+            }
+            fprintf(stderr, "finished early after %zd checkpoints\n",
+                    signal_count);
+            return report_match_status(true);
+        }
     }
     set_sigill_handler(&apprentice_sigill);
     fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
-- 
2.20.1



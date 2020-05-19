Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C26EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3F1207D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 03:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGrsxa6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3F1207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasV4-0001zF-65
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 23:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOV-0005S4-LO
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:15 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOS-0002Qe-Aw
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:15 -0400
Received: by mail-pg1-x532.google.com with SMTP id f4so5725454pgi.10
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=js3DaL9vdMvlvalMmzSSBkVboD7ayKmrqjH/PLK15lI=;
 b=MGrsxa6wM0rsT2BPjloLTXXty41U/u40ggiGWKt26FqLeKfGEe0U2FHWA6NbjgX+GT
 5b2c1kL8FKnYNBI8jSztEeUMwSnOhheZimG6PS8VvEWuDLJ/vfNpwRI5P96vI8BNek0B
 AkYdklcoZzzCKsymPkPiot29qrOmJ4D/w5hiyPl3XJTKS9EmlVZlWbeGU+Eq05QJ/rDe
 AX4Rv/+iNGkHzlPOZAdGQZj0QonL4OtkZOEMXi5fVIm4UzypN4eYgzFh8ACu9PbB8zW4
 HoENBh/BFWAcgIhStlyLR9szGWP+L2Qo3EawXNQXfUOEWxUkHW5k5ABULe1WV1OzWfLm
 fEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=js3DaL9vdMvlvalMmzSSBkVboD7ayKmrqjH/PLK15lI=;
 b=W707VWE7CW43ytc/dNvlxlxW56jq1yKtHBrgbma81guZ9LD3BkbtbM9p66v7dzHWhi
 A4351njIlikJ26abE3UpxMfn2Dlzn/TaNTtaa0ChEhwRWDGHjuGTAFhPa5GN1uRWVpgD
 jZbVJWCT/UyM2QNQIThifusHCN/RiMga9j/Tk5DOih4nS6er6Ic+j/Pyv6Tj4sZYJSKB
 08NwisJCX0sxZAvZN7OpaeL3iQ1NyiouTkLfmQKIvQfKJ55COJAo3R5h/U87CrsCRrY9
 drZNwXH5H/Ghqhv/NjEenTDgb5qvSv/tXSgoyKV6a+sKsuKSlKc/DhnvwrEqlOxtWAxU
 exDg==
X-Gm-Message-State: AOAM530TMmdE9lNYR4Ojv5dVIS2JrcJDn7mIE2YJpr7mays29RqCj1vb
 S2ark/wrQtZeIqC5Q+pbMrsJ/YrTeb0=
X-Google-Smtp-Source: ABdhPJxO0ZvBsukoYDji7LCi4yjCBGnpsTAijAQquUYvoa/WPB50J3aEggpE7sh5YozMLLfA2EXI0A==
X-Received: by 2002:a63:503:: with SMTP id 3mr11684925pgf.15.1589856850498;
 Mon, 18 May 2020 19:54:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 10/17] Pass non-OK result back through siglongjmp
Date: Mon, 18 May 2020 19:53:48 -0700
Message-Id: <20200519025355.4420-11-richard.henderson@linaro.org>
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

Rather than doing some work in the signal handler and
some work outside, move all of the non-resume work outside.
This works because we arranged for RES_OK to be 0, which
is the normal return from sigsetjmp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/risu.c b/risu.c
index 78c6b8f..d09ac0b 100644
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



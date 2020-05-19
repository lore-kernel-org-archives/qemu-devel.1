Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76BBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8581220657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDzPjGjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8581220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasQh-0001mX-Ly
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOK-00059U-CB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:04 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:50920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOJ-0002Om-Hg
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:04 -0400
Received: by mail-pj1-x1030.google.com with SMTP id nu7so706497pjb.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l8CNEpbNSwxuY2Dqho2U2FL6h85cata1jdT1yHJcAt8=;
 b=QDzPjGjL4SM/hI5CHVYRhL25SSqtD7Z6l1jBJfKKHP5eMfGT0+Jf/9mX4vk5p8IL5R
 Re+sn4zVEOD4gtWMrIblWf+pUc+ddMXvSDlK8ktO7tCy3+fXmHpw9/X7WHTQKxJtPVgU
 +rIGkvC55aMVO3Ccy9QELodleKol4Yb1p6ztHScA/zZ9JCDUqxhsyxSklqPvIU2QTnbf
 s79nJ9CYr1BSXWb7covF+V0HGDo4e5AvMddeBaHW7ozm1lUG1zMujhszqx4BLBc/T+W7
 s+F1qP/H78fLh5g9KvSSfI4hoVhfa2Ty2Zzas1/eDUCDuEd3MjmgPV71RpSlYHsyz7YE
 q1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l8CNEpbNSwxuY2Dqho2U2FL6h85cata1jdT1yHJcAt8=;
 b=qImDlZV72BHZT4cY8sc4o8fJ1XtpAKetak8BKOyTjkBa3FT1qWd1B0yJ+lTCj3DGcv
 PJ9tDJMqUFUp3nAyTEuw3ZkpgHj1oX+Ns9s2GirueDMcBLBPnHfgpyJ9auj3TI3oVnsB
 wT9pbKTT5ubTO1eaFA/S3UhfAdCQZmJJU/dAiXllCdayB4QkhiT1bYsX/i97h98sDziI
 DaxUHKffJQT01Rmh8Zyh1Sx6yQeZWi9HOVrFb8hksCi5nfc8f+JJzBvldRBM3EkGwXvs
 w34to5W+sJIutp6V0KW74anWk3RXIvoimtBTlkh+VqX35Xb2hFU0TM/hNMzuJDxf3PNF
 Is7g==
X-Gm-Message-State: AOAM5308ANTc9yd66ClVQbLRvaGFXUr1bwwG8OU9W5biAk8IZ+3q/zzH
 RCPl2Qh2ld/k50xn35xSgPiAVFZBxXk=
X-Google-Smtp-Source: ABdhPJx0Kpxtx5v069Q4bl55gYxOSQoo1aIPDsSygPvXCwbX7nZxmq1uihl+/zS2DjSDtQ/k0F9inQ==
X-Received: by 2002:a17:90b:789:: with SMTP id
 l9mr2564325pjz.111.1589856841627; 
 Mon, 18 May 2020 19:54:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:54:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 03/17] Hoist trace file opening
Date: Mon, 18 May 2020 19:53:41 -0700
Message-Id: <20200519025355.4420-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

We will want to share this code with --dump.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/risu.c b/risu.c
index 059348f..1c66885 100644
--- a/risu.c
+++ b/risu.c
@@ -363,6 +363,21 @@ int main(int argc, char **argv)
         }
     }
 
+    if (trace) {
+        if (strcmp(trace_fn, "-") == 0) {
+            comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
+        } else {
+            if (ismaster) {
+                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
+            } else {
+                comm_fd = open(trace_fn, O_RDONLY);
+            }
+#ifdef HAVE_ZLIB
+            gz_trace_file = gzdopen(comm_fd, ismaster ? "wb9" : "rb");
+#endif
+        }
+    }
+
     imgfile = argv[optind];
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
@@ -373,31 +388,13 @@ int main(int argc, char **argv)
     load_image(imgfile);
 
     if (ismaster) {
-        if (trace) {
-            if (strcmp(trace_fn, "-") == 0) {
-                comm_fd = STDOUT_FILENO;
-            } else {
-                comm_fd = open(trace_fn, O_WRONLY | O_CREAT, S_IRWXU);
-#ifdef HAVE_ZLIB
-                gz_trace_file = gzdopen(comm_fd, "wb9");
-#endif
-            }
-        } else {
+        if (!trace) {
             fprintf(stderr, "master port %d\n", port);
             comm_fd = master_connect(port);
         }
         return master();
     } else {
-        if (trace) {
-            if (strcmp(trace_fn, "-") == 0) {
-                comm_fd = STDIN_FILENO;
-            } else {
-                comm_fd = open(trace_fn, O_RDONLY);
-#ifdef HAVE_ZLIB
-                gz_trace_file = gzdopen(comm_fd, "rb");
-#endif
-            }
-        } else {
+        if (!trace) {
             fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
             comm_fd = apprentice_connect(hostname, port);
         }
-- 
2.20.1



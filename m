Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D10EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E501320659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfi2Mcyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E501320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvro-0007QX-9D
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpT-0003mj-FA
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:41358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpR-0000L3-O5
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:10:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id u10so139814pls.8
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6WnKJJxVIg6V1eDs3yOOQwU7naceEXc9NpTs3O74BXg=;
 b=nfi2McyhWp5KlLT7B06opOJr3FBtWlysLiXVLx64YHZNK5Zz5OuDvWRhL+PYRUJgrl
 Ye0EUEVdtFau36gY1+8+RpR5H/serJmfVatuu8ifL61DIl8mi1kzJP41Y9+X/WW0ulyL
 sqG5LV/EPGSKp+9zx7q5b5aUxVAMUdx+MK5drcN8MUMYvXSn0M6oVhFw8wGzZ7EzfxPS
 iWp3div9b23xgpNCy5y2ZIIprc4+2RomQw6NKNoLPzbsBylgXN9jv3lJx3JN9YXbaiIM
 teice8DetAKE2bClgZhTSzIpTtdEDEKY/yl42Bdx95EJ55or4yhr/QEyDeg6zR/bNum6
 PutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6WnKJJxVIg6V1eDs3yOOQwU7naceEXc9NpTs3O74BXg=;
 b=lLzR9BDHroooZcw2fXKqT+OJnkOS6Dy4bh35g2RL394LuQgH0BjixT6nEByEdnjVIY
 xVEKPqKGqMN7WAmnO1yum1UrqfQhN5A21poeyGTOWHLvD7DPIzoAKT2Nn5teVuuswukj
 OZNVr5HC29Kno0Z60xg0grJl5gv9+RPeQItOEWWUP9uJ0+/fYjUFbjo1GuoSEkUGpJ61
 Rit8pC6TmxhXz8bO266+ab2ijn7a/I0kIWTzOI+B5MIAguM7si1MqcSwR/eWQjYzRaYS
 uSOAN7elyyL9p5UIMw5VpWe1+ScVQFxEf9XabDZjS0/l9thkyP4TjJG/biUfQ9ujxmNY
 V36A==
X-Gm-Message-State: AOAM530Wsst7NDB4phl9YLCJG3POiQJRPDBGqFxoa9E0qasvm8p2zYk+
 8oX0dfvzTBo/EIso3Bn9+lYQQOFfPqo=
X-Google-Smtp-Source: ABdhPJyrjMWSo+6Kz1+4qe/3MThC7RsJn/8OCPOyxNIfCJxIhKBaqIqP4sOP9BqdcBbwUnXp4hbEeg==
X-Received: by 2002:a17:90a:df03:: with SMTP id
 gp3mr5378232pjb.50.1589393399401; 
 Wed, 13 May 2020 11:09:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:09:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 3/9] Hoist trace file opening
Date: Wed, 13 May 2020 11:09:47 -0700
Message-Id: <20200513180953.20376-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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



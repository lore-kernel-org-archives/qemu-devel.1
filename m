Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008552072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yo7rGMXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008552072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxYO-0008AK-5V
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWK-00025F-Bi
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:48 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:41737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWJ-00055z-I9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:48 -0400
Received: by mail-pg1-x52d.google.com with SMTP id r10so4276232pgv.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qsogh1iVORSWncpn9Q6d07KHmeqCKiBimOSa205EF/o=;
 b=Yo7rGMXbypolOulo6jZnvutW+SAmxwEFHKRUQz1ULYq1OfBzpJkl6iw6WxsFlO/iCq
 K8aC7Tu+Ok6g2WlFkDZDGRgYNGJI1dV3rj+UMA1zjeRImM76sOwsO0ukAZv7LJ9FhJlU
 KS7ok2OdGGZldx6hs4H+YRjMWFu3e6uDbvINnnurPXyA/UtGfqVqLnvTZFMpHHwVd3w3
 wqRmBIucoVLbYFm3hJ33WYcHsYdnPwefcyBEUKum5a1pHLRtQiN0r7QhjHyJyj2PM3kH
 TEFD4Xf7cAR0qIifdU0KoQEBoisgtrfwKiltpTqxRYylvyG9nzA0RlAl0nq+z1efS8XE
 l+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsogh1iVORSWncpn9Q6d07KHmeqCKiBimOSa205EF/o=;
 b=rKHn1qXnF/Np9sHhifGPll4UaOSOD7CXV6FkFWWmx/SUClZKcYeNq+T275/RTszK/i
 RtR08ynwnyUQgoMxtCnUuC3FzyzUmOtO/jUYIIut6u2eYdXZd4n0PUxPYj1J/6MPw4l+
 9VFxbWcpxXyv1RVejqK950CUO1z3csIfdjGpcCFKIxiVxOfsQr1Edea0auaGMVSat+q2
 CzGp8p6yncpSZs3ludiomjvyfdzUIlbBe9tlErOvAJM0wzuYtl4WjUGU8NgQWH+qyee8
 czZM75LmsmWkVE6hqHqUWRut0arjCG3tyjl6h8VS5LAihBN4bDcAMCuHTqaLZw0mAyQb
 KxkA==
X-Gm-Message-State: AOAM5337QFTaNHK7BxVXVAQ2da4HktB6r+YEcqZFBSdyJMiv60MiHExk
 DuqTuVillDh2Ffkz6h7JxfoXPXJlx5Y=
X-Google-Smtp-Source: ABdhPJyF7xwPQByPXj1qMHkswo4g4MIzsvSUy7uCKGY8Rfo+4xlh2IOEn701EZmnXDdsA6HlWIczig==
X-Received: by 2002:a63:d70b:: with SMTP id d11mr11840970pgg.372.1590114885833; 
 Thu, 21 May 2020 19:34:45 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/25] Hoist trace file and socket opening
Date: Thu, 21 May 2020 19:34:18 -0700
Message-Id: <20200522023440.26261-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will want to share this code with --dump.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Hoist socket connecting as well as trace file opening.
---
 risu.c | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/risu.c b/risu.c
index 059348f..2f6a677 100644
--- a/risu.c
+++ b/risu.c
@@ -363,6 +363,29 @@ int main(int argc, char **argv)
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
+    } else {
+        if (ismaster) {
+            fprintf(stderr, "master port %d\n", port);
+            comm_fd = master_connect(port);
+        } else {
+            fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
+            comm_fd = apprentice_connect(hostname, port);
+        }
+    }
+
     imgfile = argv[optind];
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
@@ -373,34 +396,8 @@ int main(int argc, char **argv)
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
-            fprintf(stderr, "master port %d\n", port);
-            comm_fd = master_connect(port);
-        }
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
-            fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
-            comm_fd = apprentice_connect(hostname, port);
-        }
         return apprentice();
     }
 }
-- 
2.20.1



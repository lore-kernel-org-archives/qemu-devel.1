Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2907420657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 02:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yB4GxqVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2907420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jasQf-0001eh-Ae
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 22:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOH-00056h-Pj
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:35861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jasOH-0002OQ-1D
 for qemu-devel@nongnu.org; Mon, 18 May 2020 22:54:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id z1so5876663pfn.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 19:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J6GEOI64wSUnLIdW8jpIq6kLD++FF+yxc6i0EiqZJFU=;
 b=yB4GxqVR9ejP+DUevjbKZtciyXoe7y3iRBX2baTlao2QsZ2hjQFnWCDEod1Q3B/Zi3
 URENq4sg54ZZkcUce8dbCQoOUrXNnfrzKpPj/TcZWFlfJaw5G2QS0jq1IXsiDz9ss1uB
 AtcN/wEQXH+1Q4XddpVbZLbrOmCKMD+j1dZse1X2L0lef5ibZrJwov9uJBp9+eiKgexI
 8vVujPI4N/k3CViP2dy7E6Boro459+Dqusrz+NzU8AuK0v+Cj1vV3TW2+gWK3K+0QsRR
 YQdrC/niOhcI0NHNhBt95lTbnfbCvIl2EEF/kM83vs8ktf5LTa47C7K/9pAblFea9EyA
 nDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J6GEOI64wSUnLIdW8jpIq6kLD++FF+yxc6i0EiqZJFU=;
 b=TcI7drd9RDvJFRUgnLiKRjhIYISPAWQlE/s/eRJdtnYVF683q13c/G43uvP/Z7mSUH
 UMdcbIOGgs+oDRw0YtpzL9e9wkn/puJfAXtI+SB1nHQPR2s01Hmo2KRVLfM5O0WHr/QR
 1QY8FPpcqLq1qtRvYvhhn7DexCC3P8hEErJV3Z7XJndNVzYFuS59T5Gab75B2fUH4tNk
 ts0fu9gGsFyESSSjVSbMsiG36IfafZjdvgTRTtQbpLuIHv3Q1HfYcDv/7nxywlX7Ksdr
 tWfOlwJ7Vn64ymxuAj0KeWiKbq399y2s7oWwC5Roc4mzDl8L19B7Mbm8AurVTGeBUNK3
 op4A==
X-Gm-Message-State: AOAM530N7yoxQbM0SAJH1wKpIy9/rKpy7PRKv6/yY8domA6J8FhjSoFR
 THu81SjsGUCjWgcWrym2CRwkI+dVPwk=
X-Google-Smtp-Source: ABdhPJzvIT4IN4y+I/g7yEYO6U3jxj32YN1vp44cCCgmbaC8VE6hkuHEWXjqdVcncOD9tk9rjei0nA==
X-Received: by 2002:a63:175c:: with SMTP id 28mr16761352pgx.44.1589856839108; 
 Mon, 18 May 2020 19:53:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm8772418pgh.57.2020.05.18.19.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 19:53:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU v2 01/17] Use bool for tracing variables
Date: Mon, 18 May 2020 19:53:39 -0700
Message-Id: <20200519025355.4420-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519025355.4420-1-richard.henderson@linaro.org>
References: <20200519025355.4420-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    | 3 ++-
 reginfo.c | 2 +-
 risu.c    | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/risu.h b/risu.h
index 8d2d646..e2b4508 100644
--- a/risu.h
+++ b/risu.h
@@ -17,6 +17,7 @@
 #include <ucontext.h>
 #include <stdio.h>
 #include <getopt.h>
+#include <stdbool.h>
 
 /* Extra option processing for architectures */
 extern const struct option * const arch_long_opts;
@@ -96,7 +97,7 @@ int recv_and_compare_register_info(read_fn read_fn,
  * Should return 0 if it was a good match (ie end of test)
  * and 1 for a mismatch.
  */
-int report_match_status(int trace);
+int report_match_status(bool trace);
 
 /* Interface provided by CPU-specific code: */
 
diff --git a/reginfo.c b/reginfo.c
index dd42ae2..1b2a821 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -141,7 +141,7 @@ int recv_and_compare_register_info(read_fn read_fn,
  * Should return 0 if it was a good match (ie end of test)
  * and 1 for a mismatch.
  */
-int report_match_status(int trace)
+int report_match_status(bool trace)
 {
     int resp = 0;
     fprintf(stderr, "match status...\n");
diff --git a/risu.c b/risu.c
index 01525d2..79b1092 100644
--- a/risu.c
+++ b/risu.c
@@ -31,7 +31,7 @@
 void *memblock;
 
 int apprentice_fd, master_fd;
-int trace;
+bool trace;
 size_t signal_count;
 
 #ifdef HAVE_ZLIB
@@ -228,7 +228,7 @@ int master(void)
                     signal_count);
             return 0;
         } else {
-            return report_match_status(0);
+            return report_match_status(false);
         }
     }
     set_sigill_handler(&master_sigill);
@@ -250,7 +250,7 @@ int apprentice(void)
 #endif
         close(apprentice_fd);
         fprintf(stderr, "finished early after %zd checkpoints\n", signal_count);
-        return report_match_status(1);
+        return report_match_status(true);
     }
     set_sigill_handler(&apprentice_sigill);
     fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
@@ -344,7 +344,7 @@ int main(int argc, char **argv)
             break;
         case 't':
             trace_fn = optarg;
-            trace = 1;
+            trace = true;
             break;
         case 'h':
             hostname = optarg;
-- 
2.20.1



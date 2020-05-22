Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32549C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8072072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYjy3/1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8072072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxXA-000423-5I
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWI-00023Z-AA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:35254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWH-00055l-7N
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:34:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id q16so3822656plr.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gkyAigBcxeB9sTmXF9GJufgbDs99qzgoeJAd1MWy3/8=;
 b=eYjy3/1MBhnXWugPc+CFxZeLIxiTC0jYd4kIUwzJV8T2KLpJ8jQYffGbx5qJFaY3j7
 deRPgUhyPV4SE94sam6cWYBP5R2zj1LaKDSZJbJHQaKLsYczXCd2KbMk/7Zqiay2bWvV
 +da/AAj7xBe14iChYVnA7PoUzV5gu+daGIAmlZDyr+Zd613Wl5w8v1nq/loMNA5MG15P
 jF+EHWquY78+ZrfrTHq8Ps/oKuNUcoF8rMOPC9TjS+LGi40fnG9E1sWb6n/ORjmUXZ98
 ANzbmk4z64vlH8Ztxw71oVjbC+0iN7hOE0FvO4je8HdOdIa676Yxho0+9cgrn2/FKmMM
 L59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gkyAigBcxeB9sTmXF9GJufgbDs99qzgoeJAd1MWy3/8=;
 b=NDPG1c44YcoTW6+U7vtrRj0GQAkHD0dBeVHor8IaT43CZKpY0IYip/eNWb+8A2Pax7
 B/oYzAP80HpLXJLKdblkBOmZgwnKzYdOhu+7ySh8F/WqWygoY3MgdAZJMZeLDO5m3guo
 YU5lfiwFDjI3bSAlDJDEVQ03GONMVGXEixu7Csc3lUnC8W0GLRfJnhIl0IYPNybeCV5K
 40b5z008XLJryrgEWtqiWnlR6ARQN8pLxm958FOkBAbukjvlMYFlW45W+QWaxjfs/nAL
 HZ81H6BkLZOrY1ZT3C1BenWbANuUBr1lAWj8UfIsvzghrCqNVQzP+6ag+DFeLosc68gB
 fiLQ==
X-Gm-Message-State: AOAM5329gzG03tsbggdU42Bxf5hLFnFBr1zbdcI+XGz+oVAVWr5HEm92
 1uJnA5wYSBn/T4rwHgr23r92FQEBIAo=
X-Google-Smtp-Source: ABdhPJzzf1M25wPmaMu5y7kfJz7/kw91o9IVkvYuihZwHuF8/Itj1H3jz+DD0uO2mTwA+3qMd3Lxjw==
X-Received: by 2002:a17:90b:3745:: with SMTP id
 ne5mr1822404pjb.68.1590114883474; 
 Thu, 21 May 2020 19:34:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/25] Use bool for tracing variables
Date: Thu, 21 May 2020 19:34:16 -0700
Message-Id: <20200522023440.26261-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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



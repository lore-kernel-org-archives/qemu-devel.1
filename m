Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC82C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDB820659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJzWjm/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDB820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvru-0007W7-SX
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpP-0003gI-5N
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:44302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYvpO-0000Ki-Ag
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id x13so85146pfn.11
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZgV2/q17x6H7Sn6RUMsv4Yoy4IHja1Ijjf8wQZe1BeM=;
 b=hJzWjm/Ppdu4ojt5uk9DhZXaiL2o1DLHMEPiJMtnDM4oyAVwviuFTUy+5enIa72Q4S
 qGYwo4XgeI4PIrCqPfTwaa2P1TYWMFjZNku0E0qNigNbIOmWr+Z+KGqZmWhUJRMnwK0W
 ANkSzqKY5ScNQZ3hL1x9JnWqL3ti8mp2yEzt8xMunPqEGFwgAjfnTOWdUVnyZTbrEHCU
 gEzguY0YUhTtk2WssiW2ffhA2zxSr2eNX0V+wF49jhWDeogaSVxm9AhErt8Ycvs5dWRw
 uD7rfqfOijhklUm8J/QVI4RYgKN3bsXaA4YME6qCx75sGhEPC4TrpfDTc4XAcTBXfxbG
 xhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZgV2/q17x6H7Sn6RUMsv4Yoy4IHja1Ijjf8wQZe1BeM=;
 b=J8YxVJG+B1fZ1tskhxtbn5zFEqbBi0WFep9+tcODWjOt6EzBI8PNtOx3Z5KC154foo
 f2VYSUK9DJWRV+KogiaC2rNoNnqWLtWLB1AYJG/X42+szeUkd0+feKgGhaDPYyR5dX/x
 TGYpihTaD2hPFQtMe5ZlMncGyxpI0JCl0FFoLY2FY2deoPECvZnkG61k0zVaXH3xcFO/
 K0LrqieFHcSwNzL2SiKCR+K16EKZtYjY+6ag5vDtMH6E5bg8S5mVfbV55CutonEJcX6B
 gSBYvUchvG4PGW+cmiRCh72IZrSPKeC5cyHkMV+lQORupFP4h1V23HoWQLlF6D5ch1dc
 UUgA==
X-Gm-Message-State: AOAM530+EZBL6fz27TSirzKyNrKYuKEb7FrYcz2gcplBGqB/9xuf1pL2
 8Z4dZ1gVwG8I2errru/s6251Hp4sZgg=
X-Google-Smtp-Source: ABdhPJxXMxBE0LYNq2Tl0U1T1fa6C97Tl0S4773WsE1+oGD7GRNbe8cFNayHBpN1dN5M4nABjbzEJg==
X-Received: by 2002:a63:150:: with SMTP id 77mr495647pgb.136.1589393396669;
 Wed, 13 May 2020 11:09:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i185sm197361pfg.14.2020.05.13.11.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 11:09:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RISU 1/9] Use bool for tracing variables
Date: Wed, 13 May 2020 11:09:45 -0700
Message-Id: <20200513180953.20376-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513180953.20376-1-richard.henderson@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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



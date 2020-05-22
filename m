Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B143DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0A42072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWA2ChL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0A42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxe7-0003lD-Ly
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWX-0002Zs-29
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:01 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWW-00057I-22
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id n18so4481515pfa.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=47X0nDkNnDfoYJURE/fAwmOiKXa0tA0+uH16JNzJ4Lc=;
 b=mWA2ChL7cbSgsA8g2nvgitxTW1oZxOYAEYKR5OH/gT3gDT9P6+HySeBugg1Jlk1XSX
 3JmkJBJFbWTbnI954Dtuwe4kib7HQH+QvZLFlCxqS+BRVMIvmftrv7t9yTn+uejcX5T6
 kPjCxmWDDks49igwOipyI44uu9eEZY1SX9OY2pEREQyVR+5/dWFawqCS2UAy35ofmN1v
 so00RI4y7wyEbONjKQsC+IkOtin4wiroO/bKOR5dkGDmfMt90YTeBWbsUfY8AXMDzElQ
 UyJvaFIuz7CJOkjCfxTGFx32BvDPnyRdqpl9WjH6YWYoF3Ntt2D9wmLlkUoc6AMz/lJU
 lt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=47X0nDkNnDfoYJURE/fAwmOiKXa0tA0+uH16JNzJ4Lc=;
 b=a3UF3HcZzyeH7Sbrtis/T80WMJMmIh44LsgeQoh529Ar6G7dhT/39cQytuad+3qwNm
 y0mtP9auOqc8lbErTEF+4yDtpO70qQZboCbr1BrBjpr+yE32trC1uWRY51uCk5m1efKT
 JXAxWkJZO+eRCUdWSUAz4KaUhHbOf4oknrNFI9UeVEeNYf9UdmmGGOrhGN5LG6+xWhpH
 CsvXbyVN7+EEIRQycayDIOwYmLdoFEuOx3pAh1IN71mJRQe19sRpCjY1SOUXRu0LuAFv
 N4XGwBIBDWKy1hYrGDQSRjDa1T9K2lktT4870AisxFsn6FV3qRAhhlCqKZMLneTHerQx
 UJfw==
X-Gm-Message-State: AOAM532xobtVXrZMj5+acySeY09BJBPHzK9oykSKwJ+SdmvghQnvNtXc
 C0bKsgIOvsWaG9OPIFWMq6Kx9pytfcY=
X-Google-Smtp-Source: ABdhPJy55Oc883tPMWE8Pyp08urluM7Ghzp6IjTuIqEcpku2coynGTh9UtQGXdq3qcUatUCr+H45QQ==
X-Received: by 2002:a63:3ec3:: with SMTP id
 l186mr11489052pga.228.1590114898319; 
 Thu, 21 May 2020 19:34:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:34:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/25] Split RES_MISMATCH for registers and memory
Date: Thu, 21 May 2020 19:34:28 -0700
Message-Id: <20200522023440.26261-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

By remembering the specific comparison that failed, we do not
have to try again when it comes time to report.  This makes
the mem_used flag redundant.  Also, packet_mismatch is now
redundant with RES_BAD_IO.

This means that the only thing that report_match_status does
is to report on register status, so rename to report_mismatch_reg.
Also, we know there is a failure, so don't return a status from
the report.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h    | 13 ++++++-------
 reginfo.c | 45 ++++++++-------------------------------------
 risu.c    | 10 +++++++---
 3 files changed, 21 insertions(+), 47 deletions(-)

diff --git a/risu.h b/risu.h
index f383b64..77d6128 100644
--- a/risu.h
+++ b/risu.h
@@ -54,7 +54,8 @@ typedef enum {
 typedef enum {
     RES_OK = 0,
     RES_END,
-    RES_MISMATCH,
+    RES_MISMATCH_REG,
+    RES_MISMATCH_MEM,
     RES_BAD_IO,
 } RisuResult;
 
@@ -100,13 +101,11 @@ RisuResult send_register_info(void *uc);
  */
 RisuResult recv_and_compare_register_info(void *uc);
 
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
+/*
+ * Print a useful report on the status of the last reg comparison
+ * done in recv_and_compare_register_info().
  */
-int report_match_status(void);
+void report_mismatch_reg(void);
 
 /* Interface provided by CPU-specific code: */
 
diff --git a/reginfo.c b/reginfo.c
index 31bc699..a007f16 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -17,9 +17,6 @@
 static struct reginfo master_ri, apprentice_ri;
 static uint8_t master_memblock[MEMBLOCKLEN];
 
-static int mem_used;
-static int packet_mismatch;
-
 RisuResult send_register_info(void *uc)
 {
     struct reginfo ri;
@@ -107,10 +104,10 @@ RisuResult recv_and_compare_register_info(void *uc)
          */
         res = read_buffer(&master_ri, reginfo_size());
         if (res != RES_OK) {
-            packet_mismatch = 1;
+            /* fail */
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
             /* register mismatch */
-            res = RES_MISMATCH;
+            res = RES_MISMATCH_REG;
         } else if (op == OP_TESTEND) {
             res = RES_END;
         }
@@ -124,13 +121,12 @@ RisuResult recv_and_compare_register_info(void *uc)
                               (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        mem_used = 1;
         res = read_buffer(master_memblock, MEMBLOCKLEN);
         if (res != RES_OK) {
-            packet_mismatch = 1;
+            /* fail */
         } else if (memcmp(memblock, master_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
-            res = RES_MISMATCH;
+            res = RES_MISMATCH_MEM;
         }
         respond(res == RES_OK ? RES_OK : RES_END);
         break;
@@ -141,40 +137,15 @@ RisuResult recv_and_compare_register_info(void *uc)
     return res;
 }
 
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
+/*
+ * Print a useful report on the status of the last reg comparison
+ * done in recv_and_compare_register_info().
  */
-int report_match_status(void)
+void report_mismatch_reg(void)
 {
-    int resp = 0;
-    fprintf(stderr, "match status...\n");
-    if (packet_mismatch) {
-        fprintf(stderr, "packet mismatch (probably disagreement "
-                "about UNDEF on load/store)\n");
-        return 1;
-    }
-    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-        fprintf(stderr, "mismatch on regs!\n");
-        resp = 1;
-    }
-    if (mem_used
-        && memcmp(memblock, &master_memblock, MEMBLOCKLEN) != 0) {
-        fprintf(stderr, "mismatch on memory!\n");
-        resp = 1;
-    }
-    if (!resp) {
-        fprintf(stderr, "match!\n");
-        return 0;
-    }
-
     fprintf(stderr, "master reginfo:\n");
     reginfo_dump(&master_ri, stderr);
     fprintf(stderr, "apprentice reginfo:\n");
     reginfo_dump(&apprentice_ri, stderr);
-
     reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-    return resp;
 }
diff --git a/risu.c b/risu.c
index 199f697..d6c2deb 100644
--- a/risu.c
+++ b/risu.c
@@ -224,9 +224,13 @@ static int apprentice(void)
     case RES_END:
         return EXIT_SUCCESS;
 
-    case RES_MISMATCH:
-        fprintf(stderr, "mismatch after %zd checkpoints\n", signal_count);
-        report_match_status();
+    case RES_MISMATCH_REG:
+        fprintf(stderr, "mismatch reg after %zd checkpoints\n", signal_count);
+        report_mismatch_reg();
+        return EXIT_FAILURE;
+
+    case RES_MISMATCH_MEM:
+        fprintf(stderr, "mismatch mem after %zd checkpoints\n", signal_count);
         return EXIT_FAILURE;
 
     case RES_BAD_IO:
-- 
2.20.1



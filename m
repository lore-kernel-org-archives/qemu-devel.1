Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E037C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32622067B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aY/6jD3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32622067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxgp-0002QF-45
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWd-0002t4-Qn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:07 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWc-00058I-Mn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:07 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q9so4346658pjm.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=luiwJqNtbF93pa4B4WEBIHdTcK0G0uHbjDw2xJ7Jaew=;
 b=aY/6jD3EsjlwEoRTgPmICL0MkRiVyaBx8KayP38X/AVAvNkC69XW+F7RuVcnTTMmw3
 nMB7SnSE309lKgASpqSA+X4+4PL9FnA6scLJh9W5qsve8DRmPnQsetyiQU/lSrgBik5y
 Pe4/oLrV8QbyprXhcut6piyNDC6fudenaVMw2LrRoJuUnE+799HvfSWR6kjYpe29qHtM
 gIBCim8u4NYBZ5tHyQsSfbUI+rTLO3uK2JJ7pyHGMD/VeVSgbGDLQ2M8B+hRAGTGgLUF
 P6HhpBZJYuBjC7PEFuZ3jiFjJQOjiMeEKQ8OBcXOA9Q64puvt5KU8QH9HDrxpt6Bkxpa
 8obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=luiwJqNtbF93pa4B4WEBIHdTcK0G0uHbjDw2xJ7Jaew=;
 b=JA8lpo4ZvIT/YLVTdchEZ5CL6l/ONK1y/tvfRXxXtdwwyoK5IzMkKn7kmPmcoOCAor
 uDF2XWfm52hgKwxD4o4XmoPKBMZH5BhoZM8BOB1OIUNCAgaat5TzKkv+wHgV7sYoA7JT
 XbTpGe8HECS5yG7ArV4TQwpUfU721jzAR9B4zH2yqwCEduEE4jNwAKPvsRtUwcJDtUnq
 D6SrvxFcpURD50qZswRKmJtyLr8NDDxfqUcXILofTBpLCYKDv+MxjTP4UdWcZznNFld8
 LiMAw8lezW5Yl5iblcWp6lFaiOStrW7T0R2D0L4DCzNBrpuQJw0pa+WcYRQtFbuJy3YV
 yjfQ==
X-Gm-Message-State: AOAM5313b2moQtkn6dfPvPIUuf0rbovpo4AEoUiwkuVSUctKX0jZGi9e
 L+LXiM0DGZgkE3O0GhxvgCb7mTRt5/0=
X-Google-Smtp-Source: ABdhPJyZv0dxD6edB7fe8ZimVdoisW6ljJ92K4udZxTP3s1Cwcr6sJbv9JWINWSgG+2K4JcG/IKPJA==
X-Received: by 2002:a17:902:7045:: with SMTP id
 h5mr12695977plt.108.1590114904835; 
 Thu, 21 May 2020 19:35:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/25] Compute reginfo_size based on the reginfo
Date: Thu, 21 May 2020 19:34:33 -0700
Message-Id: <20200522023440.26261-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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

This will allow dumping of SVE frames without having
to know the SVE vector length beforehand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                 | 2 +-
 risu.c                 | 9 +++++++--
 risu_reginfo_aarch64.c | 4 ++--
 risu_reginfo_arm.c     | 4 ++--
 risu_reginfo_i386.c    | 4 ++--
 risu_reginfo_m68k.c    | 4 ++--
 risu_reginfo_ppc64.c   | 4 ++--
 7 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/risu.h b/risu.h
index bfcf0af..3cad3d5 100644
--- a/risu.h
+++ b/risu.h
@@ -126,6 +126,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f);
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
 
 /* return size of reginfo */
-const int reginfo_size(void);
+int reginfo_size(struct reginfo *ri);
 
 #endif /* RISU_H */
diff --git a/risu.c b/risu.c
index a248db1..a70b778 100644
--- a/risu.c
+++ b/risu.c
@@ -125,7 +125,7 @@ static RisuResult send_register_info(void *uc)
     case OP_TESTEND:
     case OP_COMPARE:
     case OP_SIGILL:
-        header.size = reginfo_size();
+        header.size = reginfo_size(&ri[MASTER]);
         extra = &ri[MASTER];
         break;
     case OP_COMPAREMEM:
@@ -209,7 +209,12 @@ static RisuResult recv_register_info(struct reginfo *ri)
             return RES_BAD_SIZE;
         }
         respond(RES_OK);
-        return read_buffer(ri, header.size);
+        res = read_buffer(ri, header.size);
+        if (res == RES_OK && header.size != reginfo_size(ri)) {
+            /* The payload size is not self-consistent with the data. */
+            return RES_BAD_SIZE;
+        }
+        return res;
 
     case OP_COMPAREMEM:
         if (header.size != MEMBLOCKLEN) {
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 028c690..7044648 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -69,7 +69,7 @@ void process_arch_opt(int opt, const char *arg)
 #endif
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
     int size = offsetof(struct reginfo, simd.end);
 #ifdef SVE_MAGIC
@@ -194,7 +194,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
-    return memcmp(r1, r2, reginfo_size()) == 0;
+    return memcmp(r1, r2, reginfo_size(r1)) == 0;
 }
 
 #ifdef SVE_MAGIC
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 3662f12..47c52e8 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -36,9 +36,9 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
-    return sizeof(struct reginfo);
+    return sizeof(*ri);
 }
 
 static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 60fc239..50505ab 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -74,9 +74,9 @@ void process_arch_opt(int opt, const char *arg)
     }
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
-    return sizeof(struct reginfo);
+    return sizeof(*ri);
 }
 
 static void *xsave_feature_buf(struct _xstate *xs, int feature)
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 32b28c8..4eb30cd 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -23,9 +23,9 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
-    return sizeof(struct reginfo);
+    return sizeof(*ri);
 }
 
 /* reginfo_init: initialize with a ucontext */
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 071c951..39e8f1c 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -32,9 +32,9 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
-const int reginfo_size(void)
+int reginfo_size(struct reginfo *ri)
 {
-    return sizeof(struct reginfo);
+    return sizeof(*ri);
 }
 
 /* reginfo_init: initialize with a ucontext */
-- 
2.20.1



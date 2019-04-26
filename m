Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2037C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8AB2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8gt93oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8AB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50015 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4hr-0006p4-1O
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:32:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aO-0008R4-96
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aN-0006Ll-7Q
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:45495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aN-0006KW-1s
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: by mail-pg1-x533.google.com with SMTP id y27so1205418pgl.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fs+VAJvIUlV2gQG99NKmKU7MN80ounXs6KwGIvA+I7I=;
	b=U8gt93oOkgf05Ldlc7W187XUsHmjfwaiPiHczKZ6ujc/igrQYJ/VTHvj0q5i164k46
	pVvQRbYJ4ko68TYcb+f0fVnfaQ30gnX/ENcIXVdZv8Qg6oVRNMYpJsZdW6d4jkvzISTV
	ES53r+sSgsS6KB7yhgBx2+Ao7L7Wz/Ck/FOoktl/Lpw+RLwt2yCnG+SZKq+Uhn2+ypas
	wpnN7JCub/tA+W9cBBMUapIaUzfrvd1b7n8ByL4Y6xv7JlcgQhcNMtQHY9+18Je9ZiG5
	z8ZMktPJ0FfRv1PcTGXjtGm2kkxHW1gJyoizGppst2RpFT7mnZZp45bhP6ErugomaQqV
	rUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fs+VAJvIUlV2gQG99NKmKU7MN80ounXs6KwGIvA+I7I=;
	b=XnKqqJsWaWKK1S2OqFVCmzZagYdWYRI4BCP+aG8oa0PXcroQLYYEKqcb78e/6rgUoo
	vdhC+YOueaE9vhnGGyeID3RblHyvjBVUJdB89oWInHVNvWW8PHUyy81/rB5ESrBJMTv+
	bOXGl7s9SZ2AQEfwpTICUC3+LtqroX1ZJZFBPxY58gcpgT4n3vCsBE7oQP45iFCNANxU
	4ufGqKaIVxop8qm1rn/dYASVYfhplZtlAyu0bNr1v8n2zwEPlk5AgTr2kQRE+lUYcYEk
	UiD6PdZeUimQVV3cbAo2jSn4gce5i7v4goky1TL9JXGTG7DkOKKlK08sfEBkrAGxFxup
	0lAQ==
X-Gm-Message-State: APjAAAXpWZ913T1sVepRhD6ycwMJctUIGNIZacFQuMVZtfka/cu1Pa+J
	J0TDj8ZQ1+lzLzWyVaTlBL6dfoYvE3w=
X-Google-Smtp-Source: APXvYqwBHdFUjs1+Mz82jS0ZIiWmn9SKlP4vglpVhskcweN38adCAmDCZjwnO2TC/qsLdMJlpfPr9w==
X-Received: by 2002:a63:e22:: with SMTP id d34mr39717983pgl.251.1556299469717; 
	Fri, 26 Apr 2019 10:24:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:11 -0700
Message-Id: <20190426172421.27133-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PULL 05/15] tcg/i386: Support INDEX_op_extract2_{i32,
 i64}
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172411.euwqXLM7XdnPLmC7IUbJY-ryH_VW8-hMMYuekOfDimo@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  4 ++--
 tcg/i386/tcg-target.inc.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2c58eaa9ed..241bf19413 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -124,7 +124,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -163,7 +163,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e0670e5098..1fa833840e 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -452,6 +452,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_SHUFPS      (0xc6 | P_EXT)
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
+#define OPC_SHRD_Ib     (0xac | P_EXT)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
 #define OPC_UD2         (0x0b | P_EXT)
@@ -2587,6 +2588,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    OP_32_64(extract2):
+        /* Note that SHRD outputs to the r/m operand.  */
+        tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
+        tcg_out8(s, args[3]);
+        break;
+
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2845,6 +2852,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_0 = { .args_ct_str = { "r", "0" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_re = { .args_ct_str = { "r", "r", "re" } };
+    static const TCGTargetOpDef r_0_r = { .args_ct_str = { "r", "0", "r" } };
     static const TCGTargetOpDef r_0_re = { .args_ct_str = { "r", "0", "re" } };
     static const TCGTargetOpDef r_0_ci = { .args_ct_str = { "r", "0", "ci" } };
     static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
@@ -2970,6 +2978,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return &r_r;
+    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2_i64:
+        return &r_0_r;
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-- 
2.17.1



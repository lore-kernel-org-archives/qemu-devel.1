Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2781DC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31E5207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svIfdfGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31E5207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulqx-0004Ci-51
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 18:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloO-0008LW-2m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloM-0007al-Rk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:22:56 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuloM-0007aG-M4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:22:54 -0500
Received: by mail-pl1-x644.google.com with SMTP id g6so2024973plp.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cQhgygH4bfZwxR3NyGM41BM8azlcJTXClsEEe4Z5yDA=;
 b=svIfdfGxzZjrQc9r73XIU1tmARm1Kiahm3975LpZai4h7EIG/AORsfvamIxLtgedly
 RcTI2q1Da4imcJxzruXBENPeugIBkiljE/9JZFCWM8b2pDmVjfiiI7FQoGK3jCOLVMj1
 8XSM6MNBUWF0ZDwclQezhS4tpJvSdd4XDDLmSxhqWg0SOarRpW/zbiNfE4d0VrkUQ1ww
 6e/d07gYHBV7k8NiVaAhqXSGAoLwLcY3i1F0fijwEC/gnhbHV8jcuXoqACPM8lmaXGmn
 0opnsvr+pmurPiOGuYH3y5A8GOgMRpzyx9RkYp2+vih6s9CzDicjb4khGIrDLYXl+phU
 byfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cQhgygH4bfZwxR3NyGM41BM8azlcJTXClsEEe4Z5yDA=;
 b=PZDpAq7HxOFRkisdWpswR/+KLvDf3nWIcaOwLwqDfXGD/m33GlZ+nu1guIYSqwot9Z
 h4xFqLA6fXTMC11RqyKAEHJ8yHEGfEzQpr+HoK7yHs82Bx2jl//vUHoEyRsLzoAGHUHK
 c6Au/whGuSrQ9v8T87CMkm2619CbR8Rxw6QaNd2YjOv+kglKlvWpERT5OjqtHfkX3lp3
 1htdgsvbOR9Ze1ciXAZHRugKtVM4XCq6GeBBaXzUa6sdV1apyPdEzilWp1FBkm1vZQyc
 /Pkcyy8oO9/uDYwFsOVwjbDQhrYGb2HoLzPOIiM1rHhkbxNW4Yk06tNLLHcMfEiERMig
 fP3A==
X-Gm-Message-State: APjAAAXAfP93xztbM0ME8xSkhI7n8fMz8BZyrzY2STtKlM52LK6obegB
 7pErgICyAAzCszCO+a7pXCb3nRcoxkQ=
X-Google-Smtp-Source: APXvYqx988qaj/4AkCChERIJL+pz0xMcZpGT5gqLzhkKBuZZeGzYyYwowsbY6j65Ssk2zp8Im/boXw==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr135700pjv.34.1579821773293; 
 Thu, 23 Jan 2020 15:22:53 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id z5sm4136008pfq.3.2020.01.23.15.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 15:22:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/s390x: Move struct DisasFields definition earlier
Date: Thu, 23 Jan 2020 13:22:44 -1000
Message-Id: <20200123232248.1800-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123232248.1800-1-richard.henderson@linaro.org>
References: <20200123232248.1800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: thuth@redhat.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will want to include the struct in DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 164 ++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 81 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b764ec3140..7ef228843a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -53,6 +53,89 @@ typedef struct DisasContext DisasContext;
 typedef struct DisasInsn DisasInsn;
 typedef struct DisasFields DisasFields;
 
+/*
+ * Define a structure to hold the decoded fields.  We'll store each inside
+ * an array indexed by an enum.  In order to conserve memory, we'll arrange
+ * for fields that do not exist at the same time to overlap, thus the "C"
+ * for compact.  For checking purposes there is an "O" for original index
+ * as well that will be applied to availability bitmaps.
+ */
+
+enum DisasFieldIndexO {
+    FLD_O_r1,
+    FLD_O_r2,
+    FLD_O_r3,
+    FLD_O_m1,
+    FLD_O_m3,
+    FLD_O_m4,
+    FLD_O_m5,
+    FLD_O_m6,
+    FLD_O_b1,
+    FLD_O_b2,
+    FLD_O_b4,
+    FLD_O_d1,
+    FLD_O_d2,
+    FLD_O_d4,
+    FLD_O_x2,
+    FLD_O_l1,
+    FLD_O_l2,
+    FLD_O_i1,
+    FLD_O_i2,
+    FLD_O_i3,
+    FLD_O_i4,
+    FLD_O_i5,
+    FLD_O_v1,
+    FLD_O_v2,
+    FLD_O_v3,
+    FLD_O_v4,
+};
+
+enum DisasFieldIndexC {
+    FLD_C_r1 = 0,
+    FLD_C_m1 = 0,
+    FLD_C_b1 = 0,
+    FLD_C_i1 = 0,
+    FLD_C_v1 = 0,
+
+    FLD_C_r2 = 1,
+    FLD_C_b2 = 1,
+    FLD_C_i2 = 1,
+
+    FLD_C_r3 = 2,
+    FLD_C_m3 = 2,
+    FLD_C_i3 = 2,
+    FLD_C_v3 = 2,
+
+    FLD_C_m4 = 3,
+    FLD_C_b4 = 3,
+    FLD_C_i4 = 3,
+    FLD_C_l1 = 3,
+    FLD_C_v4 = 3,
+
+    FLD_C_i5 = 4,
+    FLD_C_d1 = 4,
+    FLD_C_m5 = 4,
+
+    FLD_C_d2 = 5,
+    FLD_C_m6 = 5,
+
+    FLD_C_d4 = 6,
+    FLD_C_x2 = 6,
+    FLD_C_l2 = 6,
+    FLD_C_v2 = 6,
+
+    NUM_C_FIELD = 7
+};
+
+struct DisasFields {
+    uint64_t raw_insn;
+    unsigned op:8;
+    unsigned op2:8;
+    unsigned presentC:16;
+    unsigned int presentO;
+    int c[NUM_C_FIELD];
+};
+
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
@@ -1005,87 +1088,6 @@ typedef enum {
 #undef F5
 #undef F6
 
-/* Define a structure to hold the decoded fields.  We'll store each inside
-   an array indexed by an enum.  In order to conserve memory, we'll arrange
-   for fields that do not exist at the same time to overlap, thus the "C"
-   for compact.  For checking purposes there is an "O" for original index
-   as well that will be applied to availability bitmaps.  */
-
-enum DisasFieldIndexO {
-    FLD_O_r1,
-    FLD_O_r2,
-    FLD_O_r3,
-    FLD_O_m1,
-    FLD_O_m3,
-    FLD_O_m4,
-    FLD_O_m5,
-    FLD_O_m6,
-    FLD_O_b1,
-    FLD_O_b2,
-    FLD_O_b4,
-    FLD_O_d1,
-    FLD_O_d2,
-    FLD_O_d4,
-    FLD_O_x2,
-    FLD_O_l1,
-    FLD_O_l2,
-    FLD_O_i1,
-    FLD_O_i2,
-    FLD_O_i3,
-    FLD_O_i4,
-    FLD_O_i5,
-    FLD_O_v1,
-    FLD_O_v2,
-    FLD_O_v3,
-    FLD_O_v4,
-};
-
-enum DisasFieldIndexC {
-    FLD_C_r1 = 0,
-    FLD_C_m1 = 0,
-    FLD_C_b1 = 0,
-    FLD_C_i1 = 0,
-    FLD_C_v1 = 0,
-
-    FLD_C_r2 = 1,
-    FLD_C_b2 = 1,
-    FLD_C_i2 = 1,
-
-    FLD_C_r3 = 2,
-    FLD_C_m3 = 2,
-    FLD_C_i3 = 2,
-    FLD_C_v3 = 2,
-
-    FLD_C_m4 = 3,
-    FLD_C_b4 = 3,
-    FLD_C_i4 = 3,
-    FLD_C_l1 = 3,
-    FLD_C_v4 = 3,
-
-    FLD_C_i5 = 4,
-    FLD_C_d1 = 4,
-    FLD_C_m5 = 4,
-
-    FLD_C_d2 = 5,
-    FLD_C_m6 = 5,
-
-    FLD_C_d4 = 6,
-    FLD_C_x2 = 6,
-    FLD_C_l2 = 6,
-    FLD_C_v2 = 6,
-
-    NUM_C_FIELD = 7
-};
-
-struct DisasFields {
-    uint64_t raw_insn;
-    unsigned op:8;
-    unsigned op2:8;
-    unsigned presentC:16;
-    unsigned int presentO;
-    int c[NUM_C_FIELD];
-};
-
 /* This is the way fields are to be accessed out of DisasFields.  */
 #define have_field(S, F)  have_field1((S), FLD_O_##F)
 #define get_field(S, F)   get_field1((S), FLD_O_##F, FLD_C_##F)
-- 
2.20.1



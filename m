Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52628C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C7B2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDxptqFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C7B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxYs-0001DW-7v
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWb-0002j3-2v
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWa-00057t-3a
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:04 -0400
Received: by mail-pl1-x644.google.com with SMTP id q16so3822938plr.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QZjvdmBYYHmi+JAXhLPT2G2PqWOdLYnmeKZkQvZb7ek=;
 b=FDxptqFJysnUoaUeN8EOXWdN82ANKTymZV4rhaBjDEs/EPCoMSjOAsKYEi08MoYxct
 spNydnPRl7fyu00l2oaXoV0oqqOFUMm85/Kong5rpMFE7YHKabRjdRypzAe8zV/eJUxy
 U+r20sb/JMyiOaFpgNkDX5vGnsKx/zkawXm++GfMlT/GnV5uYX6SaFPVnxNnyz2DeWxk
 h2miMfzALhCnozsGDDjw3+7poOvBONA2R73uhF2VUZTlq+37Sg+upAYO60RD9Mnh3Jjq
 OuDFxex89P9+vJSaKjW/UOdAYCdbVTi3wVFmI4us4VsT9XAYP6iA3Y0dZIucMN4QYJrY
 eTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QZjvdmBYYHmi+JAXhLPT2G2PqWOdLYnmeKZkQvZb7ek=;
 b=WSVauLiTJkwV+t2tbKtKixg9SmoXdbXOulIyg3/vEt8yYiWgSyV6/oByfhHvrDs31g
 bDZSRcLgfjzwwtnCkC7phDJBuzZHhkq8gTHDjxo4YDDoMqxVX7pFcYV0jX9dKgZXYS1J
 /nvEkQoYUwzC72DeQG6uBEsT7dXLbi+ZXaW7bBUIHWuXlNWzV8ZNhmNSuU8kjbn/LDMe
 9zMU0vVeeOFs9e9P1hFr8VMxg9u7esFfA2i8VFq6Mm3kVMrsGyiGH95rcqNV5CMdFQty
 yYHKYyPeWXO+eCpSLRTvcKCDyA23I4zgvbYUvl9yKg+BEtdx7lgABepFou94pwFKVKDO
 kk/Q==
X-Gm-Message-State: AOAM5335q/0HurI4u3NFH74NJUU4EzTI2boUAkDWNA4F2BP1AZniRmQt
 tTS3TN1H6pyl6blIpV1I4pArXGT6fdc=
X-Google-Smtp-Source: ABdhPJyjA1gt4zWnTa13cMdu1SaIGYiWw1lMKT3M8KX47B0eci2ZttLAwbfM7GCWHkbxroP/JTN1LQ==
X-Received: by 2002:a17:902:b206:: with SMTP id
 t6mr12690295plr.248.1590114902429; 
 Thu, 21 May 2020 19:35:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/25] Split out recv_register_info
Date: Thu, 21 May 2020 19:34:31 -0700
Message-Id: <20200522023440.26261-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

We will want to share this code when dumping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 50 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/risu.c b/risu.c
index b91ad38..80bc3b1 100644
--- a/risu.c
+++ b/risu.c
@@ -166,6 +166,34 @@ static void master_sigill(int sig, siginfo_t *si, void *uc)
     }
 }
 
+static RisuResult recv_register_info(struct reginfo *ri)
+{
+    RisuResult res;
+
+    res = read_buffer(&header, sizeof(header));
+    if (res != RES_OK) {
+        return res;
+    }
+
+    /* send OK for the header */
+    respond(RES_OK);
+
+    switch (header.risu_op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    case OP_SIGILL:
+        return read_buffer(ri, reginfo_size());
+    case OP_COMPAREMEM:
+        return read_buffer(other_memblock, MEMBLOCKLEN);
+    case OP_SETMEMBLOCK:
+    case OP_GETMEMBLOCK:
+        return RES_OK;
+    default:
+        /* TODO: Create a better error message. */
+        return RES_BAD_IO;
+    }
+}
+
 static RisuResult recv_and_compare_register_info(void *uc)
 {
     uint64_t paramreg;
@@ -173,33 +201,26 @@ static RisuResult recv_and_compare_register_info(void *uc)
     RisuOp op;
 
     reginfo_init(&ri[APPRENTICE], uc);
-    op = get_risuop(&ri[APPRENTICE]);
 
-    res = read_buffer(&header, sizeof(header));
+    res = recv_register_info(&ri[MASTER]);
     if (res != RES_OK) {
+        /* I/O error.  Tell master to exit. */
+        respond(RES_END);
         return res;
     }
 
+    op = get_risuop(&ri[APPRENTICE]);
     if (header.risu_op != op) {
         /* We are out of sync.  Tell master to exit. */
         respond(RES_END);
         return RES_BAD_IO;
     }
 
-    /* send OK for the header */
-    respond(RES_OK);
-
     switch (op) {
     case OP_COMPARE:
     case OP_TESTEND:
     case OP_SIGILL:
-        /* Do a simple register compare on (a) explicit request
-         * (b) end of test (c) a non-risuop UNDEF
-         */
-        res = read_buffer(&ri[MASTER], reginfo_size());
-        if (res != RES_OK) {
-            /* fail */
-        } else if (!reginfo_is_eq(&ri[MASTER], &ri[APPRENTICE])) {
+        if (!reginfo_is_eq(&ri[MASTER], &ri[APPRENTICE])) {
             /* register mismatch */
             res = RES_MISMATCH_REG;
         } else if (op == OP_TESTEND) {
@@ -216,10 +237,7 @@ static RisuResult recv_and_compare_register_info(void *uc)
         set_ucontext_paramreg(uc, paramreg + (uintptr_t)memblock);
         break;
     case OP_COMPAREMEM:
-        res = read_buffer(other_memblock, MEMBLOCKLEN);
-        if (res != RES_OK) {
-            /* fail */
-        } else if (memcmp(memblock, other_memblock, MEMBLOCKLEN) != 0) {
+        if (memcmp(memblock, other_memblock, MEMBLOCKLEN) != 0) {
             /* memory mismatch */
             res = RES_MISMATCH_MEM;
         }
-- 
2.20.1



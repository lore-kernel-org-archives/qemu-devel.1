Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A38C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1952063F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaJwSGhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1952063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5dI-0004k7-12
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0006HW-3q
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Db-0000D4-Os
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:24 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:34554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Db-0000Ae-2D
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:23 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n126so305402ywf.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1bzHpiZ6FFENFVSOkmr62QPa02e2ssd1mMO1ztS9NeI=;
 b=QaJwSGhRzeOR7h3B8V+6WbA0rM1/GzSwpdVLvhKS8/eikRAzm9qo9oiRg0iA65aQ9n
 lOGU+2MpeI3u2h4SBZl5AfIomUMxL11oQjri49Ew64gauYeq1ZGPtGbszQOTCXodG6W8
 juMRWEE/CfQGEWBccSeYGEAqZAvLIpafM74ua2UnmtBn0DTppCxi3LrU+XEotm5MAF4U
 2KTdKpB0RSxFBBEa+4g+ie8DOihlXSgbr3c2yeAm2X1qLeX0ebiOjDzz/Km7u5ac0OB/
 N8OSTyip4xicrdlC3kmasgq5DDGnhPS8HzUBJIaiFZtN7Wcsc/nFhntk8d4eQOJBmw17
 4TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1bzHpiZ6FFENFVSOkmr62QPa02e2ssd1mMO1ztS9NeI=;
 b=kxGheIjSoreh1q529xSykc3xmFD6lubLC0PJhHtvZR9hbMspL9HBz1Nq3HhU25zDP1
 MYadDindWjXTOnO7SSbBopbyMZjh5bgOjHlQmanxYwLpaDEIJ3L2MrLsEABWcgEFJMZU
 UUvpJedd4kviANunFR+Pwbd0tGqIFPeBiW2Rq8ElOqSM+8Fe7Gfdop1dALjXnmfyHaAu
 22ETByh2kfQXjyt366FTLfuf4xm+pxt4amp2oi5OOfysx+umcElnluMD376LeQQ2/ZRx
 AqcUU54/TP6utfte2NF7c4UQVgu7Zt1gV4b8ZASIbK2KOTkVkSmnXpWWGWp89ECQYfVI
 KoVw==
X-Gm-Message-State: APjAAAV2bIktJxVf3RdWkOIA7OApBwI1gBtVbaGRMXe3iUiSrelDWi6r
 AWxb7XgK3ZXd08dGhjalN4m0aMk4
X-Google-Smtp-Source: APXvYqz4sBlcJ/p1qHmii0+QgxRlqM5BbZZvaCoObx5jd/QuUeAmxKn1cQM0/awX0irBYkmkOK3s3A==
X-Received: by 2002:a81:31cc:: with SMTP id x195mr1571820ywx.390.1565835021226; 
 Wed, 14 Aug 2019 19:10:21 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:11 -0400
Message-Id: <20190815020928.9679-30-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v3 29/46] target/i386: introduce H*, V*, U*,
 W* (SSE/AVX) operands
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These address the SSE/AVX-technology register file. Offset of the
entire corresponding register is passed as the operand value,
regardless of operand-size suffix.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 117 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index bd3c7f9356..69233fd0f8 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4930,6 +4930,7 @@ DEF_INSNOP_ALIAS(Mb, M)
 DEF_INSNOP_ALIAS(Mw, M)
 DEF_INSNOP_ALIAS(Md, M)
 DEF_INSNOP_ALIAS(Mq, M)
+DEF_INSNOP_ALIAS(Mhq, M)
 DEF_INSNOP_ALIAS(Mdq, M)
 DEF_INSNOP_ALIAS(Mqq, M)
 
@@ -5090,6 +5091,122 @@ INSNOP_LDST(mm_t0, Mq)
     }
 }
 
+/*
+ * SSE/AVX-technology registers
+ */
+#define DEF_INSNOP_XMM(opT, opTxmmid)                                   \
+    typedef unsigned int insnop_arg_t(opT);                             \
+    typedef struct {                                                    \
+        insnop_ctxt_t(opTxmmid) xmmid;                                  \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        return insnop_init(opTxmmid)(&ctxt->xmmid, env, s, modrm, is_write); \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        const insnop_arg_t(opTxmmid) xmmid =                            \
+            insnop_prepare(opTxmmid)(&ctxt->xmmid, env, s, modrm, is_write); \
+        const insnop_arg_t(opT) arg =                                   \
+            offsetof(CPUX86State, xmm_regs[xmmid]);                     \
+        insnop_finalize(opTxmmid)(&ctxt->xmmid, env, s,                 \
+                                  modrm, is_write, xmmid);              \
+        return arg;                                                     \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+    }
+
+typedef unsigned int insnop_arg_t(xmm_t0);
+typedef struct {} insnop_ctxt_t(xmm_t0);
+
+INSNOP_INIT(xmm_t0)
+{
+    return 0;
+}
+INSNOP_PREPARE(xmm_t0)
+{
+    return offsetof(CPUX86State, xmm_t0);
+}
+INSNOP_FINALIZE(xmm_t0)
+{
+}
+
+DEF_INSNOP_XMM(V, modrm_reg)
+DEF_INSNOP_ALIAS(Vd, V)
+DEF_INSNOP_ALIAS(Vq, V)
+DEF_INSNOP_ALIAS(Vdq, V)
+DEF_INSNOP_ALIAS(Vqq, V)
+
+DEF_INSNOP_XMM(U, modrm_rm_direct)
+DEF_INSNOP_ALIAS(Ud, U)
+DEF_INSNOP_ALIAS(Uq, U)
+DEF_INSNOP_ALIAS(Udq, U)
+DEF_INSNOP_ALIAS(Uqq, U)
+
+DEF_INSNOP_XMM(H, vex_v)
+DEF_INSNOP_ALIAS(Hd, H)
+DEF_INSNOP_ALIAS(Hq, H)
+DEF_INSNOP_ALIAS(Hdq, H)
+DEF_INSNOP_ALIAS(Hqq, H)
+
+DEF_INSNOP_LDST(MUd, xmm_t0, Md)
+DEF_INSNOP_LDST(MUq, xmm_t0, Mq)
+DEF_INSNOP_LDST(MWdq, xmm_t0, Mdq)
+DEF_INSNOP_LDST(MUdqMhq, xmm_t0, Mhq)
+DEF_INSNOP_EITHER(Wd, Ud, MUd)
+DEF_INSNOP_EITHER(Wq, Uq, MUq)
+DEF_INSNOP_EITHER(Wdq, Udq, MWdq)
+DEF_INSNOP_EITHER(UdqMq, Udq, MUq)
+DEF_INSNOP_EITHER(UdqMhq, Udq, MUdqMhq)
+
+INSNOP_LDST(xmm_t0, Md)
+{
+    const insnop_arg_t(xmm_t0) ofs =
+        offsetof(ZMMReg, ZMM_L(0));
+
+    assert(ptr == s->A0);
+    if (is_write) {
+        gen_std_env_A0(s, arg + ofs);
+    } else {
+        gen_ldd_env_A0(s, arg + ofs);
+    }
+}
+INSNOP_LDST(xmm_t0, Mq)
+{
+    const insnop_arg_t(xmm_t0) ofs =
+        offsetof(ZMMReg, ZMM_Q(0));
+
+    assert(ptr == s->A0);
+    if (is_write) {
+        gen_stq_env_A0(s, arg + ofs);
+    } else {
+        gen_ldq_env_A0(s, arg + ofs);
+    }
+}
+INSNOP_LDST(xmm_t0, Mdq)
+{
+    assert(ptr == s->A0);
+    if (is_write) {
+        gen_sto_env_A0(s, arg);
+    } else {
+        gen_ldo_env_A0(s, arg);
+    }
+}
+INSNOP_LDST(xmm_t0, Mhq)
+{
+    const insnop_arg_t(xmm_t0) ofs =
+        offsetof(ZMMReg, ZMM_Q(1));
+
+    assert(ptr == s->A0);
+    if (is_write) {
+        gen_stq_env_A0(s, arg + ofs);
+    } else {
+        gen_ldq_env_A0(s, arg + ofs);
+    }
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1



Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA635C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B727520838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y17WVTPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85rB-0000fg-9j
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i85ok-0006Uz-6l
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i85oi-00049C-QC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i85oi-00048I-Gj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so25347459wrx.5
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tZDnbxA1tgGLPJyp4aIprnZlr8V2xMzpBpOE4T56/8w=;
 b=Y17WVTPun+N4PRztWH+extypyyVdJPmbUNah1P0oJfeHqU4Z00Nhw8yzyg0uqEFuX5
 ZkayqUlmWFN49PTu5XGU6gADk2sDPotyCrQG+2ekI2bTO22G+HrJYg6NyieHRTF07C1m
 4bJe6c5TpH6CpdHyNw/Lp7yAMdOiQs+3q0NyQdm2e+FLIlNQUz3rVFEr3VBNc/DHI0WS
 qsNGbcrQHM1EXrExtRIl1B1aovQGVJISb1f+YJY420MoWZ01AEKwbQb8OmfUv8Ad77lC
 /TIIbMHT68SBSFfrthdC/QUjouYOtFBCF0O2YHNwPMTZM4dIZurR8MoGZHlj2CGdfe7P
 dHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tZDnbxA1tgGLPJyp4aIprnZlr8V2xMzpBpOE4T56/8w=;
 b=sE54ckU1EqODDrVAEeoMBOQzizLeF2SavDxrtju6g+O+2feY9/aIgfNdJOX2/UXUkn
 cTsTZo2QCLeCjpgP1+SbA+9gZQhj+sBH44A/vNvOY0xaulQrH8L38DwsieFl8yO6F4yx
 9sVfc8BmSV05W7sIaoidFfBfqFI9cL0ITgFoLTaxe+Kd6vRQsB1vKCxojkxsiPqoVh43
 JBIKBZK5Kd0s9nCoUQbHTK5jHczaoWzP65bCK7bRLhhJWzaIH6RxzKfjRU08gPbBhI7a
 CnENIMFFJn3FnoCycnaJmKWBwvgv4EODjAw9oCWGJ/gfNsDFeJtI+EFroU1NxRxYrsX0
 N4AA==
X-Gm-Message-State: APjAAAX54q1uabToqhk8FVB8ORz+AzySTj3Zqt0wIuYQ+i0eaWrSQMsl
 +DVZIUP6HgTn61l5/dxkyJge6g==
X-Google-Smtp-Source: APXvYqyvI8VO4e9zppW4DbGjygOaGOwIQeFDmeq4Yg4s0AgousohfSSm/OuBHSZXzpSShlyaAQu7hw==
X-Received: by 2002:adf:e704:: with SMTP id c4mr32984788wrm.283.1568220603391; 
 Wed, 11 Sep 2019 09:50:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r20sm28709817wrg.61.2019.09.11.09.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 09:50:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71E451FF90;
 Wed, 11 Sep 2019 17:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 11 Sep 2019 17:49:57 +0100
Message-Id: <20190911164959.11003-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190911164959.11003-1-alex.bennee@linaro.org>
References: <20190911164959.11003-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v5 3/5] target/arm: handle A-profile
 semihosting at translate time
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - update for change to gen_exception_internal_insn API
v3
  - update for decode tree, merge T32 & A32 commits
  - dropped r-b due to changes
v4
  - !IS_USER and !arm_dc_feature(s, ARM_FEATURE_M)
v5
  - only if !IS_USER for softmmu, linux-user is still allowed
---
 target/arm/translate.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6689acc911e..fac791c4b06 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10219,14 +10219,25 @@ static bool trans_CBZ(DisasContext *s, arg_CBZ *a)
 }
 
 /*
- * Supervisor call
+ * Supervisor call - both T32 & A32 come here so we need to check
+ * which mode we are in when checking for semihosting.
  */
 
 static bool trans_SVC(DisasContext *s, arg_SVC *a)
 {
-    gen_set_pc_im(s, s->base.pc_next);
-    s->svc_imm = a->imm;
-    s->base.is_jmp = DISAS_SWI;
+    const uint32_t semihost_imm = s->thumb ? 0xab : 0x123456;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M) && semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        !IS_USER(s) &&
+#endif
+        (a->imm == semihost_imm)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+    } else {
+        gen_set_pc_im(s, s->base.pc_next);
+        s->svc_imm = a->imm;
+        s->base.is_jmp = DISAS_SWI;
+    }
     return true;
 }
 
-- 
2.20.1



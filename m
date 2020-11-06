Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F611C5517A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E064820A8B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hq4/9sLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E064820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasdL-0006Yv-IW
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRt-0005SS-HQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:05 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRr-00074Z-PA
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:01 -0500
Received: by mail-pl1-x642.google.com with SMTP id k7so30214plk.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0nOzDi9GCulBBSiNGVZiKYWH3fm6VYqbKdWJcIsxfhQ=;
 b=Hq4/9sLPxHok2kFbCEfNYXfwEG4m3JZgJs6Vcx0FHPFS1NqxxQkae0il1LHcVrUsu8
 vPeE6ga+uMS5OvP8WpgDS/Vj6fjxRNkyMqinFtuuppfqiuQDEQoW5WwWq6o+mCdfLA4t
 23EMm//HV2mgj49il1uYc1JTPjILYE+nVJR0K0gD4PY7Mnxrh103VfFgt5THJEkB5r2k
 rU21+IM51PPQu8JlpX7AdrGUeAY7wjtmDcKrM4YAN9rNqOd+HcT/6RGClcKOwyh0EfjZ
 /MSNJgK7W3hweVkW9PWEC/OSF/21pjesw+eurkvEpVphBMkulomFnvGKz9fS288IyfzO
 3RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0nOzDi9GCulBBSiNGVZiKYWH3fm6VYqbKdWJcIsxfhQ=;
 b=FxjsDoxeQ4ZJeaulKnyXZpguC9tCQiMCDSHDg38lnnsMCHmq40prxKsVK6thWi1DDQ
 3vNccbGeGIGn/NtaLWI/psBeCNczlM4QD+hn88ib84pshW5Zz55ubReyB+/kCT5rVjGb
 oqIzt7xVUCrwvluUlnki3W+h9oAwwnbOw9WioneBShVohjILfjVFqqIQpY9MaQBLD2rV
 c+DDT0PreefWRZvI2VYBT8wk59LcnhCL7NxLTBsn9AeSnuVS0FdKCXYarPQpc9g7eBKe
 HBY3REZCFKPpiSHlUa2z947aq9IMwkrPPfsmBCfGichKswiq+Wg5rcNbHzvmNhehau8i
 hJTw==
X-Gm-Message-State: AOAM532CTgijFqx0ifDCYoVSE3kgoiBCNLFEcuthBy7WpNG46gcO0Vmo
 2azB+J5rs2BMMy13NalVZD0jfu7LpghneQ==
X-Google-Smtp-Source: ABdhPJxx6m/bAg9EHhnK32sHRVM9jigANIfpJdy197L4XpeKxWvAoCV89p8X6JXqKncYq8IybpuVHA==
X-Received: by 2002:a17:902:9f86:b029:d6:d25f:7ad8 with SMTP id
 g6-20020a1709029f86b02900d6d25f7ad8mr136493plq.4.1604633398094; 
 Thu, 05 Nov 2020 19:29:58 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/41] tcg/ppc: Use tcg_tbrel_diff
Date: Thu,  5 Nov 2020 19:29:05 -0800
Message-Id: <20201106032921.600200-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use tcg_tbrel_diff when we need a displacement to a label,
and with a NULL argument when we need the normalizing addend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bc0057eedf..dc90705d02 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -837,7 +837,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Load addresses within the TB with one insn.  */
-    tb_diff = arg - (intptr_t)s->code_gen_ptr;
+    tb_diff = tcg_tbrel_diff(s, (void *)arg);
     if (!in_prologue && USE_REG_TB && tb_diff == (int16_t)tb_diff) {
         tcg_out32(s, ADDI | TAI(ret, TCG_REG_TB, tb_diff));
         return;
@@ -890,7 +890,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     /* Use the constant pool, if possible.  */
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
-                       -(intptr_t)s->code_gen_ptr);
+                       tcg_tbrel_diff(s, NULL));
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
@@ -940,7 +940,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
      */
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
-        add = -(intptr_t)s->code_gen_ptr;
+        add = tcg_tbrel_diff(s, NULL);
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
-- 
2.25.1



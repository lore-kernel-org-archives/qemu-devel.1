Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A74C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65792083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5mO9wtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65792083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVa4-0001C6-P9
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTz-0003oR-A4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:19 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTx-0001zH-M1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:18 -0400
Received: by mail-oi1-x244.google.com with SMTP id 26so6169955ois.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iyDgOefakgRBrjZznHAuamMZUpzKL16pwL2bnPHHK48=;
 b=A5mO9wtfs/osS0/64tyJ0M2N0oIvR06pB+X7+t8AFVp4fAqam2/wK2HdMpADmiyM9T
 A97VoElYKntSmGxEtUS+qpohYUVUPd4YvvSCuoKtysLsElJssYWiZ13yN3dzL4FNb0SL
 TSi3Rhz+LIIdIlxvd9ew7qTTopHdcfUOeWlo6Uh7AipK8cCTorUJoIwTp5MZcws/rF2C
 Tc33V2fxBEvWXD5eHHwyf6Fb1VUKGqX6b/4FfxnupR/b7KFb/27WUrqoLSUU987+ETZb
 jbbqxRChZjgMT6Drb4vxxYCpQtX5hZ4HhLgcUYzp1+7TvoYeGI6LeOA20OWHemAIQqT8
 57zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iyDgOefakgRBrjZznHAuamMZUpzKL16pwL2bnPHHK48=;
 b=YyQVGtdENT1D7yoAHECLokIM5rnxySZOxjGvap6tJboasfk5I4GAuyjdPlucrtJ2gf
 VEOI1TEXwHxtErSihS6Zf02P5LLTvZFkCDOuUuGaMqZvGqXSlddKJmAsUAXmpMpqWhe3
 ySAGLN53/fZ5F3HqLaulq08kZcR5xRnd/MNFTphtbWDcqfkd0PZfhVrrt1NV/O+8K56Q
 JyA10a+yCW7mlH7Uy5sNUTCHiMMNexYKIrKj/g7jncDJ1sP+T+hXvb6vRv/6I0HcEDKW
 6TN5C6EAz9AVOvddGlM1TQ4/j2UnHSr309NHPSDjB+6+81KHy89W4KOpTI3llIlCyMVn
 l4dA==
X-Gm-Message-State: AOAM530VGv/vWImrfn37EEo0rzuvTKBasAmRPe4sVj0JGHLeK3eFNeHp
 8zrHN7zWIsZ0XpyOUZSM6nL0OUlMo/60CDvk
X-Google-Smtp-Source: ABdhPJzxc6u4wNoKhuZRKznByAsRs9I9zo5M5wZFEYf3CBazDXLSW6FWiXHtdW1Fd9cL2DTC7FWCzg==
X-Received: by 2002:aca:ef03:: with SMTP id n3mr4956311oih.67.1602161836191;
 Thu, 08 Oct 2020 05:57:16 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] tcg: Fix generation of dupi_vec for 32-bit host
Date: Thu,  8 Oct 2020 07:56:56 -0500
Message-Id: <20201008125659.49857-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The definition of INDEX_op_dupi_vec is that it operates on
units of tcg_target_ulong -- in this case 32 bits.  It does
not work to use this for a uint64_t value that happens to be
small enough to fit in tcg_target_ulong.

Fixes: d2fd745fe8b
Fixes: db432672dc5
Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ed6fb55fe1..cdbf11c573 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -252,10 +252,10 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
 
 void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
 {
-    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
-        do_dupi_vec(r, MO_32, a);
-    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
+    if (TCG_TARGET_REG_BITS == 64) {
         do_dupi_vec(r, MO_64, a);
+    } else if (a == dup_const(MO_32, a)) {
+        do_dupi_vec(r, MO_32, a);
     } else {
         TCGv_i64 c = tcg_const_i64(a);
         tcg_gen_dup_i64_vec(MO_64, r, c);
@@ -280,7 +280,11 @@ void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
 
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    if (vece == MO_64) {
+        tcg_gen_dup64i_vec(r, a);
+    } else {
+        do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    }
 }
 
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
-- 
2.25.1



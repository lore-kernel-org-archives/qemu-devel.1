Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BA0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099202064B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qp12gmfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099202064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8WV-0003bK-6G
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83i-0008Dv-Et
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83g-0006DA-ML
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z4so1987426wrr.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nIzuYGz7q/BjMjnaGZYlU6EoT8dPI9fWBVpOfpEF2ck=;
 b=qp12gmfo+WkhICtoXVqcDjAZDj52psvYtOOGr9U2wpXzEf7yOZ8AB7QCTxQqq3HPNI
 +IaRNsKnAz4/2u+jRpj5ONjB054sIJV++hSY6PI3btZGjrGXNGp4P1RaukOxSdI9cy6P
 BlPq4GXPmq+Qf/eOFxBukngO5lEEl13EFGL+kUsTw9EPcQcSjRhi07A+EEIn1ygHPpg/
 56JlVhRHfN0rwFPmYK0gnJwk+jHcJBdmuqa9kv5+aodGJHZ2n5JbviReUXvIhEE22VT4
 6a9EU2wQfSjHfV1YXkp519cMjGUf8ryonRgnKJ2nviFhy2OREPi1gPB0nuDUzTCkNWTL
 0iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nIzuYGz7q/BjMjnaGZYlU6EoT8dPI9fWBVpOfpEF2ck=;
 b=oY4/Mk1C+gVpx9x01qqHaFB9FjUbWjUoNBgmnvnZOMwaDJklSw6Tmo9t7R3+8SJBoQ
 E+mXgbNGAJWTgZoDyxbAa3pLy3etT9BnwQhEkz3RO17fLl9BGBk0y+awf6SjybVy2TRk
 agO4A4OjHd7K1j3efV8VJT7Xa/2lEJlX0EEsEg1p5XJQu/5l/9XXjPW5giv2I9zxSlAd
 wlorI3U2Zgj2gPLSBxSp8QF1Rc0fI0FufvLsUKjL6Z96RC3/HdF8syXXVxnaCObAV6nH
 poQUdZmT2fu6RAbrLa0l/nPDxyv23AMyrqwQ31obRl0yLcT/5sccmclVUsdwg4vbtpv8
 EFZA==
X-Gm-Message-State: AOAM531LDuMbxxKt8NCT0DuKnLCgEXlUAGcP36ejLAWE/J1cXp75RWVb
 YRlK++bs/m/2A3sOga6hbLMwonB8dbh4TtAN
X-Google-Smtp-Source: ABdhPJyv4WvLrNAV4E0mKXmlZ31fyFpv9AnIDvSMhdkTeyzYzkUJH6MPum2wGfgLJlx8Fy8LNkMYYw==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr2578903wrn.2.1598973530782;
 Tue, 01 Sep 2020 08:18:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/47] target/arm: Implement new VFP fp16 insn VINS
Date: Tue,  1 Sep 2020 16:17:55 +0100
Message-Id: <20200901151823.29785-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fp16 extension includes a new instruction VINS, which copies the
lower 16 bits of a 32-bit source VFP register into the upper 16 bits
of the destination.  Implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-20-peter.maydell@linaro.org
---
 target/arm/vfp-uncond.decode   |  3 +++
 target/arm/translate-vfp.c.inc | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 9615544623a..39dc8f6373a 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -74,3 +74,6 @@ VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
             vm=%vm_sp vd=%vd_sp sz=2
 VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
             vm=%vm_dp vd=%vd_sp sz=3
+
+VINS        1111 1110 1.11 0000 .... 1010 11 . 0 .... \
+            vd=%vd_sp vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 7ce044fa896..bda3dd25136 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3454,3 +3454,31 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
 
     return false;
 }
+
+static bool trans_VINS(DisasContext *s, arg_VINS *a)
+{
+    TCGv_i32 rd, rm;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (s->vec_len != 0 || s->vec_stride != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* Insert low half of Vm into high half of Vd */
+    rm = tcg_temp_new_i32();
+    rd = tcg_temp_new_i32();
+    neon_load_reg32(rm, a->vm);
+    neon_load_reg32(rd, a->vd);
+    tcg_gen_deposit_i32(rd, rd, rm, 16, 16);
+    neon_store_reg32(rd, a->vd);
+    tcg_temp_free_i32(rm);
+    tcg_temp_free_i32(rd);
+    return true;
+}
-- 
2.20.1



Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39795C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DEF20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chYVmqbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DEF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhR5-00046G-7O
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGt-0002e0-GL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGr-0003CF-MB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id q5so7772664wru.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=atbuaNCQdYY84+MOuxQ6o76AKw2wUTKV2kwqEbNgCzQ=;
 b=chYVmqbe3T6vUaGNE3PUksF8A3j9SLTIP1MLiTf+GOAch10FN1KIPk4EMJ3sFXNLfF
 8RYRcmo8h4kJ+RXkDo1q45VUBw5JxDgG1JllwSqsUmbTiysuqw16gNs4W+hfZAxoGWUO
 HN7P6MURtvPWJvYBolWY/gpxm/h4Skw71j0lJx0P2AiVy9QJLCShZRVhM+WykJnc5CSL
 j6Jat+febKc4iIFN1BCy9ceL5pnsRAITQoySxzSQIe36i5la8OULG47jQXcSiI8TFaTC
 yYypLvSLuMKCZB1lSqaVESnz9UlACfZJ+BjzdqEGmYU+cwGaQ229YtNtDUvpJyoCVC9w
 HHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=atbuaNCQdYY84+MOuxQ6o76AKw2wUTKV2kwqEbNgCzQ=;
 b=sE8atJsz8CDho0WjPNidH6BWT1LDmNeGmWMWL9PYPMVciztc+zDJFGyrNdtLJ5Dq0Z
 BYfeCb4nlVhnyU/B6RMMctZL3bAW8C1rD0/4iSOa/DOVLH6jnnJ0Rfrpakh5+1EbLkFI
 qsg3wB4TSgg/piyrQxGbvpkoDYaqGoGFRW693yefDPfyQZSj2RgupbwR2f18Fct4vwtq
 ThNQybNPLhiOyLhiS+k2xuC0u7NtNdaSYxVKuMoqKwd2aVerf+SK3VHzp2twOMaGSt/R
 xW9LO58MGdubuHlmxpT/C6ZIvVUVn1i+uxFow8mCtmNLprGpXlNPRUo3yffptBG0CIZ/
 KwTg==
X-Gm-Message-State: AOAM532T8ahrIc/LWdAHmttoGPvhYi4u3sLofE+xH+RQNJmTnt14p0F9
 5gTP4C+ZiZfxhFcI0DFtkdR1ER4ZWsQfjQ==
X-Google-Smtp-Source: ABdhPJwGMupc3Rv91569St4ISblYlbxywAM+b2/yUrogNCK+YjuZWF7tAwv33iQ76+0zTzmBHaGsWQ==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr24881220wrw.260.1592912360080; 
 Tue, 23 Jun 2020 04:39:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/42] target/arm: Fix capitalization in NeonGenTwo{Single,
 Double}OPFn typedefs
Date: Tue, 23 Jun 2020 12:38:34 +0100
Message-Id: <20200623113904.28805-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

All the other typedefs like these spell "Op" with a lowercase 'p';
remane the NeonGenTwoSingleOPFn and NeonGenTwoDoubleOPFn typedefs to
match.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-11-peter.maydell@linaro.org
---
 target/arm/translate.h          | 4 ++--
 target/arm/translate-a64.c      | 4 ++--
 target/arm/translate-neon.inc.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 35218b3fdf1..467c5291101 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -372,8 +372,8 @@ typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
 typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
-typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
-typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
+typedef void NeonGenTwoSingleOpFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+typedef void NeonGenTwoDoubleOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7cb5fbfba80..12040984981 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9534,7 +9534,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         TCGv_i64 tcg_op = tcg_temp_new_i64();
         TCGv_i64 tcg_zero = tcg_const_i64(0);
         TCGv_i64 tcg_res = tcg_temp_new_i64();
-        NeonGenTwoDoubleOPFn *genfn;
+        NeonGenTwoDoubleOpFn *genfn;
         bool swap = false;
         int pass;
 
@@ -9576,7 +9576,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         TCGv_i32 tcg_zero = tcg_const_i32(0);
         TCGv_i32 tcg_res = tcg_temp_new_i32();
-        NeonGenTwoSingleOPFn *genfn;
+        NeonGenTwoSingleOpFn *genfn;
         bool swap = false;
         int pass, maxpasses;
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 5e2cd18bf71..c39443c8cae 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1664,7 +1664,7 @@ static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
 }
 
 static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
-                      NeonGenTwoSingleOPFn *fn)
+                      NeonGenTwoSingleOpFn *fn)
 {
     /* FP operations in 2-reg-and-shift group */
     TCGv_i32 tmp, shiftv;
-- 
2.20.1



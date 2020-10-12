Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E0C2074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHHzeoBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E0C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0H0-0001J0-LR
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzth-0003eP-Ea
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztZ-0007le-8g
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so19725826wre.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Umu4egodx5sV5t4RrajGKZ+finJTlLjjG3K3DjBGHw=;
 b=oHHzeoBV6pWWnUhrUB6FQqWoC3FfjZ+znbu9NgWwx/S2Tb93kiRZSgVJSkGAFStBDQ
 BuXxmhJCm30jJb7wXkxk5um3y4TSnYzymzhgzhtPwvopgB4cNDd1WZm/8ymaW/OfooA/
 u9aPKRId7odG/luRVoOW/AvVgaoobqrtNO0M7/DoSX9VQM6V7V9dkp4353Kt6K7WcyQL
 Y5dNhdbm5OWGJeh61eVx0uzat6YCjXVyZC8GXeI3rED8cpR7WWqWt0X6U2Z8mWbMmhYA
 0kJBgbvZxAxfSB6wp7MnfMmGTt07uBMe7PYYDf9W2l+6asEnmQMmV9pMgpt8mfdSJ563
 26Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Umu4egodx5sV5t4RrajGKZ+finJTlLjjG3K3DjBGHw=;
 b=XL59lp/cdHa8stQ+Yz+Ja2a/A9fTYImdKU/v40DZ9yzX0r2zLn8g/ZOlb1UzIfwsBL
 IvnCiVTWeXyX6FQ2p3g8+isxf92lPk6oG4d5VlCHRSjTTeBtoO92yI/Q3/jUwFvRkdwJ
 mI4sopJOSVc49lusi90Zb2can/VIoZCUBwYuuEYfzHpgqYf2KvkeGxLWNPMROG2OYQmm
 YlZ1HgRs3XCTNzETq3uEikqhWXOoozBSBrzQqtnmuzFLMEPf5iP2xg0p2ZnVI6SJhF2u
 t6oQsW4cezaKtFHqqo7B87rY1DM9SX8Nq7/uQ7VMIS9wUSw+h1Z2pHasNkcuJFfJtAiH
 GAvw==
X-Gm-Message-State: AOAM530zZ1i6Y99qIhkYlmVcl+TsmVfE/hJ5BhS7m/JFW+KIGST0GQ9g
 1y6THRQmXYkvUiH+3gKgjdxgrA==
X-Google-Smtp-Source: ABdhPJwzVOsTtPivXQrUIZKbBSEM2erYgG67mu+RivDJtcX6MpRIBVjF4XYtK/eyqTm1VvgkBiEvAw==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr30811881wrw.370.1602517071926; 
 Mon, 12 Oct 2020 08:37:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/10] target/arm: Implement v8.1M conditional-select insns
Date: Mon, 12 Oct 2020 16:37:39 +0100
Message-Id: <20201012153746.9996-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v8.1M brings four new insns to M-profile:
 * CSEL  : Rd = cond ? Rn : Rm
 * CSINC : Rd = cond ? Rn : Rm+1
 * CSINV : Rd = cond ? Rn : ~Rm
 * CSNEG : Rd = cond ? Rn : -Rm

Implement these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/t32.decode  |  3 +++
 target/arm/translate.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7069d821fde..d8454bd814e 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -90,6 +90,9 @@ SBC_rrri         1110101 1011 . .... 0 ... .... .... ....     @s_rrr_shi
 }
 RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
 
+# v8.1M CSEL and friends
+CSEL             1110101 0010 1 rn:4 10 op:2 rd:4 fcond:4 rm:4
+
 # Data-processing (register-shifted register)
 
 MOV_rxrr         1111 1010 0 shty:2 s:1 rm:4 1111 rd:4 0000 rs:4 \
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d34c1d351a6..a7923a31b56 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8224,6 +8224,61 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
     return true;
 }
 
+/* v8.1M CSEL/CSINC/CSNEG/CSINV */
+static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
+{
+    TCGv_i32 rn, rm, zero;
+    DisasCompare c;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    if (a->rd == 13 || a->rd == 15 || a->rn == 13 || a->fcond >= 14) {
+        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
+        return false;
+    }
+
+    /* In this insn input reg fields of 0b1111 mean "zero", not "PC" */
+    if (a->rn == 15) {
+        rn = tcg_const_i32(0);
+    } else {
+        rn = load_reg(s, a->rn);
+    }
+    if (a->rm == 15) {
+        rm = tcg_const_i32(0);
+    } else {
+        rm = load_reg(s, a->rm);
+    }
+
+    switch (a->op) {
+    case 0: /* CSEL */
+        break;
+    case 1: /* CSINC */
+        tcg_gen_addi_i32(rm, rm, 1);
+        break;
+    case 2: /* CSINV */
+        tcg_gen_not_i32(rm, rm);
+        break;
+    case 3: /* CSNEG */
+        tcg_gen_neg_i32(rm, rm);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    arm_test_cc(&c, a->fcond);
+    zero = tcg_const_i32(0);
+    tcg_gen_movcond_i32(c.cond, rn, c.value, zero, rn, rm);
+    arm_free_cc(&c);
+    tcg_temp_free_i32(zero);
+
+    store_reg(s, a->rd, rn);
+    tcg_temp_free_i32(rm);
+
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
-- 
2.20.1



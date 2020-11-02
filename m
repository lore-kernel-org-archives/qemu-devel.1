Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F3C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB82620657
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpg6d4CG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB82620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdS3-0000lb-LG
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLT-0000Ul-TY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLS-0006NJ-7V
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id g12so15468427wrp.10
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JwYY+dnUWGn92siUF9yWZYm92u30bUmTLinCII/ykAU=;
 b=hpg6d4CGarhwSYsLoknXiRwVJjw5j4A7JxuIb/gyxyUjoe9INUmu37ViIPfasid55R
 9CBqeJfpmhBxRI2zRsCFc0NbTSVVy5fCe6QpfU8h+RNjkm/DPGU/dFy4lRuQLWD9l6FL
 AjPvpv9dPJsZyYp0Ebkm2I69higHqPoQfW2dRA0SGk58hjd2VFFt82hZgZQvxku1YLrz
 w4//zIu3mMaKNy/GPUGo8YLyLjGEPdOLcZYncdnT2+erBaQtQdUMiMuEZxGhhElU7wKU
 K9R7KFLsIU8sKysi9v6DPgWKc8Gn1fEFEmrsT3is501rWYHG5NwAmSrU7RvMjCMDhYEZ
 pU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JwYY+dnUWGn92siUF9yWZYm92u30bUmTLinCII/ykAU=;
 b=HJ44jooI/GPY26NPlGCKOZM1sgY6Ap5u7nfTuDq9EJMhLk8KWrbA1oVkVb6OwNYkLQ
 MUsujxZqH1ieZhk6Z1fxNnHnlGLOrzPqCXCHLSXaFNQG2YeRqmp4rDYKEDUbbQzQ/8XM
 BvGnJcr6mgp2cf8o3J+gBnsNS/wLG0GEgmQI/xafG6quMwhmFNgEaEdvtHIVtcCHkHJf
 /LO3u83DMlL1wdVsuyd6q0vS4oeMjoj6gptSYFiW+9+PZbsLiC2pz/rGs7g8c+6BPZsd
 ts5HL3MIpNOH4/CSy/vz7PmYKz5nKevhvsrjcgI/RRYnThJ+BqXUrgMBGNH71dfW02xH
 64rQ==
X-Gm-Message-State: AOAM531p1+jJdHVWcjZFIv1AHhBXjBqAIrrGmn6RdlDN2/NQ7Se8Mmtx
 LvZVmpIgd4pSTMN+ON0cId34k/eo7aCb3Q==
X-Google-Smtp-Source: ABdhPJxMNaoa3Wv7BHpowglcKBv8MJk9URbNh8Xuk9/zscigs/5yFFKfzLT1oCozGyDXHtNf5ulVwg==
X-Received: by 2002:adf:db51:: with SMTP id f17mr21218044wrj.126.1604337012379; 
 Mon, 02 Nov 2020 09:10:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] target/arm: Use neon_element_offset in
 neon_load/store_reg
Date: Mon,  2 Nov 2020 17:09:42 +0000
Message-Id: <20201102171005.30690-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These are the only users of neon_reg_offset, so remove that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bf0b5cac616..88a926d1df0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1137,26 +1137,16 @@ static inline long vfp_reg_offset(bool dp, unsigned reg)
     }
 }
 
-/* Return the offset of a 32-bit piece of a NEON register.
-   zero is the least significant end of the register.  */
-static inline long
-neon_reg_offset (int reg, int n)
-{
-    int sreg;
-    sreg = reg * 2 + n;
-    return vfp_reg_offset(0, sreg);
-}
-
 static TCGv_i32 neon_load_reg(int reg, int pass)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_ld_i32(tmp, cpu_env, neon_reg_offset(reg, pass));
+    tcg_gen_ld_i32(tmp, cpu_env, neon_element_offset(reg, pass, MO_32));
     return tmp;
 }
 
 static void neon_store_reg(int reg, int pass, TCGv_i32 var)
 {
-    tcg_gen_st_i32(var, cpu_env, neon_reg_offset(reg, pass));
+    tcg_gen_st_i32(var, cpu_env, neon_element_offset(reg, pass, MO_32));
     tcg_temp_free_i32(var);
 }
 
-- 
2.20.1



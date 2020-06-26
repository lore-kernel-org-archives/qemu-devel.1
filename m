Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D4CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255AA206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amKFnfPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255AA206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofLu-0004Vt-Ej
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6L-0000iY-Tb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:29 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6K-000211-Cr
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id f2so3750927plr.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=stVlKjyO4FM1PLWl+alUt+TVVCi4zJ9UBg3ub/hbBOI=;
 b=amKFnfPR+Lve+/3UZ9LS5oxmM1nPGn8UoUZFIWtDJeQAXHMylui6RcKccZiM7PjDiz
 SyRu9hBrXzkOgBlTbvrqToucH1gImZ1RCOBFadwxtqCmg+s1DXqwgjLhnTD2HNKlyXNg
 WpKtp/gz0BgLclxMRfVVIS0Ia5HZ/RAF6tXDZD3KtEel9rJwQOZRK/5q+LqF1kBeuFUn
 0Jtkc2JCAMSwgqDLVDUZaSB7QNyZ6g0c4KyUexMaIHr7GyWXlL/zPrXOk8AaC6+uWvTH
 XnPMbjFnMRKuII4B/sp3By/L8PODenxADRCg2YJh/dpAqOt8XKr0X7owhxPSjr3A52DG
 AULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=stVlKjyO4FM1PLWl+alUt+TVVCi4zJ9UBg3ub/hbBOI=;
 b=OYD9jEYdLVeiOB4XHcrERlbaMLkgCOKFUfea4CYUdP94w/eSCK3sbU3gW2ZKpmxfeB
 2Yo6Hi29h3DOaJ2+upkktbCtbtwPJikYKRVTp9pdyyLQpe7YkwBEqSCPGk3cVpYjrKak
 h6Oc5FianJ0gB8L3Gudu+7GXzhp3RKwfYh6uIIFDAEWIfuHdxg2I9oY/tS6Yhh0m41hj
 MDRlAJo3DTTzOZ7CMsBlOgyuBwvtRkhAu+p4v/n35IWC1EoG9+/BB9UZOwTrT4nqiHic
 EnGACWra08Pk+oClychFlTnAgATQ+W8EERrJvqLA+DS2zl+lmHUHaNP+nSAhCc7VYXTa
 /PXw==
X-Gm-Message-State: AOAM532kf09RDMqBJvWQ+lOAqwavdXx16C8gI+yF1kEYMWqTsB+O9sQ+
 26m9IxOafeZMizdm6OitpNLURswI2Hc=
X-Google-Smtp-Source: ABdhPJzYrgp8wD7kdwoO5jYhXDo3jjznAYKfwNaeVVDA69G9hyJvgCbSQ7O+hDsXP6yFBB5NIWlPFg==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr920357plk.84.1593142346731; 
 Thu, 25 Jun 2020 20:32:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 30/46] target/arm: Use mte_check1 for sve LD1R
Date: Thu, 25 Jun 2020 20:31:28 -0700
Message-Id: <20200626033144.790098-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4a613ca689..4fa521989d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4892,7 +4892,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     unsigned esz = dtype_esz[a->dtype];
     unsigned msz = dtype_msz(a->dtype);
     TCGLabel *over = gen_new_label();
-    TCGv_i64 temp;
+    TCGv_i64 temp, clean_addr;
 
     /* If the guarding predicate has no bits set, no load occurs.  */
     if (psz <= 8) {
@@ -4915,7 +4915,9 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     /* Load the data.  */
     temp = tcg_temp_new_i64();
     tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << msz);
-    tcg_gen_qemu_ld_i64(temp, temp, get_mem_index(s),
+    clean_addr = gen_mte_check1(s, temp, false, true, msz);
+
+    tcg_gen_qemu_ld_i64(temp, clean_addr, get_mem_index(s),
                         s->be_data | dtype_mop[a->dtype]);
 
     /* Broadcast to *all* elements.  */
-- 
2.25.1



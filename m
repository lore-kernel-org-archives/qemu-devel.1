Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99869C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660BB2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMDaQIt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660BB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8MN-0000T4-KH
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LH-0007CO-8r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LF-00041o-Ou
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id y20so2407820wmi.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vSkVOKtJxqx//RCCUxNSVEp1GCYwMklJDIoZLRP8qYc=;
 b=GMDaQIt4dEx+eBvHYLBWWi2xvbjnf6DoPzeIBk4DVd1Ln2wzMdBNhhrX3tWeSYWdwJ
 bHfBzhttIYCxv+xrXDufavmvSH77nd8dJR4OFOjiSm6sBBIAfa9qXvnCdmHEuNwAq4qB
 iUdOlDzvpNRYIVVz0nOKLWh0cmjOu0D1B9vAAtvycqa5VVT5Qv8DKAm479MT/jL9GfXt
 y059zwOGgTYbYQD1/xtfLCwKJ/evnUO7wokmj2da5xTnrr35ueH7N3k6ardk4Vi2JGtF
 dLO9rFXbUsWrJD0/YZvk33rQRAf0hfKbCutWW/4kEHBmguOn3hueQ+7zSSGUM6CnsGPN
 C49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vSkVOKtJxqx//RCCUxNSVEp1GCYwMklJDIoZLRP8qYc=;
 b=FWmfF6JMFWED9JdqPdDKsjELAF3k5gsYlj7gKH0s/B53OOqcv/4Q3VwygVjQcdL08x
 tUPBTwca8i0z2CedDbjDB4MTDu+PcqSwRFynivVodsh1mwa5kBzeu1YlhtwUtrTL0nhn
 wxl+vHFS4n0EsEHSomLzqUW+QprrYcfhhQkIUPXTf6WjSmBT3/J2yogGv8IwqJnAvCx/
 ndWJyTNNdXobYOgKyNUfXa/6dB+ZP+6KADVvBT2+EXoeeGWBTcUgUvoqFMULlOYwysO1
 CGN5GcYvu916/3ElzXJ7OrBwPAq98S7yYAgijisR4wn6ySHOphGy44P6I3OgvzK6PcIN
 truw==
X-Gm-Message-State: AOAM533GSU1qUgtF7nkLQkEfx+vMkQ0GMKGl0odg3WC+pev/Nvd0CBjJ
 Fdixt2YETOL5gJ53VJEKTvS0AcNv45mE/w==
X-Google-Smtp-Source: ABdhPJzB/CfXc3psw595vX5zB2leXQBXaLVgjt6Q2Hbp5qYhaJZ2tfraxzFcnDwbEkOPpbfFM+cN/A==
X-Received: by 2002:a1c:9896:: with SMTP id a144mr2304933wme.75.1592301436086; 
 Tue, 16 Jun 2020 02:57:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/23] target/arm: Add missing TCG temp free in
 do_2shift_env_64()
Date: Tue, 16 Jun 2020 10:56:48 +0100
Message-Id: <20200616095702.25848-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In commit 37bfce81b10450071 we accidentally introduced a leak of a TCG
temporary in do_2shift_env_64(); free it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-neon.inc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7c4888a80c9..f2c241a87e9 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1329,6 +1329,7 @@ static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
         neon_load_reg64(tmp, a->vm + pass);
         fn(tmp, cpu_env, tmp, constimm);
         neon_store_reg64(tmp, a->vd + pass);
+        tcg_temp_free_i64(tmp);
     }
     tcg_temp_free_i64(constimm);
     return true;
-- 
2.20.1



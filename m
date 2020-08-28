Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D77C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEA7207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vh6ZzQW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEA7207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfb0-0004l1-RT
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFf-0002pG-Bj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:11 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFc-0005T6-Gt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:11 -0400
Received: by mail-pl1-x642.google.com with SMTP id q3so520819pls.11
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/v81xo2Oa10INQECM2V7ceku/8UgY141rA25N+r+rLA=;
 b=vh6ZzQW+RwGNCOrlzmxvzget01L9cE3CdqNCroefA6J02cEjaK2A0KckaZu6M+xzYW
 8G97COWlqwWc6tSN6BaXW16SRSx5leZsnAzIce10smEQI+mMyq9Lcr6cikAqpORQEzpQ
 mcXfpMk092zqyZsnQIWufpWl37Icze0iVjYZ1pz9in3T+29MIn5IFnwMhqZYxGgvYLMw
 hqIaRnf9dR/KQV91ou+H4v+0Q9ahhfJJzewub+TvgX+xnl8jvAExyvGX1aBIZzsVTgP3
 DrQrou65otSfsdUZ/Fvm8TqFcS0xQxgxGiTu6UpoVdFaakx5nx/6bI6azip2HCj1WzFo
 Q2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/v81xo2Oa10INQECM2V7ceku/8UgY141rA25N+r+rLA=;
 b=d8PvLNvPl2fUEdrtcRapfuQJ15CmNeCw6vKopjIMtNclQcu5SBeeWQaADwfesdycd4
 KH+1zaCrwxDxfGWop8AAWZZIx0qA4we3zlL9rtqee+PnTuxpBt5gUxHViwwXXWiiVb7Z
 9A0HBSPkPS+li8yN0nutRjS6DZrIqtZS4dgAFMfwphIDL9AqlkI31ZlE3fgySYUu48T8
 RIzWeg2HvIUiFAX7ITtvwduubPDwx2MVSMt7TAK+i+kK7T0K9zxkEvuZeaQ+9fcwbJyA
 JJRn5JU4h4q2zW/02kgAlS+M8r4Zi39RKEPitnZXebhJM+oJKSK243a4P06FUtiGO2iv
 Q9pw==
X-Gm-Message-State: AOAM531NfV9mJASeolIhbfxpctH+wHF2aSGoqfarCS8b+nK0u/OfB5H6
 6w0WA2Poj4mA+qhOR4lpS9JTPzjMIDp+eg==
X-Google-Smtp-Source: ABdhPJy6AS6VGRtYdAz/wdiQAi+B31owZRzr5558UT/tyr03ksQVG7PcSRWSNaTu35+RcyWlZXJv1A==
X-Received: by 2002:a17:902:343:: with SMTP id
 61mr1552180pld.274.1598624466936; 
 Fri, 28 Aug 2020 07:21:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:21:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 75/76] target/microblaze: Add flags markup to some helpers
Date: Fri, 28 Aug 2020 07:19:28 -0700
Message-Id: <20200828141929.77854-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mmu_read, mmu_write, get, and put helpers do not touch the
general registers, or any of the other variables managed by tcg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 3980fba797..f740835fcb 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -21,11 +21,11 @@ DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 #if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_3(mmu_read, i32, env, i32, i32)
-DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
 #endif
 
 DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
-DEF_HELPER_2(get, i32, i32, i32)
-DEF_HELPER_3(put, void, i32, i32, i32)
+DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
+DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
-- 
2.25.1



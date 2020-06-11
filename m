Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13811C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03492075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IROQ5Xkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03492075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOUM-0003X9-4K
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSk-0001TE-8G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55160)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSe-0003mk-Te
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id g10so5204315wmh.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mYq1MqrdFl5JxHZzgiamWFM2bwNZOEqA/8m/GF3wHr8=;
 b=IROQ5XkqbQYzopH9egWOZ1AtCMddqDhN97eJ6lhyA5NBIAzmf/WtiFjGqD+Ykx3aJc
 CcCFdYy4SB83bEdAlB3201KVrUvJTN+ixiQUcpTWumSFy0VUL1sI9Bccpeczi4H68+KQ
 VgLbSpt7Crp3NO0FKszYsWuzuYvuJECw+SxiB+PC3q6A5DRsjRKxQuR2IhQtHDSrM8G/
 aEv95BK4qzq0Y0VOTGuICAiNYdC6WYJWHp0KLzDmGx10m2pGZVSw3LEctgO1ZwfXGMiZ
 QNbWKTCbR3IfQTmE8Jt6cCF0b81fKBm/WSNgbMHImS5Ztt+rH7I3Ozu0Y12H1V8aU8xV
 xgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mYq1MqrdFl5JxHZzgiamWFM2bwNZOEqA/8m/GF3wHr8=;
 b=qauaOXiqlZccw1uAWjuHWxuSU8Xm8M+asG+F+QtfXLbAL6cQQ+1wAeIe9fIH5Sf3iS
 Vzb8mu9Ft+NWz2O0STPBKpOTzb8VEV3HpVtjw4DNksopeFeA1pV/V7uiUYrn3uwXReSF
 aoWxfUeeFKkm/hMDrYlRJ/805TQT4iK64fXNmqficZ2aGJ4wxCYtNCTb1OB4wVQB4OUr
 r0lMUGeqFqpBzC8hChuWARcMbUMq1trNHwaysJkej8YGeyEd8PTVs3ZaRudIfLc5KWNq
 u3W9q8fWNn58FPMd9ZOs3sY3Udqdd6U1nW3UPu/WSxGlZYpJB/3y2fnxng/5iK69GKX+
 EsXA==
X-Gm-Message-State: AOAM532uT/6/3Q2ZQteDdPiEmrQr+qO8iZPkhFxwmnyzlBSK5W3S6/MI
 wi7ZgRCvFPkW2pHnlHBVvu0bwQ==
X-Google-Smtp-Source: ABdhPJzkeH32NeuhGksIFwDmRXVIZuKJbp5TFQzk9zyHPYUBcLsA5Tpu+xgQFtAweCPfKhoOFd8t7Q==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr8298069wmh.37.1591886734428; 
 Thu, 11 Jun 2020 07:45:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/10] target/arm: Add 'static' and 'const' annotations to
 VSHLL function arrays
Date: Thu, 11 Jun 2020 15:45:20 +0100
Message-Id: <20200611144529.8873-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
References: <20200611144529.8873-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark the arrays of function pointers in trans_VSHLL_S_2sh() and
trans_VSHLL_U_2sh() as both 'static' and 'const'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c2cc10913f8..7c4888a80c9 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1644,7 +1644,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
 
 static bool trans_VSHLL_S_2sh(DisasContext *s, arg_2reg_shift *a)
 {
-    NeonGenWidenFn *widenfn[] = {
+    static NeonGenWidenFn * const widenfn[] = {
         gen_helper_neon_widen_s8,
         gen_helper_neon_widen_s16,
         tcg_gen_ext_i32_i64,
@@ -1654,7 +1654,7 @@ static bool trans_VSHLL_S_2sh(DisasContext *s, arg_2reg_shift *a)
 
 static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
 {
-    NeonGenWidenFn *widenfn[] = {
+    static NeonGenWidenFn * const widenfn[] = {
         gen_helper_neon_widen_u8,
         gen_helper_neon_widen_u16,
         tcg_gen_extu_i32_i64,
-- 
2.20.1



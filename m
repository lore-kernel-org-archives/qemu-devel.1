Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA7FC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF5122242
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLxioBkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF5122242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV67l-00022x-IT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66T-0000N8-FD
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66R-0005gj-O4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id t4so559675plq.13
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V7ITHdPywINRSPHDouu96JAYypKQKGBAbsPkldgr1Ak=;
 b=bLxioBkZ9vY2PBfL5ttyEzr6ZARx8Jws/G8kK61Hwu52C1fTUC3pET3I/Hu9SOJs2z
 PWRFKNGQ8RindH20SlStZEnfhWpDspPkIB9mKu73HVAAmQ6frT/fYeGqbsl5sAu4tJlA
 6ZWIt9bcwgW4AAjasHe9ZAfzVfs6fbEdFkoYuy4zFhoZtLyDhCTo5PIR0/vM2fR5l+rF
 m3FU31jsIukyuJYPJzoh4232/r9YCnZsqg5sgeDI/sl8aUhFnS03TGhmwUpYBS2e3NGP
 EIzVfZO9kCG25JYwp8//jC9+4GF4eFxvZ8HG+aODxxFomwS01G7u7Urn+M4OqU4gVgiS
 498A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V7ITHdPywINRSPHDouu96JAYypKQKGBAbsPkldgr1Ak=;
 b=LubaRz8LSRVbmUfA/RFsFWlWufpbp0WbJ+YCxGoNQRE25ImboZvu794QG6z23xomdP
 5qvdXJ9wboVCa6/VWkLDtGRVx37Qd7TReM2RhzjNCTU6ACRLu3n3nkb+AXQl6MDlZnUr
 TAGacjXy2fEwLAJV9UE91SNbpzvLrOmtMKq8582buuye1xu6yRcGfdV19MblDP0MjR1D
 tA6XueFp1hO8erMMPrLy4zksYkqgoo57jAWaB+uN0Fn+gQDV3xk5D8+Xe7rn908rTLoW
 ChNk+bF1fqwvZd7tbVlubRcyDCzuKvDWzbzqUYZv+o1vTWQ+8nBmjYYZV/8TdsSkmYkY
 QUrA==
X-Gm-Message-State: AOAM532Xsih/6orEJ9fJ0TTefP9DE7NmJjD6rsDFkq4hTvb/Hka4m8u9
 Ur8SAyY0gPokFt8hsY1Jz9QBECG5P8TVLQ==
X-Google-Smtp-Source: ABdhPJw1/fXGaW5y35E05tN/NnoudHJnV6FoLkLW4Nqc4WQpP2ctzCu9fKQUgYi7/cbiteZzvkIWyA==
X-Received: by 2002:a17:90a:cc0f:: with SMTP id
 b15mr1463373pju.202.1603255918146; 
 Tue, 20 Oct 2020 21:51:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:51:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/15] qemu/int128: Add int128_geu
Date: Tue, 20 Oct 2020 21:51:39 -0700
Message-Id: <20201021045149.1582203-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an unsigned inequality operation.  Do not fill in all of
the variations until we have a call for them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/int128.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index c53002039a..1f95792a29 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -113,6 +113,11 @@ static inline bool int128_ge(Int128 a, Int128 b)
     return a >= b;
 }
 
+static inline bool int128_geu(Int128 a, Int128 b)
+{
+    return (__uint128_t)a >= (__uint128_t)b;
+}
+
 static inline bool int128_lt(Int128 a, Int128 b)
 {
     return a < b;
@@ -303,6 +308,11 @@ static inline bool int128_ge(Int128 a, Int128 b)
     return a.hi > b.hi || (a.hi == b.hi && a.lo >= b.lo);
 }
 
+static inline bool int128_geu(Int128 a, Int128 b)
+{
+    return (uint64_t)a.hi > (uint64_t)b.hi || (a.hi == b.hi && a.lo >= b.lo);
+}
+
 static inline bool int128_lt(Int128 a, Int128 b)
 {
     return !int128_ge(a, b);
-- 
2.25.1



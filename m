Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41656C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7F923A78
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YebU2m56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7F923A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y7A-0003VY-9V
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6y53-0007vk-6Q
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:26:49 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:42417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6y51-0003gM-Bc
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:26:48 -0400
Received: by mail-vs1-xe41.google.com with SMTP id q13so6126273vsn.9
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SYhTH7/NoKSZMnkGd9mMb4nrqyxVnLFVoR2e/Dwfxy0=;
 b=YebU2m56OOBYOl+xeB0Xu+Cg4A9AkuO8hy4+NFP+uKIwYR0wepCJJ7XSpJwsRvrn+8
 kiP6OCUsbEqkz5wjbkFQ4L6+/Qzv3iQ+1IejuISOvYUvAyqbfEoE034TlFciSCUtualk
 c0lnPWRlwWsGbIvaOEBRRFbFaXO72919u4Z2bTDs8vT89sarlQm7hOZ6g/v+bZQwiyOZ
 MzFof9KfbCAR7194J0vTMmBXYvb1a+a+2gHAxJs+o7l+i63VMn1eTxjKCudzzhKen6Eu
 83ZukN/gANdnHwdZWAeCe/hOdHAvS/sV7VLUllkJ1s0MlLohLWf1rYAKL2Z20vExarm2
 yJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SYhTH7/NoKSZMnkGd9mMb4nrqyxVnLFVoR2e/Dwfxy0=;
 b=HoYlJYPN/1ANkNlUMezT3O/WerMGjlWThJ6t19ur/XCWWv396QIqepxrbBE62CakHe
 CvksUQ+0YQH7crBEDCRmmzv5rTz5AwaYdx8P9V+pQyxoxiuztJ7h9WKl83aTuHG5fE32
 MELJWVrRCb2qa+UbI86M8jhVwDePKyqMhrfp/aXTcLvl+95L9D9fKqlGtdB3Rn/yx93k
 HpohniIZ09G3IW5RH4UfSYUlXyntaYKACa6KQ4KWilDDOAt5GvhMpn2rl/691mAa5iJ+
 Ti2VjNEoPLFyFyJM9NE0JLhQsJdui0V9niP6whiGUsd6yRFDVUgZ6OdPVnwCBC8Omlcf
 MDRw==
X-Gm-Message-State: AOAM530HMGCMCb59rXDGI14iAQqgcAaeZqtspDFuzQuwgSn29zwn2MrA
 jvgOjEoMAjHfnGkIh6jNRZViFNEoODt/8w==
X-Google-Smtp-Source: ABdhPJy7s8q1Hf0lUvQjlh+j5gLNlLuefI6LGQqoPDX5yXTekv/pHi/+h18+PMsQiOnce6LM4DUIjg==
X-Received: by 2002:a17:902:bd09:: with SMTP id
 p9mr4005177pls.322.1597455109367; 
 Fri, 14 Aug 2020 18:31:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/20] qemu/int128: Add int128_lshift
Date: Fri, 14 Aug 2020 18:31:26 -0700
Message-Id: <20200815013145.539409-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe41.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add left-shift to match the existing right-shift.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/int128.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 5c9890db8b..76ea405922 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -63,6 +63,11 @@ static inline Int128 int128_rshift(Int128 a, int n)
     return a >> n;
 }
 
+static inline Int128 int128_lshift(Int128 a, int n)
+{
+    return a << n;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     return a + b;
@@ -217,6 +222,17 @@ static inline Int128 int128_rshift(Int128 a, int n)
     }
 }
 
+static inline Int128 int128_lshift(Int128 a, int n)
+{
+    uint64_t l = a.lo << (n & 63);
+    if (n >= 64) {
+        return int128_make128(0, l);
+    } else if (n > 0) {
+        return int128_make128(l, (a.hi << n) | (a.lo >> (64 - n)));
+    }
+    return a;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     uint64_t lo = a.lo + b.lo;
-- 
2.25.1



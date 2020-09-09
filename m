Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC4C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040272145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/axuwLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040272145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnrO-0008HN-5L
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnN-0007uA-7Z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:43497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnL-0002DB-HY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id f18so539901pfa.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fodn9EwyCn1urQvTDcZN29eMc/3x0mPfT2ar5TaBOAc=;
 b=V/axuwLtpU8Hwu68PCUmsDnACAxXINotlIj46fvpKd/RplKFeB1pBl9zKz7KLjB364
 WEsXKk2i9isMI4XzjuYsqDs7CCt13Ul/aeMM82eJXvX+CV2ZMKUdW3M4lMdulaG0m6WN
 U3FX7LmvlfsqI7aTQOP+Z6d4Qlvs7GFlKlXvp0A+sfdKuJ18qlQwJ84QLir1VmuBL0ga
 CRQxCpC2GBXsKBEOIZA6IpQdiJ215mBNH342S8/iw9bYLp2BxwsbDTFxp8+kMutD3D2j
 t+leaQRWGNsuz/7Wl0+yopZjCFNCMM66VnsDEr8+JwPRpW6vn7opjkFwcPI/oyI5pJPL
 u6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fodn9EwyCn1urQvTDcZN29eMc/3x0mPfT2ar5TaBOAc=;
 b=QuZTA3JtVeiTHW/Zp3tSPT7ippBBoiCzzrjXea1FWxEKv5r9tV0xLSHTAFUQ02qTi7
 tI4WmUzl/3APmc+pWWkeRbLVir49nPJ97PstpG187GIal1WAU4TNCguJHFLqalbtMbjj
 agNTEhLMjvbqS6PNPAvzSz7z63ic9Sacy0WT+H7JC49uNfvD5wocd5K2Al4OxLa7yLp7
 i7khNR3SqFwcF90pxfU+8lcmbbieXSuqZGvs94OLXTX1dHzugO9231LjqKag8IuW4jXq
 xSHkMSH5UDGTaAu8SqZxO+ZgNerzmOgcSEi/0N9WYUk2eEtmG4RUfzTurIusYejUh8ck
 MvSw==
X-Gm-Message-State: AOAM530swCmKfia2R2zfrjNLntKHlbU5sR1D2nI+JXfqirnoQafpG1gq
 /oSdR8XX5jl5QrUYAMP71BJaNSMT2pBrLw==
X-Google-Smtp-Source: ABdhPJx7H4UYbwhv+9rqQ8liTDo9bHiBAGi9UUGQqEI8nLNGEoiG/R6PWcac71xnY/D99hy4w+fCiA==
X-Received: by 2002:a63:29c7:: with SMTP id p190mr975523pgp.292.1599610621672; 
 Tue, 08 Sep 2020 17:17:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/43] tcg: Remove TCG_TARGET_HAS_cmp_vec
Date: Tue,  8 Sep 2020 17:16:14 -0700
Message-Id: <20200909001647.532249-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The cmp_vec opcode is mandatory; this symbol is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h | 1 -
 tcg/i386/tcg-target.h    | 1 -
 tcg/ppc/tcg-target.h     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9bc2a5ecbe..663dd0b95e 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -139,7 +139,6 @@ typedef enum {
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 99ac1e3958..1f6dd8f45d 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -189,7 +189,6 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
-#define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index aee38157a2..be10363956 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -169,7 +169,6 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-- 
2.25.1



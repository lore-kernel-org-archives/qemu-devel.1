Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422A6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E49A214DB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGE/TBgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E49A214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmk5-00077k-7v
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmD2-0003mU-Ee
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:28 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCz-0003Ly-98
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:27 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a45so2991444pje.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MepNhYFr1+IOeR1yUlz4CllcCZZho0JnjR8wxuWPCCs=;
 b=pGE/TBgY7pi/we4LZSV2eO6ZFmN9jYsljcuFvbh9WpWZmwEYU387MoUWMV/FCDCrWs
 iE4xc1ckAcN1i5+iOJNeztkHEPDj+uGj5TyhImIWFXtqwesVRdJAokh80ebnZHnIm5Ls
 hQ/8uR/KmOdU8b3/heHzvL9mvOZjChb9g0D5FphWaVr1ju2wjVXD6ENZ9ew0++CBlvgQ
 HJx2D+vsRDp6riR8r009t7phNj5mcVBG9INjBRhcuCKo3/+TVvSGGMEMqgdA0tHBgt7G
 HquZl02nYU23yRcq2BY+S1OOokILD4WsS4bGFnastM7/5LfskRndPbZya3nu5tbqPRC/
 QY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MepNhYFr1+IOeR1yUlz4CllcCZZho0JnjR8wxuWPCCs=;
 b=ZlJKS6IRCGMwj9Xd2YcIzuFBofmib/wUQIKgirK/MLT/M2ayrsX907UFjkl6cglZtp
 pf6Zf8sskkYlRHAkz6KQLqqD/m3GVVngHlC58mqwOsfnyT7YKgQg5FK2WJGshozAHTIy
 c1D8uo8ljZs5CJcogUTqkvySwKC93I3uiMW0dXr8cW/cq7KjLVsfrP9CexqpY3VNkxA5
 r62XSQSrWbrf9sjeM5SfuzTHLs1gRxoJ9FOwB3U9XxVkzR4E+pPf5Vbicx0K2oLrqGUJ
 CBA4OPEvPusXrGzxgYEIgalkU534S9Oh521rTye6XeJT5mMW3/t2roxsEtxKf/KtZyk5
 jUOQ==
X-Gm-Message-State: AOAM531fzNDlC1yLDh2u8OHml3TprWl5nP8KmYUIgyJWdfNPyRSOOTbR
 hlT9XVQoFlellq5qec9CIKVmYGC1Wh0=
X-Google-Smtp-Source: ABdhPJz/gVWZs83Wwz568L5WG3yLici6G0zurt/a+oIieV+cJ6gs2KAXsppq4p7ISDl8NSJIzVFt9g==
X-Received: by 2002:a17:902:7246:: with SMTP id
 c6mr2079283pll.191.1592454683494; 
 Wed, 17 Jun 2020 21:31:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o1sm974337pjf.17.2020.06.17.21.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 069/100] target/arm: Split out formats for 2 vectors + 1
 index
Date: Wed, 17 Jun 2020 21:26:13 -0700
Message-Id: <20200618042644.1685561-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently only used by FMUL, but will shortly be used more.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5815ba9b1c..a121e55f07 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -67,6 +67,7 @@
 &rri_esz        rd rn imm esz
 &rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
+&rrx_esz        rd rn rm index esz
 &rpr_esz        rd pg rn esz
 &rpr_s          rd pg rn s
 &rprr_s         rd pg rn rm s
@@ -245,6 +246,14 @@
 @rpri_scatter_store ....... msz:2 ..    imm:5 ... pg:3 rn:5 rd:5 \
                     &rpri_scatter_store
 
+# Two registers and a scalar by index
+@rrx_h          ........ 0. . ..      rm:3 ...... rn:5 rd:5 \
+                &rrx_esz index=%index3_22_19 esz=1
+@rrx_s          ........ 10 . index:2 rm:3 ...... rn:5 rd:5 \
+                &rrx_esz esz=2
+@rrx_d          ........ 11 . index:1 rm:4 ...... rn:5 rd:5 \
+                &rrx_esz esz=3
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -792,10 +801,9 @@ FMLA_zzxz       01100100 111 index:1 rm:4 00000 sub:1 rn:5 rd:5 \
 ### SVE FP Multiply Indexed Group
 
 # SVE floating-point multiply (indexed)
-FMUL_zzx        01100100 0.1 .. rm:3 001000 rn:5 rd:5 \
-                index=%index3_22_19 esz=1
-FMUL_zzx        01100100 101 index:2 rm:3 001000 rn:5 rd:5      esz=2
-FMUL_zzx        01100100 111 index:1 rm:4 001000 rn:5 rd:5      esz=3
+FMUL_zzx        01100100 .. 1 ..... 001000 ..... .....   @rrx_h
+FMUL_zzx        01100100 .. 1 ..... 001000 ..... .....   @rrx_s
+FMUL_zzx        01100100 .. 1 ..... 001000 ..... .....   @rrx_d
 
 ### SVE FP Fast Reduction Group
 
-- 
2.25.1



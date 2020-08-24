Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF7C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0752075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bjivqb1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0752075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Dr-0005qz-NM
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95l-0005TE-VK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95k-0004pR-Br
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id f7so8031264wrw.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rXc1zd2h6n/7ieWiemihqkhV0rfIkaZUjYQ6Am+tbsw=;
 b=Bjivqb1F8zUa+4MCVxoESr4CnKxu5wBc2ps+Vnh3Nopyl/QE6jPFibz70VbcNjlTP0
 7M7A5aOa6jPxN/CM5lpNilcRfNmPdVvetwOoQwHMCjDrEH9o6xDHaSObeARnS+BP4gsb
 UU9ewuyeJ7UQKXuPRQX79yqwO/7v0bGu07IKVLQBLGcx7qikxBsyYwCMHsj/KmXQRTPM
 uM87f+Y68GqEoJdhzNGOH6aTj8zuS5Baj4dYDmnjYulLs2NZoGYDTW+aQDBIt454dux2
 XTPHmgQt+8Pl/wwRXRvcTJ6SneVKQaBGGEbwNToGY0jn0KHOkaH5tZVOr4puBit/gQ9P
 /onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rXc1zd2h6n/7ieWiemihqkhV0rfIkaZUjYQ6Am+tbsw=;
 b=kIAXhrRAJjW34Q0vYANp9NAOuT48F3hZUIiZg0OEVbMeu4zHSLdIUe/SxAvGjSmASI
 fUllKrzs7qX3rlaQL0YhODe/asMPh2Bf7uRHKs+Zp44ks2HlmSGhd5Bq1i/TijXR6LKY
 GtF5YCV/E8vEMN78wBOp57HpI+Vo/6aVVYhgPFg0N0Jacm80E93zpOIup4okRRZMODF4
 mHk2Jrapd5OQO1ayqbBOx/w5t61kbrcplU1UVM1SpIlyxyint6t7zMtDF5fSFPx/WWGO
 6NUtDZXspREHguj7rS8h6RmZTQBksAVXhXyztxnN1Ksqc8pnnHOJ241Xc2iBaoWZ7VJS
 54Tg==
X-Gm-Message-State: AOAM533rAYPm2EPSFeXht/7nc/hQqlRzaeGfiO7puz6dZ5zZS+m7FdJ6
 BB2iiDoM1hsX3PbVQvmbfbvP9O5LHYYpVrW9
X-Google-Smtp-Source: ABdhPJwb0LF9hYJAKYix13FJCk2P9wgXu8bZPOILGzZfwrUM1vPWsF+lNEO1K0hD7yJNF2wW7k4znA==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr5007840wrs.400.1598262518862; 
 Mon, 24 Aug 2020 02:48:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/27] target/arm: Delete unused VFP_DREG macros
Date: Mon, 24 Aug 2020 10:48:05 +0100
Message-Id: <20200824094811.15439-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

As part of the Neon decodetree conversion we removed all
the uses of the VFP_DREG macros, but forgot to remove the
macro definitions. Do so now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200803124848.18295-1-peter.maydell@linaro.org
---
 target/arm/translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b74a4350e39..4ffd8b1fbe5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2470,21 +2470,6 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
     return 1;
 }
 
-#define VFP_REG_SHR(x, n) (((n) > 0) ? (x) >> (n) : (x) << -(n))
-#define VFP_DREG(reg, insn, bigbit, smallbit) do { \
-    if (dc_isar_feature(aa32_simd_r32, s)) { \
-        reg = (((insn) >> (bigbit)) & 0x0f) \
-              | (((insn) >> ((smallbit) - 4)) & 0x10); \
-    } else { \
-        if (insn & (1 << (smallbit))) \
-            return 1; \
-        reg = ((insn) >> (bigbit)) & 0x0f; \
-    }} while (0)
-
-#define VFP_DREG_D(reg, insn) VFP_DREG(reg, insn, 12, 22)
-#define VFP_DREG_N(reg, insn) VFP_DREG(reg, insn, 16,  7)
-#define VFP_DREG_M(reg, insn) VFP_DREG(reg, insn,  0,  5)
-
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.20.1



Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BCAC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C811C206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNVsemZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C811C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwzs-0000pZ-Th
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyo-0007S1-DX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:36159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyi-0004aI-7U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:14 -0400
Received: by mail-pj1-x1035.google.com with SMTP id q1so2095762pjd.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ujJytkO077otcKV33Z+6URYnEerHnMmPUii31K7Opk8=;
 b=nNVsemZumGQHzPZsmDIwWSVy9lKcieRa11sGrPfas3bq5Q8s07H314usupPsyAbNzy
 IbXlAMI5XpJVxz1Hxzv3dLzOu9gf11NMCLi6pvg8upRUJYsnTYIxGS2G+zB0fRtmKRSJ
 QlQTdbyBBjfIdv/ayuqFIFhhJkJ9GS/B34uKWO1m9NM6ehCDFkjXT6KNQzW1yx8TJWCM
 z3avuA1xWtBQthHOpp0h46Z2yug1MQfbLtBmz0mRE3D4+1VDIPxlYMP6YZUhqUaW5DBQ
 PM7EI/hR1OZmFZJ4u6gr1bp9jZtmgX7Cb1UHO+S7e+gVYiKrwUJjmwIGtg3h1dRpa2F5
 zM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ujJytkO077otcKV33Z+6URYnEerHnMmPUii31K7Opk8=;
 b=K4euij79VzXINqrZKbCUtU7t94gY1Z+oGn14YFtaGympsg0+jMGtxBoAwXjsnF3LMB
 tOGedSb8cFSHTkgcxMAUwX8mLDDgthQ6lNrOsCp9sFbGbnzOwmcGIu1yn/n4n4OOJWGz
 Fgq/YDTWI70kvtjHku735Tl/9gzii8ZCTibwS9NSk+XY7VEdmhNF1+dMZN4yw0k9qTn2
 LXkLBPIBgv23deNkLpcURpBN9525M5b5zSRIZkX2pLS66zJEEHP8s25Fl5Q7MXQCKAed
 A3wjdPAuw3mOzGdMhgPHhHEv0fYh02kS/XSauteHey80pBTwA341koJJaPRVDCVngp9F
 8UYA==
X-Gm-Message-State: AOAM533vQSYBj8GkHlThHydZU3GTIrFqTCEmgfrVcsN26/DhY6wo4Jmd
 +JTdttLrk1lJfTzrYpM4UvddyxWUgRfOCA==
X-Google-Smtp-Source: ABdhPJyh/9ucyiqnpcm/plApsTotHR5qxKMI5JvApPoJoBqpbJdmMLXXJ7T+jlVHQzHfvSD+l1ir5A==
X-Received: by 2002:a17:90a:5a01:: with SMTP id
 b1mr4828268pjd.27.1599169266244; 
 Thu, 03 Sep 2020 14:41:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v17sm4113290pfn.24.2020.09.03.14.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:41:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] tcg: Fix tcg gen for vectorized absolute value
Date: Thu,  3 Sep 2020 14:40:58 -0700
Message-Id: <20200903214101.1746878-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903214101.1746878-1-richard.henderson@linaro.org>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
Cc: peter.maydell@linaro.org, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

The fallback inline expansion for vectorized absolute value,
when the host doesn't support such an insn was flawed.

E.g. when a vector of bytes has all elements negative, mask
will be 0xffff_ffff_ffff_ffff.  Subtracting mask only adds 1
to the low element instead of all elements becase -mask is 1
and not 0x0101_0101_0101_0101.

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200813161818.190-1-steplong@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0effb..793d4ba64c 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2264,12 +2264,13 @@ static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, unsigned vece)
     tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
 
     /*
-     * Invert (via xor -1) and add one (via sub -1).
+     * Invert (via xor -1) and add one.
      * Because of the ordering the msb is cleared,
      * so we never have carry into the next element.
      */
     tcg_gen_xor_i64(d, b, t);
-    tcg_gen_sub_i64(d, d, t);
+    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
+    tcg_gen_add_i64(d, d, t);
 
     tcg_temp_free_i64(t);
 }
-- 
2.25.1



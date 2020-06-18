Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE09C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB182100A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0FdUzGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB182100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlm9v-0003nx-JX
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8a-0001cU-I5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8X-0002F3-Jo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id n2so1892935pld.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1xo/F7/aAE6h7nPyZHFzXrWII41wbW4AOQQ3nfWZDVk=;
 b=b0FdUzGe3BXPetK/2aEAhuhSvJmeQUfXAHvM09IBE+4BhJZn4isVbicceHZHl7oNqj
 O38RBvu2d6sPxO1h7i57ia6rBHmsbCGa2XLLn9hfCrQ5jNUoW0SsmpcEojqciM4qxl1d
 lgOYK605ojAcIINS+KA2dDAacXZHTXCtRJvtk0L3+xI1v0Srffw9S6FOMraM6aAFNFXa
 D/VXjDtp1EWWyVlzIDWpen7pVrhdr4v/UG4EKa36kLM3PdOP33C4djVtum3dC2DvR0RT
 GAypi1tvyeVhnMBntTAypQkKrBAKeHCXYPxSJOP54YLSsDpBuGED92FYWsVBcSSjd1Lj
 mSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1xo/F7/aAE6h7nPyZHFzXrWII41wbW4AOQQ3nfWZDVk=;
 b=jw5c64AStKl7GVr22RQMzti/Ysa4Mflc1xe2hNZuB2Xm815NnpG7a3ZRwgFYFdNqpx
 FG/ijw1gV3xQJBcDmKRNSB67oHSrGusNmCZyDLPVBAUJn+bR/thjysrOcXFDLsdFH0Xl
 GtA8OHqxGZ2iy3cQ1u+w/jXxH1J51wQXnTYUkdDYCbnvFAKj/UT4ibTmdsKMrbl558dM
 s/EjGH/ZiOcTgs6zWmZrs9MhsSQvJWDh77iRN8LiComtVA3JH+UzNMSnzEg3FsgVAhtw
 fW6pZcwIXZ5f7RuzUS44lAJGBchZGmkJibTPWbrYtVDfZp3CkB2kSU77bRVFkm4zq0gp
 /mdw==
X-Gm-Message-State: AOAM5322wYBYpgx6SA35ivuDnomWBFUXXweSNP3rjns1mIb1tj/N/rsP
 xWXKZvNuklAMWHxOqL9ILBgDtglZ0iY=
X-Google-Smtp-Source: ABdhPJzpQSuR5sjS9P5+/7rdZSQioPQRfgcHqqzfZAeEjg0GsHQC+ktlYj3ukz61MsNJvrs0565CYQ==
X-Received: by 2002:a17:902:8544:: with SMTP id
 d4mr2187704plo.234.1592454408092; 
 Wed, 17 Jun 2020 21:26:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 001/100] tcg: Save/restore vecop_list around minmax fallback
Date: Wed, 17 Jun 2020 21:25:05 -0700
Message-Id: <20200618042644.1685561-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

Forgetting this asserts when tcg_gen_cmp_vec is called from
within tcg_gen_cmpsel_vec.

Fixes: 72b4c792c7a
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index f784517d84..ed6fb55fe1 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -657,7 +657,9 @@ static void do_minmax(unsigned vece, TCGv_vec r, TCGv_vec a,
                       TCGv_vec b, TCGOpcode opc, TCGCond cond)
 {
     if (!do_op3(vece, r, a, b, opc)) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_gen_cmpsel_vec(cond, vece, r, a, b, a, b);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
-- 
2.25.1



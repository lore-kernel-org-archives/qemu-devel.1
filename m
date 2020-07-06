Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D281C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4376D206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfyWv7Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4376D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsWGn-0004Kf-Jh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEc-00010W-0w
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:58 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:52065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsWEa-0000fg-FS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:52:57 -0400
Received: by mail-pj1-x1032.google.com with SMTP id l6so14089819pjq.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hUkw5IV25PzdOpbKU56LvtYexDUOIKyrljMdyGHGiXE=;
 b=qfyWv7RleJAdZTrZmwUL4ineINZT9SG9RU3WZbqZOU4XufGdslg9daes6nC1hcwZTb
 s1mLxJRj6glIT103LtuoYoIXcCvT5GzUpiUREre6/zhGBsyMkLMAXMxW9guOYeM3jBEp
 8Dvel4Gu4mpsAHupPoZD+CJkw/u3wknsASa/tnMxpk+y8NxwSsWSQnMB7SYXOGRpgULD
 qKzANq+7dBcEOwokg17gwIeU9v7yut0TejndXsc4wFJpxaojyt5TtGvCEzbWl5QaNB31
 AhGmHfLhWQqrmChxJRr2oMJmVfFwSTUyzDIVe+srpeopzSb80hfBRJz8iuyRNR/hWIdF
 06Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hUkw5IV25PzdOpbKU56LvtYexDUOIKyrljMdyGHGiXE=;
 b=kUhg3UsYmkijd3+W2E8RbcNitEXbbR2jBklg8L3FcgnozvbYHTg5O42BuNjbLVM3v1
 /IS5YxLpU0rtt/AhHFLi3t5g8pYOnC/gBU1Xq++Q/pZqEr6p4IBa2AkIl5C+FavR0mft
 sWc+PXbAvsrQrQy82kHV3umhLPwXd/D/l5DZfNqzqkQxmi4LntYKL5BXCmFaJZgxHgvo
 xK90B1pme+3j1BKOsClUFyPIbPONDJtZL+w2yofD0jXnuUfyp8q7HXcjdKwwXss5oilR
 u7QvpNEbLGSRWll3BQvMmy4/KgnFZxQdzVT01Fp6OuQ+OY40gTFeXXo7YAMNVX8WpueY
 w5EA==
X-Gm-Message-State: AOAM532uFuAVQ3zNW9fPxkYfLwooEQnItXFVRm0w43zpPtO0TWxtM87k
 5P/e515MXNDPr9OjV2OiGBogoCeN+n0=
X-Google-Smtp-Source: ABdhPJzI+8AIZXU/YL6JBRHQvvJTxDK0I5U9+M7Wirawsc8p2YqvEX1EvPNv1Y4Bs7ZUrXNu4BT8dQ==
X-Received: by 2002:a17:90a:a887:: with SMTP id h7mr615794pjq.0.1594061574641; 
 Mon, 06 Jul 2020 11:52:54 -0700 (PDT)
Received: from localhost.localdomain (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id q6sm19988179pfg.76.2020.07.06.11.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 11:52:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] tcg: Fix do_nonatomic_op_* vs signed operations
Date: Mon,  6 Jul 2020 11:52:48 -0700
Message-Id: <20200706185248.118447-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706185248.118447-1-richard.henderson@linaro.org>
References: <20200706185248.118447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
Cc: peter.maydell@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The smin/smax/umin/umax operations require the operands to be
properly sign extended.  Do not drop the MO_SIGN bit from the
load, and additionally extend the val input.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reported-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200701165646.1901320-1-richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e60b74fb82..4b8a473fad 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -3189,8 +3189,9 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
 
     memop = tcg_canonicalize_memop(memop, 0, 0);
 
-    tcg_gen_qemu_ld_i32(t1, addr, idx, memop & ~MO_SIGN);
-    gen(t2, t1, val);
+    tcg_gen_qemu_ld_i32(t1, addr, idx, memop);
+    tcg_gen_ext_i32(t2, val, memop);
+    gen(t2, t1, t2);
     tcg_gen_qemu_st_i32(t2, addr, idx, memop);
 
     tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
@@ -3232,8 +3233,9 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 
     memop = tcg_canonicalize_memop(memop, 1, 0);
 
-    tcg_gen_qemu_ld_i64(t1, addr, idx, memop & ~MO_SIGN);
-    gen(t2, t1, val);
+    tcg_gen_qemu_ld_i64(t1, addr, idx, memop);
+    tcg_gen_ext_i64(t2, val, memop);
+    gen(t2, t1, t2);
     tcg_gen_qemu_st_i64(t2, addr, idx, memop);
 
     tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
-- 
2.25.1



Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B278C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6937D2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js0UNPOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6937D2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmj4-0004a1-DU
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCw-0003SZ-L9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:55611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCv-0003L9-4W
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:22 -0400
Received: by mail-pj1-x1035.google.com with SMTP id ne5so1955985pjb.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sbIRSfBXy8STM04dECtWnQvP46LbKwMWsMmZFP6hP68=;
 b=Js0UNPOzX/EsnAy+hcoRAOHo5Ei1XfgwmXDxu836/YMRZOfKClZaWjCRvY3AARTEa1
 Z3rJoNG2nIs/tXoLjcZlXM0b1w+8mZ/IHsA4YUGSAxhzERt5BacOFy6ggoGZpV5Ex89U
 1X50JXPpBSjmZFDzCYh6xrPVFX34A9yibl8+Jd+l0oZg9KwCtqttLZHODz6pP1GRhtsC
 rlewrrXtTwwTPy33Nnz3q8M5WCHJVt/YsofRlzXFhaE3dGwi6om1lEJIN4FKbfPsq+Zh
 F+K9v94kISOuksP3BN/tX25DxzefBJhlDO7lcewhFvr0jJ4X23Yt58MiZDRLyeSb3rqf
 Opng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sbIRSfBXy8STM04dECtWnQvP46LbKwMWsMmZFP6hP68=;
 b=dSSP+B9KMxH36lrDI+FvU0ZBSGy9N/tf0GnQWCJcooCWnJThpjRhCXprrvpgOQTogJ
 MiEJr7YXpTVlWxeLwik5oHy3o7V7g8Z4bSdMGG8CFyIeRVC4xsVeWWqWt3RQTRx3/o1X
 mLP/abihu76DnRp2FVpaddbnnDhoS+UlqHJJdUIRKW5thk6yHPGopAtxA2s7VvSgO+it
 RwXfY10OmTb+Pp4YtQmfel5jd77WAQtzvK5sYpUKS0IJtuRFWSye3RKpmYpLkjBDkmQb
 iD2tCR1Es+3/jwvhPLw1ewyCbeNrIOSe+LuFu5U74Hm/ZkP2Eu2pF6RxLUqBg76rocaq
 cf1Q==
X-Gm-Message-State: AOAM531xGT9Hv9Aqj1rv8GQl5POUj+95ukqFot6rMF8iBdLlx53hUFdV
 IwepQVDqHok5eIMwyyXvOwCkVxF5E5Q=
X-Google-Smtp-Source: ABdhPJzte23V8WXHqTox4tj+KWEmYZgv/sYl17pbLgTl1jJsavFKOv0DD3GSFv5YxX05unrvxHhVCg==
X-Received: by 2002:a17:902:768b:: with SMTP id
 m11mr2169751pll.136.1592454679386; 
 Wed, 17 Jun 2020 21:31:19 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o1sm974337pjf.17.2020.06.17.21.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 066/100] target/arm: Fix sve_punpk_p vs odd vector lengths
Date: Wed, 17 Jun 2020 21:26:10 -0700
Message-Id: <20200618042644.1685561-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, qemu-arm@nongnu.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrote too much with punpk1 with vl % 512 != 0.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index dc23a9b3e0..24c733fea1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3137,11 +3137,11 @@ void HELPER(sve_punpk_p)(void *vd, void *vn, uint32_t pred_desc)
             high = oprsz >> 1;
         }
 
-        if ((high & 3) == 0) {
+        if ((oprsz & 7) == 0) {
             uint32_t *n = vn;
             high >>= 2;
 
-            for (i = 0; i < DIV_ROUND_UP(oprsz, 8); i++) {
+            for (i = 0; i < oprsz / 8; i++) {
                 uint64_t nn = n[H4(high + i)];
                 d[i] = expand_bits(nn, 0);
             }
-- 
2.25.1



Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E50C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEE12073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPMxe49j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEE12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSjx-0006ou-G1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSc1-0006UJ-K9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSc0-0007Ai-D2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:37 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSc0-0007AL-79
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:36 -0500
Received: by mail-wr1-x42c.google.com with SMTP id j42so22872976wrj.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=93KaggC3L/e0TUJ7Jbl9RL8NFMa1vRqYhk1SMuCskPQ=;
 b=QPMxe49jT7YIbBd+VzzrfMYIrgcAe8EwM2vhoSOT23P5lfMFd5VSwhGUdqBUhwApNW
 b0MrmyN9Mjrilj/0GCEi1JWWBPzJ2q86F9DO0Lrb9WHSNiiqkkJYUq4kp/yDC7Iv4cW0
 HPElM2X4+BbpPHqsRjRNsdyoKGy2dNwZ4T+iq2GP/R2LA6R3aCsQSCIyKOQaOWyOwWAI
 a6xCMWDuE5Q/zLJSkslR91Wt+yP8KrtlDPVxQYe8jcHeucTdUNROp1T1irMhSRM0pZ8S
 kknN9gJVoXxbNNf68aUIDc1XV35UoKm4crWwQMaeqtpa/D1SmAQMH/M5UUctBmGTPPPj
 2NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=93KaggC3L/e0TUJ7Jbl9RL8NFMa1vRqYhk1SMuCskPQ=;
 b=qFZJNHAQgVEu32Z4rN0QCHhPPznVWRFCzuHkmABP1WFuRoSGthnfGvhnjO1wiXaH2o
 h8C1Nk3GqNr7BSSCsaGmKxOwlYU15N+Cm5TVHHUkwblp7jTnwBVLHCNtOPMtAYNpDW3B
 W38n1TWmKA+A9h1ziAKJ9vudHf5BElFqrkqk2wmPPChxReAS8/uhtO7MD5BLiMTMw633
 Pf6/vusHxga2j+JzeZ5DTAJkrcBj2PADcjGf+k3R+kTk70Ryn4zuNQWSo9KSmsGzC+KW
 jj3bMDyFDFTvJ1B9hlWX2D0t0T7ONKFiNoXIdWP+fD77M8AvXmoBNOrJsUtZiodEm05z
 sSJg==
X-Gm-Message-State: APjAAAVNntoXtvPxhjlcfujtd39xUX03mthmHtddcCrk1EyBOx6cO5xb
 HFcw+RmV3cTST/BRKu+9UK0lhOiIA1V5IA==
X-Google-Smtp-Source: APXvYqxy31JTfvgmY5shPx+sCal7+OOhiPwKUb6QIoWpSqKP1/Au7iuDcDKY6usL6ay+56GCRWZsSw==
X-Received: by 2002:adf:e812:: with SMTP id o18mr3288300wrm.127.1579271315072; 
 Fri, 17 Jan 2020 06:28:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] target/arm: Return correct IL bit in merge_syn_data_abort
Date: Fri, 17 Jan 2020 14:28:15 +0000
Message-Id: <20200117142816.15110-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

From: Jeff Kubascik <jeff.kubascik@dornerworks.com>

The IL bit is set for 32-bit instructions, thus passing false
with the is_16bit parameter to syn_data_abort_with_iss() makes
a syn mask that always has the IL bit set.

Pass is_16bit as true to make the initial syn mask have IL=0,
so that the final IL value comes from or'ing template_syn.

Cc: qemu-stable@nongnu.org
Fixes: aaa1f954d4ca ("target-arm: A64: Create Instruction Syndromes for Data Aborts")
Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200117004618.2742-2-richard.henderson@linaro.org
[rth: Extracted this as a self-contained bug fix from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 5feb3129417..e63f8bda296 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         syn = syn_data_abort_with_iss(same_el,
                                       0, 0, 0, 0, 0,
                                       ea, 0, s1ptw, is_write, fsc,
-                                      false);
+                                      true);
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
-- 
2.20.1



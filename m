Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BDC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5ADF21789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YG4C3v1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5ADF21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQX1V-0007Ky-J6
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs6-0004Uq-Jr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs3-00061D-V3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so6728669wmq.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7WypgywffyK5TRi7PnYgrX30P78iXnGl8x7fIn/+Sxg=;
 b=YG4C3v1xccGZJdaRmDz5XSS7dbfYzYSSJoRPP97+KYtvEsBt11JchWP5dCaIiWMeeO
 3eCbTUxH82I+nct59BD84/zLkywPrISE1OTKd4W1UGl+bTGLyBayt71esAYCRd/XnBR7
 Td3HUIewWGOw0HsF6Zcb77XrDcZET9uHNRMjJg2K7jJfnaCdmVfV4xVmujty1OpaIPHy
 D7TPHuDKtbvzQ3ov3FHieP97rtKANUB6v4lNL0PYxoEKdTdlgYWq7MpoyhTZhM1763xc
 MLkb9aYG3efaxiKftEWcGe5t2QBKd2uLGdZbU0NpeVkAkS7KtrPAvguhywiciKarLYs8
 +5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7WypgywffyK5TRi7PnYgrX30P78iXnGl8x7fIn/+Sxg=;
 b=r66seSgNAhrBXWqArIKKZBTJwOjc0Ccocp7lfS7nZfNrdNkt2ZWnKRu0zzomq7AwwJ
 kdgtKWheZ7msbAcLRrZX89pnczjbi/XvXHT2uYIa0pQxVk06ZG3iSK60L7qeLdzI5LHX
 y9leoQuSPOl3yWyQ5BerthJzjKJzyWirf68kEbs1jZsKlEXcEbTr5rj/8IL5NJPo1t7T
 pZ1GywwBZGIx9YzWVjJwf5yfUOIjmLyzBXeNFDV/9l8WhHql6Zz+PQqiX/E/Tgxb0cl3
 JN67/dCkMIEI6ZRTbHmmQlxPhxHHKyFPlYz7/aNZzKGI1GG//G3YaGJKDgg7Odw5UkTT
 EEPw==
X-Gm-Message-State: AOAM532qJcvUM+KFuwIz4hwbcn1z/HT45FPSNemIMBxukRtrdWyofY3C
 VVB/PY0hCYwoZOcyka8vc9+E3PxfoR4ilMIo
X-Google-Smtp-Source: ABdhPJy3Ub/m9TUnoKIHdcFe+qG+5mMGcFHZ75TUwO9aOc1XRr5t8kkAFUdpbZq5JTX2pkWz7T8/Lg==
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr328793wmi.59.1602167174165;
 Thu, 08 Oct 2020 07:26:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] target/arm: Make '-cpu max' have a 48-bit PA
Date: Thu,  8 Oct 2020 15:25:57 +0100
Message-Id: <20201008142557.9845-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

QEMU supports a 48-bit physical address range, but we don't currently
expose it in the '-cpu max' ID registers (you get the same range as
Cortex-A57, which is 44 bits).

Set the ID_AA64MMFR0.PARange field to indicate 48 bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201001160116.18095-1-peter.maydell@linaro.org
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e00271b932f..649213082ff 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -653,6 +653,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
+        t = cpu->isar.id_aa64mmfr0;
+        t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 5); /* PARange: 48 bits */
+        cpu->isar.id_aa64mmfr0 = t;
+
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
-- 
2.20.1



Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F64C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634FC2171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8+shBMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634FC2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvZ9-0007mX-M0
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN9-0005Uh-1C
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN7-0003nl-Gi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:54 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:43349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN6-0003kw-TI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id i189so32518685pfg.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Zz67J9BYvHkyirLYAvJnaBfIqywYlFR2wUnxCxYbY04=;
 b=L8+shBMp3yVjZG/WydqMY31Y7UzDlaO60sIBUkdhBOaavGxe1ryke/75AN8tUQrt9v
 oejc7f7waua8NcKbhXHZ6g0nvvGnCUUuuNqXSs+bYlAtZ87NWPmd3CvbFxcMHyHjOh8/
 w1HTio11uGuyiJ7Fab6Y08/LUfrVdhi3sQgm0LLvKPxXwC0orrnT5OOXEHKG4+dvucK8
 fZeW/HbIE0LXlKBOy66Ox9OArrCqptiUoox/3ND2VMjUX8sks7ALXweX8pUIf5Xtbu4t
 Vz/UIGAaoNrE6Dlfxyjpz4uA+Vp36EF9pOnliJFKHu5/DSGDD7ODk4ry7eQ0eUsb1PbP
 4tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Zz67J9BYvHkyirLYAvJnaBfIqywYlFR2wUnxCxYbY04=;
 b=DQUJbRCEjX6OMbALglnjTxQWmf3OLCF2njtvqhIBvN1TbWjTVl9SBRzFJ5X1BLl5pW
 tkm+lVhdDGP+LlegrrnfMRcVJCaBxBdPP/IF7qd76zXcusppGyBZ260oyIrHCNhmqnol
 WxlDAXIJnTflaBRvG/HCy9iy0cZWqysthka2F7Y1eUn1zMitY9S6AJHe0/SstXRn9rmV
 KjQanTL2dVNtu2y88oh5IpocZ7846Yh16XO7fz+v+T4ilmOYC2uPEhL7PNwk2TIC3wvh
 gEykJgMaZLg1T9JmpPzYqFjegdpjxjT99WVCc37F31XRtT0Zeal8kXUrMnbjbIOKd06R
 EQVg==
X-Gm-Message-State: APjAAAWn8XXUifuzVm30XPPE/AG9JNufWXxAos9nHYmiqwJJb+hflebU
 IZuD/yt3nQlmfzgdJoo24caZaxuJY9Q=
X-Google-Smtp-Source: APXvYqyO/bYu48vDK8KNFYcAnLNfhnN7o0hWF5s8xNobIlXNmRb10yEbsV6iQNHe2Y2xXzVtbw8XBg==
X-Received: by 2002:a63:10a:: with SMTP id 10mr31711947pgb.281.1564605529644; 
 Wed, 31 Jul 2019 13:38:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:09 -0700
Message-Id: <20190731203813.30765-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] [PATCH v2 28/32] target/arm: Update regime_is_user for
 EL2&0
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c6b40a12b4..15a054a141 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8894,6 +8894,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_SE0:
+    case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
-- 
2.17.1



Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF53A21721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYdT9Uiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF53A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOsQ-0007Do-Vq
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58769)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcx-0007tj-BD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcu-0003wx-B0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcr-0003tu-ED
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id x17so5233198wrl.9
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZUooYRNQgmkNG0e2yEBeTuMYF1MRR7xam1XkALvG320=;
 b=oYdT9UivNs+OPvJezs7OUA8WLYiud+InyFfN2ZNe525ESXhsF6vWC8/S/qATRDZBMK
 bmdvZASWVSiNvD44mWNvFtZ8lt4CctQ5cA67KYQvP7m/xHAOVNytBXnk/9bk4t+6dcEg
 X9Vd1x1Eoz2+mg7MfoCtZfPdqbie+gYZkd3ddvsgZx3HJlCp7S07uVNkXPIWXXNX7+dg
 fc8PmajTVs9u0E3iKKo4DA6vnbeP1w9x0KNqYwhihK/Hm6hZGu1VmhGTQskko/dgpoXy
 4htWSOJ0xArlcuMup7097n5MpUA9Hs2MSpyuQbGDpTEN6YuwfOPVktGMX0XHao0MI++C
 RnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZUooYRNQgmkNG0e2yEBeTuMYF1MRR7xam1XkALvG320=;
 b=JTXTq8UpSEk2z7INEAyZw0JnstnoS1pW5UJNyCLNdq8ju8xPNQqyK9C3DjIPDJb8ru
 gJNaXPYNLShcs6vmzOKXEAFeIKaEYlh9Xr1GA7Dw1VJ3YrI/BD3mLvf3isgNUQWXiWtb
 0kq7lpNuilCl+Ah7zqHoCO0tvzAOmwz4sEoEQO46jhM8vj9E0acX7jFE8qgutJCDsz3Y
 3ULWrs4cZ5BQwPsHlxP1Jx3j3hdVNplXWaZkMxN26tOB3Gbgk4HJ3yoXLOAIGFlARtpm
 mt2icdAf5nr2UYMv89afcB+NLxrA2WAJam6wc40dOv1D/MAu6hepMHWHCpX4JqRoNj6s
 FdSg==
X-Gm-Message-State: APjAAAV42yAuh0w9HvMKBV3JHEv3IaXMjLARfWIxRmGXGnXZr9e3/kGE
 GqgA2/HeIbttLRrs/frSmKS4LuBsMaDOIg==
X-Google-Smtp-Source: APXvYqzZjqmA9maAN/u+MG/EpB6yaTKpdoChcU5mxKN6vc9kD25id12ilfrfF35IXl3H1nMAZgiDfw==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr31275776wrn.285.1560428080053; 
 Thu, 13 Jun 2019 05:14:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:49 +0100
Message-Id: <20190613121433.5246-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 04/48] hw/arm/smmuv3: Fix decoding of ID
 register range
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

The SMMUv3 ID registers cover an area 0x30 bytes in size
(12 registers, 4 bytes each). We were incorrectly decoding
only the first 0x20 bytes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20190524124829.2589-1-peter.maydell@linaro.org
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index fd8ec7860ee..e96d5beb9a8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1232,7 +1232,7 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
                               uint64_t *data, MemTxAttrs attrs)
 {
     switch (offset) {
-    case A_IDREGS ... A_IDREGS + 0x1f:
+    case A_IDREGS ... A_IDREGS + 0x2f:
         *data = smmuv3_idreg(offset - A_IDREGS);
         return MEMTX_OK;
     case A_IDR0 ... A_IDR5:
-- 
2.20.1



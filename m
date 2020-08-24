Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CE8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F3F2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dve8epIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F3F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Ap-0007yy-Tw
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95X-0004o4-Nb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95W-0004n9-0a
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id x9so3650509wmi.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=apEmOXm4AQqmayGyw572zskFnVNsfChXfz8USNcN8vs=;
 b=dve8epIUfMeiNe1rf+TGWWGzxvIwkaB+f9e1jikEu8IGtNxpNWW6dc3tGXIkOPr2dw
 vgxpiYzDlSjUXRftVO/9Iq4k4Auh8dhtEsKGOlarMUdLE5KXdFxm3XcgtmofPShKXi6s
 0QUKn1hBSypr4Y6zK41W0O5cmYT3wA2jyWFwPnvJW2C+cDlY6TNacrokQDz+4gY6/ADR
 XXwlR99lKWWijHITCJxPRtPWkR8oY0C5QZbbd8h2HO1N7xDmBPfJt4ktHR3OiyfJSA6L
 ZGub/NL2PrhzyQs4otIrfni2MvN0I05Jp6LuT0gSndLt4iE+0NY7ezfzH5igN69+F7qF
 ZNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=apEmOXm4AQqmayGyw572zskFnVNsfChXfz8USNcN8vs=;
 b=nSjfjrR1BXu3OqHUlkJixX5Mm8PJFzxFQt66Cn3cjk6/XjBHgR1Dqe8695wsD1Wv7A
 FF4rROsPCKoxuE63zKhHM4YHxhsud1Mmfi7mNK4CnttigDV1NX0Q+iIKAWkt7J5chxI3
 bfOP+9E72QdgOIzxVlwcUIC4+gN4GtjGY5dyGiZFk8XE1wVfHIlBb7TJEiRA6i0UZL8/
 cDqZcp8fEE4zqbV8c92oRFNiDb04KklmeEpFd/HseFtPb2Fswd4BFJ0VzpzPtlj+O6KV
 g76yJ8aEfdm0bAuxTjttO3sX8IzpRGFz1Mo/JJoFWGd2OW4oHCzyLO2t7mEaPqZNXVmD
 OysQ==
X-Gm-Message-State: AOAM532+x38f6+jektcU2pgcfnPI0+3YzdWMKWefR4HwdQKx43/smvlh
 1YO9izG6oLjZSkNdfwajD34D5tKq566OqFsj
X-Google-Smtp-Source: ABdhPJxu62EuD6hDwXGTiVyy8g5O1En38Etfpqr7YzEg2xHZUW7JQYtvuvo3kwlcl/JWQTurbQ+vzg==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr4886402wmq.60.1598262504540; 
 Mon, 24 Aug 2020 02:48:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/27] hw/arm/smmuv3: Fix IIDR offset
Date: Mon, 24 Aug 2020 10:47:53 +0100
Message-Id: <20200824094811.15439-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Eric Auger <eric.auger@redhat.com>

The SMMU IIDR register is at 0x018 offset.

Fixes: 10a83cb9887 ("hw/arm/smmuv3: Skeleton")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-9-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 5babf72f7d5..ef093eaff50 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -63,7 +63,7 @@ REG32(IDR5,                0x14)
 
 #define SMMU_IDR5_OAS 4
 
-REG32(IIDR,                0x1c)
+REG32(IIDR,                0x18)
 REG32(CR0,                 0x20)
     FIELD(CR0, SMMU_ENABLE,   0, 1)
     FIELD(CR0, EVENTQEN,      2, 1)
-- 
2.20.1



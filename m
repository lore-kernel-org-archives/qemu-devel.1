Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBFAC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF47A20643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTjvaKod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF47A20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiKr-0002HK-0J
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI8-0006pj-A4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI7-0002Zx-Aq
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id w7so6028458wre.13
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GnYXmYc6RRM664iT3oxB7lyBMcCRlVJ8yPsgk5u15TQ=;
 b=xTjvaKod0wdM/kzGIi61kAVVN9qCdg1E6BZ15UAByaVuiPmS4anUf1W9HzTAvEIRC9
 fcVfEkwdEYcua0fZ/lpI7Rn52Xgh0canXMQrHvevryPjbvYLvvl58o2DImFkuzZXRCKs
 5dP8s4CdwREKu471VbZZKrdod9OwBiIu9fTc+ALdatYhT1RZtGpQN7Cc/KXGgzYCrPq4
 mt9X3u1D6VV8pGzYkk4Rqd5mRaT2etm6JVv7P3rIjRNdvffS4oPXyOBFSvYQ20F1lEpD
 7AtiOG5AnBT3kyIL1WN75v+DceAqGf8JIGMP49aWMeWnNWByxreDjGsvXWZH1ijO4/UH
 Y6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GnYXmYc6RRM664iT3oxB7lyBMcCRlVJ8yPsgk5u15TQ=;
 b=rvovPDx6LDNox6wd+MOPyKH/5h8seR6CVcYzqVoqJj+nnLpi0AkqTP1wPtzqmRpeSP
 9kibbytGEvu6N/iBSkWsbAIgakRUnq3AlUnE58tsEjI5jJnq2t2/RAuxpo5PxkPjzQi2
 l+fg+QAbbRhl9uLYBmXaCyra4YID1/B8rcmaDRBHE+tRI7vpcd4DENN/iFVQsIjLDAqp
 qgyfVdiXOc2Gt2vRNm4DiuHEZEjs5D54bmnXoGEnytRMyuOmUjgkCHWA1bKOGoX+WE89
 HL8RyBdoig2RWDbd9H39jgb539KkWmfMu9+oDA/HX3+6iWm5hO027icaNHgH/BJ3/YY8
 Noww==
X-Gm-Message-State: AGi0PuaQ0N2yraZB4B2+81/MpQ+ZEkU9VFDaj0kqjPvP0mafKk/yUZ74
 pp1VpKj99Om2Iqu4vyA7zgcwSOHTELj2bw==
X-Google-Smtp-Source: APiQypJzqzs4V3aVaX/yPAadfEuBfLXoEuAPby7LDxGcuWdnuBSI77QcM2TgY0AE0yk4rAH4wMJGkg==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr13338094wrv.236.1588864705313; 
 Thu, 07 May 2020 08:18:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q74sm961246wme.14.2020.05.07.08.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 08:18:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/5] docs/system: Sort Arm board index into alphabetical order
Date: Thu,  7 May 2020 16:18:16 +0100
Message-Id: <20200507151819.28444-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507151819.28444-1-peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Sort the board index into alphabetical order.  (Note that we need to
sort alphabetically by the title text of each file, which isn't the
same ordering as sorting by the filename.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/target-arm.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 324e2af1cbc..d1196cbe01c 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -71,15 +71,15 @@ undocumented; you can get a complete list by running
    :maxdepth: 1
 
    arm/integratorcp
-   arm/versatile
    arm/realview
-   arm/xscale
-   arm/palm
-   arm/nseries
-   arm/stellaris
+   arm/versatile
    arm/musicpal
-   arm/sx1
+   arm/nseries
    arm/orangepi
+   arm/palm
+   arm/xscale
+   arm/sx1
+   arm/stellaris
 
 Arm CPU features
 ================
-- 
2.20.1



Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58903C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBBC20738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nhp2jQQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBBC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqhB-0004LR-B0
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfz-0001y1-AO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfy-0000Ou-H2
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id n18so7557819wmj.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=u7KCiGuOgAZ7UqunOZf69lXCjQ+SrqjjB07ACAIR9HQ=;
 b=Nhp2jQQmmXApv1pE5D9w1AtHZ4YqZL/UHM+CikIQ2a49cZaCvxBLcGJKzNw5qbwaFt
 +tov3wEl35c4dj/KyVViEh4OzRGhJs4JH8X7Unjg2qii1MOKlb2bYsm3XZM7fj0Z76un
 cgfh1FNJCN/FDOm5oNpNFOxp3sEd8gGwrZFHtvCjVWt354ktCuah9gnkoS/EaP7YaG14
 2LwOH3yMW0ykFDMpRrxKUNjk6lKJUsZYWALNrnOnT3oD5cq+BHl2pa+KLv24Eop3AG9q
 kcBeyTrCc92zABMzDLFW1U6eoPwYDpkGv01pGV/1dt431U+2vMSxbj6oYUP52KPZyJw7
 gfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u7KCiGuOgAZ7UqunOZf69lXCjQ+SrqjjB07ACAIR9HQ=;
 b=seAMZXGkJJ7opREsaMg4uqnfz08eaD8GYUcyFYRPuA+s7sX7ln1QnDfOQiYaZGp2+b
 ru0V4805A4rjFzneCAU1crAE/QPnlSzVCPhaYIzeNfoKchzwuUzVBfTBjqmWKmEg7G2B
 q7Hz5yjtMMTDaW/FtgCTGH1KSQMCuQcMjuacxtS9vpevZTdHKh6n46qnQqenUKbRMh/e
 tmol9ChL5+cC5GohSHdH9wBvRTz/PQqbJeH6v2JPaRTTFGLsoeEFj7rMIf2KkLwkUY61
 H360WZgLLLNHwq6vGY3kgV17qxBfQiOUv5xO3Rh5nKQaLLLaR0iW0BUn5bCx3zpd1wlk
 pDOg==
X-Gm-Message-State: AOAM530+Yq6au7ZmYJT8O1qvuv+/dM8/QXuXFl+450rXe2at4Y3IsFmP
 3lzoy6Jp/RQ5LU3zdrBC/ySTaOJeYTnQtQ==
X-Google-Smtp-Source: ABdhPJwdsXEOAxv/+gy5DyrvZCOxJ6gANqcTvUPZMbarEXR3FTNkDRPU2BGDnNGobgX7YKwbhSnoog==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr10059710wmb.123.1590088576824; 
 Thu, 21 May 2020 12:16:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] docs/system: Sort Arm board index into alphabetical order
Date: Thu, 21 May 2020 20:15:44 +0100
Message-Id: <20200521191610.10941-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200507151819.28444-3-peter.maydell@linaro.org
---
 docs/system/target-arm.rst | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 324e2af1cbc..d459efb3d20 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -67,19 +67,24 @@ Unfortunately many of the Arm boards QEMU supports are currently
 undocumented; you can get a complete list by running
 ``qemu-system-aarch64 --machine help``.
 
+..
+   This table of contents should be kept sorted alphabetically
+   by the title text of each file, which isn't the same ordering
+   as an alphabetical sort by filename.
+
 .. toctree::
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



Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F4C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EAC206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIvVcVJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EAC206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoTT-0000At-GU
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFb-0007a3-Ib
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFa-0007jn-Ey
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFa-0007iP-8t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:18 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p17so6237782wmb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xjn8RJQ0vY8rUfMNnaKgorm1b3kbGVHvXOz31kMfCJA=;
 b=nIvVcVJ83qyg50OrGtQp57MU++5uJWorzNom5qGy2nT8DVGSYwyPU1pZruFXkYq33P
 QP11F5U1CD16HhlyhU5AFuuOiUZyVdTn9ihawtcIsYLJrgFFabuRX6AGVXMrwgtmhxEH
 d7G2fcJP29ViUpuGTPikQIn38WE6FVLBIkZdtluXHSe5QxkhHkUOd3vEEwIk2s/da4Q8
 Wi5Q32WVKtRp7iwaJ7joWs9EGn/PNVi5+RmfXXA4+9uvHTjcY5ZD/HEcahjiM/i1one9
 km1M0f278/PW/lJXXrs3BUYs5twkheH8ozIWIZZMHWMIV1m/aSlJg8H2faRlOLle8VxI
 3rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xjn8RJQ0vY8rUfMNnaKgorm1b3kbGVHvXOz31kMfCJA=;
 b=gmrngAcWczYhz7GZVYaJMdhGhc+EVRvCO0PVAAy8lsKYxorfNfFWO9dlcse4+lUxOr
 eCBH1l91jmXjE1PKV7jCGFMDdwG17qsErkThEvSU5FzGom4L5K5xm0VRoEo0o8Dd684O
 jqn8+oZg8kT3vachp6UGqPmD4JJA7l4lWUxauj925pwLlIpVb4vJ/Ck90YrYbyCZUwUg
 twNvulr8+Z/ssE4vO0xvQy5mnoFOr3Tppl1DKI1BJIi0fidhW26jDnvUnw/gzIUBPze4
 E3EneVWd22ur5Uxi160gimR6Dn8wEUkQ7GG47vEtNFv22Y03a606yy2bYpgMreTluq94
 sNNg==
X-Gm-Message-State: APjAAAVwu18S/t1/HGFun6kp1DLB5N4IV8j/wArSeIybhTuMqRllAQcO
 rkIn1xGAQiA//Oj/J9F8dOx5qrEZ67ySfg==
X-Google-Smtp-Source: APXvYqxNdHYg0F2eJisfixjNYBbP0dCfjduPvzfhtEKampgPp4SzaSgFs5ei1bkUFNoXhzLziq9/Kg==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr28403322wme.52.1576494557023; 
 Mon, 16 Dec 2019 03:09:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/34] aspeed/sdmc: Make ast2600 default 1G
Date: Mon, 16 Dec 2019 11:08:38 +0000
Message-Id: <20191216110904.30815-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

From: Joel Stanley <joel@jms.id.au>

Most boards have this much.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-7-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_sdmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f3a63a2e01d..2df3244b53c 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -208,10 +208,10 @@ static int ast2600_rambits(AspeedSDMCState *s)
     }
 
     /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
+    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
                 s->ram_size);
-    s->ram_size = 512 << 20;
-    return ASPEED_SDMC_AST2600_512MB;
+    s->ram_size = 1024 << 20;
+    return ASPEED_SDMC_AST2600_1024MB;
 }
 
 static void aspeed_sdmc_reset(DeviceState *dev)
-- 
2.20.1



Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2DAC17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10CA214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2s50m4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10CA214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPuA-00057m-0f
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrV-0003JC-5P
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrU-0007M0-6K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:13 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUPrS-0007Kk-3B; Tue, 12 Nov 2019 01:41:10 -0500
Received: by mail-pl1-x643.google.com with SMTP id az9so8114328plb.11;
 Mon, 11 Nov 2019 22:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vr7OAtLxystNKN+NrjrWHkCNh0LuFiDiJrrJhFdZUC4=;
 b=Y2s50m4XrJwxyYZCwg/2AbvgQCUbirg5dt4UAGPRf8gcoYyGkAZatDg7Jd7koF5vfL
 8ylFG/aB2RoXMg+3UIKdC9iad4ApxBLuWkf1aIfCoP15tAKa/3+5Y6kMAKjJQhAyj1Hk
 604YQoKDzssLUMb/glsO8Av9GHyPF4u1xXvja3JUcas5+n74eg4UgKXiZH9yTLIhsJdL
 Zljnlw+sHVRiBxNN3wATc0cIwSn57CcsoxD70hVKeG/avKdbOGOKLOP6zponC+Ollwsy
 iyVq3z+I19zQjjE9zxCf7/pkktGyeznQbcrVLSxwy85QUE6iXBfM2Nv98r8p7+UPE6rC
 YAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vr7OAtLxystNKN+NrjrWHkCNh0LuFiDiJrrJhFdZUC4=;
 b=mpT8ff0FwDcFOViEmbuHx5aoPRJ74SUVleErykGCpzxpOCBuul/nDxPUAGZ4I6lLEz
 1uJsgbW9BzFIoA3fL5JN6q96ubuFfME2a627QF911q2TSu26prw2Mtay5Hj642/krnzB
 nyLEhJqGOGfjUGvi51/j1YvPSvUQ/jhsKDd78lur3WCmsWvmi68bX8H93Ok3KSBf6RHZ
 4yW2X4Dqqs2mtbdo8L5OFMc3F7Riq5Ys4t7Uq5Ek56mYk+7/+LKLgzvVLwd0WSDBynlJ
 I73bo5kTljSn2331iy5N549BrqgN71xrNMFeyo6mtrjcoGPB2Xk43TOCKhz3zjWB2XcX
 JGPw==
X-Gm-Message-State: APjAAAUgNb+S0uBnWoXr+RnyqbdUUbOEmjGJbfR7jiiSuOR45SEKK+Gh
 saJg2/dTQhr+qgLDuyy1mqQ=
X-Google-Smtp-Source: APXvYqzzs3FuqGuZtZtykUFQHOzm9dqFBjuHRsw9vLSvvwhH7olOX/bPX09CoruDjyQbQmhv7fOMxA==
X-Received: by 2002:a17:902:326:: with SMTP id
 35mr6518256pld.248.1573540868881; 
 Mon, 11 Nov 2019 22:41:08 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id q8sm16375590pgg.15.2019.11.11.22.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 22:41:08 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 1/4] aspeed/sdmc: Make ast2600 default 1G
Date: Tue, 12 Nov 2019 17:10:55 +1030
Message-Id: <20191112064058.13275-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112064058.13275-1-joel@jms.id.au>
References: <20191112064058.13275-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most boards have this much.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f3a63a2e01db..2df3244b53c8 100644
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
2.24.0



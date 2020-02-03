Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747DC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586582086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIzUlwSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586582086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygCT-00053V-Ih
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iyg9s-0001QU-Qk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iyg9r-0004K1-TN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:09:16 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iyg9p-00042J-LZ; Mon, 03 Feb 2020 13:09:13 -0500
Received: by mail-pg1-x541.google.com with SMTP id 6so8246560pgk.0;
 Mon, 03 Feb 2020 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=etoHwdNyoSRutm5MdnEpD2P8ySOBKOPV8Ax17Ri7UPA=;
 b=rIzUlwSx2cU9kTKSnSzkf/21PjTuERz6i0hT7ZLCiLODznauFpKYy8BXOCofpfctH/
 1D5aM91f+pt6xWAwHzqVckWSU+EypB9pqUAfRzLFXUX7Bcct44ym1CPqMuqS52BHtMym
 EF8YDBclpRtYKLtK+hkjwRxEYDMZ/kytOIDx5FSwoOlWZpT/mxh4trjf5lthlagS9xVi
 yWNA/roMAU8ZC3CKTTZ9YeRsCxnb8xYoC216ATprYQxVqZQkLecNKzCiPNutmP2nHZXV
 QfVoJvq1ftfRQFlCu3zG5e+MpfO3CTR2yq2VMF05m6x2z8WgZWnq6tnJ8suEgIgTKjlI
 4/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=etoHwdNyoSRutm5MdnEpD2P8ySOBKOPV8Ax17Ri7UPA=;
 b=gytas3wdBMtMYxYp2s4PqlZyoH44rFZzkY0fanEP36EY9a3kCgQNAgOZRSh1g0dJHU
 x/XRzb7vUh7coQyQ/s34xuPLIXyG8nysfbkfweZs4XTmD01rfQXLjCRinrVbBHLCub/S
 pbQI+EuCmqo/eOt5skkWAMyD2SU4imEfarl6eeAVQXN5HbJEIqwmAFgDhExvGp/hCYYz
 8j2jaRl0OEw79T0C0LAax4qogAHwT47owevKLNV2hUWKyFK/yB/uYnxcKSIXxVYxqngG
 49fHjKbpD0FGC5+ECLvJrE884ma4BXod5YS2twqCBkne3V0DFQe1O6VfOmMZtlJJTuYO
 Y5VQ==
X-Gm-Message-State: APjAAAXm+ilX2O5K78KVAp2w+oRFWv3UQdopFWwwVqRFOFT1uH4bCQpp
 b2zsT1trOrpKDkyXOHHbyag=
X-Google-Smtp-Source: APXvYqw1z9IvsrNpF/Ovy/W2pLZpyTZAyBf0dUVByblVqFbrME4fkfrMfzf5xGqwxK08fWcqmEQQAw==
X-Received: by 2002:a62:4d87:: with SMTP id
 a129mr25624154pfb.116.1580753349506; 
 Mon, 03 Feb 2020 10:09:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 10sm21451759pfu.132.2020.02.03.10.09.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Feb 2020 10:09:08 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 3/3] aspeed/smc: Fix number of dummy cycles for FAST_READ_4
 command
Date: Mon,  3 Feb 2020 10:09:04 -0800
Message-Id: <20200203180904.2727-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203180904.2727-1-linux@roeck-us.net>
References: <20200203180904.2727-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel recently started using FAST_READ_4 commands.
This results in flash read failures. At the same time, the m25p80
emulation is seen to read 8 more bytes than expected. Adjusting the
expected number of dummy cycles to match FAST_READ fixes the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/ssi/aspeed_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f0c7bbbad3..61e8fa57d3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -762,11 +762,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
+    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
-    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.17.1



Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059FC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1AD214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="munbN8Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1AD214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPuh-0005Tz-TV
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrd-0003Mc-Jg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iUPrc-0007QW-Iv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:41:21 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iUPrY-0007O0-Ld; Tue, 12 Nov 2019 01:41:16 -0500
Received: by mail-pg1-x541.google.com with SMTP id 29so11180175pgm.6;
 Mon, 11 Nov 2019 22:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j37H1qa+h9fHDfjTASOPnrg2HuSkQw6LSGgwlJ4L1BI=;
 b=munbN8JjSqEXfb42+yBm1Gw05N9mU52wiSskJnU7YntaW5je8OsU3VO8GqzLdAT6ZA
 aar8hkWM0ILovvTGBbVHpMZXgQv5h8BrU3q5wCQEUb+aPXP60KUdc7VOTua2Z4wsXBGx
 n3ClqjyFNmfc9TbpJgDNj1YaS9J1KG3LVGxfxg5KZW6sg8+8bOGugsRWhZVoKJXpK8Th
 5Fyc6bNKU4CO7wKDyGIfaMjQ7J5SqDsM2G2Ow5Idcp/yy5yVzLQ8Dc3XCmKETM4kHOzn
 5LNWoZWa2G0aTdkeCFJY/SeRCC0WODRFkEaVJLmrvK8tMLV6vSDKiMpC6ezo8EEwzu0b
 n7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=j37H1qa+h9fHDfjTASOPnrg2HuSkQw6LSGgwlJ4L1BI=;
 b=jdMzzQ2NstfTltWQSu0HaqK4LeQR/pPmgyV5RqDUepDsztnXypgdWRxBmlTUcixvTy
 OHy95CfQhfqLAym4u+iC3YwMAR9NdEFQ1nZL5Oatkz358bTwYqUNUnswcLYEI+O8vgAU
 h5lySxRZVHM0R87s3zDIdm4VgyqOgACu2VNEwGgowOKYgtwoW7a5FrpgYCEvcpILeXUh
 pzx6Vtc8Jv+INrcEQdPLMUSalpm/uaLAaLtPcBXXoxGJx18iBs9ueSsPEjzHJFqnlvbe
 u7FbtyU008D/bNNfBoPaWjijrv7CMcLpfcMQ7JoO0jXMCFKhhSYQo1evXQtzwuIB8d3e
 ds+w==
X-Gm-Message-State: APjAAAWXd3ShUyKME6ltEtOxuKA4PU8rXsDYaBFOY4XYnzSh9woPCTNb
 sTvboyxz+Kkoou+Z8sq1O4o=
X-Google-Smtp-Source: APXvYqz7FOSyX/dYD2dqFlp3f5xEt1LTmd6MSzexY1TghuZzJaPxcFCVmRl2ueURCXApNW88tASDPg==
X-Received: by 2002:a17:90a:e90:: with SMTP id 16mr4277177pjx.65.1573540875064; 
 Mon, 11 Nov 2019 22:41:15 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id q8sm16375590pgg.15.2019.11.11.22.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 22:41:14 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 3/4] watchdog/aspeed: Improve watchdog timeout message
Date: Tue, 12 Nov 2019 17:10:57 +1030
Message-Id: <20191112064058.13275-4-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112064058.13275-1-joel@jms.id.au>
References: <20191112064058.13275-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Users benefit from knowing which watchdog timer has expired. The address
of the watchdog's registers unambiguously indicates which has expired,
so log that.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/watchdog/wdt_aspeed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 145be6f99ce2..5697ed83325a 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -219,7 +219,8 @@ static void aspeed_wdt_timer_expired(void *dev)
         return;
     }
 
-    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
+    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %08lx expired.\n",
+            s->iomem.addr);
     watchdog_perform_action();
     timer_del(s->timer);
 }
-- 
2.24.0



Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098AFC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D278E214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRYmMeMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D278E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izm21-0007BZ-14
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izlx7-0000My-Sw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izlx6-0003E2-Sk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:32:37 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izlx0-0002rS-CN; Thu, 06 Feb 2020 13:32:30 -0500
Received: by mail-pf1-x442.google.com with SMTP id s1so3529362pfh.10;
 Thu, 06 Feb 2020 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IilPI+Sl+B1I6W2BM0SWvCm9l7ZzLSY3Gh4DaMCNP84=;
 b=MRYmMeMeK0LrfdlBnYA80D6ZOqlWW8huDdFcoVVb5HtB7oJkkCMiuUJ4isEtkJutMQ
 g6p2VXaPGFBMSHjPxr1FvKs0uYe23MNJY+L7ztF9YpVhHbUhUP7Yn9xe0bhWObP2g4yR
 WGFKdwS73OTGI1pajnq8ds+WlXrkosbcmusaV9VoD+hyssqfhbw2403nzx2h8BJyAh4U
 OvPZyhmz/fItlKH4rHtkL5aO92zPEpCy3OcMQFTZSbQgW47e5765V5sGX8XxXMcLsqEm
 b8ivxDdHuaOpjn+ooGcJdd/51couDDkQiMQ/QRIKi7gipP5zunAc0afqGeQkpVjb53fm
 RD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IilPI+Sl+B1I6W2BM0SWvCm9l7ZzLSY3Gh4DaMCNP84=;
 b=Jv07uvCVvoANmMmTKJAt8m/yzawU8m0dAM4+B27ToprGLlBhIayULYv1k4xXbnS9Vc
 GOi0qquINFg3s5mfccDekg3QQEbRHEwVoidY2ZAKcPXq0TbXEwQaR7hH211uaHhS24Qs
 tlb7vOManzD6FgdQ0Yu/inbtUx3DJIDyyK3/dlECPYQMDPGRLW33lo3sZQnF5B1C6sda
 NUVlt9iybf12XhXs2f33odp0kjqlChaDlXY3PpL++NefnhCX9P/ju8GQfN/oLdsDoHYU
 AlwfXhOKs/ETlHTLwkAUmmIgU3ywlLAASEIjLf2TyCPxqmPQ4+oJfCsQmpuXGPduCQdP
 9jOg==
X-Gm-Message-State: APjAAAWz7vHDMM7K4VKh5gbitS+rLzrfvDrIhnYwUegRbQWB0hnArRer
 j21goPfIRLmDGav5njGMvgo=
X-Google-Smtp-Source: APXvYqwPzrYYEVvvds6kGd54V8A9rorEuu7jXADmNvh8HUjLrfMVFbUUwSHNlNdQ6f3lLCBup7oPXw==
X-Received: by 2002:a63:6e8b:: with SMTP id j133mr5030071pgc.6.1581013949370; 
 Thu, 06 Feb 2020 10:32:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 28sm127082pgl.42.2020.02.06.10.32.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Feb 2020 10:32:28 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 4/4] aspeed/smc: Fix number of dummy cycles for FAST_READ_4
 command
Date: Thu,  6 Feb 2020 10:32:19 -0800
Message-Id: <20200206183219.3756-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206183219.3756-1-linux@roeck-us.net>
References: <20200206183219.3756-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel recently started using FAST_READ_4 commands.
This results in flash read failures. At the same time, the m25p80
emulation is seen to read 8 more bytes than expected. Adjusting the
expected number of dummy cycles to match FAST_READ fixes the problem.

Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycles")
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 hw/ssi/aspeed_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 23c8d2f062..0444570750 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -787,11 +787,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
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



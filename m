Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D2BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19E8217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zu8XjrqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19E8217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Zm-00042M-0Q
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:44:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MY-0007Un-Ty
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MX-00069d-Q2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:14 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MX-00069D-Kk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id a3so3335124pgb.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NqFQGLUWEK2q+OruuYLxByccY86fvPfXVx23TDmISjI=;
	b=Zu8XjrqUMrWf6XQgZqoSlfd933QyJLsMUJQuNdp2L7GFynd9RDOEw1hWF8yxnOzvlw
	i8NC2LAfv2ISDvMhlXDqvvmU0yyNejuABQKu/L5M05RTWlIlo38v5VuKLPD1Pu/RCtBH
	c8dlidgMdExoOB95L+z/Yo/VhCdJBDf1HUUwfs1nk7FBtaqp5MVzgz6x4Yms4pd42Ry4
	gd9bqMWeqHjidCpR3gO2ShzKlVYfr5Cg6IS2TAVFEtwPplwynNDJ4Lku7nltwjQivkUN
	qUaOPK4OXKwO3LMyBGDkF6Cr41X26Ya1fWH0nf++KBfnx5554yDEFiOn7ls3xwUHcPRu
	QFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NqFQGLUWEK2q+OruuYLxByccY86fvPfXVx23TDmISjI=;
	b=FrJmfpIb7stKljxVT1lbZNxIQAH1aQcgoIUI6li/oK6JzECbkObRbAF90lx12IRG+1
	LvfTutMO++dJ3BLEMXcV7KZ5PxBENMizUlw4m91iOmOOsUH+y/G/pLHsWpimXBwGPo6G
	ildeS4z13Xool6tJH34myS3yZPu+v6DN0B8grCMvrLB5suTYWSX2mw/FMTC6k84+8ZI/
	6WqKt0Vc6Md3g/6N6YjHkMzD7fRJvZ7WuXQeukHKDTVcuumbT+P3f/3Voy7Xzhh1XdWk
	aL5AUavmxBIH+8cUuON/Zaod/jKtlY2krfsIXIHg1jzqx7y9/iqq9oufRFdTQnbCmI0F
	j4Kw==
X-Gm-Message-State: APjAAAW+437024M3rkhBF4ve6Zvu9XqNV4tmOgK8YlPR44lOJ16OS780
	bbRMEsQObZW7idHbRuCKdKw6I2uUTb4=
X-Google-Smtp-Source: APXvYqy6wOc+8c96iQxItMOjG8tbvfPrnnPa9zEmbjd2a+FXMa8yonoQeqIn8msvlZy9MTcJF4TleQ==
X-Received: by 2002:a62:4ece:: with SMTP id
	c197mr16128216pfb.139.1557509472366; 
	Fri, 10 May 2019 10:31:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:41 -0700
Message-Id: <20190510173049.28171-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v6 17/25] aspeed/scu: Use
 qemu_guest_getrandom_nofail
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of rolling our own error handling locally.

Cc: qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/aspeed_scu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c8217740ef..ab1e18ed4b 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 #include "trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
@@ -157,14 +157,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
 
 static uint32_t aspeed_scu_get_random(void)
 {
-    Error *err = NULL;
     uint32_t num;
-
-    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
-        error_report_err(err);
-        exit(1);
-    }
-
+    qemu_guest_getrandom_nofail(&num, sizeof(num));
     return num;
 }
 
-- 
2.17.1



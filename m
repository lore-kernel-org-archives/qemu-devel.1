Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE5C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D03217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmKaoaZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D03217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOubI-0006X4-2r
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:45:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHr-0006MG-MD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHq-0001HM-Gu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:23 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHq-0001GO-Av
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:22 -0400
Received: by mail-pf1-x444.google.com with SMTP id g9so2244611pfo.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NqFQGLUWEK2q+OruuYLxByccY86fvPfXVx23TDmISjI=;
	b=PmKaoaZexxoZh96Z5SSBy4MbrFYGDyGKI6XKBNjH7wuaKs10QNgrTo1r9QxWIm2Cxt
	o9BXZS6H/B/w1JbrIW62I5XQTVJ2JlkpYmG9vea9erBWiW8RnLJlcExHDm9tv4oWRvVy
	fn14ogW1auLxR6kQG1c07EiYK0NnlBTeh6377EL8KTopwKRG3l+gIsuBKJ6UTihSQioE
	r+HMobJf+sYB91Zk+V6XdadNcyhtm6c0ULvTP/pKGjhTt8SB6g6t8PXm1oAiaI/QlmsF
	F3jUIInF2+ic9gJ0zx/REhj82vTKXclXusWv6lzvAqUcitO/1FQs7rBqjnTDAZZSg1ft
	BMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NqFQGLUWEK2q+OruuYLxByccY86fvPfXVx23TDmISjI=;
	b=mFfLX/azz4z0gdHbD8yk9OImpVoeLtCgXlNC+UrVzGmm/fOqSw5jdZUmvhqAKfPYT9
	2xtcxdBr2V4K6jcbNdzVnuDvNHQqY7+SikXbDwI4p5usJ0d3nzlF2wLQrU3JrhR0Tla9
	EgMyhH5TBuVIUVPA4k4iT9gaCueJtNBmTFk1l2kiOgEFJqMde/4m6QdCoueJhyI312gc
	OsqgNp5wWxIVzCixc+daSy6seSTRAfwhKx4KvmGCEEcZ3iteQkNHi547bO7yx+V6pRfM
	Mvz1aWI2jVuSsLXxM+sf5tZgOjUD61UP5wboWksHrW+dCGTY2yRaU/Bw2HlU1t4fuyTm
	fDyg==
X-Gm-Message-State: APjAAAVgOlzajDOJsNFEKjlRzcW3yKkbzShRKsHXKvCgvH47TRRneOL8
	uGzQIVu8jNzEMAYtdMdxJ9Hrgv1zSZs=
X-Google-Smtp-Source: APXvYqyRZXio1LWolVpRtPVnE/YcnTKLBY3979p2EYKWUwZuhHQo+LKp4zgIesxuvO24236oMnXiIg==
X-Received: by 2002:aa7:842f:: with SMTP id q15mr9927856pfn.161.1557451521062; 
	Thu, 09 May 2019 18:25:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:51 -0700
Message-Id: <20190510012458.22706-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v5 17/24] aspeed/scu: Use
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



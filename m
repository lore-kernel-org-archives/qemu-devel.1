Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C52C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F9E217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/PcVJ5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F9E217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWpA-0007n4-Ht
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:22:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOo-0008Ga-QJ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCN-00089U-Vl
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:49 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCN-00088Q-Qi
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:47 -0400
Received: by mail-yb1-xb44.google.com with SMTP id s69so1085143ybi.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gZNiNYQQXuA93bC9AkQ3RkBuv003My9kgUQccuqjr10=;
	b=B/PcVJ5JaoLFNLP3h/Y5MLrwQgrFOMJz4Nle0d731qT/PhTmK4OHsMjnEH3BY8zA+U
	xtiaTZU8swftv8jVV9AXxlY4xxMJEczk2CJf7s8VhSkRU4uuXxnUSE+8T7UaoBivxq2q
	RESa/ZuGE7xK+49GUAbv5u92GRVL+FS2ANCCHO2RrE62MRkGBsshub+9rINGYC1NmYEL
	iD2a0nrkNHO46kzsLqk+oNDdMIZdb0g1hGsSq6lsOBJCi2R07691mMRlg1ghxpkr5Vc5
	FrwEfZUKQDUm9IMBq1Nc6fsPesZ/btYu8+MNq28dR0hx47T2rvYxDzPFLYEJXilqmrfe
	pRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gZNiNYQQXuA93bC9AkQ3RkBuv003My9kgUQccuqjr10=;
	b=Rb7OjTBVOpljbu2yPJEsu8eJ07XUUZTrvk9YDioNNj91M9P2bM1ND3/F4YkmX5Qd2D
	xYVw9Y+EQu+FBBS/f9RCaWzvhkEFAUbJ2TdjlYaEFo1yyz4pDjrBLZ0JEzYQgRjHgoE4
	c9NC43rwNWnlGdVutyO2HHAqa44IkOG5oYU549i8c8w/1gImyqCqLqOLo5cV5tZefHqf
	JXVdqkbfaaFvO478/ocwF+rGndI96NV4XJLbRXY9XnmwEXTZcSswBL20EI0TXiws71sg
	It7P9VyFbkK6QT0A9BdjksR78q0YtTKhhmlUtwSPtY8A4/7a0WUSuyEBjxJ52cKlkhfg
	0MGg==
X-Gm-Message-State: APjAAAXoMiBb9XmG92txaCoq9WAl+/ppAGab3ZPm+UOs14y4/0uF3cYS
	qgujCTMum7rv4BxoWEe9oRewHmXvSvo=
X-Google-Smtp-Source: APXvYqz0C28LmVIKf8wvi/NNmWioaPE9eW+FGe61d+AcAE+ZlEzG2Qshe/kw2CE4GRBAngjyYe/W2Q==
X-Received: by 2002:a25:7502:: with SMTP id q2mr22098191ybc.31.1558550566459; 
	Wed, 22 May 2019 11:42:46 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:18 -0400
Message-Id: <20190522184226.17871-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [PULL 17/25] aspeed/scu: Use
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of rolling our own error handling locally.

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



Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB9CC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B99B2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dg5+08ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B99B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhkh-0006kX-7Y
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:50:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVO-0001Ez-07
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVK-0001T4-Pe
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVK-0001Ry-Ia
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:18 -0400
Received: by mail-pl1-x641.google.com with SMTP id z8so6722983pln.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=N99BQlBfn/0a0vkPsRVGBD0Y+fTNw9UH381I+mLvorI=;
	b=Dg5+08ulJwFtevhdXETSihRnqYW53GxvjPzw9ZR3Qx6fNBXqDsUz+BEg2OG4QoUPe8
	vkoX4Cs3zdwrbURmxP7Z5gDG9uvSpuYLcAl2mt1cL2BfZWIJDouEdvI3YxOExef4pqDP
	m5dU93hcjaSZu/r5Rq/WnMWTNMIyIDCMaIuzmiHaojzodxuIcuUpU7QSkftKg1DT8hcJ
	mNvgznnAm2labFfkUIS9R/KqaLXyETesGAqL8i2q5hn4GBphmnJHBn+SMNi+9FgWyjKF
	xqr9Jb/vVNb6XzFDBMUBx5vJA2Xli40KCjRhl+BZdwcIDuCapR5tZ76B1tHpCOrESQ/I
	5vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=N99BQlBfn/0a0vkPsRVGBD0Y+fTNw9UH381I+mLvorI=;
	b=fK0tgBJuWWwyf2phhUO24LUVeIorSMZ7OJc491yH5Rle2HYkYqzTM+HE/+UeT3Z0gx
	J9tUWbFqhe0bmpImswdDt9jcq2xZEwnDeGajJJH7crgIrvGwVFe2SnfSX+WY5SM1p5YX
	AEf8iZw8ZklrjgQEc0UpzWtbOUv9JfQ0dkqCb8SXmepYaoe1MDElzYWxf0TYJOzwTMUL
	vcS2J6NP7GEb52l4JPLZeoeXSJRoVBZHPCe6SK6HFmEmCwsRjh+Fg2Jq44wUP+nKFyOC
	pG1SN5Hwy42FOEBaSKGlYoULVA+8UaWq1Oc6onUg1UFD+a/zFtqqKLMMTBNGH9qnsa2b
	NzAw==
X-Gm-Message-State: APjAAAXdjyTU1cxZ+PIsDJNYI3Ffw0Oou3ue8oi+bNfABRTcBSiOdoy6
	2OH+2ucw9Yoidcpap/rfMvj6LIvfpH4=
X-Google-Smtp-Source: APXvYqwyoYJRvKtAqAdVjtdNgDRMJYwzjNa1PM170md8pV5ss2e/e7CItTFdt+H+ZpZn0Ez2vVS2GQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id
	j5mr34356896plt.337.1557164057250; 
	Mon, 06 May 2019 10:34:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:47 -0700
Message-Id: <20190506173353.32206-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v4 18/24] hw/misc/nrf51_rng: Use
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of error_abort directly.

Cc: qemu-arm@nongnu.org
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/nrf51_rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index d188f044f4..3400e90a9b 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/nrf51.h"
 #include "hw/misc/nrf51_rng.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 
 static void update_irq(NRF51RNGState *s)
 {
@@ -145,7 +145,7 @@ static void nrf51_rng_timer_expire(void *opaque)
 {
     NRF51RNGState *s = NRF51_RNG(opaque);
 
-    qcrypto_random_bytes(&s->value, 1, &error_abort);
+    qemu_guest_getrandom_nofail(&s->value, 1);
 
     s->event_valrdy = 1;
     qemu_set_irq(s->eep_valrdy, 1);
-- 
2.17.1



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E7C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEAF217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZKBvI5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEAF217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuVF-0001zP-85
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:39:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHt-0006NW-2w
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHr-0001Io-Vm
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:25 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHr-0001I3-QW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:23 -0400
Received: by mail-pf1-x441.google.com with SMTP id z28so2271820pfk.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iRt1ekpVqMBTFPlbEkwvccpMEH6z9s1kPn0wCee76Ys=;
	b=xZKBvI5wkHxN8vjZl6NblWPq5dSgQO4dYbU3Bgo5lChSGqLdi8PvGxQsaPmWTMXKUZ
	prPiD6tUxsooCy/3NbroKaReKsUjU2y7JhTaph/hTZnBk5B/kt0ISR0iUZ5ZAue0M1Dr
	UzJMuyWoGIW85R+sqeMwRFV+6tpYmwVzaBBLSuzYtJdqd+TMvxeQVCCDg5rI02Loah1S
	OtQFJQn1X4liUzI2pp8Zi6UEb2lfk41tWRuSOMA6MN5lizf+F2U0naiPVrRll/cIy9Rt
	A85xKvcWmrTsztX+lZDaTNeghRqz2kOcinMD+0uYVdfZ/UzOaT/dnwhuaY2INaqW/ItK
	6hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=iRt1ekpVqMBTFPlbEkwvccpMEH6z9s1kPn0wCee76Ys=;
	b=COe5TcuM12Am6FNniBFTKa5oGAD9+wagS5mtdCjogD4A2IlG0Pbhtx9aOMTlwKKd6S
	EVss67lUjsgv1agny/1WmOD+4EHtQoULuB1ZioRPhjjhjERJjrVqefEPX8Tw4U2K96r8
	fjqEVTe0l2LjDPQeHjgSxe4W72R7LTcLdo0FoaoAsN7lHT3CQNJ4nYV+3fOx4led+Fpn
	fUo7nCSsuoBxeEECzfJ5kmTOALm61oNQuD5Q3jZQhPg5GZhbh/WH43nylnNMhlcqBlcL
	kaX2CScou10h5mS8dVOGReAMacSG65/b33ug0ZumSvfUMBW7BAE9VBRm2ZiMAZr33oSC
	w2Ng==
X-Gm-Message-State: APjAAAW+6w9tEuqos9ZnLHtLhWt32CCxtEUnDmoWPxa5pLlMgT4G7K0m
	b9ToSk0jZ2EPUYrbujpbT2GTuBdf9KM=
X-Google-Smtp-Source: APXvYqzzSH5vBOg/Fqdstq2Ekp30Iu0CwF8mdFR7Cer7l8fiiOSZlF4/wY9bLTIAeeVcsS4YAP3XkQ==
X-Received: by 2002:a62:4281:: with SMTP id h1mr9882033pfd.162.1557451522632; 
	Thu, 09 May 2019 18:25:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:52 -0700
Message-Id: <20190510012458.22706-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v5 18/24] hw/misc/nrf51_rng: Use
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
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
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



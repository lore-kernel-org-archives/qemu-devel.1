Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5332CC04E84
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6AA2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgF8HzPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6AA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSzm-00083Q-DF
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:53:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmw-0005mq-2i
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmq-0002E5-Ne
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmk-0002B0-CD
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:51 -0400
Received: by mail-pg1-x541.google.com with SMTP id c13so2528493pgt.1
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zHL5/dOLNq3cxnvhnBPOBazkJM0pmZq+fc+P6w38V4s=;
	b=NgF8HzPq3hUpPgukWYKOVmFXN7jjuXkq4n3g/lazes+V4szF+voHzAT+KTPT5vXVKR
	gtUOk5Zar0zJYvQovL/cb9W2qpz6IRGy5jU+Oc9l4SebLiXPulN0SAp/Nz8CZMNEj25i
	H3uHDxz04GXlulOuokRYThNvOTunXSZCFjZysL7wfZOwMlRrtzKh2/aJFC02H0SxNpTs
	jTbWV6pAX2xWeG/FdLqT6rkbwyhIWj0My6uuc5WXBqrs7akU1f6eIqrmE8wUN42kJWuN
	yCwcALfwi3x5WAiU11oET3eNMY04m7Ril7vdECWMkdeDMxaYuVdPxrXIongNBgNR5SFJ
	UBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zHL5/dOLNq3cxnvhnBPOBazkJM0pmZq+fc+P6w38V4s=;
	b=s3bqSUyLSR9ooSRhTtKFkZg4qUIRp8WjOeczpvMxIrtzqj7EUQjBuidONG30Ud3CmR
	q6k+gCE1nE0tpOW2GwyAWkMEsIInG2fqzC0aqBG46wd8mSNfjFL4tDynjgS7pZg36BDa
	8T6AIjDcQcJ9BjqnofvzyG6o17PLMKDjLrCyXjX41ZaDM2ll+MJkmlb6KFOxMd+Nuksm
	Wc0JBgKs1st0FqXJq5HTS8EtoNMPHY17JqpQT8O84/MUUIt7O5tN3x/0Zs4dGf80NENF
	KsKahIbNoQuHUdZ1cXSprhiHJnaKqEx++Ccorxnfn3lNFoNXnhBT7W+Qlx29rFM+TVZr
	c3IQ==
X-Gm-Message-State: APjAAAVjFdChACDE5SABIK2QpSIhpOsmI9Hg++GLmENwaydifde0UVlT
	/o3maBkzGnH/4ctvg0bT/g9o5cbAgXI=
X-Google-Smtp-Source: APXvYqya7hsxHF6vWCZ4fvvaEdv5UGR4ukKTwZQHClh2K4DY0Xj2BOxaIG2Wklrnt3YvLRFQNZNlZQ==
X-Received: by 2002:a62:a511:: with SMTP id v17mr31236498pfm.129.1558060788972;
	Thu, 16 May 2019 19:39:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:17 -0700
Message-Id: <20190517023924.1686-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v8 18/25] hw/misc/nrf51_rng: Use
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of error_abort directly.

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



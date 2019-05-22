Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F89AC46460
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3AA20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6Au61lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3AA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWXK-00009f-4I
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:04:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOn-00086d-RV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCQ-0008As-3b
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:52 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:46557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCP-0008AK-Tu
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:50 -0400
Received: by mail-yw1-xc44.google.com with SMTP id a130so1226271ywe.13
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wKy5ep5gzBeVJvdgqxMAwC/EHW/NEI1i+sUaPM2vsGg=;
	b=D6Au61lOK217c6i5LElq05rVyQKQbmn2pNey3boFrtxtSEThXVHUu3ot12gV+CkRWd
	6UQAxBzpWOy9ixwBm/LAaJy6zViddRGqqI7M1zAVESCGxT3sleVAvUkHfXM5nlrnr0UT
	JOyIyfv7O64xd7l8E+0RdOLxGYLWbUsx4NKle+UvNquTt+vIoOK8SYzauVVYYRAgOsvL
	cP9z+zQUd0HRe7AE+mCWDT5AY7OTWUd5leOoyBgFNa81UZtgmKKCgpr07GYE0+PNXKCe
	lbb/1cbsIb140iath7U2DEMxYpEXtidHLQEeWIX8/IZ/4PKV+qeRWRW+Pspbp4V2xRQn
	pl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wKy5ep5gzBeVJvdgqxMAwC/EHW/NEI1i+sUaPM2vsGg=;
	b=Qq7l+iZs2UxPf82rZbf38TgFIvcHkMHXJEYWuIOAPVM1H6iojjckq6IbHWa2blAuog
	ssCa2NWf4TTNWoSMd69c8rDRCbdXjtNSe693cD+9UnA/b1Hmrnj1f7PHoohs66LTtye3
	ExHoaXwb09t59evxUXjBUCRHfK7832WiFNMX5pHW9q6WzhEgC5zQFRiv560D7WRVha2f
	nkOaxIIe1mha3IJ1Mu973H10KJyDttgZqMn9uy1wgRrqQbPml1jOFwaTTIDkWcrQp3MA
	EhCgygfVZopkBVuh+76mRqzsPxFHEVnY/rkB6doTT0qrO+wbwyKT+AlbGj+oJbzuSWa5
	Z+Og==
X-Gm-Message-State: APjAAAWhnRO9YL7DA8OaMQcaDjhvq00h1A3cAFqxTwxtniPesT7MAqs9
	VmojBXabfW6JCptjPBf5uhkfg1WGA+U=
X-Google-Smtp-Source: APXvYqy0fgz/9DyRLZFpjD9P7dDhyck2g4dRXY6d7+VluSaQWAtssoqVR4t4BYMVFR9HbuiyFHWxBA==
X-Received: by 2002:a81:3c13:: with SMTP id j19mr24625854ywa.483.1558550568683;
	Wed, 22 May 2019 11:42:48 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:20 -0400
Message-Id: <20190522184226.17871-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [PULL 19/25] hw/misc/bcm2835_rng: Use
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/bcm2835_rng.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index 4d62143b24..fe59c868f5 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -9,30 +9,26 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qapi/error.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 #include "hw/misc/bcm2835_rng.h"
 
 static uint32_t get_random_bytes(void)
 {
     uint32_t res;
-    Error *err = NULL;
 
-    if (qcrypto_random_bytes((uint8_t *)&res, sizeof(res), &err) < 0) {
-        /* On failure we don't want to return the guest a non-random
-         * value in case they're really using it for cryptographic
-         * purposes, so the best we can do is die here.
-         * This shouldn't happen unless something's broken.
-         * In theory we could implement this device's full FIFO
-         * and interrupt semantics and then just stop filling the
-         * FIFO. That's a lot of work, though, so we assume any
-         * errors are systematic problems and trust that if we didn't
-         * fail as the guest inited then we won't fail later on
-         * mid-run.
-         */
-        error_report_err(err);
-        exit(1);
-    }
+    /*
+     * On failure we don't want to return the guest a non-random
+     * value in case they're really using it for cryptographic
+     * purposes, so the best we can do is die here.
+     * This shouldn't happen unless something's broken.
+     * In theory we could implement this device's full FIFO
+     * and interrupt semantics and then just stop filling the
+     * FIFO. That's a lot of work, though, so we assume any
+     * errors are systematic problems and trust that if we didn't
+     * fail as the guest inited then we won't fail later on
+     * mid-run.
+     */
+    qemu_guest_getrandom_nofail(&res, sizeof(res));
     return res;
 }
 
-- 
2.17.1



Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E47C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE5820848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6DT1Oeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE5820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT4B-0003At-Qe
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:57:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSnM-0006Cx-By
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSnL-0002WQ-1j
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSnG-0002BZ-PL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id z16so2503476pgv.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/VWGaUBQJcHRh8ZCol9Bt7n9p31zv9AWS8bL9WKxKYs=;
	b=I6DT1Oeg6MAL8iMt1FFcz4RercqdWySvvBan8w48H/yI1HpVufU0VqVbNGV6AOB1V5
	MzNqKZjsU+aSbV9o3s+2/SioXZfAZjf8e+QkM1u+JVgCIZmDoMAmPhFakQox6HTxzv6E
	8MJ2YT6SxPHFHZ7cggmdwe51qyNCO813TB6EXvqFWvk5Kt1Ds4RUiX96oVfd67xSRbQV
	MouSeo3ZBeOPSRFKPZwWClb3sigo867WQuaWgG7bP8/mpu8kiWqbu+0lRh1w4CX7Vrez
	6uenrs5oiEnCaqpv8HVmWHh1Et3DCCu8utcGriVLZiNdOp3I+uHNDFANNxnImCvClkc4
	xt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/VWGaUBQJcHRh8ZCol9Bt7n9p31zv9AWS8bL9WKxKYs=;
	b=Z1RiK3ld/zaZHMXZd3adubr+z8KqQ5po4+CIkp8+lXQuFW2XnuAP+fLZQm4nzoEo6c
	scr/lVD7mTlQy+A3nzXzsY/RNstzvOL1xS+9GM0OAvKW+R/qnMRN/AWkXUiwAOFldjoI
	1AHl8zGA3DT2JJtzpNC6A0kcyZYXVs8IK3wtnCLKjUCjuXNWQ72GnQBV+ZMQlCid9Jvt
	hsxHjETpOD0HQ/RUePLW9cVN+5yizZ0QGwnrPz1Bt21dgDqzvzNGieHj2sGQwwGsmesf
	A1cx1zswYS3PiPS7mctKUZRhd4OS4XRsMMrsrVAYg5BF1+jQomNnNM4gfAdSrG4hmRPJ
	Tn3w==
X-Gm-Message-State: APjAAAX9p8TY0LmMCh55MC7OcK/N0k1ShHCqj1TYs+tPlvjdWLA5DuFT
	H3Kep0KaYTFgYRnu8PIJd5cJ6sCNeno=
X-Google-Smtp-Source: APXvYqx0CQOcuooD4zq3bRK75uuOXfr1VlJxsXcXgvE9UpzleqlCbmJZjNlj6fg8QZ9rSXojdpOVaA==
X-Received: by 2002:a63:1820:: with SMTP id y32mr53537545pgl.287.1558060791054;
	Thu, 16 May 2019 19:39:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:19 -0700
Message-Id: <20190517023924.1686-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v8 20/25] hw/misc/exynos4210_rng: Use
 qemu_guest_getrandom
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
honor the -seed argument for reproducibility.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/exynos4210_rng.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 4ecbebd2d7..0e70ffb404 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -18,10 +18,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "crypto/random.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 
 #define DEBUG_EXYNOS_RNG 0
 
@@ -109,7 +109,6 @@ static void exynos4210_rng_set_seed(Exynos4210RngState *s, unsigned int i,
 static void exynos4210_rng_run_engine(Exynos4210RngState *s)
 {
     Error *err = NULL;
-    int ret;
 
     /* Seed set? */
     if ((s->reg_status & EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE) == 0) {
@@ -127,13 +126,11 @@ static void exynos4210_rng_run_engine(Exynos4210RngState *s)
     }
 
     /* Get randoms */
-    ret = qcrypto_random_bytes((uint8_t *)s->randr_value,
-                               sizeof(s->randr_value), &err);
-    if (!ret) {
+    if (qemu_guest_getrandom(s->randr_value, sizeof(s->randr_value), &err)) {
+        error_report_err(err);
+    } else {
         /* Notify that PRNG is ready */
         s->reg_status |= EXYNOS4210_RNG_STATUS_PRNG_DONE;
-    } else {
-        error_report_err(err);
     }
 
 out:
-- 
2.17.1



Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFD3217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LipXyzHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFD3217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9aX-0004oS-OU
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:45:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mc-0007XU-7H
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mb-0006CF-8Y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9Mb-0006Bq-2x
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id g9so3565191pfo.11
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=SUOVHO6j5bto5JT3YOaz6mzG9aMKtYONtCxKiBQvOSY=;
	b=LipXyzHFUhm484KKJAcq7BZ+BqYBjTds4vKoHfGYZlrvORzSuywhoFR4IMaLxNXb2m
	Ic9RP9r4CLy7khPIvhqp3yfu98Vb+svfMFhP0XLtBLWN4QJIA7vyV51pvzgmMgGX3lW1
	lPKQiq/XpPBbXg5JTO/nA+gLemnkXwfJqVq5hl6NE03BiV/70s93liFNrfw+i0xPZzWl
	fvdw3qhmWZQ2CSVPf5ZtpVr9bdlkgE+esCX3DM7mO1Jmxv2kVGs6UzA164V6wcrIvgpN
	1UwhDl8sOOSvmYvorRTpqfB7lOGvcVypUl7SQxQaBUX3OyVb6KVwfVlqUVVUotRxdiMs
	+8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SUOVHO6j5bto5JT3YOaz6mzG9aMKtYONtCxKiBQvOSY=;
	b=c+J24mIN3ysg5W3t/czioky0RDvdZsQ+qUEGvUALP3nFAkt6MDfR+Vay7Tks+FhcAe
	5rPKJFt9+ikfL5NlIc4Z8MNm8yVc1mx+rweowWQhzZ+f15DOdvQHRpAd638SDV+x8mI0
	Na2wTxy4jQ10P4XhulHvaz9uiVZxaWTFbI0Z4+WVmIkrTclpLrVcjzb+tN3nHIJmUGN4
	8VGk0a1B4GfqAc26kZt/Ya/mN5p9JzoPzOWnc03gdDBPyXO1jsfoeMCnyozMEHGkiRs3
	0Whj4lcFrMtQDBi9FZtwbtgeZf1D8RvDj/kiW4cgmyMJF/VxOpOYq2tHBjZmWsO60LGP
	Nbrw==
X-Gm-Message-State: APjAAAVrdzZPycUOrcgjsxDAzaMJrzbSnSb0Q6MiPwH8262muhYLXmjZ
	GUQKwJE3ritJXZ9p/joOZ0i1P6Oh+/E=
X-Google-Smtp-Source: APXvYqwulKm3nDVLf+NCAHExG2aKD8SObAEW0Y05zAtf4r9L/2tUu/DwhS76UxuPELuufdJHLK/0MA==
X-Received: by 2002:a63:6f0b:: with SMTP id k11mr15135478pgc.342.1557509475903;
	Fri, 10 May 2019 10:31:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:44 -0700
Message-Id: <20190510173049.28171-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v6 20/25] hw/misc/exynos4210_rng: Use
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.

Cc: qemu-arm@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
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



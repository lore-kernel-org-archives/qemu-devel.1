Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AB8C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E192B20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIeas4e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E192B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWdj-0005R9-3c
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:11:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOn-0008Eq-Gw
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCU-0008CI-1u
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:54 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCS-0008B2-1G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:52 -0400
Received: by mail-yb1-xb43.google.com with SMTP id k128so1268603ybf.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/VWGaUBQJcHRh8ZCol9Bt7n9p31zv9AWS8bL9WKxKYs=;
	b=pIeas4e2eGmoShylW72dz3I+fq499gQC5L5yzxJlyyc95qlsW42IE94fKa3YpY1u9V
	WCio4iCMHCRVIOsRLpq/f3OiIfkycpcFeT0mhBSu7t3l6saUO1KtaEpQDYDmlUj1Nw+M
	1eASOtVyS0YSVV29yxiCs0ttGAS1CPQEZFM2Y+cMZ+yECIpAsoedS+SBsFz9UO2yWQJ3
	B+pwbDpB2vna94DhRjPpGJpzT0CwIYWHXOAF8TMmttfU6cC5tUUHBzRBmCAcmXI/dPzb
	/8cviERkCdPeqq21PvFmno4zMSHPGMywPt5DGL5WLhVu3HrcCJpwsBvg7fvqVnBc62zv
	sduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/VWGaUBQJcHRh8ZCol9Bt7n9p31zv9AWS8bL9WKxKYs=;
	b=Qbqe3sGESU5hH0yitN6CycIhuvQHzJvvf1/VPm0/pUAZp72TGBzLKosW/D6uur7UPT
	LxiBzdtpzw/K3G/ipK+bKAvjavzerWWCA0fb7SnYafOatesMzmUZvDE8glPCpaDPw9LF
	ZF2HO9jVqg519t7HblzC88UgnvrZ48EBEV0o1xzBCCknmSObxej8JPelMWkPn6vqURze
	fr/oMMtlRmSUlVZLJrr+E3Wdr2sb5UEDTc3sJ7mRePakUnw1f57Km3cfBHHFaiIOcCVX
	guW/Mx/IaezjsVryTTsOi/4aciuFuRhrmhmfRA16olWt+kMVlYXyFGFpLdeIrrwVZ9K1
	wseA==
X-Gm-Message-State: APjAAAW4tRnQEgr3yN8YvvbGbuifw5ay2l9WbA7BYgtYqhRs5zUXWtbp
	IdJ8n8FSvLMqxMAHYm2uF3x/L061+CY=
X-Google-Smtp-Source: APXvYqwcl22IEHY0L4PJQdIKh0zlkvS5K8EWxiFyzmZS+s3ysZ8VIGtSXAGo3D82qpvDrNvxwAGf7w==
X-Received: by 2002:a25:3c9:: with SMTP id 192mr15663764ybd.223.1558550569701; 
	Wed, 22 May 2019 11:42:49 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:21 -0400
Message-Id: <20190522184226.17871-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [PULL 20/25] hw/misc/exynos4210_rng: Use
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
Cc: peter.maydell@linaro.org
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



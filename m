Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730CAC04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7B72182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTX7Rz1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7B72182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuK2-0008Qh-Cx
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:27:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHv-0006Qy-PB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHu-0001NM-M2
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:27 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHu-0001Lu-Gc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:26 -0400
Received: by mail-pf1-x443.google.com with SMTP id t87so2267050pfa.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=SUOVHO6j5bto5JT3YOaz6mzG9aMKtYONtCxKiBQvOSY=;
	b=yTX7Rz1f4JFetaDPpeaTvLwRQg8laV+kMLAqlXwDf0bBw6PkyU1VTCDgUB2b0MEvdm
	XMYAL4CyArzDQ/1T+F6rq759JmBPCFMztWbTgFTFLbb+w8yFhs0bRLi4RzW4Txe3DPlP
	m3H6rPfg5B7qUHH5h4oJXs36IquYPi9x0D2LJelsjuOgez9BQo92ing7uwoYuuZNO3WP
	nogDUipeKF9ESiFdtWRaBDuuhMmVG48NgS/+qqUINC45keVJnqniE+YSgP3wmZOqmGfH
	xOF5Ncjns3uStSx41NCJXuHxD7DORbEnOeh+TR9CXr0EVTCYYk7OBuyAGUpN7KUX0BN0
	eNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SUOVHO6j5bto5JT3YOaz6mzG9aMKtYONtCxKiBQvOSY=;
	b=umUVU4WhkyARYVmh/TZA7nHGaFu2N3DNNR46ji1a7AbiT1s2XaC/C99jDaBGyg66q/
	ByWKCQb9ElJLahqIScJFp9/Nmp0gztSaWmohV5WBLSiG8ZsEiHoBXKkNlkiBZnC66qin
	zmSKfYa2j1dnjQlLL/tUzuFrBqbWQ4Q+3uZIYvffOjNIXCZbY4KmepdmOqu2X8Z/cHpX
	DL7V2em/1vnWVghVf8/K++G2rRQCZS7TUQlLecbO/PY3pZFoLnYpyCx98m15mUqzAfL2
	AorFfINgPFcLIIrOmulK7FSrnPqHSfF1pvnE3xAl9h7XMmPzpu5lttwnY6YM6HxMCuYQ
	HZVg==
X-Gm-Message-State: APjAAAVc9C+GASma998t6SrVp1H4eZBggatK1cSCFpQ6llRVacEH3rsU
	nJCIASQYE9E+HfLB13H9IHSDJeMUthc=
X-Google-Smtp-Source: APXvYqxHupQo3fCLcxXUfn1e0KGg1E/lTa3IxUeleqrsjrhsghxPUvqxf8l+myByFhb0gZ0pBWAetQ==
X-Received: by 2002:a63:8149:: with SMTP id t70mr10054715pgd.134.1557451524878;
	Thu, 09 May 2019 18:25:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:54 -0700
Message-Id: <20190510012458.22706-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v5 20/24] hw/misc/exynos4210_rng: Use
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



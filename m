Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA58C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69AE20881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ry6QEhMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69AE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQdER-00024q-RU
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:36:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvV-0002hK-BM
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvT-00077L-GS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvT-00075U-2N
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id g69so73586plb.7
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/VWGaUBQJcHRh8ZCol9Bt7n9p31zv9AWS8bL9WKxKYs=;
	b=ry6QEhMeXE+0og9mw97zNWAEloNKkbE7ODLUz0iLgJwFzeY9WxkiukGjsbexWRwrto
	NGmnfgcOedsNVxI5363MkVUJOsLhTHN0dFpJg6tZGwL3Wv7QdZ/CY8/WRCvjTxwXhL/4
	Qv8X8QngWVyFPouabU56oeHedFPDQaAEujSZAbcSGhMkXltt9tmjWU13N9g91OalpwvW
	FqmVFAxc9iphkhv9DsIrK74utN9okF3A8jbDU+son2vluXc2YQIdhIzr8m0OWOrwUGDO
	rb9fsGlXAcNjL+QYhiw2jgsu5+TWQUtbmWMdTridweG+dOaUaGl1PtRFbY0mX1gd8Zxz
	0iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/VWGaUBQJcHRh8ZCol9Bt7n9p31zv9AWS8bL9WKxKYs=;
	b=cnZhoB0qXn7vvQ3liI0xpoZL63bjdBOji35uBG1SE/VGkXnzSxfQPAmFqK1EyUHb4g
	zDSmDxVfvzXV08md5ZcaWEixla0wFiIzDNzlzbd9ZoGYn/i9CPf+MS3qFsx851l8iX6z
	eVSzL4ROv7hTdYPeYi+O4jzscPF/0U06KcY6zy+C7ZZ7MHtPMR2cho0UQn3Qy9FUbn35
	r0D3B9+idi+vk5Gk4y0/CKhHgFXYDNG5UD1u4ePD6Ibr2DL9SMQutkw0U4t3kpOO0Np5
	nGV0VFG8rhusDhJeg6o86ar3NLTa/JrCU/tQxkZ+Qq3TZtmOjHBPa3RTNekNsk41rNVD
	F2aA==
X-Gm-Message-State: APjAAAVkezsSZIsHkBoO6yzzBG2JJXT7Wg3vjbhFeRjQfZpEfD5K8rhm
	WMqZWmLq/G2V+uI9Qkgb/B6Q3ly+xuQ=
X-Google-Smtp-Source: APXvYqzi6HJzbjZwABtfVsly1pqYu3v7pxF734dxJYriPwpIbMurAs4mvUnvKEvOAH0rxjULyQ9ndA==
X-Received: by 2002:a17:902:b606:: with SMTP id
	b6mr40343627pls.100.1557861440862; 
	Tue, 14 May 2019 12:17:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:48 -0700
Message-Id: <20190514191653.31488-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 19/24] hw/misc/exynos4210_rng: Use
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



Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DFC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE042053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0lQsOCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE042053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhnh-0000t9-41
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:53:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVS-0001Lo-6v
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVQ-0001ZM-BT
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVO-0001Uh-Cf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id w22so5482385pgi.6
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WkMgXREw0aoSQxhQGI3jtOyJDuRA2/EcPM5PhnT27hg=;
	b=M0lQsOCDnQ1jXB8oOlUdFWQEnQl2GKBcG39v9z7yxfTA5yax80UsmGLJL3XbgGwRIZ
	w8RJlHAQ+ehS6e7VcrU2IsXp+KANuR7/iwP+VM7eBCxb8meC1VxMltyitzx7SzJSURXB
	DGQ5EC3fnwwcmYznShqkqR/yg6BzPaEQ/6GBcRCBPo46g8zOui0qUU6qqeB7ZAqfrPXh
	fJS+HIVgnBy55567Zj7eJvPEHlLg/tjyAnB3ndc9hC4scZhErZmcpqtLnYs1mCIWagY4
	clTC+PnhZ5/8tS9DSZg0TRAnlj2cFe22ajUUea5otUju4fD5s2PThdjBIe4zBwyBSs98
	T+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WkMgXREw0aoSQxhQGI3jtOyJDuRA2/EcPM5PhnT27hg=;
	b=hSElmU8AHGFTwkK6Q9lM7jrNlzJXFolzf+O9FiI2ITk5g17O9KBCkj7eplVzVQHGxE
	lsQZy1VZ/5HakDufIw54mTcjWup/40IU16Kx+ISx1xS+ak/rpEoc/gyLJRozgCVHDBfB
	bgG3Ho7y/j9LWPbPxnP18792JY/jV5q2zfokpwxdYiPBo/b7dm8vm9XLv2iO+ruyeeFF
	ubWlVrYgJSseqh/RhyQ79SJlb0KsMXxMVNKQO+Lu89kmIEbi56vaLkQDHAnqVj/MRnvv
	TYEv5rNec0ztXH65SFiO5ne4btQUzKJtncWGqsYJP6LgzGGBE62rTVNmSgk/ZwmBMK93
	ZEhg==
X-Gm-Message-State: APjAAAW8R7Ojs2b3j9oCEUD6W6ihyUOP7RlM0LFRahB0Ic4uiWnTR+ri
	8LmXcoC8yj9m82ov5JONocO89bGQkOs=
X-Google-Smtp-Source: APXvYqyXHcsDzKyF1c7ndIZgJ0pe1liHklZJNJ7QN29FvqVqUq3UWp7M+reKS9BDdFGPE8wZoczZcw==
X-Received: by 2002:a62:5915:: with SMTP id n21mr34013649pfb.180.1557164059592;
	Mon, 06 May 2019 10:34:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:49 -0700
Message-Id: <20190506173353.32206-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v4 20/24] hw/misc/exynos4210_rng: Use
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



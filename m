Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74DC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5E82053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HO/a2KJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5E82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhnB-0000WL-7B
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:52:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVQ-0001HV-Aj
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVO-0001XD-Dw
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:24 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:45199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVM-0001TN-NK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id e24so7118995pfi.12
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2div2YVLjVe7DwdMLbNY+nkm3nkpzeNz5eXH0qLyY8k=;
	b=HO/a2KJObdqAqpfzLvR4kxvp/QT1f95D5xt+K0LIV2VzAmNoQrgm2U+Nb2uCf6ok6p
	yN33eYIsJXEMa86FMzwRDP162tq0K7ekCNjWz9cOGIOkeG/onWyEg4nEJGAXrkw460tS
	NOSp1OhPx2HiQ9GQAkxvRiGX4f+tuL5IXORfBo1QJ+G4iJR+U3OivNRjq9vrDvSriY8v
	dLij5r9lDV1F5g6q7TqaGK/4pGnx/duV/MfxhsjPjcXBmgD7RKOPbeUaIj154olp8win
	XrtNK5cif//1qeYt0l/YvCjKD4GRFKh7boWflcS9pGWDkuwDHwYfRu+GwoFgVdmC1L8e
	adNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2div2YVLjVe7DwdMLbNY+nkm3nkpzeNz5eXH0qLyY8k=;
	b=qHVUzgOwFrAI3mn0sqI9OYd6ipCYN/3EtlKtjYBK9g1a5pAS5e/bnf543tYzjp1daP
	jVx6Co1aOlKZz4KUnWFkf7DZgq2ZSuxvIDED1goildRYioadkXZNryU4Ha7XgTyR7gtC
	mvq2QCjgT+zDHQBG7oXO/e3QTv89GbP1AYyKl8t/p1tNA2bO12crSdWsjv41rBfwifyc
	cllYLDqBqMAhSlEBlSkud+aNPteiH+djKJ9mz0RIA0BF9pT1Hb2eLsQlhSi/bmdIeJoE
	0IrlkuL182G/5gqJCQknXuUJrjzBlkOJevJQq1sW0T8tSI/z6dD88RdPTQrn9QfmChVO
	E6wg==
X-Gm-Message-State: APjAAAUUYVYo/rjOg+kJFCYwrHrO3617Y4RAIa69UBfrngp7NOykif+q
	q5uYn9XSksGDB5Dz5Q8D68fL+NPA86Q=
X-Google-Smtp-Source: APXvYqzzli0KoGVRT5t4y83bYT4UU6lSAu6qWL/0KRlflxZW1u9UItZx484N034yxLjY4I8PBsVGIA==
X-Received: by 2002:a62:2703:: with SMTP id n3mr10803121pfn.199.1557164058577; 
	Mon, 06 May 2019 10:34:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:48 -0700
Message-Id: <20190506173353.32206-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PATCH v4 19/24] hw/misc/bcm2835_rng: Use
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
Cc: qemu-arm@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of rolling our own error handling locally.

Cc: qemu-arm@nongnu.org
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
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



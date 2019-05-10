Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B0CC04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064DA217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjeBll7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064DA217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9UN-00068r-3P
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:39:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mb-0007WQ-5s
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Ma-0006BS-4z
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:17 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MZ-0006Ax-VS
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:16 -0400
Received: by mail-pg1-x536.google.com with SMTP id z3so3329166pgp.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CbChhlXQdosoI4MWUK/zk2WTRGwUvizy4vwPQDmKAqs=;
	b=RjeBll7F2XfVW0Fos68V1JZ1XYmFQC/be0V6fR3mzqCne3S7j002nc6dhYdmOjQJ8w
	OYXEMa6OyvHaH31Pz43TCMnbl+S+Q6DgBitHESuwBq4AXKFZtqGqezx6SiT7Y0ZpL0CK
	7lnLGG8yHmsYqd3hhS5kdFhPDXFrvWdcwWwUqDc1223nTv/6I8V5b4fm5QljfV5Y5yza
	2Zxag66oHEFOMjDDizUiiwi2imuPuSDkCAWzzy5Vymo4pVXl8lR0tgf1NTn3NL5EaPGl
	bYRSzYsfzlGrYphoEZQ+btl0ZnRe7E+HVPZIGMSBD1t0zTEFek6Jp7d9ciSyxQRxKBSV
	8O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CbChhlXQdosoI4MWUK/zk2WTRGwUvizy4vwPQDmKAqs=;
	b=JNYc5W+LSqpRG4PWB/JgOaAtKHeteikdHp/EYibk96BHOYmouAXWHUGLupDA2MiXop
	O8z+FW2+XQOUPealcfdnYap01CK0+4RbvOrAbzjXm9NIoKrF8CvgR5C/Epgfyrkwcb2h
	LUGOnho+zvZ9zdNWRknXT/GG5BFOyjBoYQOXsuw6sGtEtcS8JxWAJnFR0xAo0XV5D0UT
	whQJUBuCRvFNZr3OHtDI1Bik8yJGmtIlT5g42dxbqHSVLHHiK3c9logMbwFNMNs8SHbz
	AIdLWYwDDtc4hX6Ys+7qoby7WrxwTcTA6iQpxcHpTpjBiLUkWcQTrTmPDs6stCHyq/Ud
	ByfA==
X-Gm-Message-State: APjAAAWHEp9XfDUYqjoIbmZyjOrbXAGY1RDn3CTSpIhezpLAeggwIL+N
	Qvd0gvMhu041FXC66k78InvHJXgUuw0=
X-Google-Smtp-Source: APXvYqynip9408w9bqdS56Iomy8eTGWjjSitc/jxnisaExMCBzPDga0KLtNhDmzCaoJwl027Iz+rjw==
X-Received: by 2002:a65:644e:: with SMTP id s14mr15629617pgv.290.1557509474699;
	Fri, 10 May 2019 10:31:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:43 -0700
Message-Id: <20190510173049.28171-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::536
Subject: [Qemu-devel] [PATCH v6 19/25] hw/misc/bcm2835_rng: Use
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



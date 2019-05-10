Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD945C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86618217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGlxs+Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86618217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuXh-0004A9-R1
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:41:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHu-0006P3-Bc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHt-0001LZ-BA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:26 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:37563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHt-0001Jn-5i
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:25 -0400
Received: by mail-pg1-x52d.google.com with SMTP id e6so2127761pgc.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CbChhlXQdosoI4MWUK/zk2WTRGwUvizy4vwPQDmKAqs=;
	b=mGlxs+IkXNYa9y7ymy9eoOjb1uY9oIleFJoAdb2sQNqtgw9XGoWKqDvOQQ0KHuyHWP
	GBqOzvAQZXaQyKYddxNliA2cj/LQ+BWNKktDhMxaziCB7gQ7eQ3VxC7waceUkjIci+vh
	O6F/UBGLbxI86EhfpCRx7vInAa41BvVpwauHa30wEjgyaWmYCLFSo7utNrSdLnlnv6d6
	bcY754D/Va8ma506KyuJpKTtNv1e+Ikep8BjK3GEjxEEFggMz6xAGUxoZYkrKskARBD3
	+ujpaYssXBI0o3IXk/rID2La/D7wGbflEbA0gXG8cvQU8wKXyak0+36rK8oM8lnzXXzZ
	fmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CbChhlXQdosoI4MWUK/zk2WTRGwUvizy4vwPQDmKAqs=;
	b=mKSB4FldhNIZW2U5qt/uVrJ1iZnp6g3W2wGede2Opm7/W+fJY8BDA+ow9LTUPyGFIB
	B9xzaWoTX+02E1qbnN5jykqf+Lpc7FH0kfxI1nwitO9QBk1OyS7EYNrQywtvB9Vm4eot
	qaMHe1OdXa3aAnOWx3SwAUmYw0OhkUjXrFfkwdYgjmA4uilD41q5hTMkqz/lcMMZTyd1
	RTnvIlhKxhORXl1HNjs5BCj+XgTdkHXL8/kCCN+txPGhRDiK/fHZwsN7wElvr0EIOVhK
	5fO3NYR3D36TPqGRcPeljjX8693DZtbc39Py3FINFyZ8p4k3xUW445AR5UHj4QJUWpzQ
	16wA==
X-Gm-Message-State: APjAAAU9lGRRz406PS8uJdToOI/ZjhG9icV4uG1RIUnS/fEMsrmAN1zb
	IdRY4bJmZo8G+gLcZY/sOuinK8WPMTw=
X-Google-Smtp-Source: APXvYqxX8tzL2SGTwOMM8DwwKDNC/kk9jb7lyZKg2K+nwpn6pwZrkht0teX7OrO+/jNzP6YeG3DmBg==
X-Received: by 2002:a63:6804:: with SMTP id d4mr9965353pgc.240.1557451523832; 
	Thu, 09 May 2019 18:25:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:53 -0700
Message-Id: <20190510012458.22706-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH v5 19/24] hw/misc/bcm2835_rng: Use
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



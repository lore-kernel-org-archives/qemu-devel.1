Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B0AC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0D82082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWt+ECBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0D82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40325 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT1w-0001LE-W0
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSnK-0006BV-Vq
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSnE-0002Sh-KQ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSnB-0002BM-Ev
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:18 -0400
Received: by mail-pf1-x443.google.com with SMTP id n19so2884909pfa.1
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wKy5ep5gzBeVJvdgqxMAwC/EHW/NEI1i+sUaPM2vsGg=;
	b=LWt+ECBZy7DAmGZIWxNFA7O1YEWE1cDEP0DGP8rugWir3Hp5IadPSKoyaocN42DwQ2
	5Y3Zshm3bC4DAJeI9uNPiKGGXkKkUFTRcYaTRm2ttit1I4YsOiDgEMy3oAHnzPyy8NGC
	gqNXg8YTlkH3jBVDLyKWRzx9jMm6t3T6swMAT0bBdAQkBLPn94fnSlHQwNlEIrUtctx1
	eV9etY0qf2lzD0e9dMLDodG3bluhAyciPKINY+zWfYm2vlzNb60VFtPVb5dTzsxFL/j4
	kBkOBm1zkdntJtnVUThBsMVv4Fax4Cjt8dPMdal/qA+plLyL3KQltAF3diaUVwV6z8eC
	nD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wKy5ep5gzBeVJvdgqxMAwC/EHW/NEI1i+sUaPM2vsGg=;
	b=VYDS2JFZLs8BrSYaJ9X0CrU/fow93bUc2jX2UPeP8z5V31FAN+C04pSJFhhoOQcZDb
	M/w2Ei32McmX9qkzQ656ZLPNc8wuFobHFa+YMIiYl1x6IyiCXgg0UkheKRQrAtdoY0Ew
	YsaWzBwWikUQqQujxUyxYUHKaGa+2Oj7pV9Fu61fOyHyeOyvHo7FY5ZcYrSQhHb5Tvqw
	HK2AYU86XATXXQEAFPzlJP85iussmE+S6SVh8LlRmlkwyOMotEPmrO/7/pxus5O8z1Qr
	sofAU5hnAzmFSn3ovZ2evbtSynOK0uUz0ym+C0w/kwHQ/Ly7pvXnWvdlOA9JbWlQf0mf
	l9iA==
X-Gm-Message-State: APjAAAXsiWh/pmAdpCf5Pb6UqqSHTzMZQ7tCuCGDj7p/tC5SOXyv8Rbd
	AuUi9O3raAnaq7DqLFhWpEREeGIjHxw=
X-Google-Smtp-Source: APXvYqxysR8/jBWxoMlvD+PdoX4BOmu8GCVZL/CzgauPMIJCv76cuW5TBpR46co97hcjYPJ7c/HLUA==
X-Received: by 2002:a63:42:: with SMTP id 63mr54224522pga.337.1558060789991;
	Thu, 16 May 2019 19:39:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:18 -0700
Message-Id: <20190517023924.1686-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 19/25] hw/misc/bcm2835_rng: Use
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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



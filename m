Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDEAC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B7220862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUMjL7Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B7220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQdBn-0008Pf-Dv
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:34:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvV-0002hM-Bs
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvT-00076f-3A
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:25 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvR-00073d-IH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:21 -0400
Received: by mail-pg1-x541.google.com with SMTP id z16so34264pgv.11
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wKy5ep5gzBeVJvdgqxMAwC/EHW/NEI1i+sUaPM2vsGg=;
	b=HUMjL7YbNsLvockZ2JWS36HhF7Fu+KVAC98o3BcIpBR1mnssHseBVExELZPJO3y24P
	iskIXmWNnsyrl+hwNmr4KCejZOOjzsP/Bf7Qv+5S9v9qi6/qm4/aTfquomhrUckKf6TB
	2rk/3ex0QtBwMEhVD4/V4xfT8i9e42C7Aq9vC7ECEnTvgYOLntqzayUSyuzn0h2cys/4
	EsmGJvTBQL68MEA7vMzt05MiZQXMciYXywLfPT7UO+A4hQdFa/ccCcVw5xI33uvg93x6
	r0liswMq8iDa0jInLwEnBl4LjuQPX8bXg6vJUWNdrCxXYxyavQAXrvKwb4m6D+zG4NIu
	pBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wKy5ep5gzBeVJvdgqxMAwC/EHW/NEI1i+sUaPM2vsGg=;
	b=jLJZBC7JEQ/oR/gH65Oky6faO/J4RGcXyy1112/eMMZDlStsv6ZPHNTLXn4J1OYFPX
	FQPS7iOPHAnbFIf8LH/zoaz4SQsoPqDQqdTQv97jOvYDMvAzJTL1YkYLBOJ28s5jg7W6
	MoO4FT8fYkvOSwwY54aBrPAmNUX1B83AMLnnMmtFPuaUTP6I8WL21tOipPUOnATIVHxL
	x2z12Q77Ld0/PM6DubIlYiTfwehu+1yXE6QIewmZ4mJhS7Gvo8l0fiRZQ8aoYrFSY++Y
	v3JA8wy0fajc5E7VshoKFIP0HtBhBUHc8EKzkFdlNs7bnj/vPqOpx47al+oweg68HPTI
	zOFA==
X-Gm-Message-State: APjAAAWGNIjkqi9vzc/dg/6Uh/SgeHeoU3ddP/ocNZ6e4dyCDnZY7FXl
	QH0MvKsMpkuQvugfrm0u2iLCQG9eFNA=
X-Google-Smtp-Source: APXvYqyOgMnuN63CxFx71LWU6oKE7bVwvuFxqvEwpxfZXimI9r7lrhxk9aiLv0uM0e6e2OtSt2NG3A==
X-Received: by 2002:aa7:8d81:: with SMTP id i1mr14308617pfr.244.1557861439629; 
	Tue, 14 May 2019 12:17:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:47 -0700
Message-Id: <20190514191653.31488-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 18/24] hw/misc/bcm2835_rng: Use
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



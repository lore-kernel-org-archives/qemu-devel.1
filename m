Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D06C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739472053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPsVvWSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739472053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhpW-0002HG-My
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:55:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVV-0001PA-9i
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVU-0001d9-BH
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:29 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVU-0001Z0-3y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id e24so7119093pfi.12
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=rV9JIaOzfUN4OkPt3KeztWbx7AsXbIEUWY2EQzqrSHU=;
	b=JPsVvWSvgo2Fx1dliry01ZRpiz217ThUX6fAXN8kyJBII2va8k4DXmt24Yts3yATwT
	TyfORURm+fJVw6aaSM0EH2PvE4NxQEoNbgxUpQXTN5mMtrgk9vBdw2bn0awnSWzrAUdH
	oaC2pe6y6AibFYC+xs0rSaxXaE+5MJW0sxeytMXd1O1+HymLHnyjMMERVf4iF67D97Ei
	CJnL0tahD0Zme+M1iB2vzyGqpvSKJVZrlLKvI6sFs4sF6C+J0PmSlMUHuVsfXSzqCG2q
	PrIWSguquJzYL5vl87osooTd/hH02sjzd3VPW5Lg01Fct0chJr75F4neWIDfH5E6pIjY
	Ndbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=rV9JIaOzfUN4OkPt3KeztWbx7AsXbIEUWY2EQzqrSHU=;
	b=jIEJc21amS0Okm6YQ/lh3vlhUlCXc/pPd6vFQxGO0MnHBLxNUDSWmIUlGMrM602ZBM
	10Pkv+BYdBXG3Ooi1EMa5EgpbRV1lPkmT1K438s3H1TJAyQhFGeSVV289ScN7TUY5v7A
	sehzprOm0i71xzgUpSjEuIjJSyPGf7Bqge/4o+XA6xqh+xr0QqE7fydoShuRg6cZkjYF
	akHFREk3w+zhE+e54/S8jf+i9e5MAurM2954SbZINwN1xb5bK/BhwisLK2J+o3ipyupj
	22P/3DeQBV/exX264BTILpkORaz4wMUVovB1ZwrreQLQySZRQxMaa4q1SlNuPzb6pd7x
	nMAg==
X-Gm-Message-State: APjAAAWVmlBchjTiOLyQNOyGskF9WRLNzRmWUldF20pmS/D637RXnnIu
	jmT7eRBXGwyvQyaHk9GhHdG7nPCOJYA=
X-Google-Smtp-Source: APXvYqxIOpvAJCQfPxMVpK+99PSEX4I9ehpdwQCerITj+GLWig7BaveIJXxMAMrXO92YHeuDPBCCrg==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr35979178pfm.217.1557164063137;
	Mon, 06 May 2019 10:34:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:52 -0700
Message-Id: <20190506173353.32206-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 23/24] target/ppc: Use qemu_guest_getrandom
 for DARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now have an interface for guest visible random numbers.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 42 +++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f6a088ac08..9059e70b9c 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -23,6 +23,8 @@
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "fpu/softfloat.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
 
 #include "helper_regs.h"
 /*****************************************************************************/
@@ -158,25 +160,41 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
 #undef hasvalue
 
 /*
- * Return invalid random number.
- *
- * FIXME: Add rng backend or other mechanism to get cryptographically suitable
- * random number
+ * Return a random number.
  */
-target_ulong helper_darn32(void)
+uint64_t helper_darn32(void)
 {
-    return -1;
+    Error *err = NULL;
+    uint32_t ret;
+
+    if (qemu_guest_getrandom(&ret, 4, &err) < 0) {
+        qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
+                      error_get_pretty(err));
+        error_free(err);
+        return -1;
+    }
+
+    return ret;
 }
 
-target_ulong helper_darn64(void)
+uint64_t helper_darn64(void)
 {
-    return -1;
+    Error *err = NULL;
+    uint64_t ret;
+
+    do {
+        if (qemu_guest_getrandom(&ret, 8, &err) < 0) {
+            qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
+                          error_get_pretty(err));
+            error_free(err);
+            return -1;
+        }
+        /* Since -1 is the error condition, try again for that case.  */
+    } while (unlikely(ret == -1));
+
+    return ret;
 }
 
-#endif
-
-#if defined(TARGET_PPC64)
-
 uint64_t helper_bpermd(uint64_t rs, uint64_t rb)
 {
     int i;
-- 
2.17.1



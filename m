Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C82EC04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67579217F5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLB+U6uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67579217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9iy-0004IW-N5
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:54:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mg-0007br-3A
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mf-0006EJ-48
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:22 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9Me-0006E7-UY
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:21 -0400
Received: by mail-pl1-x642.google.com with SMTP id d3so3130070plj.11
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=U7V1DU2sIBLR4xyyuIblisrMELcV0ZOXk8BQM7uyeGA=;
	b=lLB+U6ujZVJ6L4XThI1HmZzsFwQkCilJF2kR0pCk0VB700ZOMTfW+27s5Lcr3dCz4o
	lUU7mlOdzzySUgVSVl6cJgm/3y/yoDVJdD+zgmYM/qwfqKWQVhYiWnbspflLxb3LQThX
	x2i32RAZncGat5Uw512Yv6XoK3sVBKo49XLawnjVvA0BFoDcT4qBkGDphdyb/cDcUJkm
	zH/0yTvkGHC0Qq5ujjkWa3K3+JBMLDVf6ERFuVfjFgMu6TR+JltjLkEhX3Bm+mmyFH6W
	epYmWhNCJFVi9ooIOVovD45qcxExbPAl8HQEPuWmHnFZmjmwuCIs5HuurcNmpPkIusDC
	Fk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=U7V1DU2sIBLR4xyyuIblisrMELcV0ZOXk8BQM7uyeGA=;
	b=t8mx7XkjJCRJRSdNNzlRxod4v6QMChokG1cd410aStSbm6DvNhZ5EeHRhThBlqw+d2
	OOTn/G7uqXp3N494xONLzZWjKDpqrJ9YZGTb9UuFGi0dkSqwAe0rnhj6RV0QTNYF6cfy
	0RspP6X1l7xfIGN8ZM6DqVyp1H+yKeSmHcaBh2BnTvxL1Iom9u8kytcEB64EwXzhen1B
	DngnHlsrbAF3r5MpZOXbaDQwcW+8O5xITFpo44OTgfFoN8LSYzA36LXRcfdkd5lPbdaY
	NEKtTZyBF5FtK7a0E+uh9J/IaG5RnF1abAV6m4UxGsgqeHuhJ4LpRjPh638Rl6s0XMSL
	Ex6w==
X-Gm-Message-State: APjAAAU6znQBfIXyHn2QgAldJrAxaI+SbGCEFN7FcVbAM2RcsGRiysa4
	+aoueLEhpbsq63c7FSxRiAXpsUHBRos=
X-Google-Smtp-Source: APXvYqy2vnGtD31v8PeCkAUuA9XOgxfT/4xnOzMkOrdB9nborCshQpjVz2ay5+hFcqZTKku/0ay6IA==
X-Received: by 2002:a17:902:2b87:: with SMTP id
	l7mr10116770plb.11.1557509479776; 
	Fri, 10 May 2019 10:31:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:47 -0700
Message-Id: <20190510173049.28171-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 23/25] target/ppc: Use qemu_guest_getrandom
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
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Do not loop for darn64; use sizeof.
---
 target/ppc/int_helper.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f6a088ac08..9af779ad38 100644
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
@@ -158,25 +160,38 @@ uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
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
+    if (qemu_guest_getrandom(&ret, sizeof(ret), &err) < 0) {
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
+    if (qemu_guest_getrandom(&ret, sizeof(ret), &err) < 0) {
+        qemu_log_mask(LOG_UNIMP, "darn: Crypto failure: %s",
+                      error_get_pretty(err));
+        error_free(err);
+        return -1;
+    }
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



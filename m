Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A92EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6D820873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlxewZmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6D820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53297 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQdIW-0005WG-9s
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:41:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvd-0002o9-25
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvZ-0007Cx-8Q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:31 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvX-00078h-Ah
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id q17so1141636pfq.8
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bpjcbv60JSWpD1TbbxFv9kSVFeLonJbRE1N/VVDdCYY=;
	b=PlxewZmjyDw1MRMeUJq5NHFmH8hnskUokgZSO9xNh1AbLmV6hnE0Mn4KI/rIai48Iv
	hxBBfjK55wezLBn1LuyPqmYy5226oZhqeMfzAc5igpSsKrNRja+lg8xstqn3vDwAYyWS
	DVboJI3YJGV1aHZMxtpt5AiF2qQKJGKoUKKJR2fo41bh5ApjZ4yUJTJ2Y2tP+k5TOjUr
	Si368T13i4bNNK9DjsCs0Zz7rJI9DoLHHgNc2qp2MEjjJUwPakxCt/qKKp61KwxoT9l+
	YNWD8zWKFJzmY7RxjZepLkB5l5CJUsANyh9TUbwep7GqigsT8ttd4C96CGhc9HOP7+rQ
	Iepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=bpjcbv60JSWpD1TbbxFv9kSVFeLonJbRE1N/VVDdCYY=;
	b=Hbw9beNr9Gj/NrwHN5/36WMA3nb9OYqIOyveDJxel0gmonwpZvNDpdZ6ajthHRJEAk
	KJAoivtURKeLe6WEADJENZJ27f8zSJaE1KwTad9hJGZo+EfthV2gyy/S1ypYnLkNZsPJ
	1QJf0Dv6S44d2j1Mt7T1gwD3MD9W3qxWQ/mcSHTP1BM7W/FlZs5vCMJ5KYAZICgSXMbS
	b47250VPZFeZ1cxXSOtcP1jHXcfjVeSHjwjdSKL73QLMuxH5gx22knmyAbMmEdJKMN7C
	Khwm+f7ZqqsMgbGP8uqS1DX9A+CB2JjrXsbtSg16uNpC+mwJ7OHW9Vf7zXpoYKAhw/e5
	rwWA==
X-Gm-Message-State: APjAAAWCnQIADO9hHlwPIGP76HfBYFcATMjM8Z6GhmysNOlEfJlMMp47
	E+jbEsu6GF6BrEYtWzSspVFTY3tvUWs=
X-Google-Smtp-Source: APXvYqx5ggnrQV9UR+JDa7uh56AXaV2FZzqhvrMeq6hlcOc+Ou8MLx5PeHaBJe9bg2ppe3duWRTdwA==
X-Received: by 2002:a63:3e41:: with SMTP id l62mr1294578pga.383.1557861444603; 
	Tue, 14 May 2019 12:17:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:51 -0700
Message-Id: <20190514191653.31488-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 22/24] target/ppc: Use qemu_guest_getrandom
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now have an interface for guest visible random numbers.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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



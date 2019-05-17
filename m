Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B53AC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328C720848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HqnN2aDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328C720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT4D-0003C9-AE
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:57:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSn7-0005y9-Vc
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmz-0002Hm-PW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmv-0002E9-6F
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id c6so2857759pfa.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bpjcbv60JSWpD1TbbxFv9kSVFeLonJbRE1N/VVDdCYY=;
	b=HqnN2aDQgiFqND352ve6KVLTaO4Q9XVPo7FXMkHVE1WdPJ9RBrME/+ujRRC+5mD4Gl
	yQb0yvKmninXLieoV5nYWKMq7w3iCbjq5nZECfsfnuQxGnoirZothbRwXt2xkf8L1Pej
	7FASrYglahBrOJ511wPIIdA/AzVxVr1VlpY7hoTw5Frwxi5hQmUfmZAGsZQSVjRGkRTK
	xSCey+7Qn4PwNlgmdcc/WpJIOzeLB5F0DEdWru25r1lp+9STa3paYjxuSTDgHoH9YbsB
	w2kSdkS5R5jkkiY/X+t6SHNoT7WTBZkLeedOejqwXsD1Iw2p7sros9qNCe5BEZ8vq0e8
	7Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=bpjcbv60JSWpD1TbbxFv9kSVFeLonJbRE1N/VVDdCYY=;
	b=DNIfeGP0g2E46ihkOIobI9WdkgMTFYV5qcjAXa7+A1I81s0afhJH4/daDI0oEBPMV7
	HHMI31SbQXPCS3Gj3k6aJ1Ox73WyEnkaA2ovu7sr8zxS47gxmPwFLUf9d5lypkG6W4ep
	RBa1DqKuz76Lb4JZPSa0CVkZRHn2oqgUEWHo5o3bV51KDdy9uK/KW3zbaUEEwBYSgdS5
	emcWZcqj17ZZHv71zal+chXPHTI/YLpcXEf35uXOH+qkeKVrDqE3oFrLccAtykVB7SIC
	ojc7FQVGRARQ/Nj/nxLv/78ls+FEH2ppNsL4ZufEjzha7DGH6AtEzhBoYG+lmzO+eqoF
	CLuA==
X-Gm-Message-State: APjAAAXcTzyL1sczLwOdr/OhomVr2+IJmHvfTfgltDz3DvggfDpp0fvL
	NV44T6D7tXAntv3wTkPOECKkbQAvL00=
X-Google-Smtp-Source: APXvYqzPhRr0N1Di7+jtQwzCaAbonStS3001NEvT4QgiOsEYQQb3C+FfEznyqXIhrofcc4m9rdEPBg==
X-Received: by 2002:a65:5086:: with SMTP id r6mr54706673pgp.301.1558060796081; 
	Thu, 16 May 2019 19:39:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:23 -0700
Message-Id: <20190517023924.1686-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v8 24/25] target/ppc: Use qemu_guest_getrandom
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



Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA1DC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C654A2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCyaTyYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4f7-0003rq-0d
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aN-0008QG-CE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aM-0006KL-Dd
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:31 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aM-0006I7-7S
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d31so1929522pgl.7
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NUjDwC8rJFYEblahVxs6YiCANModiBNxtQ+zHc0oNPM=;
	b=XCyaTyYkv+JIF3rby6W/Z1TMey13mh7VXZDoUkH2SZsBSX9LOeO5Nd35mP5Kgt4oO/
	jpiAGoZmQfZBWYXpke1v2CvdFBMNpFZ0ID/UOg1pvETx27woW0jO52PbCtQBl7WFZmSg
	u9bdPLQA0Inu54KHZx/rYDsiBEVleqw6KdnsPLXvayDVifEvTmpTQl4KnmJPbuapBjwI
	fNjv5TI2L49O9CTeKyjjHpYsctfpv5y1AaB8Y/SRl/VxbGoG75mmgpUU/UAdj2dQzg7/
	+zjaZlqJgJmjRlzJqzxCHDlgwIwGI1ygkEGu6BLpKl+3z8rZtFud+prq8NSfBeuPA0os
	VhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NUjDwC8rJFYEblahVxs6YiCANModiBNxtQ+zHc0oNPM=;
	b=daG5bAsFKsQrqs3V1WrQgDc5yOiUrO+ezzP11Wktdzmy38siNT8sDjYhq5/5hzRFfb
	VDd/11AOSTOPqFmEDSjYhzjngiRUFHg/GcYcFmpCeIG7NcozeReyUwQDzvOcndamC3uV
	pF0ASLbL+xPIKbosRfNenRwRxspJJvJT7HmrzkT0ptlQKTTR9MehVG+hO4o+0RH30H2v
	4tOpmefAnwW72vGt310W8ConD9FCpSSwRFaXTjvygQ28ruvP2L0Lh1hAoPB0NYf7vqnt
	Sq5txowO+rq2Nc1BvKHzSFTbVG2bb5miWYYY01a0dtg2uZcXIZjVxJzF3hHuVwRFi/nc
	v8dw==
X-Gm-Message-State: APjAAAUcslubNSkFGWNi7BAoPoL+mvX8BdY19ywk7akhylmUN15hzVLL
	yA6sbnPOLijisaaXY7Lg9APzugoOID0=
X-Google-Smtp-Source: APXvYqzhzLCDLvpWR98/aZ2FaT05rU2CLNU4xV8rgc8qzai8gyULHkTsGnV80TEhPEBUK9ZQVSlomQ==
X-Received: by 2002:a63:e045:: with SMTP id n5mr42541292pgj.230.1556299468293; 
	Fri, 26 Apr 2019 10:24:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:10 -0700
Message-Id: <20190426172421.27133-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PULL 04/15] tcg: Use extract2 in tcg_gen_deposit_{i32, i64}
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172410.aKKTtjoJWK5DI--CG8X8iWWBKCY_ies3rDdXGZDqw10@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fbc70649dd..a00d1df37e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -611,9 +611,22 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         return;
     }
 
-    mask = (1u << len) - 1;
     t1 = tcg_temp_new_i32();
 
+    if (TCG_TARGET_HAS_extract2_i32) {
+        if (ofs + len == 32) {
+            tcg_gen_shli_i32(t1, arg1, len);
+            tcg_gen_extract2_i32(ret, t1, arg2, len);
+            goto done;
+        }
+        if (ofs == 0) {
+            tcg_gen_extract2_i32(ret, arg1, arg2, len);
+            tcg_gen_rotli_i32(ret, ret, len);
+            goto done;
+        }
+    }
+
+    mask = (1u << len) - 1;
     if (ofs + len < 32) {
         tcg_gen_andi_i32(t1, arg2, mask);
         tcg_gen_shli_i32(t1, t1, ofs);
@@ -622,7 +635,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
     }
     tcg_gen_andi_i32(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i32(ret, ret, t1);
-
+ done:
     tcg_temp_free_i32(t1);
 }
 
@@ -2024,9 +2037,22 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         }
     }
 
-    mask = (1ull << len) - 1;
     t1 = tcg_temp_new_i64();
 
+    if (TCG_TARGET_HAS_extract2_i64) {
+        if (ofs + len == 64) {
+            tcg_gen_shli_i64(t1, arg1, len);
+            tcg_gen_extract2_i64(ret, t1, arg2, len);
+            goto done;
+        }
+        if (ofs == 0) {
+            tcg_gen_extract2_i64(ret, arg1, arg2, len);
+            tcg_gen_rotli_i64(ret, ret, len);
+            goto done;
+        }
+    }
+
+    mask = (1ull << len) - 1;
     if (ofs + len < 64) {
         tcg_gen_andi_i64(t1, arg2, mask);
         tcg_gen_shli_i64(t1, t1, ofs);
@@ -2035,7 +2061,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
     }
     tcg_gen_andi_i64(ret, arg1, ~(mask << ofs));
     tcg_gen_or_i64(ret, ret, t1);
-
+ done:
     tcg_temp_free_i64(t1);
 }
 
-- 
2.17.1



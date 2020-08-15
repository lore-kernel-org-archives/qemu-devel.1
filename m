Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CD1C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BD223B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWBW/y7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BD223B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zTW-0006Zd-Cy
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zSg-00062Z-6e
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:55:18 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:42873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zSe-0008PE-GI
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:55:17 -0400
Received: by mail-vs1-xe42.google.com with SMTP id q13so6199972vsn.9
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Op8+nIvDwpXgHA5KB5m5Q5E20k6FFVqok3W8zuTgmJQ=;
 b=SWBW/y7m3+PdaFt/aEfgwdLYM4xUYOO17egAyx0QX5bMmY7zUS1lWiXgArxER7vnw6
 ab99bz1uQiinq8jZkO3ohdw/cycWCP5Mm00VzBf2UQfBpgAAReD9Yvxxe+up2iKlRRb0
 9lioC+hyaLBS+YCrr2EeZAhDRcZyIlwHVUSCAgjpTtqsYmo5ABE3kGQdi77me/47hfpp
 kwjg+wTaKG2QlAPNaEELUNzq9mTnG8BX5b5FsNakrnYIBDXqsDhLa4fw3If9ZK3YKBax
 kkHCAptEGkXErDKmK0yTay3HHkGJ+/g9MAzvzk34s1R4CwWZJ3iINy6Sr0ZZnPTGXlAj
 7BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Op8+nIvDwpXgHA5KB5m5Q5E20k6FFVqok3W8zuTgmJQ=;
 b=RuV9xAquiD5yc3xFv1iMObXn7xUwyT5A4xGevZ60JxyoVUd7Cf6hxLB9aEX82uQBkR
 jLecBBqG5WxYXd/gfV23dob2sjaZIyb3RFfZBoOKBYnKMt9N2k2ErmT9Ml26gmt11NE+
 gptcr0OZXhKogeoT7jaEK8mdjE+bdqp0xkV0MTKBWs1++n4898kCfxPLR+Gfy6HzBxtb
 EG/oSxRm3YeePxxzkJPOL+qbvstbBKv/D/Gwgo1rEPMnooHmmAeLayeOyA2eFeS+sqfI
 J6Ok/SgsdUMPlNBpDwzusMXmPgGjVQ17TXJIHo8+yzvMq0cmkUGge4S7wc7GDeoNeg5h
 VF8Q==
X-Gm-Message-State: AOAM531OA/3XfuKvhy7nn0l9GrWQnyj4nVqvekoMUVdK+uRHLwOAl6eI
 kdbP3PaLCKUuISH70cfUb9MYISY6Ps4+4Q==
X-Google-Smtp-Source: ABdhPJzl4Jr+b9wWrX87a5QaJFdjYVdanp/z7vDvDgb6nbmZaKTuxtqsxCnAV8VGmBYW9I1CX32rmg==
X-Received: by 2002:a62:d111:: with SMTP id z17mr3757649pfg.221.1597455128053; 
 Fri, 14 Aug 2020 18:32:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/20] target/arm: Fix sve_uzp_p vs odd vector lengths
Date: Fri, 14 Aug 2020 18:31:40 -0700
Message-Id: <20200815013145.539409-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e42;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missed out on compressing the second half of a predicate
with length vl % 512 > 256.

Adjust all of the x + (y << s) to x | (y << s) as a
general style fix.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4758d46f34..fcb46f150f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1938,7 +1938,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
     if (oprsz <= 8) {
         l = compress_bits(n[0] >> odd, esz);
         h = compress_bits(m[0] >> odd, esz);
-        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
+        d[0] = l | (h << (4 * oprsz));
     } else {
         ARMPredicateReg tmp_m;
         intptr_t oprsz_16 = oprsz / 16;
@@ -1952,23 +1952,35 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
             h = n[2 * i + 1];
             l = compress_bits(l >> odd, esz);
             h = compress_bits(h >> odd, esz);
-            d[i] = l + (h << 32);
+            d[i] = l | (h << 32);
         }
 
-        /* For VL which is not a power of 2, the results from M do not
-           align nicely with the uint64_t for D.  Put the aligned results
-           from M into TMP_M and then copy it into place afterward.  */
+        /*
+         * For VL which is not a multiple of 512, the results from M do not
+         * align nicely with the uint64_t for D.  Put the aligned results
+         * from M into TMP_M and then copy it into place afterward.
+         */
         if (oprsz & 15) {
-            d[i] = compress_bits(n[2 * i] >> odd, esz);
+            int final_shift = (oprsz & 15) * 2;
+
+            l = n[2 * i + 0];
+            h = n[2 * i + 1];
+            l = compress_bits(l >> odd, esz);
+            h = compress_bits(h >> odd, esz);
+            d[i] = l | (h << final_shift);
 
             for (i = 0; i < oprsz_16; i++) {
                 l = m[2 * i + 0];
                 h = m[2 * i + 1];
                 l = compress_bits(l >> odd, esz);
                 h = compress_bits(h >> odd, esz);
-                tmp_m.p[i] = l + (h << 32);
+                tmp_m.p[i] = l | (h << 32);
             }
-            tmp_m.p[i] = compress_bits(m[2 * i] >> odd, esz);
+            l = m[2 * i + 0];
+            h = m[2 * i + 1];
+            l = compress_bits(l >> odd, esz);
+            h = compress_bits(h >> odd, esz);
+            tmp_m.p[i] = l | (h << final_shift);
 
             swap_memmove(vd + oprsz / 2, &tmp_m, oprsz / 2);
         } else {
@@ -1977,7 +1989,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
                 h = m[2 * i + 1];
                 l = compress_bits(l >> odd, esz);
                 h = compress_bits(h >> odd, esz);
-                d[oprsz_16 + i] = l + (h << 32);
+                d[oprsz_16 + i] = l | (h << 32);
             }
         }
     }
-- 
2.25.1



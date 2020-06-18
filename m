Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC192186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGflO3zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC192186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmi4-0002Lb-Ow
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCu-0003LJ-EF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCs-0003KG-FI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:20 -0400
Received: by mail-pf1-x441.google.com with SMTP id z63so2207961pfb.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sUjpYX85gvRbXx7OLAC50qSvAFYBPvgDJch2qLP0/gY=;
 b=sGflO3zfvBANaU5bLcNPfwo8SNckoZ/9/+VWaJ8Fscf1YHVvFHYtVclMWsvPNuLODv
 MJbi/XSG11GUYaWtC26gkiy+kau9HPW8tYlIUFdCbs2vNweFJ5SYCWwi3Bi7coFi9HLJ
 1ytid1qMQIfs6b7F+iMfyvFHZRSytMxRW7MbHS3229sDNpfX9DVYqaU5a3555jJTWptZ
 aclXFGQO4zTWQHFQAtEOaIdwamvd5tfo9js6rNLOkafOLl86IYiitZKYzzVwhUcVuXQ1
 Pu/gOcvuUELveiJ/0xyC+D/CsieO3kevhlmJ8MvyHsk9KnKsLQcfS25aa/DFTBMY9eBW
 lCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sUjpYX85gvRbXx7OLAC50qSvAFYBPvgDJch2qLP0/gY=;
 b=oVRgVXCb7EzmnowI/pvrh9w/MenC2h5N9YWp8HlOVr3NpyC2S5tR1BLyqG6fr4wVJ3
 jTp/hMiJ5Fax+idmxNOfGP3heG4sJYEvQyD+GVKNCjw6GuysfttGNUhod2Qa6NfjYvFr
 vbJBYfvoPIXysossypBcOsv7VN4hsoYST4IQH+n1r8c0HVjfVunh5V0QEsCi+clnl5DF
 6meOny73FFMMq4HaBwVNvws328FqpSNKF/Ub17FH2dZ2qy6jQ9hSG/1nn2zE3XG9VPbv
 8ZCGlZwVDXZpFpR7DteSWEOGn/VBK3QBq6E0q+Fxh0zwSr13hT0YkuuPP2pIQMABTmD/
 AhHg==
X-Gm-Message-State: AOAM531JHPqDSzaPnM4VGyNLOPHT8VnN7r84x8TMrRgdA5gBDT3cIhqB
 FubQUoQaPwUXtH7WvgLPINy9TEsvoVE=
X-Google-Smtp-Source: ABdhPJxA0TXeBEWgxpB+izctGP3IAwLMvSplFlvIT10m+HibjdygCr7UgncmYh64bBDijZCgRLcHxg==
X-Received: by 2002:a63:495c:: with SMTP id y28mr1882590pgk.30.1592454676833; 
 Wed, 17 Jun 2020 21:31:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o1sm974337pjf.17.2020.06.17.21.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 064/100] target/arm: Fix sve_uzp_p vs odd vector lengths
Date: Wed, 17 Jun 2020 21:26:08 -0700
Message-Id: <20200618042644.1685561-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, qemu-arm@nongnu.org,
 steplong@quicinc.com
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
index b1bb2300f8..f0601bf25b 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2971,7 +2971,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
     if (oprsz <= 8) {
         l = compress_bits(n[0] >> odd, esz);
         h = compress_bits(m[0] >> odd, esz);
-        d[0] = extract64(l + (h << (4 * oprsz)), 0, 8 * oprsz);
+        d[0] = l | (h << (4 * oprsz));
     } else {
         ARMPredicateReg tmp_m;
         intptr_t oprsz_16 = oprsz / 16;
@@ -2985,23 +2985,35 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
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
@@ -3010,7 +3022,7 @@ void HELPER(sve_uzp_p)(void *vd, void *vn, void *vm, uint32_t pred_desc)
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



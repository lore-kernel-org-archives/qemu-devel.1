Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8401C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D55420878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P48Mm0V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpjH-0004RC-Jz
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpX6-0001Cu-U9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:14 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpX2-0005Rz-Rw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:12 -0400
Received: by mail-pg1-x543.google.com with SMTP id 34so2840786pgo.13
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zr2QWZIaQ416tfvMuGmnFuEpgzcclZDiNIL1w+CaZnM=;
 b=P48Mm0V5ZXsyDICfr03qRnpHI2cflgPzbD+s83vBKG6aARRuGWJxDqHo3udWU4hl/j
 oyxYyxaVVGBlE1ySztLuJi4f1+eZNEddyYDTXv49z5W2UH/hKtyQRR9TSsA5dDpYFrVH
 U30MZXBo38S477lMCwnA1ePeVTHw4rzXgiwqBbFxFZZlwTeRscKJUGgxCffs8S2GQfMy
 /+82lRIbyJrrQdJMEHRX+ZlY0wtod5ez1/m74x+lQvP+PqSq4z39H5EwrvbqQynY0cmd
 sE3R+HiTFEz3ddjYYGJB1HT7gHWnGwDLVjnqrpMv6Klv9+jCzhVp0P+7slgFMG5uXcCG
 HYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zr2QWZIaQ416tfvMuGmnFuEpgzcclZDiNIL1w+CaZnM=;
 b=enoK4yPwGl65bnujx6uGmy90kCxhrm9kkPx1lnFq3r1D7SsuWeU+ycTN8XNMvRph1Q
 hNt9zwq3AEo/a3Gic2R61AbEW0SvN7CAdSsfPDmObxVr4IrObKH6R0xoohmePv3M1M5g
 DD9VA0TBYwEC7CiIGhCYS/pxCJm8dcUMPJRc2AAIQfTBw177ypLmcthDTZHkCahxxK4y
 jDacdyjDZcIeKN1ULVhWgSG8TRPCIK7twEgLztuVTKp/RsJ2/wDaG9XpEACw5634N0mz
 plRi8pj04ogpsFxRJOz4UCJGHOS7hOLACsjABURL33cLkC1X4uTmXOOG7Pj2hww9Qs38
 w9dA==
X-Gm-Message-State: AOAM5302DMOgYFWoDHtb8VuPNhMPcbwy35LsmSSGkB+WW+e3DKtlDuw3
 EbaUbJrNUVVD80FCpRKZWj2gFGhUTcoBjw==
X-Google-Smtp-Source: ABdhPJwdAQXPL872sdEPiy5IQ3upfPMUvoXdE5S0t5BTBhFxgKyrLFnFliKgqkE0uFd40kvPqqj1dA==
X-Received: by 2002:a17:902:b702:b029:d1:e598:4014 with SMTP id
 d2-20020a170902b702b02900d1e5984014mr5129473pls.78.1601047261839; 
 Fri, 25 Sep 2020 08:21:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:21:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/10] softfloat: Use aarch64 assembly for {add, sub}{192,
 256}
Date: Fri, 25 Sep 2020 08:20:46 -0700
Message-Id: <20200925152047.709901-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The compiler cannot chain more than two additions together.
Use inline assembly for 3 or 4 additions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 14 ++++++++++++++
 fpu/softfloat.c                | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 99fa124e56..969a486fd2 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -442,6 +442,13 @@ static inline void
         "adc %3, %0"
         : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
         : "rm"(b0), "rm"(b1), "rm"(b2), "0"(a0), "1"(a1), "2"(a2));
+#elif defined(__aarch64__)
+    asm("adds %2, %x5, %x8\n\t"
+        "adcs %1, %x4, %x7\n\t"
+        "adc  %0, %x3, %x6"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "rZ"(a0), "rZ"(a1), "rZ"(a2), "rZ"(b0), "rZ"(b1), "rZ"(b2)
+        : "cc");
 #else
     uint64_t z0, z1, z2;
     int8_t carry0, carry1;
@@ -507,6 +514,13 @@ static inline void
         "sbb %3, %0"
         : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
         : "rm"(b0), "rm"(b1), "rm"(b2), "0"(a0), "1"(a1), "2"(a2));
+#elif defined(__aarch64__)
+    asm("subs %2, %x5, %x8\n\t"
+        "sbcs %1, %x4, %x7\n\t"
+        "sbc  %0, %x3, %x6"
+        : "=&r"(*z0Ptr), "=&r"(*z1Ptr), "=&r"(*z2Ptr)
+        : "rZ"(a0), "rZ"(a1), "rZ"(a2), "rZ"(b0), "rZ"(b1), "rZ"(b2)
+        : "cc");
 #else
     uint64_t z0, z1, z2;
     int8_t borrow0, borrow1;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fdf5bde69e..07dc17caad 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7358,6 +7358,18 @@ static void sub256(UInt256 *r, UInt256 *a, UInt256 *b)
         : "=&r"(r->w[0]), "=&r"(r->w[1]), "=&r"(r->w[2]), "=&r"(r->w[3])
         : "rme"(b->w[0]), "rme"(b->w[1]), "rme"(b->w[2]), "rme"(b->w[3]),
             "0"(a->w[0]),   "1"(a->w[1]),   "2"(a->w[2]),   "3"(a->w[3]));
+#elif defined(__aarch64__)
+    asm("subs %[r3], %x[a3], %x[b3]\n\t"
+        "sbcs %[r2], %x[a2], %x[b2]\n\t"
+        "sbcs %[r1], %x[a1], %x[b1]\n\t"
+        "sbc  %[r0], %x[a0], %x[b0]"
+        : [r0] "=&r"(r->w[0]), [r1] "=&r"(r->w[1]),
+          [r2] "=&r"(r->w[2]), [r3] "=&r"(r->w[3])
+        : [a0] "rZ"(a->w[0]), [a1] "rZ"(a->w[1]),
+          [a2] "rZ"(a->w[2]), [a3] "rZ"(a->w[3]),
+          [b0] "rZ"(b->w[0]), [b1] "rZ"(b->w[1]),
+          [b2] "rZ"(b->w[2]), [b3] "rZ"(b->w[3])
+        : "cc");
 #else
     bool borrow = false;
 
@@ -7388,6 +7400,13 @@ static void neg256(UInt256 *a)
         : "=&r"(a->w[0]), "=&r"(a->w[1]), "=&r"(a->w[2]), "+rm"(a->w[3])
         : "rme"(a->w[0]), "rme"(a->w[1]), "rme"(a->w[2]),
           "0"(0), "1"(0), "2"(0));
+#elif defined(__aarch64__)
+    asm("negs %3, %3\n\t"
+        "ngcs %2, %2\n\t"
+        "ngcs %1, %1\n\t"
+        "ngc  %0, %0"
+        : "+r"(a->w[0]), "+r"(a->w[1]), "+r"(a->w[2]), "+r"(a->w[3])
+        : : "cc");
 #else
     /*
      * Recall that -X - 1 = ~X, and that since this is negation,
@@ -7430,6 +7449,14 @@ static void add256(UInt256 *a, UInt256 *b)
         "adc %4, %0"
         :  "+r"(a->w[0]),  "+r"(a->w[1]),  "+r"(a->w[2]),  "+r"(a->w[3])
         : "rme"(b->w[0]), "rme"(b->w[1]), "rme"(b->w[2]), "rme"(b->w[3]));
+#elif defined(__aarch64__)
+    asm("adds %3, %3, %x7\n\t"
+        "adcs %2, %2, %x6\n\t"
+        "adcs %1, %1, %x5\n\t"
+        "adc  %0, %0, %x4"
+        : "+r"(a->w[0]), "+r"(a->w[1]), "+r"(a->w[2]), "+r"(a->w[3])
+        : "rZ"(b->w[0]), "rZ"(b->w[1]), "rZ"(b->w[2]), "rZ"(b->w[3])
+        : "cc");
 #else
     bool carry = false;
 
-- 
2.25.1



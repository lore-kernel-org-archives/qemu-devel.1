Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CEAC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D129621D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr2PYB98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D129621D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCLU-0003ej-BK
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIW-0001ev-Dv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIV-0004Bn-B4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:38024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIV-0004AY-5A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id h195so4156831pfe.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aF7h8rqeF+2t+99M3oN6M4tL53Bil7zhbXJ09PpgfiI=;
 b=Jr2PYB98n8W4eYtLOfF7FaH9i2h89lfkq5iTuXlXuUruLL7WEKdy7ubbBilpWNmjzc
 xSXbInx+BbxFhvPrepFdAr+KPswc8JdZyNrlP3cL0t2wxpnD8QmGiewGnmrGnk8e1O9z
 H1+A/vopzcR5VbtN/+vaDDyGhd+rdGVycOdK0HIJBCsb3KrLZdMTTnJ6cLoV7KWWvu5V
 C6/42tHAaOuw2Qh+0zUWEUwjRI0mv8LcNTci3QMeXxi6xXI+/BACso7QTBUaMGMVxNVN
 6P0V7wYPZzL2y8wCk2s3v9OdsZ010WOkvbOkCkCm6prosn2KZwYwgVvZ13pXovg0Lmb1
 ACTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aF7h8rqeF+2t+99M3oN6M4tL53Bil7zhbXJ09PpgfiI=;
 b=CM7EM7fUTDuL+de/4NwvUdUeo86j6VqvseTGsH6BHgIRVD63/erZi/l4tFWfHfM364
 nLMlsHFgnmxstnSmYtq/nFkjzBas2GT3Xx4ALvkxLsPRbC1mYWshLmT9SoVivtBRcKQT
 u2kDOveyq2awGzdTP0RR7yCpCAxtQjkMWN1NoMszyKqYw3cPZ92sFphpmczmn1TRicnh
 tyu3x99q0Tu0k+9IQ8rffoblhVG3o8O/jCakCt+FBWGnkS60uUu3gxIsvM6s692Ln4x0
 VwOFZcS10I5LrRevMhW+M2F1/VGj5gRUGJcxBnUIo7LkxWpyRZ8+1LNPiEExLIh4pmoL
 G9Fg==
X-Gm-Message-State: APjAAAXFmbRlPLJPhN63xX7slC7VOqwrbt9CqTFW8RWD8WZOa6xtW+PG
 nFGHe/wBP1B4yyjdLsixf4u2I+0z3DE=
X-Google-Smtp-Source: APXvYqy7hbfP1zi8q5boWgxY4MiapiMBa0dI6Mt7hWL+sIMg4PpcxOONPfi0FkSPrTNIrvmHp2+Gkg==
X-Received: by 2002:a62:780c:: with SMTP id t12mr11065326pfc.211.1569437153746; 
 Wed, 25 Sep 2019 11:45:53 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] cputlb: Disable __always_inline__ without optimization
Date: Wed, 25 Sep 2019 11:45:34 -0700
Message-Id: <20190925184548.30673-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This forced inlining can result in missing symbols,
which makes a debugging build harder to follow.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 11 +++++++++++
 accel/tcg/cputlb.c      |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 09fc44cca4..20780e722d 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -170,6 +170,17 @@
 # define QEMU_NONSTRING
 #endif
 
+/*
+ * Forced inlining may be desired to encourage constant propagation
+ * of function parameters.  However, it can also make debugging harder,
+ * so disable it for a non-optimizing build.
+ */
+#if defined(__OPTIMIZE__)
+#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
+#else
+#define QEMU_ALWAYS_INLINE
+#endif
+
 /* Implement C11 _Generic via GCC builtins.  Example:
  *
  *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index abae79650c..2222b87764 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1281,7 +1281,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
-static inline uint64_t __attribute__((always_inline))
+static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
@@ -1530,7 +1530,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static inline void __attribute__((always_inline))
+static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
-- 
2.17.1



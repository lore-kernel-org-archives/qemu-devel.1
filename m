Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE70C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC0A2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kq/mi5LH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC0A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VjS-0002H6-50
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0Viq-0001rP-KF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:57:12 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0Vio-0000FE-Tq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:57:12 -0400
Received: by mail-pj1-x1041.google.com with SMTP id lx9so571908pjb.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MzEFyHDI+gQaC24ULbu9ulS+caIcRJo+sQsIVHnovso=;
 b=Kq/mi5LHfHr6kqoh3FzwhWYpcyLrgH8+ryYGXN7whRrsSmvcoZKlwdEAJVd/3bEIxC
 OsJuERMChY87iljicnfRDNT56Ijb8ZJ8kJO6ZW8X7eqj9Xbdw0LXvK+Be44j8Tp4xTb1
 CRvDrX51h8F+hkA5Aeo2VUnOOTt3nKadVCaxuNPoeFWYpmgqPNyvlHMsn0727I7dlXUo
 xMco9Tjh8CZNFwTuHlpZf55diewRWcpYwcAAktIyUus/PtosrwHSbzfn0WDVvj1nqS06
 xM1WwV+Ubd/ib9mfEigiV0o8pulZbyR6b/5oFU84GSun1x1lAdFPvvdTiFy65ncoUVqL
 T+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MzEFyHDI+gQaC24ULbu9ulS+caIcRJo+sQsIVHnovso=;
 b=fri28Bi9V8l8KQfQDoMyDP92x8Cw8BusTJF+WqveZLAy6u1cHu8jKRiQpN2dPkSOQ9
 I8E5sUuZeO1RoaUDckww8MdvzDcF5sTuFnKD9ePZ03yRLbM9X+Ry57rcOgwMG/1Nrq0h
 3vV5bdJ+gITOUPi4dHep3lfBjBOghkOq5ItzIaKg+XHfOskgNyR8RLKM6Tf/HPWnxV5F
 gQ1NTYiW187eThGEgCvP0Fy79K7A8nglgvUCbjRe7IhRAGF1MG+dSa7nNOibrkJvuNjh
 3JiDY+bDD4pykoYBFdUG/8O8gFN6se9AQL3QHAOZ+6esqi0hTEBMEBDaAh+L2Af+VQzc
 HXWQ==
X-Gm-Message-State: AOAM531wIc53Ri0ZqrCV5vuWRHeKDCsYhlRHBRl2fNO0fXNQJNE5K9zm
 XYfO+lPkWqls+do1euIeaBjROUPWBpw=
X-Google-Smtp-Source: ABdhPJyhD64qsYKY36y+in2A9mctVHMToFlpscu/abevuxRYqARzljgt25hwnvd8Ox2xIvENJTShRA==
X-Received: by 2002:a17:90a:7185:: with SMTP id
 i5mr6519554pjk.170.1595966228170; 
 Tue, 28 Jul 2020 12:57:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w3sm19386498pff.56.2020.07.28.12.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 12:57:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix AddPAC error indication
Date: Tue, 28 Jul 2020 12:57:06 -0700
Message-Id: <20200728195706.11087-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Derrick McKee <derrick.mckee@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The definition of top_bit used in this function is one higher
than that used in the Arm ARM psuedo-code, which put the error
indication at top_bit - 1 at the wrong place, which meant that
it wasn't visible to Auth.

Fixing the definition of top_bit requires more changes, because
its most common use is for the count of bits in top_bit:bot_bit,
which would then need to be computed as top_bit - bot_bit + 1.

For now, prefer the minimal fix to the error indication alone.

Fixes: 63ff0ca94cb
Reported-by: Derrick McKee <derrick.mckee@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c         |  2 +-
 tests/tcg/aarch64/pauth-5.c       | 33 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-5.c

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index b909630317..d00cd97332 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -300,7 +300,7 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      */
     test = sextract64(ptr, bot_bit, top_bit - bot_bit);
     if (test != 0 && test != -1) {
-        pac ^= MAKE_64BIT_MASK(top_bit - 1, 1);
+        pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
     }
 
     /*
diff --git a/tests/tcg/aarch64/pauth-5.c b/tests/tcg/aarch64/pauth-5.c
new file mode 100644
index 0000000000..67c257918b
--- /dev/null
+++ b/tests/tcg/aarch64/pauth-5.c
@@ -0,0 +1,33 @@
+#include <assert.h>
+
+static int x;
+
+int main()
+{
+    int *p0 = &x, *p1, *p2, *p3;
+    unsigned long salt = 0;
+
+    /*
+     * With TBI enabled and a 48-bit VA, there are 7 bits of auth, and so
+     * a 1/128 chance of auth = pac(ptr,key,salt) producing zero.
+     * Find a salt that creates auth != 0.
+     */
+    do {
+        salt++;
+        asm("pacda %0, %1" : "=r"(p1) : "r"(salt), "0"(p0));
+    } while (p0 == p1);
+
+    /*
+     * This pac must fail, because the input pointer bears an encryption,
+     * and so is not properly extended within bits [55:47].  This will
+     * toggle bit 54 in the output...
+     */
+    asm("pacda %0, %1" : "=r"(p2) : "r"(salt), "0"(p1));
+
+    /* ... so that the aut must fail, setting bit 53 in the output ... */
+    asm("autda %0, %1" : "=r"(p3) : "r"(salt), "0"(p2));
+
+    /* ... which means this equality must not hold. */
+    assert(p3 != p0);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b617f2ac7e..e7249915e7 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -19,7 +19,7 @@ run-fcvt: fcvt
 
 # Pauth Tests
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4
+AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
 pauth-%: CFLAGS += -march=armv8.3-a
 run-pauth-%: QEMU_OPTS += -cpu max
 run-plugin-pauth-%: QEMU_OPTS += -cpu max
-- 
2.25.1



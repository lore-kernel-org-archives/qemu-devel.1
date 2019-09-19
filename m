Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5338AC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB97206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bbc92H/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB97206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5vG-0000UB-W4
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s6-0006EQ-Ak
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s5-0000ir-8Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:29:58 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB5s5-0000iV-1n
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:29:57 -0400
Received: by mail-pl1-x643.google.com with SMTP id d22so2303275pll.7
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QPmhTNNeHsMpQB5FpTHLnap4hQHr8B38z692x1bPeOE=;
 b=Bbc92H/HCxfeTY5layjFht+Avl8YAvGQ7oS3mzcEiF60ozopazSrVflFe8u6KoOvNi
 saTo3BDtVhs1ubLHUgsnh2teyu7ZcylkZSTtmG+En9FwNxtaarczEGeEcWb/vJiR46eA
 QWQsOo2ies0BKNQ2cjxWfLBGaVNz1862ryTY1eHfAO6N72gyP4/fGQapyJ17yitRNI6o
 40cc6BJSo6Ltfa0QOMhELyUicTeDNLH6joqyiEBc7Iu3IA3dnMdL2BK9RiC2+eqLUYRQ
 1Bvu/cR6P1i5+OxeeriyJIzIJgJJX0Sp+njn3DwhEgNa3bMMMyjOf7gHkpES2EnWUE7V
 qSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QPmhTNNeHsMpQB5FpTHLnap4hQHr8B38z692x1bPeOE=;
 b=F1TIWB/UHZoBykvwbCCMixseIEiydZ+91zOv66QAvqKUQ0gjxpRXWCtKJbQ3hNNevq
 y3S5ecYu9qZHAdIm7sl7iwaIxMNh2LweUsgyB6dhhbDKzQ+tJH/OvgbvdTbGHzQnN4uz
 K8x0FB3l0wErdqHebl6SygV5sch5+d4TnAHKw5hLkGbkZkRTAZO5peC+iIRrdnHdiWph
 xEYmnX+tv5XVnHdbxeCJmMuG8l4WYJpA/8vz7+qvhSQGvsutCugPq7pGA4LuShnTJq3o
 3WGCODgE+x8j3wHsm3DMGBepjHOIMGR9P/9iszRP2gia/YxcGDahw02k/C9jynKWWViW
 fWiQ==
X-Gm-Message-State: APjAAAUgSAKG0ho6eGuxU99nn49W4Cbn85jbdLWn2fdhiKY8J/uldDDd
 kil1tzwEDiqG6Haur/y63qdbUi4BA10=
X-Google-Smtp-Source: APXvYqzxE8WJNjcUoAGwNLJJz8qHd1QNndol6PEcapeQm0XaGrx6uaxsHtAARj4CQ+1fuTqu6A/xVQ==
X-Received: by 2002:a17:902:59da:: with SMTP id
 d26mr12809340plj.193.1568935795675; 
 Thu, 19 Sep 2019 16:29:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h8sm103340pfo.64.2019.09.19.16.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 16:29:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] exec: Use TARGET_PAGE_BITS_MIN for TLB flags
Date: Thu, 19 Sep 2019 16:29:46 -0700
Message-Id: <20190919232952.6382-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
References: <20190919232952.6382-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These bits do not need to vary with the actual page size
used by the guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d2d443c4f9..e0c8dc540c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -317,20 +317,24 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #if !defined(CONFIG_USER_ONLY)
 
-/* Flags stored in the low bits of the TLB virtual address.  These are
- * defined so that fast path ram access is all zeros.
+/*
+ * Flags stored in the low bits of the TLB virtual address.
+ * These are defined so that fast path ram access is all zeros.
  * The flags all must be between TARGET_PAGE_BITS and
  * maximum address alignment bit.
+ *
+ * Use TARGET_PAGE_BITS_MIN so that these bits are constant
+ * when TARGET_PAGE_BITS_VARY is in effect.
  */
 /* Zero if TLB entry is valid.  */
-#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS - 1))
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
 /* Set if TLB entry references a clean RAM page.  The iotlb entry will
    contain the page physical address.  */
-#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS - 2))
+#define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
 /* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
+#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
 /* Set if TLB entry contains a watchpoint.  */
-#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
+#define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
-- 
2.17.1



Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B52C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CFA20850
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WP77n55K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CFA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P9a-0008LO-9A
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1i-00083l-Be
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1h-00075w-C1
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1h-00075b-6N
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so11552109pgl.11
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3NfLm6NXnIjoUElBfRuvMC+OA+QWlwc3LpGafv9TLcg=;
 b=WP77n55Ki+4NcBuky87luuVBaS82eXlW7thfzpdWPx/p4+9nyRN+BRRQRFwJzCXTOF
 pq1DwPyddGS4GdD79NMRJzXHdXrPOZ7O8KNuZTFNQ5jRq3Dr601ZDBZUiqyTNmVNgRXg
 9osWZw//pLQfrvfsvX2KI/VqEAbOJANEgLtjI8OSdH+xOviZE0TsdStDMzlS4+1cMBn+
 vT+pCvh1yMbW7FFzlzjfoyvbXa1Th2yzsdceeUTQSz7ybMtp/j8aPa8JZaczRALVCeo3
 RWVKSz5wPbZ7TgP3tSxNeVsNvMuny3B7fD1r/eki9z8wcvEgI83wSlkKkH9OekLzkLi0
 QZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3NfLm6NXnIjoUElBfRuvMC+OA+QWlwc3LpGafv9TLcg=;
 b=EM3Q0CfISLnBhFtaHaIyfI9qqLc0WhjnHNHQtz4ja9GYQKpmOE6GU8al8+0OJhN868
 M46QD2ObXmBvKLtL8xodyxp6ugu1g06uekBvyAgjAZ308sOvMwX082xhQbCkST09H0Ck
 o+ldbPo8d/9lN0oddzvFTDkhm5wBBG6sHXKBpKtVzohxv4lXClM7y8SvP9RxiqGxsyCw
 U3e1Hyf6OikHZKFoZLRFQHCKhMIUpJxO3BSPDVTF+31QbYejRh5UE2XktIVJRIALxG5X
 w14QdlpJ5buGoGMfDZK9nDyIbcWHMuhK8ULYV9AP35hjiNpTZwAoieV4tfeIJ0Su56mh
 Slsg==
X-Gm-Message-State: APjAAAXyTM6SoArrsagdQjlwtheiHcjs2tM1CzF+lUtXsbAront+GVby
 acYRtT9SbeM/r4/FjP7A4hYAe95u9YU=
X-Google-Smtp-Source: APXvYqyWm+53IhN8EAFqzx8XaaJK6Lps0I8KzZjb2Ovz3xgQahtvdWQRUpE3M7H1E20Pi4k4lPe7NA==
X-Received: by 2002:a63:9e56:: with SMTP id r22mr18765436pgo.221.1566864475882; 
 Mon, 26 Aug 2019 17:07:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:39 -0700
Message-Id: <20190827000745.19645-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 07/13] target/openrisc: Fix lf.ftoi.s
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The specification of this insn is round-to-zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index b9d2ebbb8c..4cc5b297c5 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -78,7 +78,7 @@ uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
 
 uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
 {
-    return float32_to_int32(val, &env->fp_status);
+    return float32_to_int32_round_to_zero(val, &env->fp_status);
 }
 
 #define FLOAT_CALC(name)                                                  \
-- 
2.17.1



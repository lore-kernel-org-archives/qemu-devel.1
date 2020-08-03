Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57450C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28B522C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkERSRw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28B522C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gLA-0001sX-Te
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDx-0001Zv-RS
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDw-0003aW-2d
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id p20so358546wrf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j1c+F8DYbSwCT13YFoz0sEvQBiVdlsCam126Zkl/q/Y=;
 b=DkERSRw2DpNV1ecAeLJnOB/pwkZ/LiAzpuW7jRapT4QU3Yf4UH9tcgTpUo78Wi8PhE
 lGxEaSHVMJb79zWZTkbfIs0cpclEsB9fL96O9B4QzpUwlwe/0VHlgPtWE6GOO1SyI4fA
 2UvqTC04/AhcDqn/KRz4lrIndSx+Eo4C8fpzPjLoea7cxMISf5Vt131rKeAQdbrUzA2a
 1++kPlF7QOi7kjHxS/0214LwWtT87nqvF5s2C7PzYLAK5yavvLLHyBqeVj/Vi5YcGhxB
 XMzmjhRXeaa8w3aAfufXoBvzPMbYo0Rrgx/Buq2rjJG0x9UwyBdYZ/UjY2e5a6CZYYiz
 1sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j1c+F8DYbSwCT13YFoz0sEvQBiVdlsCam126Zkl/q/Y=;
 b=KiNObMW/c138LhR5SX45a0UCYpvmdJv6DvyN5j50ReWoopHAqfXg6otvI1U65wwm6Z
 Tv8dz+UBk9cOoMVfkvJainmpo7TYjD05HJ4/OOeevneYRK7TLk7j3tdxiIO6nS4fAkAX
 G5pDv/ghC5+miJVcMfwLmCr9jLuczsv1COjpFZGqmC+YNsGij/P7VE6gTCvT9z43feLS
 2x4zCAGeqn/Qyj6RNyemRMtdUmAapbs+cV/OsMu3kb07GqqJw7i5jbFN40CVqe/sFAy8
 DwS+rYsnlBJLrND07JmEFHegMm+1HHI0kCHFagJSBJp0bOzgqgkdarZ1Sy3MkK+mFsQ7
 rDLg==
X-Gm-Message-State: AOAM533unTxi/povc5tA5gFrRwEi9uuRBxE/z7fQ3if9YhS149YM83Oo
 SAtXeYzAvwgo3J+P3AIfDC9VctRME2lceQ==
X-Google-Smtp-Source: ABdhPJywWxrJ3tzqTIbHNIgR6m7Y3U7brQDRKgK3L5EPzkeBbAh+JZFDBgsDGMEF0P88XKWMhvzWcw==
X-Received: by 2002:adf:8486:: with SMTP id 6mr16371550wrg.109.1596483253792; 
 Mon, 03 Aug 2020 12:34:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] target/arm: Avoid maybe-uninitialized warning with gcc 4.9
Date: Mon,  3 Aug 2020 20:33:57 +0100
Message-Id: <20200803193359.12936-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
References: <20200803193359.12936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kaige Li <likaige@loongson.cn>

GCC version 4.9.4 isn't clever enough to figure out that all
execution paths in disas_ldst() that use 'fn' will have initialized
it first, and so it warns:

/home/LiKaige/qemu/target/arm/translate-a64.c: In function ‘disas_ldst’:
/home/LiKaige/qemu/target/arm/translate-a64.c:3392:5: error: ‘fn’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
     ^
/home/LiKaige/qemu/target/arm/translate-a64.c:3318:22: note: ‘fn’ was declared here
     AtomicThreeOpFn *fn;
                      ^

Make it happy by initializing the variable to NULL.

Signed-off-by: Kaige Li <likaige@loongson.cn>
Message-id: 1596110248-7366-2-git-send-email-likaige@loongson.cn
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: Clean up commit message and note which gcc version this was]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8c0764957c8..c98dfb17a83 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3315,7 +3315,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     bool r = extract32(insn, 22, 1);
     bool a = extract32(insn, 23, 1);
     TCGv_i64 tcg_rs, clean_addr;
-    AtomicThreeOpFn *fn;
+    AtomicThreeOpFn *fn = NULL;
 
     if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
         unallocated_encoding(s);
-- 
2.20.1



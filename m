Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5177C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3FE20767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKkgiQZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3FE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmKq-0004sk-Fy
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJv-0003OW-D1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:45381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJr-0005td-SW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id bh1so3225950plb.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Qj3xRWO6EliICZrXOPzUaS0C7IplaZERqwK2dfygrE=;
 b=SKkgiQZCcBx65/es52wy/nSwOdefuy/15lslalGHa1xke3Zb682mUXlbBDPgqExu1+
 zHb8B9oAH8BBr2O2WVxaIDt/p4NfTQn3dFzfkNm905F3P1ItqRqtKKnTnjJQEHzY3IsL
 VIXiiOBUmNukMpBilArRX7GOQ08HMhhcNXUni8Gg44ep2EQXJxkqZO20/Dp5Sxkr4krE
 rXPMGGQd5OUgpymcIqwEViebExSpswDAaG5HJyivIDEI26M23j2ssWqtX84O+G2HYhOB
 +MBwD5put/b1gTtUYVNqlqe6DNjBRW9Fqpu7LUPT2rGadhCzhjGtY452qaTK2ptZO1HY
 L5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Qj3xRWO6EliICZrXOPzUaS0C7IplaZERqwK2dfygrE=;
 b=AmlPO07cwkJh5rpszbAgAJz3OQ9AeAdisQbAtpTAqeBxrWv1xkb2MbXQXG1c6Xwy83
 nUGL5IsQDJdSto/Gfe/Cp0I1+FA+g5NUWIbuJtgmRDXhzrm6fGWln7iNKE35cZemyVCD
 r52yb8TlNttQP1QX1oYJKqovGUPiHSyc6EZd0jkhHGQ+VI4c5WBnwzWL5tyVxHGk0Jwn
 OM7uqHvmFvMsX+hh7/+lgOJHhS/yh1BiJcrsxWjgo/KftZN3u5ZUIqEB46j2PPAgPhkX
 HXLJl1Vp+AXgp6EPz/5eYGl/o/gKLJ/4xEoUvzCvPlaNofZOiQbpFuAbcn0mOby3bEAm
 w92Q==
X-Gm-Message-State: AOAM532CvhNLglFJ4UkaLtEBBOCvi1h6c0xipvL6F/8wGf5DoRQvOcJ2
 E2VfhvuzSebmm/XPTrU1Gqyr6AU0kkmb4Q==
X-Google-Smtp-Source: ABdhPJyYXgbdbcDN/qe/CXQPNYVsBLr4U4U5+Tv9bqq24SHnnGDsCFZsHtpbVZbTaSCkKgNS0EjNXg==
X-Received: by 2002:a17:902:7083:: with SMTP id
 z3mr1503304plk.187.1598889965788; 
 Mon, 31 Aug 2020 09:06:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/76] tests/tcg: Add microblaze to arches filter
Date: Mon, 31 Aug 2020 09:04:46 -0700
Message-Id: <20200831160601.833692-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not attempting to use a single cross-compiler for both
big-endian and little-endian at this time.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/configure.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 7d714f902a..598a50cd4f 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -94,7 +94,7 @@ for target in $target_list; do
     xtensa|xtensaeb)
       arches=xtensa
       ;;
-    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
+    alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openrisc|riscv64|s390x|sh4|sparc64)
       arches=$target
       ;;
     *)
-- 
2.25.1



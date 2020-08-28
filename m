Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF259208C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6/ylgLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF259208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfFE-0000z2-Vh
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE8-0007nf-Bu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:42632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE5-00050z-TT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 17so729224pfw.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pja91OOCTOC632k6hUXx/Hme4SkTt9HZ9gi0Kb477RM=;
 b=N6/ylgLtvX0ERwmi9ditzHITGoAA9HREiiEp5gIBwjoSmHNMVcfxFZCbT9SQO8Uz/m
 vGH0+J0bNBKV8DjgsjxZuraGc7jieIHwoS1kTsA7OeqWRIpT3loHS8vYwXdvwGVB40NQ
 yxowpEJ9hUkQBu9ZgXHWg/JsmNqy9Otvn4AMAUKZBs3cvhYIfZWs0ieH4PMIGz+8/V8G
 ZwI8LM/fqf9Yxem1YYXWVTNjMx7SPKvGvTzqcjHUS4QFi3xJNZJnrwRxb+5g5MMtFeE/
 La/PsEmO2XqbcQx3Y0qm9OqdnChUpskH9eLt9Ob9M5JzczRH4NA138LRtLq88fNxr47e
 DU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pja91OOCTOC632k6hUXx/Hme4SkTt9HZ9gi0Kb477RM=;
 b=CXqjt8He2CE6yHPDk5I0cXteaz/74Y6QcXEtTfdDSYk8kWcOA/kB0p8k2SSwVs+9ZM
 m3/wiSJr/enyPSYOJ4ToPck0f4e3O0QfmLMsIHpbxbvmJy32RJd68j3e2Gqt7LwRuNwn
 xpPu5yLOStClHIWN5/93gQMbjbQfEZBXKG2iY5OQwS5iCfIzVPx/0BHSgt1G3AR0H+H6
 LoLe52QLw2vxggFcp7jx2W9jDE8SH1+9wNdOp8Asd4CBjAwdrvtyJdAPsd5SHdphtaMa
 SbmyhaMbxL0Dlj2eREhMpJKYn8+KSdUZaxXDaOW/iOqg87E1jSHKiSo3R7SUhOgqMceM
 ZIhA==
X-Gm-Message-State: AOAM533dz+pz/2K8cCOSniJeKIcXXRQC7QB3lYd4Dxlz4eS2G8ExR8Qk
 0ghnlZRbpGzOAJ6I3++o/bdGm/z0+zX7lQ==
X-Google-Smtp-Source: ABdhPJx0uaQhLOP76muEQaAgJ4JDyDzwWqBy2kS4DB7djVd9swCVMPZtwCIVrFRC2yWbBIF3i9Ln1A==
X-Received: by 2002:a63:fc4b:: with SMTP id r11mr1399093pgk.342.1598624372267; 
 Fri, 28 Aug 2020 07:19:32 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/76] tests/tcg: Add microblaze to arches filter
Date: Fri, 28 Aug 2020 07:18:14 -0700
Message-Id: <20200828141929.77854-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not attempting to use a single cross-compiler for both
big-endian and little-endian at this time.

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



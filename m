Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918EEECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5171B2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5171B2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yaH-0004iM-Ot
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwc-0000J6-LL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwb-00070E-Iv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwb-0006zy-DS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so23417024wrm.9
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=s35F55O2Em8wHwXR9VPPU+OtN5AgatRpyAF6CF2QIKI=;
 b=ddXum8k/ImGRcrQ/t1BPbPWpGm853uD7kHHyBNIOPr4bMW6NtoP7YPT9vw6movIcw0
 Vj/DcQKgvKZEVqssGyYtE/hkordE0lpNJ6wfh7oCTFOtIJi4BC07EFuaQVXDj6DT2XzV
 1WJOUPGMWYnjg2jq8HkxD02QGVDcHJKK3+MK8DEjLTUawuFAF7VFooe9uXi6Y4f105Ww
 s9dphiOXcI5uWcX5h7Lk5aN7iqorM/JwExuDzfooXkeELHAMolV9RXfvZObBlRuI9TTy
 FvpEiZKns4LGCarzEhxRIf1SaxeevuGHLxfjwmJ7VwWi8VaNB5g2AJGy4hnGhnP9Lt1X
 E/9g==
X-Gm-Message-State: APjAAAXpyRJ3e20NV2MXt8QD92CklAsclESLUXO1k45EPO2oMBWOUr7d
 dMOSljShB9ZQSc66/Qm1L1IXgw==
X-Google-Smtp-Source: APXvYqwyOpdU76q4QGF+CrWLpTrOoNjXAE1IWJiIFUYnKWxPwdhUc8Zd55cKfkmSQ3JHuYqcDmTlzg==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr1855594wrs.191.1568190340232; 
 Wed, 11 Sep 2019 01:25:40 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id o22sm37968406wra.96.2019.09.11.01.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:39 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:05:13 -0700
Message-Id: <20190910190513.21160-48-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: [Qemu-devel] [PULL 47/47] target/riscv: Use TB_FLAGS_MSTATUS_FS for
 floating point
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Use the TB_FLAGS_MSTATUS_FS macro when enabling floating point in the tb
flags.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 16efe8c860..124ed33ee4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -301,7 +301,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #else
     *flags = cpu_mmu_index(env, 0);
     if (riscv_cpu_fp_enabled(env)) {
-        *flags |= env->mstatus & MSTATUS_FS;
+        *flags |= TB_FLAGS_MSTATUS_FS;
     }
 #endif
 }
-- 
2.21.0



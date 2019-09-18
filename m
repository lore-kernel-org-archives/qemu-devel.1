Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1555EC4CECE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E314F218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E314F218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcgg-0008VJ-Bl
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsz-0007y7-Di
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsy-0007FA-0R
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsx-0007EX-PA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so20814pgm.13
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=s35F55O2Em8wHwXR9VPPU+OtN5AgatRpyAF6CF2QIKI=;
 b=iVGpj6fZlMGqHm89PH5x2MQXYZMTP9ioiM3dz+zoMat/FMBTm8GteGYvByZsH4iD0p
 UNYqE+EOIXgnRRp8qtjbVHlv/cSRsC6HZSMEScMOyGa/qDJacEbbhTOPMk0jYfrAapma
 DvRl1om+KKC93jt8ZFuOERN30QRppGFYtAF3aez1Mv9UnLNCSQ36XN7fV0ebl2daPoQL
 8a/7IbBMOwhuaMQ2X+w5lwu0i6c3SCVKxJchb+rn5tt9N3xC2vMdtHUq0ysiwKzi0glf
 w21d/aNgnvgr9dF/1kRQjxFwZe0bss8/XM3SfjUYZGAiQ3daqKXEj61mfn5nRpr93iA7
 YzMw==
X-Gm-Message-State: APjAAAXyJC4IAsX5TCcA3goyB82Os3dbA0I8XCrXJxGwANTWLXo7s7XI
 r58B4xrh0SFT1YnhPExSFrbtGKtgfgU=
X-Google-Smtp-Source: APXvYqzfy1VAvBWF50RP0rDWtfaHd15KCdWTqLI6sI18eWmoectT8vFWQSUyCS2r5ByGoB1WXU/NGw==
X-Received: by 2002:a63:2a46:: with SMTP id q67mr4587738pgq.108.1568820530572; 
 Wed, 18 Sep 2019 08:28:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id i6sm10705310pfq.20.2019.09.18.08.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:50 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:39 -0700
Message-Id: <20190918145640.17349-48-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: [Qemu-devel] [PULL 47/48] target/riscv: Use TB_FLAGS_MSTATUS_FS for
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



Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE6C218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE6C218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAccf-0004Nr-Fn
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsx-0007vp-Lc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsw-0007E4-GX
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsw-0007Dc-Af
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so225386pfa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=QB4DlvulPZzUlgaey1nZw8B8imJR4kB3iDL99emwfxg=;
 b=iblMYP5H7oH7N+/wPNfRLNLw+4fguvgcQD3kGOQT6zhSnYmlUcJMIj38ACrgCdWdJA
 LOyQ9ELc2e/Dhls/YGxDDrvpm2FLzZetmgroPyYLoApEkbhYkw4HuUQ33JHiCpRLkNN9
 QGrwtqVGRxRWU7BrBJQ+J69qFiiZXAGfy8yZHFHTr2l1H1svACw8HHFGn54ZUufLSG5z
 +trAUmrMg+d6Rr8sLEB9YiCATgdfgryJRHET7GeDNZDhOwQCi+IEjT502Vgk5puvj0ye
 v5qoQF0vnucaKMjqDd/J+i4kwn9CYd7woe1/iGeSNfyhlGb0apScGEfYkZHWY8FouyYc
 TvzA==
X-Gm-Message-State: APjAAAUN+2pVxWvKffy460Uy7ufJ7rlpQ+Vh3ZA3l/tcRojfqTur3uqm
 yktkCv7ivCs6CUECijJZw8g6dA==
X-Google-Smtp-Source: APXvYqyh4Tei9pFzhVxmZxH3vuFBwYLPZFN5hoNNnLrh2rbOH/VMC/CRzUnsyu6X+HTl32Q52CoOJQ==
X-Received: by 2002:a17:90a:983:: with SMTP id 3mr4473226pjo.57.1568820529141; 
 Wed, 18 Sep 2019 08:28:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 193sm8474716pfc.59.2019.09.18.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:48 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:38 -0700
Message-Id: <20190918145640.17349-47-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 46/48] target/riscv: Fix mstatus dirty mask
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

This is meant to mask off the hypervisor bits, but a typo caused it to
mask MPP instead.

Fixes: 1f0419cb04 ("target/riscv: Allow setting mstatus virtulisation bits")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2789215b5e..f767ad24be 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -335,7 +335,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
              * RV32: MPV and MTL are not in mstatus. The current plan is to
              * add them to mstatush. For now, we just don't support it.
              */
-            mask |= MSTATUS_MPP | MSTATUS_MPV;
+            mask |= MSTATUS_MTL | MSTATUS_MPV;
 #endif
     }
 
-- 
2.21.0



Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F11ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D20920CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D20920CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yXc-00006c-55
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwb-0000H3-Dd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwa-0006zl-93
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwa-0006zK-3D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so23456378wrd.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=QB4DlvulPZzUlgaey1nZw8B8imJR4kB3iDL99emwfxg=;
 b=WWBjGwfhHZ6W4t/btOMXTPLfpWkUzzoC28dPN7fm8dXhAu358Ry/LThB2+CIjT4tLX
 5y2dIRJgpMMTLv2Tfy7Hq7/ls7ymhrp7ABaE1d6YsEYwsaZPTXstPduhvmYerSsVsxK0
 KeoqckF3nap+z/fWn09rnq+gfBdzBPg1E//LqfxD1co6+WxNoMeDRL13UXLGmCYA7kHf
 x+z490UQpoI7P+QDU0qvSp8h6c1GNs64+VqzBwz89lbNQn8s1m02vT8pgTtfvaFcX2/K
 cnouXc8pqrHXz8xc09kZomgeSK/917joFnu99SKU8YBqQDcxf973YM06ks3EXBdYD1ZU
 q6iQ==
X-Gm-Message-State: APjAAAXWPqzP3R9MmnKCqZ1L+kV62Xa2fmJl+J7/Yr3D/LUdT0IWvCFp
 B7nabhGRwY8Bri43SAhIyySszQ==
X-Google-Smtp-Source: APXvYqySMhkyTSZ60wpMMUzTTqVPElAoQ+8pTP4Z5PS3qMY7B5Jpmj8ilJUui7Jkqj8RGxs+aD90Vg==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr20703928wrs.223.1568190338956; 
 Wed, 11 Sep 2019 01:25:38 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id m18sm26670979wrg.97.2019.09.11.01.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:38 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:05:12 -0700
Message-Id: <20190910190513.21160-47-palmer@sifive.com>
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
Subject: [Qemu-devel] [PULL 46/47] target/riscv: Fix mstatus dirty mask
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



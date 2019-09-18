Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436FFC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168BD214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168BD214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbzw-000539-OE
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrt-0006HR-AT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrr-0006Q4-Tr
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbrr-0006Od-Nl
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so98543pll.11
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=YvM1ymkGWX0+m24LnKUHducTTIF5LG0mv+vTnIqq7DA=;
 b=o/snev5d75ZGgd7BF5oO4HRR4nDcLCpEhdLRW8xPqus0ClH2+iT2wB1pN92mYBuVYX
 fqZ2I4bwwTYiLmqNgpnRT6ypM9o0R0FJILqfGoKizW+y4oELGTz9ntEM4pmF+r8vXqEb
 gLGG/y9mbX855V85kZig2TtBWwhSjB/yF9whJz4Hue+3Q5CEORE4gr0prKbucnVRMOTq
 2+0zk+AGia31cUDYhKhN2feOwEPn0/NZMdUdXRIEs77mc1bBV8Jk3i8uBFmwtspvqeLU
 HGbKLP11jktDulLdrVMTSvJNmMROazm9YI2dE64vmVxl+6iTtkMTv2YVo/XvJsBNxkco
 9e+Q==
X-Gm-Message-State: APjAAAXwjm8W4WT9RsH8uTWeVtRgkQuN2epbkzUaybaUz1Phs3brhHo1
 JjY63w8wcAxZuhYobDvFGi1t0Q==
X-Google-Smtp-Source: APXvYqwH4WR6wPTdIqZgaF89CDq/AaxyeDTTGgjKi3UB9NuoDEhEXzb0nbJT3b2QVnvmvjFqNhrvzw==
X-Received: by 2002:a17:902:8d87:: with SMTP id
 v7mr4582244plo.229.1568820462336; 
 Wed, 18 Sep 2019 08:27:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f6sm5922552pga.50.2019.09.18.08.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:27:41 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:55:58 -0700
Message-Id: <20190918145640.17349-7-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: [Qemu-devel] [PULL 06/48] riscv: plic: Remove unused interrupt
 functions
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Jonathan Behrens <fintelia@gmail.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 64a1a10380..98e4304b66 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -162,18 +162,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
     }
 }
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, true);
-    sifive_plic_update(plic);
-}
-
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, false);
-    sifive_plic_update(plic);
-}
-
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index b0edba2884..4421e81249 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
     uint32_t aperture_size;
 } SiFivePLICState;
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
-
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t num_sources, uint32_t num_priorities,
     uint32_t priority_base, uint32_t pending_base,
-- 
2.21.0



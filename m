Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A87C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25483208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25483208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcXa-0005qx-DE
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsl-0007c7-Fu
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsk-00073n-4x
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsj-00073G-UP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so93157plr.13
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dMC8KBUimeo1KaZM5SCh8e6L1Wsgzgt11zDiG6xpaww=;
 b=SeYNhL89my9AbJ5SZZI8D+WbL1E5pKgRg36OMvRaECOYn2lnjOnBgWD7BwsXt3srl1
 U5RTLRwomMiWXDqf7lElMzoOFeue1NpPg1ae3WXHxe1eB9hrDZad9VxAIgiFGJUqEQK2
 qeTyIxCdZB9jrpbJXNX652Z9LP1/vS7YKaZJJwTZK13hDAwKGy/Gu2HfIy90uM/ier/x
 fN5GrAT0FQd15RBngrOV6MlVQ10NTjRkBloUo0QhdtX7DD55KyIaZ32A05ZuNi6X5/Vq
 CPgI8x2BnB3RDOgfYuKKjahYffXPXL0JfFyzNdwgqWUhF8OUoJvlW3z0os8Llz5chXmQ
 QBsA==
X-Gm-Message-State: APjAAAX8knlYKoIV0CH9eaqj4zm+KXFLOpvxX3wIrOvwyo2bgX4Ae/YL
 2vA7mXlu0J1N2dT8a3l5OglNSg==
X-Google-Smtp-Source: APXvYqz2MrhtG5Qm8HtUIz+1t6qoPKJKVpqum/r+LHQj/Vu1aujjvHOIFApVjsUiZIlP2VlyVhVwcg==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr4911393plb.328.1568820516781; 
 Wed, 18 Sep 2019 08:28:36 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id v3sm2548724pfm.119.2019.09.18.08.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:36 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:29 -0700
Message-Id: <20190918145640.17349-38-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: [Qemu-devel] [PULL 37/48] riscv: sifive_u: Update UART base
 addresses and IRQs
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
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This updates the UART base address and IRQs to match the hardware.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 4 ++--
 include/hw/riscv/sifive_u.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9e698a11c4..b66eaef607 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -62,8 +62,8 @@ static const struct MemmapEntry {
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
-    [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
-    [SIFIVE_U_UART1] =    { 0x10023000,     0x1000 },
+    [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
+    [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index bb46745356..7dfd1cb22e 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -65,8 +65,8 @@ enum {
 };
 
 enum {
-    SIFIVE_U_UART0_IRQ = 3,
-    SIFIVE_U_UART1_IRQ = 4,
+    SIFIVE_U_UART0_IRQ = 4,
+    SIFIVE_U_UART1_IRQ = 5,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
-- 
2.21.0



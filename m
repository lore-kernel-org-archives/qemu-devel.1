Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F726C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2D521907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2D521907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcDO-0000v3-2U
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsR-00076A-0m
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsP-0006od-QY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:18 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:34973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsP-0006nT-J4
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:17 -0400
Received: by mail-pl1-f177.google.com with SMTP id s17so128044plp.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=xpkGcRJRYadCT6ocDlVxXul15aD8WH0BAO94YOt7Pqc=;
 b=IU5Y8+a7EFo/ITjcCmVBz8fdF/4a0Np6xdYabLZyXk/NUOyPw9GjegopwCGPvKpJMl
 WvLS1+CN5aLoQk2d7gDwr/4P2acp6sM/SjuSicwZSM6dfWjZl18vCOwDUeieRKkSc4XP
 sWnA0KLha7VKuxjlezNbkQyPOvTrR+HCFm6Dt3Mc4bIjivq6GIrt1ot68FRXt0PjxW9x
 gb7U4qd0XQXrU8entfTB+LeOAPmf87r+6vFeOvoiEsV2+7g9S9hvZA5qkaD3g8aVRCAy
 a0C4OELWOvRndJFOZbfVnFJoKEDec7bObvBThsuu3TOImMPHs7I+DfTHh778sIVHgVYO
 B5Ag==
X-Gm-Message-State: APjAAAW2uzwdLzkBNUMIuYg+3Q6R6VxteJsd1G/rnrrVZALF9v45grJM
 ZyTWF8mnTLPFqJlQHIDosKY3oA==
X-Google-Smtp-Source: APXvYqxiUJaoP6chcZoXKqQu9MwlV1dyNJvg0+aOvok3WF+W+DaW7MHkF0Jvw/qULcVkMuubbNPo6A==
X-Received: by 2002:a17:902:6545:: with SMTP id
 d5mr4877277pln.333.1568820496321; 
 Wed, 18 Sep 2019 08:28:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id i1sm13119473pfg.2.2019.09.18.08.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:15 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:14 -0700
Message-Id: <20190918145640.17349-23-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.177
Subject: [Qemu-devel] [PULL 22/48] riscv: sifive_u: Remove the unnecessary
 include of prci header
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

From: Bin Meng <bmeng.cn@gmail.com>

sifive_u machine does not use PRCI as of today. Remove the prci
header inclusion.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 32d8cee335..2947e06f71 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -38,7 +38,6 @@
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
-- 
2.21.0



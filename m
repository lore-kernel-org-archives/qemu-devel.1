Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7451BECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D23D21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D23D21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yJu-0000VN-TF
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xw3-0007uc-Ly
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xw2-0006bX-Fk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xw2-0006bA-A8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so2327385wmi.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=xpkGcRJRYadCT6ocDlVxXul15aD8WH0BAO94YOt7Pqc=;
 b=ItzxcOZG2KFnG7OFR6kHWOlaivdkoVN3TjBqqCVhDIR17o+N5yJdICjBbDE3Hb8ybL
 rZU7If2njmU8CH129BcZCrL8iRx/3he2YgZY8zas4C0ZWeybGwunDHeHs2chN2kBu5rc
 W/cpUvnI6onpC1NPcXPEOD40J7gHzf2Rdbo+aLgCsmgqw6vZpeaTIYSKOmd51ZWp6rbb
 SwadmiuM7soy7lOVOxonIZgm//yM/4O5xWva9Sy9QojagDNx29dzR4ObsaNF8LN/RnAi
 FJf/EXvss3Hn4hczOEEJ/0jJLsbI3jQDPubhLfZsD4X1mgDnjHIdsDwH/6KM792paamN
 ckhA==
X-Gm-Message-State: APjAAAVyiHta8Uq0xeg0vGsKUG48laUTUEgIF1DTTWcEKK/pKSSzu7vW
 aDDIausaeOhvaChuhpG9xfSfrg==
X-Google-Smtp-Source: APXvYqzDhdmOI63MeSG7Zaf8rYsFyJLwfBkokVlm4fpS6B6eKDfzOaKebcOB3ioRvDz1zwUNSWVY3w==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr2802161wma.124.1568190305158; 
 Wed, 11 Sep 2019 01:25:05 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id q14sm43929897wrc.77.2019.09.11.01.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:04 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:48 -0700
Message-Id: <20190910190513.21160-23-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: [Qemu-devel] [PULL 22/47] riscv: sifive_u: Remove the unnecessary
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



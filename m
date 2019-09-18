Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D515C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0F5207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0F5207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbwO-0001qg-Nr
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrq-0006Dp-HG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrp-0006Mc-9m
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:42 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:37908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbrp-0006Lc-3j
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:41 -0400
Received: by mail-pf1-f170.google.com with SMTP id h195so205470pfe.5
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=SNUwgSqPs8KK5z86gRWObQ6qeL9sTS6I7byaj7lBBbw=;
 b=U6pEoHs22z9hR8A66hzppdbb2Z1xDU6XlqhIyckgezILZr//+aMWGrKYFkLNtli5ke
 9Tc12VvRSNiR7Uv/NtGPi7Boorv82bgNJtwdQMqAeU4HjGb9KpS52B9ctQ8frXS+K06/
 mJuZTp37EpvwP6KHKkMU7PjjtKb4ThgLCtRmN4emUecIVl4olTQdITtd/6gY2rdpGh53
 /Xbq5GwqwB/BTE+YE0HANXfwqnk5kcroweJEPJg79pcrXIC3PJXmYouiM24ohMepiGjA
 TOD9VXarMpXHa9M3sTyNHD9/FuL7AFZ5zNVKoM873pb4SYxe5S8QK3UC4DD7GHMBgf5E
 9odA==
X-Gm-Message-State: APjAAAUrKoCLfwzouTN7mvMiKnYjvoXBV2eJBgGJr7aJiCxUDlE/UBR0
 SNlAC5Qqgvjaepj7/DLKtXMGOA==
X-Google-Smtp-Source: APXvYqxiJBS9ABCsJI0OqNV0XPbWPEhuswgjlf2gqX/u8sGDHXqQdv78OgKw3cMP3OU+UGH1089wHw==
X-Received: by 2002:a17:90a:a589:: with SMTP id
 b9mr4325898pjq.51.1568820459949; 
 Wed, 18 Sep 2019 08:27:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id k15sm5838597pgt.66.2019.09.18.08.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:27:39 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:55:56 -0700
Message-Id: <20190918145640.17349-5-palmer@sifive.com>
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
X-Received-From: 209.85.210.170
Subject: [Qemu-devel] [PULL 04/48] target/riscv/pmp: Restrict priviledged
 PMP to system-mode emulation
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
Cc: ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The RISC-V Physical Memory Protection is restricted to privileged
modes. Restrict its compilation to QEMU system builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/Makefile.objs | 3 ++-
 target/riscv/pmp.c         | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index b1c79bc1d1..b754e4bf32 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
+obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
+obj-$(CONFIG_SOFTMMU) += pmp.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 958c7502a0..d836288cb4 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -28,8 +28,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 
-#ifndef CONFIG_USER_ONLY
-
 #define RISCV_DEBUG_PMP 0
 #define PMP_DEBUG(fmt, ...)                                                    \
     do {                                                                       \
@@ -382,5 +380,3 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
         return 0;
     }
 }
-
-#endif
-- 
2.21.0



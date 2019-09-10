Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E5AECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287D72168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287D72168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7y13-0004ze-VR
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvf-0007KB-4k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xve-0006Nu-0R
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvd-0006NY-Qa
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so10677049wrq.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=SNUwgSqPs8KK5z86gRWObQ6qeL9sTS6I7byaj7lBBbw=;
 b=rYU3CRWJ7aWCCe4Rq96cHKupr0BCn9lBl5cJFoSSMOW7rZYz2fnqPlZF9nzl4eFYWZ
 XGW8BrkQB9kZtCSMBVK1+ZvU0vkvZWzCHf20r8dFVaxsSBBheOiN2nSdamVuTvuOFhEO
 qriAqTuoIXn2uZYu0bSHcBeNptRHbOehLFkbNqDibvKcoxXF4uE3cA/ebR/BYfFx/ccs
 PboQ/wSxm54hwQ1wWdQEqRS5PjCw9k71XfqjYnJzLMwcKzoeJkrMYwu593FlqprCFkLv
 gVI7UnzAhQnY62IcD2IJ9ibdklK45aX7lW43r4/XBDaQf+TA2RpDAZwdfdkcIsYjF4VM
 tk9A==
X-Gm-Message-State: APjAAAVRa30o63sfsFTdV930GXM5DyD802hhYRl/cV6fNiRl/MBrcXgz
 V+plIRRqgqN7TOAcWX0EaIOUIg==
X-Google-Smtp-Source: APXvYqyug4DsvLjCGQCA4v242m57ZTZQgKJMvUj3h1+wJpWKw3/bBWqv30C2A3EapRwI/w7bSlxsNg==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr28157912wrq.238.1568190280448; 
 Wed, 11 Sep 2019 01:24:40 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id r28sm28106127wrr.94.2019.09.11.01.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:40 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:30 -0700
Message-Id: <20190910190513.21160-5-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: [Qemu-devel] [PULL 04/47] target/riscv/pmp: Restrict priviledged
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



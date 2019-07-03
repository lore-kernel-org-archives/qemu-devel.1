Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D5C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4597218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4597218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiatx-0002bV-2B
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapL-0005N2-5E
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapK-0006Jg-2P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapJ-0006GQ-M7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so1159574lfa.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=jUXXdmFSNX/hvuM0z5WGc23QfyAO7JYoqYw1PuN09oU=;
 b=aAI01kEWLEQ0MHCTgQcu31L0I1ntOWBUTq9VkBhj+LM2jO7UUvBGlBgixe6f5xVm9/
 vPzta2K1BsMo3zjdV4odqSuS3iAQjLdo/MDgFijH6Zg4ljNdmsVXT5JUQYYfWP7sXSnc
 ZDJCRccLfsTylR1WZ3hk92KtIlRAMmECSf949Jmbm4E/0ibxB7XtBDwx3DCDSZSOnnOh
 was69mPYSdX3aTxdRpkVmMOaAo2sr5Iic6PBTCPNxnRWDZNj0CvzTrMVgepCLfB6N7az
 qk2KU+RXmUTyMJpx4gVw+TkfqfQ8jFNGBtFYukdT8sAID1fnw8gquyMcXlCFPFIKN+4i
 XgiA==
X-Gm-Message-State: APjAAAWvE8TnKjCQpbFZ6ctEedIIHfTbB7vVWl0D92WAWxjsZu8HdaBl
 rvAxFd3nLu4ZGtctireEcQLlqk5QBHrxig==
X-Google-Smtp-Source: APXvYqyZ8edYhShDKEh1PZRkl/aXo2nDif/NjfUadwKpO4FKhlmhCF5bOOrVht4AcXdnxxTDR7sD7Q==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr16942774lft.132.1562143275745; 
 Wed, 03 Jul 2019 01:41:15 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id w6sm80964lff.80.2019.07.03.01.41.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:15 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:20 -0700
Message-Id: <20190703084048.6980-5-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.68
Subject: [Qemu-devel] [PULL 04/32] target/riscv: Implement
 riscv_cpu_unassigned_access
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Clark <mjc@sifive.com>

This patch adds support for the riscv_cpu_unassigned_access call
and will raise a load or store access fault.

Signed-off-by: Michael Clark <mjc@sifive.com>
[Changes by AF:
 - Squash two patches and rewrite commit message
 - Set baddr to the access address
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c        |  1 +
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0632ac08cf35..5b9fae608cca 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -482,6 +482,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
+    cc->do_unassigned_access = riscv_cpu_unassigned_access;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b47cde501766..2e743312536b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -259,6 +259,8 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
+void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
+                                 bool is_exec, int unused, unsigned size);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8b6754b91798..0bbfb7f48b79 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -375,6 +375,22 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
+void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
+                                 bool is_exec, int unused, unsigned size)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (is_write) {
+        cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+    } else {
+        cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+    }
+
+    env->badaddr = addr;
+    riscv_raise_exception(&cpu->env, cs->exception_index, GETPC());
+}
+
 void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type, int mmu_idx,
                                    uintptr_t retaddr)
-- 
2.21.0



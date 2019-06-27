Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE2C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C93208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C93208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWqM-0003qS-4t
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHh-0003JC-SX
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHe-0000IX-3T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:00 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:33193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHd-000771-GU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:57 -0400
Received: by mail-pf1-f177.google.com with SMTP id x15so1416223pfq.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/3ducq0eP8I5aPrZO6qPfK+y5RApmcrkJq95TSYVf1E=;
 b=Ak1uXmAMbiOb9d/hkpvelBrlznx65+t9ZlC9QxGE7ZBX1D00hTvyJnFfXCUasrmlLJ
 HfH9TQSySsHGkV/UCdaoErEi32W4VnnsTcPwbCKVZG80Tj+vSxO9jUodVmZHC2f96pY1
 i/2grrcT2jl12BBg0WvRbto8Qxq8lvDw14KDd1s710Ig4Ig0DzuzdMja+fduwEdys4SG
 gvSXukbzkVGtSxM4OIBPNMaNpQTD7WO56VPhwqgvKhKNX1FRSdi5Z4rhaDe5DNVWO7c/
 fBS8PjxBj7sykRita8RK6VKe7OkvCXiLlHXQYmBW8KqadHasmeS9rTQzydUU9qSaMfIM
 VbwQ==
X-Gm-Message-State: APjAAAUuNRxYJvUoBFj4e4cyURGnJyVKalFI/Y4ZhvE9Xl9P6G8TzCDV
 3bsavWrzZi+tunNeii3q7Wl4mVQb+9tE1A==
X-Google-Smtp-Source: APXvYqyzSWpZmeQqjyNaf9sQtW2gOTiGjQXZ6JD0rDImUIMDHjKTqErZQM9YX2QK3e+aokXG04oBsA==
X-Received: by 2002:a17:90a:b908:: with SMTP id
 p8mr6742351pjr.94.1561649056598; 
 Thu, 27 Jun 2019 08:24:16 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id e188sm4126519pfh.99.2019.06.27.08.24.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:15 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:59 -0700
Message-Id: <20190627152011.18686-23-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.177
Subject: [Qemu-devel] [PULL 22/34] RISC-V: Add support for the Zicsr
 extension
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

The various CSR instructions have been split out of the base ISA as part
of the ratification process.  This patch adds a Zicsr argument, which
disables all the CSR instructions.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 target/riscv/cpu.h | 1 +
 target/riscv/csr.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bbad39a337b3..915b9e77df33 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -442,6 +442,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
+    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ba551cd3082c..0adb307f3298 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,7 @@ typedef struct RISCVCPU {
         bool ext_u;
         bool ext_counters;
         bool ext_ifencei;
+        bool ext_icsr;
 
         char *priv_spec;
         char *user_spec;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index de67741f3648..e0d45867607a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -793,6 +793,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 {
     int ret;
     target_ulong old_value;
+    RISCVCPU *cpu = env_archcpu(env);
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
@@ -803,6 +804,11 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
     }
 #endif
 
+    /* ensure the CSR extension is enabled. */
+    if (!cpu->cfg.ext_icsr) {
+        return -1;
+    }
+
     /* check predicate */
     if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
         return -1;
-- 
2.21.0



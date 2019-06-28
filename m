Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D4C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8320D205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8320D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvJF-00032G-FD
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgul0-0008Vk-8B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hguks-0000bw-LV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:50 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:42495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukq-0000XQ-JX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:44 -0400
Received: by mail-pl1-f174.google.com with SMTP id ay6so3587840plb.9
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/3ducq0eP8I5aPrZO6qPfK+y5RApmcrkJq95TSYVf1E=;
 b=IHL9mLmCfKNaz5khw0AQ5dKK15gY7HwEIBPZ/98cEVkYTSwfjzSW9K0o2nG1Xsewht
 IWw56qD/8NUISfKDyLDlQ3GibqE4P1koqHG26ra6S3RXLlfa61uI67PX/oNnY0Y1p4se
 YO6JMFgNcsxiAG4j45zY50IaPrcqMNM1dJEoREyYremKuTo/jTuLVgc6BbLvZ2nnjFq9
 4hfPsjt1p+KJRRTCVrksO4ZTHfgoP5dzP08bADtvIOPgn8SagnGXSkmh0rUtQRIVeVm5
 KIyeIg8LTF5WQad42D1hB6x7Q1F/mQwKTy+pvGmaDbNveSjMkDeR/NvLwnR/edQigAP2
 JCew==
X-Gm-Message-State: APjAAAWtrdhETDJtBo5NkV7jkXSJwlMZlPjIxLVuvCpe811inDefXhTN
 G09NhEzYql/PIqHmMbJobElG5jky6WEffV8z
X-Google-Smtp-Source: APXvYqz+Cn6cULfB49bYnTfkiB0ZUe9nBFjxIo40XblR2bGuHf9pXctMRWsUR0R2VbjHSXlr5q8qow==
X-Received: by 2002:a17:902:a414:: with SMTP id
 p20mr12298235plq.187.1561743222066; 
 Fri, 28 Jun 2019 10:33:42 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id f7sm2742671pfd.43.2019.06.28.10.33.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:41 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:15 -0700
Message-Id: <20190628173227.31925-23-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.174
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



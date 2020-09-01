Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02630C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC0920707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnsgunGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC0920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvIa-00054J-UC
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHj-0003tp-Oa; Mon, 31 Aug 2020 21:40:31 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHi-0005UX-4i; Mon, 31 Aug 2020 21:40:31 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mm21so873677pjb.4;
 Mon, 31 Aug 2020 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jDcYY0K/h58b0nGwvA6H9r7tjjvba9vWIRW+Z67cCA4=;
 b=AnsgunGD6DpOnfMZpYfhX3yOy2ArBpwcYuMxTBay6hrBQistdgfqrdIWPFPEFUDwGu
 POP4MurV7q7CZjsx47uc14KsFLUtm4tKKrHsLrg3Nx2qp/0NuasEQ6MeAMwpTOTj03ni
 P+kI9dUA9JvW9X9t5UtJxgJis/hlTMVOzjMAEttojJFEHFQRVhCPumKKtrMUxjKErA+J
 ardqc91zpLePtVqIsNLx6tIRH1ShjFEuglGUjpDCNkR9Q35oIL2E02qieRPk82LUjCly
 ZRoCY3iQzSk6hE/ak9a3GIqBCPwvU7T389ITyJa6HRpGwLD0LuoBviKhZYOR8itdCI4O
 HOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jDcYY0K/h58b0nGwvA6H9r7tjjvba9vWIRW+Z67cCA4=;
 b=EwNONfl/uhcAckgjktaEe7N+5tMHwnovKDkHdGvmgP3utXnx3hm/UD2/m7Aija/BZg
 7wPkcfn1QSwQ7+Wv67zc+viRHhnsZ+DujUcGIg99cMCKyt+xXB1VmExn55ubWGm54EEB
 2vtkXmTr4jZXvRbNRvEV8yEBr5elcgUdDmFawigF0YMYW8yreW4DnHu+fDNa/Y3t36TW
 20N+kWqO08A23Zc2nKOXiv184uUofhE5joDHk17hcoTWABw8gLC44SLZrR9Z5vHgl38E
 4mUB6WjVgv/qHfqh8YfhSW80sfuRIRyy8603F2p290yLCkr5q0wpk6l6/CbpoZZTNUuN
 XtcQ==
X-Gm-Message-State: AOAM533wRj0piKOt6nhK0lt1+PqnJm6kRjhlBMbrU2ZSs2FYtj+zbwu4
 SDCQ9lrPbPjJ5xol6YtB5EU=
X-Google-Smtp-Source: ABdhPJxpYlNgxCHMrxRPCV5CXSPSL4fjG631ys0dCii0FQnVpxw3SGyufeavuizTK+uGR1XdBrzUWQ==
X-Received: by 2002:a17:902:523:: with SMTP id
 32mr3308860plf.176.1598924428356; 
 Mon, 31 Aug 2020 18:40:28 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.40.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:40:27 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 01/16] target/riscv: cpu: Add a new 'resetvec' property
Date: Tue,  1 Sep 2020 09:38:56 +0800
Message-Id: <1598924352-89526-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Currently the reset vector address is hard-coded in a RISC-V CPU's
instance_init() routine. In a real world we can have 2 exact same
CPUs except for the reset vector address, which is pretty common in
the RISC-V core IP licensing business.

Normally reset vector address is a configurable parameter. Let's
create a 64-bit property to store the reset vector address which
covers both 32-bit and 64-bit CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 target/riscv/cpu.h | 1 +
 target/riscv/cpu.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 383808b..dc350f0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -291,6 +291,7 @@ typedef struct RISCVCPU {
         uint16_t elen;
         bool mmu;
         bool pmp;
+        uint64_t resetvec;
     } cfg;
 } RISCVCPU;
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 228b9bd..8067a26 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -518,6 +518,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+    DEFINE_PROP_UINT64("resetvec", RISCVCPU, cfg.resetvec, DEFAULT_RSTVEC),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4



Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79117C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0398A207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hVAmBDND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0398A207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL9w-0001o9-VY
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwc-0002qa-Oq
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:41895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwb-0001pz-1X
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id z19so5515118pfn.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sb729KQ/Ggt57pZC6lIowtPsKniG5L62uiBA4Ej4wdM=;
 b=hVAmBDNDVm5Xi4vSJG+kbF1mBO/N5lW9FDYrieCsKOaFT4EOgv+TqQlxH6SzPneVP4
 s2Un0fzfNI6LC/Yfi7lLVIkhZugplx1cXkmj+a3BDG5zkpClHM1wO0QNkpMRKI7+Aig+
 fmAZXupSkCA5OaHr+GvQQApiL0cAuAc5jHHll8CNdA363ff90UYplRcNVPNeu4KrrZiZ
 lShr5/gjCsi81uVocDzMCEJl40/FUpGaA1rdWe7i+ZVHqMzHzkTp6hPCSX1jY2M/z5uj
 teRDFYN743Z0fgMoaO8iLBdkYpy+drDgdRokp+qFlrXvCzTBwQmbPqkefC97PuLmRKdR
 gDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sb729KQ/Ggt57pZC6lIowtPsKniG5L62uiBA4Ej4wdM=;
 b=MtWZxV1kIUSM7dTO4Xe/Dfyq/lzd5Y/ANu8Gi1RJX5OIUwDrBA73AMeKGDaHx35jzh
 C9G40557JFcHn2qY35N9dsAl71iOp6DL1olIRFREutSGbch36q5jADtbGf/SfZhYKMYl
 ikiJ5t5BHTip9cp8TBU6MmFcE0hxxaKSfH6PlIqJ9PaKAtwnGesWKqdxAFt6nim78X7O
 w2cLNlvC8gtbAh/9K37YIyghYzIEnt/9srfG0pY9r0Nmg/vflakF2C6YmjwVB4gn8/jh
 xUO6UDbkHOWprOJMIQCkHTEtpGhWdgrF2ogxxZ3kcFzehvcygpQCeAQzppZZbF3mITue
 aHhg==
X-Gm-Message-State: AOAM531R/IEZrDAzyJGfoAAYcOn+OAWBCRCSabynJRnGPhnplyiDpy3g
 KPv5MVVqFGS09ulnzIH84Nt57eZNZODmIA==
X-Google-Smtp-Source: ABdhPJzGzCNxHRPZ1STxJjjfgBze9GU6ltk9WJyJwwmVCtI5uBn6UhkhrrB8B+5j8xYam47WqNGMVw==
X-Received: by 2002:a63:5858:: with SMTP id i24mr4272308pgm.449.1601406343096; 
 Tue, 29 Sep 2020 12:05:43 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:42 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 09/68] target/riscv: rvv-1.0: add vlenb register
Date: Wed, 30 Sep 2020 03:03:44 +0800
Message-Id: <20200929190448.31116-10-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Greentime Hu <greentime.hu@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greentime Hu <greentime.hu@sifive.com>

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 0cf8a04dd8..1a84b7fd75 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -63,6 +63,7 @@
 #define CSR_VCSR            0x00f
 #define CSR_VL              0xc20
 #define CSR_VTYPE           0xc21
+#define CSR_VLENB           0xc22
 
 /* VCSR fields */
 #define VCSR_VXSAT_SHIFT    0
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index aa58b0b369..cf9718908e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -241,6 +241,12 @@ static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
     return 0;
 }
 
+static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env_archcpu(env)->cfg.vlen >> 3;
+    return 0;
+}
+
 static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->vl;
@@ -1400,6 +1406,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VCSR] =                { vs,   read_vcsr,        write_vcsr        },
     [CSR_VL] =                  { vs,   read_vl                             },
     [CSR_VTYPE] =               { vs,   read_vtype                          },
+    [CSR_VLENB] =               { vs,   read_vlenb                          },
     /* User Timers and Counters */
     [CSR_CYCLE] =               { ctr,  read_instret                        },
     [CSR_INSTRET] =             { ctr,  read_instret                        },
-- 
2.17.1



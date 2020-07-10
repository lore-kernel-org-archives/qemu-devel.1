Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE22C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D212720772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="llBepXg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D212720772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsbX-0003eT-0M
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcH-0004wH-AY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:53 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:32971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcF-0006TR-Dg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id m9so2395513pfh.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pnewDC7oACYylR6ETv6LhEgaXr44u5lu7gFfAFezVj4=;
 b=llBepXg+O/cQ1KgSc+WlRHPJEx9VwsIZEQCk20R14rnzTT9uD8+34wUCHxAxLwV/7t
 VCDTvP0WRqnu3qkwj4nwfdOVfnImWIVKiZOV5wnQ8BrBSqFCSKa07mOUuMfmcBzbyotv
 dtYL265RuAQdbZhjbY9SBaEc6+8SMLIkOnyFV3Mr9QTGG1FTEAVDj7/Q9GP03/cEN2ly
 dfHgqJE1SByi5/QqgESpUC8waZqWofbV6QQbRxmuyD6Ztuum3Z4AX/B8K/RdmWJnDD4D
 ei8gsWFPaUPxH/Nmpize4ERdi2qriqunfhsj9Gwu1T32D4ibYJoJitq2739RRaz3W/NN
 ExWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pnewDC7oACYylR6ETv6LhEgaXr44u5lu7gFfAFezVj4=;
 b=gAL19z1YBHAO/YjjyhhtNCTRXsCkpdzY72rKqG/WR1FFLLlufc5CZiYZKvFWMkJ1XE
 k+0S3Af8dGet9EnGIrNjyyTyMSovSuU51o8lVsNOhWBysP/5syi8q/xfwG8+5gP7fb6Q
 qjiarLTqa2SnK/cyv34h1HEjX6NGbZG3glE/j86u1tAML7hEUoGwmd+H68Es8P3XIbnx
 3p68EOEx4sMwvGsx0eTqm2HA0ijwDNC9E10cvBwwr6Eq3GcuomxjNZlnmEoFVOK4Ky/s
 rYMmBq/Babju15HueGzSgaAzvRItqcXJfGUeemM2blLHMfP4MC0KbJvhRUM7T74ipYu7
 AJyg==
X-Gm-Message-State: AOAM532EQTJOtBCC2iL9r1PQ1mk5V/bUjOKT85dhgoR7t1cKkejrAXpn
 SVcBCz2EJWOk5bkoGe9XPusYcPUuOc3DJQ==
X-Google-Smtp-Source: ABdhPJwUHUuNF8CBySI+9x6+qjtmIejJmFaaxh4u3f2TQy9SWaCTNhYNsLxd14cc07LvoAymETvD4Q==
X-Received: by 2002:a62:1407:: with SMTP id 7mr58600290pfu.88.1594378250027;
 Fri, 10 Jul 2020 03:50:50 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:50:49 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 06/65] target/riscv: rvv-0.9: add vcsr register
Date: Fri, 10 Jul 2020 18:48:20 +0800
Message-Id: <20200710104920.13550-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_bits.h |  7 +++++++
 target/riscv/csr.c      | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 8117e8b5a7..202440e5eb 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -60,9 +60,16 @@
 #define CSR_VSTART          0x008
 #define CSR_VXSAT           0x009
 #define CSR_VXRM            0x00a
+#define CSR_VCSR            0x00f
 #define CSR_VL              0xc20
 #define CSR_VTYPE           0xc21
 
+/* VCSR fields */
+#define VCSR_VXSAT_SHIFT    0
+#define VCSR_VXSAT          (0x1 << VCSR_VXSAT_SHIFT)
+#define VCSR_VXRM_SHIFT     1
+#define VCSR_VXRM           (0x3 << VCSR_VXRM_SHIFT)
+
 /* User Timers and Counters */
 #define CSR_CYCLE           0xc00
 #define CSR_TIME            0xc01
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ac01c835e1..34ce509e64 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -238,6 +238,26 @@ static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_vcsr(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = (env->vxrm << VCSR_VXRM_SHIFT) | (env->vxsat << VCSR_VXSAT_SHIFT);
+    return 0;
+}
+
+static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
+{
+#if !defined(CONFIG_USER_ONLY)
+    if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
+        return -1;
+    }
+    env->mstatus |= MSTATUS_VS;
+#endif
+
+    env->vxrm = (val & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
+    env->vxsat = (val & VCSR_VXSAT) >> VCSR_VXSAT_SHIFT;
+    return 0;
+}
+
 /* User Timers and Counters */
 static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1255,6 +1275,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSTART] =              { vs,   read_vstart,      write_vstart      },
     [CSR_VXSAT] =               { vs,   read_vxsat,       write_vxsat       },
     [CSR_VXRM] =                { vs,   read_vxrm,        write_vxrm        },
+    [CSR_VCSR] =                { vs,   read_vcsr,        write_vcsr        },
     [CSR_VL] =                  { vs,   read_vl                             },
     [CSR_VTYPE] =               { vs,   read_vtype                          },
     /* User Timers and Counters */
-- 
2.17.1



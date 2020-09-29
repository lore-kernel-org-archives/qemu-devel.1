Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C93C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05CA20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VgxqDtv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05CA20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL6B-0006by-Oa
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwZ-0002if-F6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:43 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:51259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwX-0001nm-NX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:43 -0400
Received: by mail-pj1-x102c.google.com with SMTP id l18so42970pjz.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qr4sSpwGfpTNQGz8iCK/HJSLAiX1hYwcM40uCGSXJPk=;
 b=VgxqDtv/HbIrGFNNA+kmzF4IHuyyAL1Y4Lsi/GYuqyZo7QMauyx0KCJryBHQ3a7Sde
 INJw28CCttRotHtZ0nmiYRhWnS+O4ZjtM35PV6pkP0d56oh42sgVLiCzXjp6LNl2mcfF
 vD8wKS2QJDQ+c8QmvjfMe5T9ZULJZlaPxoRpPzrAWiDQFtRtapGIkasjv8/60Q/VcWFm
 vrjYKFjB/BJDKWOkZnXuwL9eQyX6/tCHkSBMPzBrkMFzR/2Q7vxPPRe61sOEfJdpPapB
 OIIWuOL8mDWg77AtDj9I34We49E4AW2t0o9lAOmUITQIxGqDqF5wl34X0jFtPClKx8pj
 aLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qr4sSpwGfpTNQGz8iCK/HJSLAiX1hYwcM40uCGSXJPk=;
 b=gvGJ1KCaXyIKFAx5IgTdWEUqHXVmzwTc+ChB4wlPiGFRZF2UtoRZLtD7WJ5VW0gDcO
 /QhRwMymp0CxTu0F+vl2ayx54wSC4GyzdyCuTUfLP6Mzkyo0Bi3n+LI7ZpKlEXkY6BLp
 w/zsiPUu6LwwtkjVGlBu0QAtqVOQs5N/xnaHJff/zEDSkcGEQ0zW6d0aU/MGuKb6vXPD
 ryu5FHnXpJHC6gLpbFmeH0FSqcLazwro6UONAjVaH/xjKjW5GDaKEo6SDhrGxw+nEDqz
 MV4fqg6p0AE4EyuOPS7R35gvxIR364d2iSd8ql43g8gkhMRs4XojwD4+FNVNtGHFMqrC
 cKbw==
X-Gm-Message-State: AOAM533kBZusSFQZSF8iPdN0irXp/gMEfjmUcpZsQCuDg6sh04f42gao
 TjjdAf3FIPjM94MW1PtvPsnKZ5lsxjQhaQ==
X-Google-Smtp-Source: ABdhPJwRy8MQnESV4pMvfzA3LIMScTfbC0K3QujQsY1KWIdEeDWZHOoNAV+bULpSefo9TR+08oG4YQ==
X-Received: by 2002:a17:90a:d504:: with SMTP id
 t4mr4925331pju.161.1601406339895; 
 Tue, 29 Sep 2020 12:05:39 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 08/68] target/riscv: rvv-1.0: add vcsr register
Date: Wed, 30 Sep 2020 03:03:43 +0800
Message-Id: <20200929190448.31116-9-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102c.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_bits.h |  7 +++++++
 target/riscv/csr.c      | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index d77f790dec..0cf8a04dd8 100644
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
index 3117fdbe2e..aa58b0b369 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -304,6 +304,26 @@ static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -1377,6 +1397,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSTART] =              { vs,   read_vstart,      write_vstart      },
     [CSR_VXSAT] =               { vs,   read_vxsat,       write_vxsat       },
     [CSR_VXRM] =                { vs,   read_vxrm,        write_vxrm        },
+    [CSR_VCSR] =                { vs,   read_vcsr,        write_vcsr        },
     [CSR_VL] =                  { vs,   read_vl                             },
     [CSR_VTYPE] =               { vs,   read_vtype                          },
     /* User Timers and Counters */
-- 
2.17.1



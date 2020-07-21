Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C6C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018212080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RHuHE3Im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018212080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxlOF-0002Wi-4j
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxlNM-0001Am-Ob
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:03:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxlNK-00007N-J3
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:03:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id p1so9792260pls.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 23:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lyivCZnqzhrumKaf1cp2AkSGdgwxSM8kTqrAaI6ADt8=;
 b=RHuHE3Imopzm5mW2p7jbbHbavo9I6mlzfL0hBxmMQSPr9wkaMTkIsFct99x0WAA/tJ
 9sRlAMYu6W8Qst/POIVYj1fAfrSRk8hJYhl8LpVUonXRuWtPdekb7DSN6p5/fAgXDRiP
 l3k/uKYOzjvtDNbrh/vvfRM2TpKOMXALP/hSPu8HEzZitInHfVQBQYCwH2K2/bE+fNi9
 MD2nZSOuPCeNEIuWns70+nMxrYPkgWgkVlv8J+/+m1xmWzubiM40LiRXklIYM2Yu2wVS
 +LoKHJAP+vYHxyowRAdrHPAzBPMrjJ7AntJIJsCov9AhOK+kHxrpCJ62SbXaBn5vgSEH
 pTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lyivCZnqzhrumKaf1cp2AkSGdgwxSM8kTqrAaI6ADt8=;
 b=jLp6ZwMcNvCJquVYEpC2azbJ/ezxznqXSZp/SgxveZp2AhZwNb7GqHdOTPWD1y7FmL
 PsiCH5SNvvg2DZWITDfix2CAasc+DZIOxLZD5puTGJM/nV+aNMqsRtgdUq08Q1ODdOln
 Qsq/umCW14hsrubD4jX3niKeRmtbBeTfLD22VlJcwaRQoA9xC/SUPInn9MsijKhALgBu
 FsBPgpisYPpFRr1EUznxNpRQObQZAVQB4/mx20le+4hMTOwQwq/dVHE8zbekGPziTL1s
 bUPtBxNVu2VXMfJdF9HOTja/b6SEtGmOoA1aHIePIkkAcHyJS9WRcpxLD2AOVjnhT0+i
 DSoA==
X-Gm-Message-State: AOAM532igachRurSeU0+Q2vqrh4QmE0GnUS9eCk8WAZzMCcCVOGv8lNk
 BYHJQOi6UJ/BWyvHBzl3qTcolQ==
X-Google-Smtp-Source: ABdhPJzq5axPOHtmLGWH8vv4GRgKNzWaqJGdgTRGtUq0mzmsYSG5StiqamC0Y6DqTa9a8ZdunaRv5w==
X-Received: by 2002:a17:902:988b:: with SMTP id
 s11mr20001668plp.229.1595311417279; 
 Mon, 20 Jul 2020 23:03:37 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id 66sm19724068pfa.92.2020.07.20.23.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 23:03:36 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] target/riscv/pmp.c: Fix the index offset on RV64
Date: Tue, 21 Jul 2020 14:03:28 +0800
Message-Id: <f216144b553720ec33d1be8abd225a252ad79a29.1595311277.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595311277.git.zong.li@sifive.com>
References: <cover.1595311277.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=zong.li@sifive.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
implementation, the second parameter of pmp_write_cfg is
"reg_index * sizeof(target_ulong)", and we get the the result
which is started from 16 if reg_index is 2, but we expect that
it should be started from 8. Separate the implementation for
RV32 and RV64 respectively.

Changed in v2:
 - Move out the shifting operation from loop. Suggested by Bin Meng

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/pmp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..3de6535fbd 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -309,6 +309,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 {
     int i;
     uint8_t cfg_val;
+    uint32_t pmp_entry_base;
 
     trace_pmpcfg_csr_write(env->mhartid, reg_index, val);
 
@@ -318,10 +319,15 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
         return;
     }
 
+#if defined(TARGET_RISCV32)
+    pmp_entry_base = (reg_index * sizeof(target_ulong));
+#elif defined(TARGET_RISCV64)
+    pmp_entry_base = (reg_index >> 1) * sizeof(target_ulong);
+#endif
+
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
-        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
-            cfg_val);
+        pmp_write_cfg(env, pmp_entry_base + i, cfg_val);
     }
 }
 
@@ -332,11 +338,18 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
 {
     int i;
+    uint32_t pmp_entry_base;
     target_ulong cfg_val = 0;
     target_ulong val = 0;
 
+#if defined(TARGET_RISCV32)
+    pmp_entry_base = (reg_index * sizeof(target_ulong));
+#elif defined(TARGET_RISCV64)
+    pmp_entry_base = (reg_index >> 1) * sizeof(target_ulong);
+#endif
+
     for (i = 0; i < sizeof(target_ulong); i++) {
-        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
+        val = pmp_read_cfg(env, pmp_entry_base + i);
         cfg_val |= (val << (i * 8));
     }
     trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
-- 
2.27.0



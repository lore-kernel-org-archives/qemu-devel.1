Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F574C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A7E206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Hvt6a+I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A7E206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzLjb-0004bP-6h
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 11:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLi8-0002iO-VF
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:03:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLi7-000889-5Y
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:03:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id m16so6009783pls.5
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gi/phrEkN1+Q3sxpwjsqg73gbNMUPMMftuyCiLQ2q6I=;
 b=Hvt6a+I7gFcgihHypX2nlKlOdF8h9S2UV+RpDB5laXZPmsUCtF0Qkd/28Jl3yvojBB
 IV/tgF6cy3HxNWfH8NGMdbmNOdoRE9yG36+k1O3xanHbRN1nPzYeT2ViE1sYNDL5R5OR
 JIUvK9f4A0ScefPakhOGEYBLDbfdAlnqVZhB+ohny8vdBr8OTEpITmCh8sFjU4If2RCz
 7dyDrP8vr4PYUfQtAOoRRCOcbxjc1tdSLbM0MoDkl8eZFA8yDPnI+N380KqS/FWm7Opf
 KMK4ZHkNpLz+QtRjbJmtlybf5rxUsNyjfX7POOfhI23mbcCQ6ZoGS4CHSCVxMj3tf8Ac
 xi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gi/phrEkN1+Q3sxpwjsqg73gbNMUPMMftuyCiLQ2q6I=;
 b=V8CT90W1nER2M5SdxHUEcoSfNNf82WhCMqoCCPknaWa0cbuM+OSSeSevSvSU69WrCe
 zP0ayMHnZrr1BuPFf3nrDooyF677mP8yhojKLTijMFRsdGsvOViYkucwALKPFf45iJMt
 NVOM/BgBpjrfuGWKhhfCGzmoiNSFPTZju6cV7nSz1eo7cIHMZnVdLJz7bjAaIq+HnTZP
 E+63HZsZHILvkKNd7ODq5QbkcPYAHanABwzNaN+agr/myMsiGcCreU+iDwwv3vijVCT1
 /wEhfC74Uup2qfEimXktklIa3oVxPSjpCaYPJANxU9/OHJN1eaKT55si5arGu/V7iQAW
 PYEg==
X-Gm-Message-State: AOAM5322yVFbGcBqdjExlox5tzYmjxJxWt/Bh73xlGWoW0UlSiL5aRaA
 nO6UOIz9pstO+NWFDwKjz1knzw==
X-Google-Smtp-Source: ABdhPJzZb0J959VzuW1lTmA4PcW2DAyRg/1ncHDw7sPrKD96IQZ1wSmhvrqDxfTLWZxY1SBRkKHd6A==
X-Received: by 2002:a17:90a:30ea:: with SMTP id
 h97mr10506807pjb.32.1595689417800; 
 Sat, 25 Jul 2020 08:03:37 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id g22sm9059783pgb.82.2020.07.25.08.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 08:03:37 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v5 2/4] target/riscv/pmp.c: Fix the index offset on RV64
Date: Sat, 25 Jul 2020 23:03:25 +0800
Message-Id: <a1ddde7963423df8e62e98fcf3dc75ae092186b2.1595689201.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595689201.git.zong.li@sifive.com>
References: <cover.1595689201.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=zong.li@sifive.com; helo=mail-pl1-x641.google.com
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

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 target/riscv/pmp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..aeba796484 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -318,6 +318,10 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
         return;
     }
 
+#if defined(TARGET_RISCV64)
+    reg_index >>= 1;
+#endif
+
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
         pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
@@ -335,11 +339,16 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong cfg_val = 0;
     target_ulong val = 0;
 
+    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
+
+#if defined(TARGET_RISCV64)
+    reg_index >>= 1;
+#endif
+
     for (i = 0; i < sizeof(target_ulong); i++) {
         val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
         cfg_val |= (val << (i * 8));
     }
-    trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
 
     return cfg_val;
 }
-- 
2.27.0



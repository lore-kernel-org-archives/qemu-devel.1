Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70504C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1C32176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iKj+cIaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1C32176B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSN2-0002fz-Br
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxRLE-0004E8-Rj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:40:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxRLD-0003u3-5L
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:40:08 -0400
Received: by mail-pf1-x441.google.com with SMTP id x72so8717247pfc.6
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hHlA6wmhpvYVr+0JFQxF6AzpWLBgIsPSzrz6OprCNsQ=;
 b=iKj+cIaGrtmTYNZccQXM1I1mOsrkjEFYFMUR3SWCbsS+zT6DkG/G4jbbekAwe8bfN8
 kt0VPleUYJcBPMmNP7bVuD9BU9Mg5bgbSFeoh7MVLBEby0QmCHEJejxkdeh0VseyhX5i
 WmQ6fDsVajFW4FXTJOJWk+yyfHROPRxHRP88mDe+Pkc72i54T1f2aJn0JB/r7FaSfBdo
 N97cMbm0aHVI1CBX2Y0PXWJjegTtJElBydoXB1tuHdOrJ2AHWhzDVz7/Kk5gwX8SJUmc
 /Buns+o6KNu25dybhaNXlXSv5bwL6keMRVPy/+Qana9EKjshGKOAy/gHr3Jyfjnz/bl4
 94mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hHlA6wmhpvYVr+0JFQxF6AzpWLBgIsPSzrz6OprCNsQ=;
 b=Pz+WWeDQ8Z55Bzw4H5P24nKF0gY47wjQhA2kO6J2wz406hGL6Jk63t3sd/wwlcqWbN
 6SCiRR2FyQ6aXa+cZOvUzw/CGwHbgRZl2YowuwknC/O4H2wJOrGYEtyTmrVQ5KzJWG7A
 gOiKu6diw04DFf4JaBKRPoJt/TOPu4iK46pB3keyHRUNsddrPu9gMMczoyq1g2Uv+VaD
 ZGSL9z5lAJq+VHjf3xzuXsnSwugPwX6J602EDCrphbDCWzZYp0C/OdMFiAkYax23ge31
 BODOAS62ASnJ59ZPm844mH0/3/709V+xkSAZ7EbKBW59ONIz3nJ4aKMX7Sa9/Wql+ILi
 Masw==
X-Gm-Message-State: AOAM532xZSHBxgSVAI/Ofhi3MZAPbB6CRAvjQp+Z2VemnfDYBA/zn1F2
 N8UWdjRMwr034Ig8+zp/u+o7Bw==
X-Google-Smtp-Source: ABdhPJxtdrRtnGeEssu2d6QbFJYoHGCidiXzGoO3Uo9LeOzGmBQ8Rla5uNx09vVG+5XwmIslihtfoA==
X-Received: by 2002:aa7:9ec2:: with SMTP id r2mr18816853pfq.265.1595234405912; 
 Mon, 20 Jul 2020 01:40:05 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id o4sm11388151pjo.16.2020.07.20.01.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 01:40:05 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/riscv/pmp.c: Fix the index offset on RV64
Date: Mon, 20 Jul 2020 16:39:57 +0800
Message-Id: <658e49284fc564d4114307cb559cf23ea3e751fd.1595234208.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595234208.git.zong.li@sifive.com>
References: <cover.1595234208.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=zong.li@sifive.com; helo=mail-pf1-x441.google.com
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
X-Mailman-Approved-At: Mon, 20 Jul 2020 05:44:47 -0400
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
 target/riscv/pmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..adcdd411e6 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -320,8 +320,13 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
+#if defined(TARGET_RISCV32)
         pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
             cfg_val);
+#elif defined(TARGET_RISCV64)
+        pmp_write_cfg(env, ((reg_index >> 1) * sizeof(target_ulong)) + i,
+            cfg_val);
+#endif
     }
 }
 
@@ -336,7 +341,11 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong val = 0;
 
     for (i = 0; i < sizeof(target_ulong); i++) {
+#if defined(TARGET_RISCV32)
         val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
+#elif defined(TARGET_RISCV64)
+        val = pmp_read_cfg(env, ((reg_index >> 1) * sizeof(target_ulong)) + i);
+#endif
         cfg_val |= (val << (i * 8));
     }
     trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
-- 
2.27.0



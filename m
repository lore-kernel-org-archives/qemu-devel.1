Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444AFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E69B204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TiwZztDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E69B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dst-0003gt-Ci
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSZ-0003hK-7G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:39375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSX-0007z7-Gx
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id z188so16875741pfc.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cfd+Yvpk7MKSihMsL5cwiSrN7LpEGI1AIX79HNPfWt4=;
 b=TiwZztDFMkpnX/Q+1pCbkH+p3rt4KUcwX0IW1+4RDsAdOw1PpCw1pQSwbxXxgFQEZe
 OCxkUyteZa0kW9BqZK5oAeA6L/lguVnduW7UypgDgCDJ4BfkGfev2zMhV9svG3tqMABK
 LLWbC2NqG6H7s+XhH82xUMJ4D32ezxc/4u5+KD1UoB25MsN9wiGeV6PGV+sN9P585DSy
 L8hSzlvSJYHEod2YAO2haqDcclZpDUPk4IrGJBOZ4hyfi9bB9KytNmpgkUnIIhnesEdR
 1l022xzK05iw4jEHQOo+tPo/0FQKqwEFphZItMb6q5agwVlQ94zKxvw1ZFjYshSAe38o
 /oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cfd+Yvpk7MKSihMsL5cwiSrN7LpEGI1AIX79HNPfWt4=;
 b=g6ZdJi8Ihme1qUin22p9ycMpjpDCyWqJAJmLMOLDIyjrQYlDziPPT4FtXi+yxXwSYX
 i9tF5Lm6/2ld75N9CBvEeVfSxPMzTXC/+Xsrboa24Jolkn0fe/iY4Cl0rCazl/5DIAm7
 7wsJuzg+QGh51ZH590gXShlLA0+fMvhpuPcVNjR+pVvzwdbdzO7ej3VK9lnDtCDzOulg
 cz13FFUI2OCocy0V8ziFvlrwQK1A5L6PPnEAEg0M7jmepiBVuFuQgOSaMosTT+1vk3vV
 Ms+u4H61XoGxH3cX68/5GgXJ0zcTRXXY4uOokUguVYcGvIH5V7pYB6mTwN+0cUgvXBaK
 Kimw==
X-Gm-Message-State: AOAM531IqUJsRmfIpUofXhFY0nFAQRwWYbPIqLYnmNjYDNaVnYwg7+kU
 foKPEeSue0pul6ce6FuUwbIAKBpdCsk=
X-Google-Smtp-Source: ABdhPJy6oHuvBVDCns9Xv8aMBXQ5BVKnbPP0D+idJIJ7Oh5Z9H2uJg7F51Esalw7R7eVgmHU9UIrMg==
X-Received: by 2002:a63:b21b:: with SMTP id x27mr6759956pge.284.1596710956206; 
 Thu, 06 Aug 2020 03:49:16 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 47/71] target/riscv: rvv-1.0: add Zvqmac extension
Date: Thu,  6 Aug 2020 18:46:44 +0800
Message-Id: <20200806104709.13235-48-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c       | 1 +
 target/riscv/cpu.h       | 1 +
 target/riscv/translate.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 085381fee00..8844975bf94 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -512,6 +512,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
+    DEFINE_PROP_BOOL("Zvqmac", RISCVCPU, cfg.ext_vqmac, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
     DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 78264d6ffc4..528814cbfc7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -285,6 +285,7 @@ typedef struct RISCVCPU {
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
+        bool ext_vqmac;
 
         char *priv_spec;
         char *user_spec;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 95921296a56..3869389fe02 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -64,6 +64,7 @@ typedef struct DisasContext {
     uint8_t sew;
     uint16_t vlen;
     bool vl_eq_vlmax;
+    bool ext_vqmac;
 } DisasContext;
 
 #ifdef TARGET_RISCV64
@@ -859,6 +860,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
+    ctx->ext_vqmac = cpu->cfg.ext_vqmac;
     ctx->vlen = cpu->cfg.vlen;
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
-- 
2.17.1



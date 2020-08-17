Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C92C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F972063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IWs5liFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F972063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b95-0002Kw-Ka
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asJ-0001ey-Nx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:15 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asG-0005DF-Tt
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id f10so7159960plj.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8AHmQ9os1R8vl3YkHmoCbLc+gv13dnARAhx869gfPzg=;
 b=IWs5liFYvzjxU4HMiUKZIneCpgs8hPUaSePflrwJwNg2HOUUHbYMqiSX6RFRNe+XPW
 gS1wxt0l5Qmjk+r/2Bo/nGddO5/EG5/AgXafZ2gaI5VmSQE+qv8bM1ViffS4Lu+XGVAD
 BEl/+CX2CHh39Z2zJ622bozMi0o/BgoCu5hlaVj3kdKFLvsJcn1ARn8YohCqKdLqis3p
 6qD3hmorTOH/BERHO+4FMOza5LZ5MtNrnSzulWwzmjQc/KMZ8v8Eq7KhluiPtiGDSa/f
 WGoP4YildEke7+0d7CnV8rysi9CaSk1BOJyPVpxdSKCNTSo8NsWXd5/Lto3Vyi91pT0D
 6C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8AHmQ9os1R8vl3YkHmoCbLc+gv13dnARAhx869gfPzg=;
 b=s9+OyYYy3rKTN5JtbjESua667eNObsm9Gpp+YW8QPn5Wt4mDzrL2kmw4GhlbaiAKID
 rLuHVA52Hnk13+rByMx2yDL72gd1qkxusOYRFrgTEOL7A8jBbvZNfZV7rSjSbComezAx
 SBjug0CW5ckKB4oAwJ7uQ2m14HpUtFq0AoYpAi6qesYSYeA90GbWHwpCj6/e5FGUhv8z
 53XEwWjjw3lLPXWw5zP7lhzfnu2Wjp9+V48DfeY7Bd1BBWuY7A7h+wWUQPPNZVknZV0a
 q8NRdTpT06aJIpZceTgTH37rJnLkUZxRp0jdgAZOmK4uv/DFqq21hF5Lv3ZYoOqmik2I
 PIGw==
X-Gm-Message-State: AOAM533bmnEnNxalFslF3u8bc6jF8RK2+AcJ8ZBUGKqHWQyYLiLVPufT
 /qWQks5VA9eI9VoDpBwbItQNoHBmwsVU5w==
X-Google-Smtp-Source: ABdhPJwzP/2C/IfXvbLIi4e+VlI+Fwjhw2THeEZJEXohEGkhv594nIKpKgjXgWEzkaW79Etf1mHYJA==
X-Received: by 2002:a17:902:9345:: with SMTP id
 g5mr10674558plp.192.1597654331516; 
 Mon, 17 Aug 2020 01:52:11 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:11 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 45/70] target/riscv: rvv-1.0: add Zvqmac extension
Date: Mon, 17 Aug 2020 16:49:30 +0800
Message-Id: <20200817084955.28793-46-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x642.google.com
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
index 715faed8824..6e9b17c4e38 100644
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
index 0b3f5f1b4ba..5817e9344e9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -75,6 +75,7 @@ typedef struct DisasContext {
     uint8_t sew;
     uint16_t vlen;
     bool vl_eq_vlmax;
+    bool ext_vqmac;
 } DisasContext;
 
 #ifdef TARGET_RISCV64
@@ -870,6 +871,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
+    ctx->ext_vqmac = cpu->cfg.ext_vqmac;
     ctx->vlen = cpu->cfg.vlen;
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
-- 
2.17.1



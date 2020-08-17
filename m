Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B08EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7F92063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gPLkrDuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7F92063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b4s-0000Rh-2T
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arj-0000aB-Ut
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:41735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arh-00056F-8a
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id f10so7159278plj.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5gJQpQuBdx5+IRqoLCBuH1Sdjx31gU5U1EvDuXvWhTM=;
 b=gPLkrDuD2m4pKCNQx88ws2dKEf3vRIFW7Nla+ZxMhaActW0DUKkajMV4SthEtlt3Rv
 H/GBAvApITL7de5rLy582fdFxSRSaQHeUiBpNRPOaBZILN95U8RTTvx8fJ7oiuoX1s/e
 xfkfdp4fZki9UxyHIBmEThkqXRaantl2l6dhs3JyA1KeiJGZLeAPZgzCzTxxrdZw4a/g
 Ggfi6s2BxtJurf2Mi1ht1QpThDKVSAwllU9juEBmUXDv/h8Hbhi2PMTFL1cyd+dS0dAl
 u7Y9/bjImOYNoHkFVB9G9de8KpujHfL1GVqbkTbYJwoSx2xgDGMpB1KmtdJ39TAz6l5b
 5xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5gJQpQuBdx5+IRqoLCBuH1Sdjx31gU5U1EvDuXvWhTM=;
 b=kHCuk2DMQM8mVlwyS88cDI4Qnh4ynv70EiXAcu/S58RbHdbU8KgKCflylf4Gy4T9j7
 yT4/fbaEa1PS9pqkv/HEyZkSwcdIDgWG+GZvmtREFo8a3w3vC6NzTN5yh8wtms+xoYxO
 y+FYIBnLXbBb8LWB+sZoEhH12xS8jlHkKQG0f/+gORMK3xM0Mm3HGfXBn2b1l1EaCuCN
 EJhcY8VeZcsfIX5IBks81liLJ4nC7HWOC+YblGG9ueX8JdQzQyRlWEAqjy5oNizpcuoN
 JuiGHz8cBJEFG17T9A3RB2ryVZC6gVM2kUfs2o5shgZ/rXemKhqZ8pVWoqN2Yxxjzy72
 afLg==
X-Gm-Message-State: AOAM530CG8LH6GVFe7d9TgjqR55kRiVlyRNz+5hXYO1DNoWlfTFRue7S
 7vdGfDGG+4fUzEn1HdlQsrG/cE4YZL2WWw==
X-Google-Smtp-Source: ABdhPJzuOHawyqvvoqkF0qolk93kWpFNMecTz647odkJTiPyn5lX8CtVljCP+xX5NFZE3pNVLbzLTg==
X-Received: by 2002:a17:90a:d98f:: with SMTP id
 d15mr11797197pjv.212.1597654295871; 
 Mon, 17 Aug 2020 01:51:35 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:35 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 32/70] target/riscv: rvv-1.0: element index instruction
Date: Mon, 17 Aug 2020 16:49:17 +0800
Message-Id: <20200817084955.28793-33-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 7a10fc27c5f..15afc469cb0 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -597,7 +597,7 @@ vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
-vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
-- 
2.17.1



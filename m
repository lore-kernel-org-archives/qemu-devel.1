Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124F92077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NqUTBCVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124F92077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB9B-0006o6-70
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvx-0004Uo-32
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:05 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:37467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvu-0005yz-18
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:04 -0400
Received: by mail-pj1-x1031.google.com with SMTP id o22so871795pjw.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V77vPoxF5wHJpkr1vzvCn6SW3F0N4bm+U02KvfCaIVI=;
 b=NqUTBCVRXRd+sTcoCU5+MGfTn2sznVrpu6qrvqCL0Oi4fvO20C2HGRCsGGHmElkmw2
 mUI3sNhnRm3xKTWsk2EV/0pMdXRBAMeI23UiXKRagN3yuIsg/sfRaKyEWZHDdxv8P5DX
 EYqLTqGBmNKhXU9P9prwVPkTrztAyvdR0HP619wus4BoVIBSKFDKHN1vq+MVx4VsIQz1
 9uKRtOF76kdJdcES9Xx49F7uc0YzhQRQPR1v1bpJ2UWeEPk2wpnzKNubOmbDNDMbeklI
 ifQErwstsxorFLuNupvMume1YeUrBY8LQ2+DEBWIuuIRaVRhR+cr5woltAOLxM9HTCYR
 nLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V77vPoxF5wHJpkr1vzvCn6SW3F0N4bm+U02KvfCaIVI=;
 b=qZ6PypcTlthb95ihkuSFQRg3RQ5GQQGtC0eY3s9xTz2PkUH5b0dilFZVtldGGK+Z7/
 efgAjpe9xV9tFbQhd3JfkAfKZ1K/R5CcWlJgKENVfQmWpuJhg3s10L/3H1JR5pCPYquL
 i3TXBUzuGZ3uTuiq1Nf2gFNf1ooFzo10Nxxp+Us6Z65WD9b+NuzMuBjPUjNZVoKTZEtg
 yQL4beNDyVVYUFi1kGBVnOVyDH/RVEs04EGgut0UABd1Ugxe2PfVSgTFrlmyS183wOff
 s7lJtej4q/3BpaqLmOvPpIjzkFdWAeygnAIjKQOHMr6S0SNvCLJHV50D73FO7+R2GrEX
 lo3w==
X-Gm-Message-State: AOAM53238glRawdjPZQMDxpYVwDRr8CAAOjtqyf7narRH2yL0hUH9S/h
 krPfvICidXWy/WSKx5y1mOzS6xPIPTA=
X-Google-Smtp-Source: ABdhPJw/INe8A2OwpA3e0HysV41P0wQ60wemAi5fO7ATOkcyA8U/1hMvj55DIu9GecdiguT5acwSmQ==
X-Received: by 2002:a17:90a:1acc:: with SMTP id
 p70mr9572815pjp.210.1595409660695; 
 Wed, 22 Jul 2020 02:21:00 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:00 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 48/76] target/riscv: rvv-0.9: widening integer multiply-add
 instructions
Date: Wed, 22 Jul 2020 17:16:11 +0800
Message-Id: <20200722091641.8834-49-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
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
 target/riscv/insn32.decode | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index bc6c788edf..c6a7145aa5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -420,9 +420,9 @@ vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
 vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
 vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
 vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
-vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
-vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
-vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111111 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
 vmv_v_v         010111 1 00000 ..... 000 ..... 1010111 @r2
 vmv_v_x         010111 1 00000 ..... 100 ..... 1010111 @r2
 vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
-- 
2.17.1



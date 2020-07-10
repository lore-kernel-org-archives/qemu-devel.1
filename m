Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF8520720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lrVZGaY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF8520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsdE-0007CE-Mi
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcD-0004v3-V5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:49 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqcB-0006Rp-Fr
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:49 -0400
Received: by mail-pj1-x1044.google.com with SMTP id k71so2455784pje.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4bn+oUGGFPh+TBNTW+1Y2E2/tR5+d9f5YZSgdQZEwD0=;
 b=lrVZGaY+4FcvyQAQ9GygGzkp2ku8QP3JRRKoNwf6xrJtYAVqrMN3BJBRO3stiej/tq
 gu03Ktef4NXjl1N4bD9w523Nd5KfdKJheYAMDppWWzL4ir+nn1g9q+cga2QORXMb7mSH
 4/V1Lzd19y5ufi3ev7WfSANBUmkymLl0HRcIuBU8r4lwyrouN03hDioEzxN2BLq0jc2w
 PNa1cB3LrZLSOCfO7TU5J03tUNqmrskXtQtiucDXNh4N8caZ9Zwf3il+Vt/GovQuu2OH
 W14h3gX7fhjY62uJhBvqSq/a3Y05a1DC2OEtQWiOKnrGf9P1vOoxgI6l+OH6d8TQdIs1
 Ytcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4bn+oUGGFPh+TBNTW+1Y2E2/tR5+d9f5YZSgdQZEwD0=;
 b=FSurS/RDo8zHDFnXEWiHYDaCzXkruD7Ur2CEZqeOwlT5PCPFCzPaGgBtvXf6iy7tyK
 AkR8S3xwtqVYu1Z08iV4623zzJfMX4ctiWJbUdNC+ctJ351bztYkThiudSF7tKt+46l6
 gdOOa4mjlw3k0hrnlzuKlU3AxRHyPc7sTStZZog2VN50qSfIjet4JZBEz/uVLjocfTwK
 7XZML6nJ2+Vo7g78j94quYLxBfDq4UaZpyVINgTTBGzFv7b2PrFB7fksJiiiLYry/cl0
 jSKReLUD8vo0RR5fWpSoWJZ1Bbp7QSaPlkg2jrQ5q5gwPL6YtbarDOVTWUkf1CX+sAfX
 qYng==
X-Gm-Message-State: AOAM5300xqA29+nbyuR+ua8vknAHCVEucACkBNjnP9UPD2+KaYU9drSw
 f6Iif8oiZ6r18ou0nV7DzSi7N08Pb+bNYQ==
X-Google-Smtp-Source: ABdhPJzw/B6DXZl7APkB8F0jY3xolapGTEsmaH9URq66xwoGzNoxulIszyK+w33pkgC0Ula6P2s2YA==
X-Received: by 2002:a17:90a:ba05:: with SMTP id
 s5mr4665123pjr.132.1594378246081; 
 Fri, 10 Jul 2020 03:50:46 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:50:45 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi,
 vsra.vi insns from using gvec
Date: Fri, 10 Jul 2020 18:48:19 +0800
Message-Id: <20200710104920.13550-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1044.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

vsll.vi, vsrl.vi, vsra.vi cannot use shli gvec as it requires the
shift immediate value to be within the range: [0.. SEW bits].
Otherwise, it will hit the assertion:
tcg_debug_assert(shift >= 0 && shift < (8 << vece));

However, RVV spec does not have such constraint, therefore we have to
use helper functions instead.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c0b7375927..70d31a5525 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1427,9 +1427,9 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
 
-GEN_OPIVI_GVEC_TRANS(vsll_vi, 1, vsll_vx,  shli)
-GEN_OPIVI_GVEC_TRANS(vsrl_vi, 1, vsrl_vx,  shri)
-GEN_OPIVI_GVEC_TRANS(vsra_vi, 1, vsra_vx,  sari)
+GEN_OPIVI_TRANS(vsll_vi, 1, vsll_vx, opivx_check)
+GEN_OPIVI_TRANS(vsrl_vi, 1, vsrl_vx, opivx_check)
+GEN_OPIVI_TRANS(vsra_vi, 1, vsra_vx, opivx_check)
 
 /* Vector Narrowing Integer Right Shift Instructions */
 static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
-- 
2.17.1



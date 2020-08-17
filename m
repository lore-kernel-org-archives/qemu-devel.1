Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88625C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5837C2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MzslXUN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5837C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bGQ-0008Oy-Hb
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asu-0002U5-BU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:33462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aso-0005Hp-AT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id u20so7906508pfn.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3hvE+RspnEJb9Hzut0m2ZeEVXpPm8G/Iavh7BR1RkbY=;
 b=MzslXUN2FsU4TlpK5wNbdKWKmrt5lwShKcDmIjvpUochIVC/XFgF8gMhBTISLPp4Wn
 zJvT3X8QTQ0cXhLf/4PMRrROxjSH8ZuDr28Hgc2EXklx2hUPcE9hz5/sFrXy8tZZ5/gc
 8DavuJ44Iuu/xcS4f1JeoDFC5YyjinSNngYRjHbxez9FUMl7w4kCvIPVy01aQPwwBSd1
 RjGvlKCuVhRYt8b78Vv+Lcb5+YY8DhejkgmcjlYHvp4lNwLsHpQl3xwd2C2wtncjNgBi
 FmxvZeFo2KMCEcgcMw6784++8ZA0FsDrOhkDOioNZWz7N1tONGDGYUmQtw2tpAbMAOt3
 votA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3hvE+RspnEJb9Hzut0m2ZeEVXpPm8G/Iavh7BR1RkbY=;
 b=aMNwD6Ch72sjArgy/6MGM51lL+sEaxQyXwFXiasdOj0OXkKwr4cqg8+fhJfrnGm9Lg
 uFy+CHuF91OGEGqZrtyYiAkg3JA3v/OnGezHkoI3lWOWKOjwhPLaHdf5rh+f2tNuZJSm
 wIFhpCYbxky27mxNW8HCAPxywjywGCpsDtM9hd+24bmToQiw4VGsTJqwfGx1SS0Tx/Sg
 jsuEhGbsO28m2r11WllAQN2baL5XNpvTMTo8ZGOIxSQ3vrnLPORQVDKApGaWhkuaEYdx
 bWWJ9RGAyjr6H82853OdTX92o143kWpmU2Qe7j2JBqNg9AFekXFYPEG4cXBpKmELR5Ev
 x3sA==
X-Gm-Message-State: AOAM531TKnVOLqFJOgagamnyO4zYwswBcPBBuFUo8Hb3Vy3orJY+HYvs
 lqk/uA1V8HxI5waXuIuEpxT2Ddwd5ntGYw==
X-Google-Smtp-Source: ABdhPJwhzCSVp7Kq3p6Lg72zOS81LXU1LPVrz9lUB6tcspI5LQjuwd3VixsMWBKBVjHGmR9YcU0xcA==
X-Received: by 2002:a65:40c1:: with SMTP id u1mr8929748pgp.379.1597654364221; 
 Mon, 17 Aug 2020 01:52:44 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 57/70] target/riscv: rvv-1.0: single-width scaling shift
 instructions
Date: Mon, 17 Aug 2020 16:49:42 +0800
Message-Id: <20200817084955.28793-58-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42f.google.com
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

log(SEW) truncate vssra.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 2ebe2373237..9c92ad62915 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2372,8 +2372,8 @@ GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
 GEN_OPIVV_TRANS(vssra_vv, opivv_check)
 GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
-GEN_OPIVI_TRANS(vssrl_vi, IMM_ZX, vssrl_vx, opivx_check)
-GEN_OPIVI_TRANS(vssra_vi, IMM_SX, vssra_vx, opivx_check)
+GEN_OPIVI_TRANS(vssrl_vi, IMM_TRUNC_SEW, vssrl_vx, opivx_check)
+GEN_OPIVI_TRANS(vssra_vi, IMM_TRUNC_SEW, vssra_vx, opivx_check)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
 GEN_OPIWV_NARROW_TRANS(vnclipu_wv)
-- 
2.17.1



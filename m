Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8BC433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA532065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="abQtfsOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA532065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBB0-0001rM-Ri
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAw3-0004mC-Vw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:39339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAw2-00060e-G4
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id b9so653625plx.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=luapOFzm51xYRtzAj/W9SIi2lVG0a4XONIdVgpZBqII=;
 b=abQtfsOlpyA8C700Pth9hYwSb9dnPwgWP6K6Mzm6RLt2FH7ohMq6TXaRzksnPC2MnR
 IjRzFJY/TuDqyMnLXg/3fpwTiROsp8AdRhWkho5SnPTNwjk/+2c4ZO5rvKPDjarAn8HA
 ZCQ9xR9dw00gVLZGoqfq/hXSgDwr7lQR86QFqZlZbubnxat8K7XqnShPyuegnGyZZKBq
 q9pkrHFnGlSw99UsBBPHITg7N7AbOvVTgjFRGyKg2OvjbVBC2uCYHLWgnvUcFHyCmYcC
 F1HXzyfG1EieM1YSs6RLOdUwQ6JhFnu6ZEhkl1ZJY2G6PScXI1+uy3zXJwpLfEUkfijl
 QSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=luapOFzm51xYRtzAj/W9SIi2lVG0a4XONIdVgpZBqII=;
 b=Vx98pTdeVBkyi3eFmZeHZEwK1M0Z2imbjzHxb8zNrWV348zzRFRj3pzDqjhLYTF1Xk
 QsAMgItZGyal76v4Cfv4/DtX6u5h+q4qazuxc8cZbgbRla6R+DTUexJ4xfVLg5UKGNd+
 oGB47V+ZUBk1UfFUG1opFogb2wj29HPvzUPSfrQoX0z8g9CMYOcM7QnY2j7jMiB4fQs2
 mDDH5Fn0OX7FhcsjzX7Z0wxP+Wj8CNS+yNqWTtlO8IGTWgnEOUCoIsRMKnshc8YnY0jF
 QF0OMJMqWMXJztI6L6FOv8ZSMVTnJO9n43LbEiKDqFi8iIT6REWdNBKiZwiltGCgMST8
 jXkw==
X-Gm-Message-State: AOAM532EDFDv6Rj2fGfPC+1D8a55E9cVOthPUGb0SzEy4FfdFKJQvjS2
 KMuRJLZdB3W942bLv/9MQbrcqv4Vcbw=
X-Google-Smtp-Source: ABdhPJxkxMPLAgYECMJKHdSBA6RtbOlCibPEKbKxQHoJ6zSSB5UsJYvthCZcx68j1zrxwzjMCKs55g==
X-Received: by 2002:a17:90a:800b:: with SMTP id
 b11mr9119062pjn.105.1595409669044; 
 Wed, 22 Jul 2020 02:21:09 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 50/76] target/riscv: rvv-0.9: single-width saturating add and
 subtract instructions
Date: Wed, 22 Jul 2020 17:16:13 +0800
Message-Id: <20200722091641.8834-51-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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

Sign-extend vsaddu.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 956ee90745..3018489536 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2374,7 +2374,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
+GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
-- 
2.17.1



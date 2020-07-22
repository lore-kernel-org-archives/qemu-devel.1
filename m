Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21EEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CD820729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YyvwtEWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CD820729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAuX-00011a-PU
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAsb-0005O0-PA
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:35545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAsa-0005EX-8A
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id a14so872691pfi.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dY1VnCufQZpa+aF68DC4K7OikxwvWj2GSrpOqri/zyA=;
 b=YyvwtEWm3SZpOurKdG7x6QNieY/R2CtsObGD8omuXOjGvRxJojJXb+EF1I+mKRQm3K
 xaHGV0jVlugF2DvHiLSaEeJkEXFmxtCPhlda3eKfMlk4kTbnBa07PbjNp2AfiAyXRh+u
 hEClgtM/U8ysFA2wRkI1uZnUdB9Xx3a/hkFUsrApdoA9K+xbODqofsqNG4nxkKbQOtIu
 6B5NvWxEfuY8K71ouCSsx8mg00gESQ549xZ5yAlssFTIe8NBUIwXTTdy+TtJxTz8oHDQ
 83Z+x0V2A67KWIvy4/Ve/ZY6lGV++saI/qWXU+SAQPu5V8yhRr5TyDnciZN3FPuprosp
 83gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dY1VnCufQZpa+aF68DC4K7OikxwvWj2GSrpOqri/zyA=;
 b=nahVty0cSt4w8tC0NHNkTBuuU6igFs8YntkH12MHP8IGG0CEGWIl/AoycKyYCcsDv2
 GWBiOPXWwMPAPGcob71FyKOPgtD15tkUL/GLReUWeZCjzn/lBwTyrxAuDa/3rWbryksB
 RIU2mjqLZR4o2ohsU60Kbvx/WoE0259+yRncMBcuUiMCJhVFo3IFnjKZzy8YYS5BmSuN
 Ek1gy74ajrtE5TQwO0HMgUAY7GvIJKGZSvqG2jWWnLTXSKqdLG5Jaa+RwrDbXW0kIbrx
 CCrBYERcDkahB6/TiLrk+4oxRvxuwQS7X4sfKvt2eWL0oakwVM16BqMXMADSWfaKEgY0
 kVjA==
X-Gm-Message-State: AOAM533ich1a41tj8xQ6Cm3bjC8ed7Q+uJEks7a+aHCf6Y9CnB6g/zb3
 G5sIl4OWgdc3YaanSwwmmtkF/nGOUVI=
X-Google-Smtp-Source: ABdhPJxrtBNZoM5PQ7qpaY8LDID71dzKi7yj0Uxp7NqcqUFishirIGLpNK31OpzoiUMoSGd6V20e8g==
X-Received: by 2002:aa7:93c3:: with SMTP id y3mr27667419pff.206.1595409454891; 
 Wed, 22 Jul 2020 02:17:34 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:17:34 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 04/76] target/riscv: correct the gvec IR called in
 gen_vec_rsub16_i64()
Date: Wed, 22 Jul 2020 17:15:27 +0800
Message-Id: <20200722091641.8834-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 433cdacbe1..7cd08f0868 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -937,7 +937,7 @@ static void gen_vec_rsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static void gen_vec_rsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_vec_sub8_i64(d, b, a);
+    tcg_gen_vec_sub16_i64(d, b, a);
 }
 
 static void gen_rsub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-- 
2.17.1



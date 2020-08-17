Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DD02067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UYix6MGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD02067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7atM-0002Ve-3j
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqT-0005cX-Np
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:21 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqR-0004lH-8j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:21 -0400
Received: by mail-pl1-x644.google.com with SMTP id k13so7148047plk.13
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jwaQ01os+v7ccKsWD7AIi9EmHRf1oR9Hg4U1s1xtcn0=;
 b=UYix6MGy9wXyF4AKmCa7MrHXJ62hgyqYlorwJVRFnfsXvu300GRrqndsBfE4y0xEwo
 fPGk1ysAWysp2iTVElgBJBaufIy4pzz+LP/YuMTDx2oT0ODH8ixBD4DneGJ4HLfici4U
 amhp9hCxw3/tjDLik7mdGP/lVfAz4tjmGeH+V3pZeLNh8FGtbHyqE9IhddxHXOl4lDqO
 +BypsrDVZuHYdQ0tANAZBM+J2t2jd7pf1tdb6c8RzWHIprDeF3l1lbwPtfZ8NmQvDxjv
 fEmrzBvqJ7MsTtIcu+dlOpfKaF2xmoimZP+MHPQXzS9GKpqxQBOQJiK/EeQpIW/nQL5O
 Olfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jwaQ01os+v7ccKsWD7AIi9EmHRf1oR9Hg4U1s1xtcn0=;
 b=FuW6Hz61HzoDuzwGdeR0Hr5urnRhr9V0u51m7okEHlYftPCocjR2P2YppFAKn/0udb
 PiaozWpYkduQzhj+S9b/NKnVSXvvr2cKWPFBnHDQp9qHO+fHk1AexRIHmYxyMZcvOCig
 qRA176wJk8ofuc3pYkIpxEhEVTNJvIHh8Qq5L+UAHsgA+zWsb0KdoeE2A2TPm9cCdCIo
 piZXKFMUC0uepgzwkMNeOXimWoq49tvH7sJ/YK5rUytdTnOOpKvIbGUIbGHbOhJS+657
 eyxsOeJwjaOVM28M/fQNvWBZMoBzJl0K/p37mBuw1P1Tl9PsrmwkzXT/YlqXEzoDST2u
 t8PQ==
X-Gm-Message-State: AOAM533ef8v26GTq5GEE28Uc0nxHCgy3wgFgni0EpCTM/4SuU8EvjpOi
 GFEfzTCJLrcuHZyR+0pL9wnOffvDxhBJ2A==
X-Google-Smtp-Source: ABdhPJzxZ+ItaBd3hSu9Drs4vJmJ+J8SVL5xwyBZY3Ntszm5n7Dj8krSCtTPEgeJuG/bgXV6qwczMQ==
X-Received: by 2002:a17:90a:ff07:: with SMTP id
 ce7mr11692290pjb.192.1597654217728; 
 Mon, 17 Aug 2020 01:50:17 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 05/70] target/riscv: rvv-1.0: introduce writable misa.v field
Date: Mon, 17 Aug 2020 16:48:50 +0800
Message-Id: <20200817084955.28793-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x644.google.com
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

Implementations may have a writable misa.v field. Analogous to the way
in which the floating-point unit is handled, the mstatus.vs field may
exist even if misa.v is clear.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 46c35266cb5..7f937e5b9c8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -494,7 +494,7 @@ static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
     val &= env->misa_mask;
 
     /* Mask extensions that are not supported by QEMU */
-    val &= (RVI | RVE | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    val &= (RVI | RVE | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV);
 
     /* 'D' depends on 'F', so clear 'D' if 'F' is not present */
     if ((val & RVD) && !(val & RVF)) {
-- 
2.17.1



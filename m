Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576E6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DF0204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I8ex4h9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DF0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dbQ-0003Za-CQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQr-0000s1-UD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQq-0007h1-8T
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id f193so14310378pfa.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PmJPlLLbVG3Gytq6oYvdgoCyUZVGxpYxNeJ9teoiRrI=;
 b=I8ex4h9TehJ7xYu4pYHdQOgqG5kIJJkGa0NVgyDYJGIHqqZkCBDcjIudN/p59enxZz
 Tox13h4KTgN4D2QbG6LbiaZg9wcpJR75mXVj6AJ+Sgy0ZV/KtQdxOWh9y/vgZNGFP2ef
 RCIP42jtKRFgtMFojBSQeWbw1dV8vlL1+/yf1XLdvnCPGFbS4bEdoX0POslLOtKVBb3f
 QIjbF8g8WB+q0PzhYSqvFa8u185iymrwZKls50FWUjFpiJ1aHwkoiU0z2LgLfOq2wxVS
 D8iAgkLNqynLnWMtDd/goT2JlelMhdL6ZB8wnMbVVHolxzZP+qJ8LeM/QNjDhMHMMp7d
 T4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PmJPlLLbVG3Gytq6oYvdgoCyUZVGxpYxNeJ9teoiRrI=;
 b=YekLN5HKT9/3yO5JjrkZmzVHiaqwEc0FUq8eeSrehwlsq60ZEP3IdNi+X6a1s0ctI5
 ylBLFgvkGBtpZEBQh5a3m7tSptHjQ9dFVrn/nLRba7XSxbrdJf4lct84fvFvTs9ddUzW
 JSsqBcnpfDCavVt4TnvSrQlMteWGlPiBTEF3kPy+em1EnV82PZbtCgSvF/Y8TA688oj+
 MVL2s8Ma4Ys072dvcnMXwYtf9T6WhB9nf7IULUvoOjU5ZRlFsDEXLI3+9Nnu523q+exx
 UF+QV3kMavt8hQBMsJSEGbCrkPuyflIuU0cQNZiRke5pM40ef7B138m4A2LBrPQtDpST
 8oKQ==
X-Gm-Message-State: AOAM532qVbsInietpOzlXfm+dQ3cyzrzVRH/6Fs4kI1JjrDQLH8InW8L
 ikXCOGyryIaPFBhWUF1KDg67KptjnwY=
X-Google-Smtp-Source: ABdhPJzukxB/HWZ+14qsp5oD6N71xzlQamJ37WpVqFm/d5Ve9v53vE9hiXn1o31jUe9BqSPFLyIw4A==
X-Received: by 2002:a65:534c:: with SMTP id w12mr6572125pgr.156.1596710850828; 
 Thu, 06 Aug 2020 03:47:30 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:30 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 05/71] target/riscv: rvv-1.0: introduce writable misa.v field
Date: Thu,  6 Aug 2020 18:46:02 +0800
Message-Id: <20200806104709.13235-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x442.google.com
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



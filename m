Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AC2C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BD620774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aTDN0kLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BD620774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLgA-00025h-IV
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzJ-0007Nq-QT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:33 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:37812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzG-0002Qy-Pf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:33 -0400
Received: by mail-pj1-x1034.google.com with SMTP id kk9so3184058pjb.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JzyTM2tWktA+ljiJEur6MshCGktexIa7148Uh7k2hDc=;
 b=aTDN0kLwKo0oAwZ5lF8VbWmugEX5zoXqFQAyuDOu8Z0HEZDyL+eHA4kfoqNRUsmv5n
 JdSWwP8pz8gyk1jZxJR8r+4fzCy2i0IQnlODx7ldkHAv9yzs+hinZ5clWaVjpUc0JsXN
 fSBofLqplTbgIVFswsd5rxOU4Ikc+AaFzYJnwCWJhCj3yE7DgM3C4tT2GO3wM/sLQAal
 eqNaMJFp98HxFdZrEH9/lO9q7YSwRzDi3Qj71S0M6ZwjLFJX4l/2xqRIuonxuLQ71Rxn
 5Lc7eODcMT5eHlskb1wzyX+v6hO3WOmuravnXr8O6fYpgmP8yHNj2mi/Dihb779pwNa8
 IwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JzyTM2tWktA+ljiJEur6MshCGktexIa7148Uh7k2hDc=;
 b=nBcW95YJDGGIs1wY8FkZxJcUHPmkBS/Rf9gn71NHJYL0y0n4boBTxKaJ4+MiZSy5Qj
 CD8z/xNtKJGHf4565gswcB+WcAQz+FOhedjikDkT5sph7CKh6O6J0wAXtnmAWxevzpp/
 lOfyUAcmYKv8QgcTXq5jcOa4biumpnbBu9XQZ7y215x0R0sN5wArp+drgLr3Fsj8sVMN
 2wb7Bg0LHyU0bQa7aj2YrShsE6V8Pb/ZuHbdJOGn1kM4uo5Dek2u7mBYR7wHOInsYN9V
 VkyVj71dgbEu738UYTcgSKRrn4Y5wky6lSQca8wYWfQHeD4oFz+Ojb53+WGIBVRr3LSc
 q7pA==
X-Gm-Message-State: AOAM533mRbwsApyRYORU3eX1fpkaR+LonsrMRGsPJ+jB9uPW8Dqd0nhp
 X5HKleOUoV/acwt2Jp0vhLqBOAoQc7H25g==
X-Google-Smtp-Source: ABdhPJynF83gErDjS1rWqXzQCSeWOKu+FUeulOMNMLZkwqF9AvgVS4MxrXZenVWukwN4SDYxcIHqjA==
X-Received: by 2002:a17:90a:1690:: with SMTP id
 o16mr5175384pja.148.1601406509406; 
 Tue, 29 Sep 2020 12:08:29 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 54/68] target/riscv: rvv-1.0: single-width scaling shift
 instructions
Date: Wed, 30 Sep 2020 03:04:29 +0800
Message-Id: <20200929190448.31116-55-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

log(SEW) truncate vssra.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index be5978790d..6df96f4597 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2280,8 +2280,8 @@ GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
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



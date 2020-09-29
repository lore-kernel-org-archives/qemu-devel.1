Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C00C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0BF20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RjfLZ66Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0BF20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLfl-0001YB-QI
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzE-0007At-Em
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:28 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzC-0002QC-R7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id f18so5517716pfa.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SmOcdQ82zJFTbAL8cnYxTUcRRhNx5mYQ8G6z15GLkyE=;
 b=RjfLZ66QqniygkbZBwbvnUwbUZgYbAxU5ascjaeob9xGntsQnzhrTF1mubcPy0OIQ3
 q7AeIO2tbxRwEf9QsYQWdtx2aTD4L8PDk+/SetWu9mk+lRY0t/dAz4KImf46kd7yAOm3
 /eofdOtbxkODj05q0MJtW12DAE/Z/uFFLCVsI55xdfDZzIrDwX9DR8eJ6sANOmwtdhUs
 3tNu7ay7WRixUfDy88xKxQeLKchMUey+k+Rq5oxZS1WFJD1OTqdnzP0TcNl+Cfx2Ne0p
 Pgz3PpeK/GGJyJ423qO+25o9MkJQrjxAB8dRY4KCDLAaj/VkBKoxDERcCeI2KV/XL2n4
 Q5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SmOcdQ82zJFTbAL8cnYxTUcRRhNx5mYQ8G6z15GLkyE=;
 b=smtQb1Aj4IuJnu5pzZ9mxZCimNMj38RExHO5DjZO65Ufroh7BPIXL9Y12r2JyNrW5P
 Z92SEUwm30BG1UeHWAKWNO3dLwccZZzCrgeDnvrjTYgcjyGcUoz5cLyMTIjIU5lyurdh
 81ge9U++RDnsXb2gQIbe100TgXREvFv2/7FHeVQkn2g9sKxRiqfpCEjnfDCp5aZ2dGsX
 Ma/eRlnSMTZFegMc+DoZHiZwbmOcJ4ieUT3LyfPEmZmJ4Je4YYyYoBrk2YhS3W4EznBx
 RbjGm93fs6Jwd9i0eFjPVJFftLdFlJHAaX9LEoZ6+hNoTeD6wOsqks0OZ7ay1qPsHvhV
 YOYA==
X-Gm-Message-State: AOAM531JY1xhI4zZ8jA6BDY2imzbbryhsaR072OY9I4ejNh0uxlSIup8
 Fa5GCQfmBtXxKwsaLF4Qos3y2GcBJluzXg==
X-Google-Smtp-Source: ABdhPJy5jQ/COmMVM6eHddLkgWJ/YK2TJmKz5UxnGcClA1w9VuLnBcb5rGkNQcaIv+pTOdYtVNdNhA==
X-Received: by 2002:a17:902:ab89:b029:d2:93f9:54d1 with SMTP id
 f9-20020a170902ab89b02900d293f954d1mr553769plr.30.1601406505320; 
 Tue, 29 Sep 2020 12:08:25 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 53/68] target/riscv: rvv-1.0: widening floating-point
 reduction instructions
Date: Wed, 30 Sep 2020 03:04:28 +0800
Message-Id: <20200929190448.31116-54-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x443.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e2f4de6078..be5978790d 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2895,7 +2895,14 @@ GEN_OPFVV_TRANS(vfredmax_vs, freduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, freduction_check)
 
 /* Vector Widening Floating-Point Reduction Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
+static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return reduction_widen_check(s, a) &&
+           require_scale_rvf(s) &&
+           (s->sew != MO_8);
+}
+
+GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, freduction_widen_check)
 
 /*
  *** Vector Mask Operations
-- 
2.17.1



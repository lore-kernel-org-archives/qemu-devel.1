Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1596C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4CE204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Cy1E4wOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4CE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e0E-0005Dp-U2
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dT1-0004Qp-DE
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSz-00084B-8Y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id m8so17863748pfh.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=La0dMO1EDgYzAK0UH7rJx1lpxEeCZ+SwiTkARPgIAro=;
 b=Cy1E4wOBmKf3E4tPP25ocinfFgXo8DWw52hVG9wuhQChlb+OHvPjo+BcJt8JV1gO1i
 KUOOTmD8d2N53vU6fVxaEviqXEKQ1DZYwgyygFy83u3AXwX6vmvSqx1mq2dKEavWBn4E
 +aEo0HvsVEIdGKheXGudVIUYSL0YWAXgyFVQTTdy37hzIRtTyfqFC2/B3jyHGTAnFLeJ
 hlMO3dqf8aio6pZT37EYUD8UrQBWOFw0t3+mLuRSzOSzvaiA9QYB8W5NECS1ZVl227jT
 PUapNlNJjJj42wv+7/3a2lb0vBZvmOm2k2geh7w5bzNR/J780C+VnuIZRXg8g9SNHtMD
 mrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=La0dMO1EDgYzAK0UH7rJx1lpxEeCZ+SwiTkARPgIAro=;
 b=M46UvYZAExncjpF0SbXltRq0HCGC4XV7nlrnX1ALItZmGppRZkfGYdA2f1jngk9zYl
 fms7Qh7FvgbvdEICbLpvEicpIaJGzxpjBIG0TqbaieAds8keQKU+k8+10esXlveF+7Oe
 QcA9Uh9kZw2WPQKyrTZYeNDJnXd9Pt4AnoLyKtCsEk0xwyavHVlsWNUATQVJopddgSM2
 H3SsaGen97qFLHEECek6FdcWlKMzObil0GTkBp6N6MeqXQt0IDp1gD2wXyu4CHieMUAQ
 3q2W/L756LYXLFdzIV0wSNrJSdU3cgOmqDjmo6RicMlbTsuOcaX16LL7mwKKs2C0cqsd
 kfYw==
X-Gm-Message-State: AOAM532+BhjWgSHs/lzPfdOBuiRHxDxgU4JaVRsrxHIGdh7w0W3XeMGV
 AE6n2yM7MvrJH3LOjD2OaBBNztba9vE=
X-Google-Smtp-Source: ABdhPJxF0C5XE7WQJpvkMyUq496/h9MzP3bqhYx36lkrYqxLhJis+nCE5tX+hoSDhxOsVK6WLauzWQ==
X-Received: by 2002:aa7:9e1e:: with SMTP id y30mr7143741pfq.120.1596710983826; 
 Thu, 06 Aug 2020 03:49:43 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 59/71] target/riscv: rvv-1.0: single-width scaling shift
 instructions
Date: Thu,  6 Aug 2020 18:46:56 +0800
Message-Id: <20200806104709.13235-60-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
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
index 64bd4aa239d..2a2133a588b 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2360,8 +2360,8 @@ GEN_OPIVV_TRANS(vssrl_vv, opivv_check)
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



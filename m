Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A4C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F62920774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ipOKA+NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F62920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL2W-0002ic-P6
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwf-0002wW-5P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwd-0001sl-LG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id 34so4603171pgo.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hp5DzLiX5CfPOqsg6g2o1fOOo3aptoJGc/1BKoFrOdg=;
 b=ipOKA+NNUMOanWkJqAntM1dalwjhSI1lbYcFKoyUTWOaXMhcnRfsWfZYjZKHi5gC9E
 8xpUd1191yjELvc1d8aIUK5d+BpKThrw+3x/G4jPgXIAwdydhojmz0o1DqyHCsV+f6KI
 MRc9FsLmGzSiKFWAdn+x44mekltQoW9K1SjBSwSEzyRTiMecjBj+Hm4X8UCUNf8YLOEa
 N2d+ZPkPhk3ByxB8i2at0ywDBLXG+0vu4rKAsI1ti7TqEihhfJFUlxbDf3o6jSREdmy1
 yDeodEplpYi8zl/Dpf9e5CTdVDYqgYDvos4sk2CpFOL9Ip3QsQygLtLA5WqzRkiPZoi1
 OIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hp5DzLiX5CfPOqsg6g2o1fOOo3aptoJGc/1BKoFrOdg=;
 b=X69LyagTGBjILDJ1WcQdxfTqPVUcYMNMDTx6cIDEISbKnSCwZL1gMoSYvOQX7PWAS7
 vGagH+f1WBBM4EVvHYSYG0s1ZBcmB8SdLK7E+81s4Dnbf1DSg+264XH03tlINYltiI24
 mAP9srS9SXR/H3t1leeFZo5FvolK3gzKKFxTEQMWnUvaoDuyB8lceeZ/13bF2VAaGo5f
 PPULUabkOMH5i99GlriU8V6e7BVByH3gX68aobdpWXPXlEFG28mbe6fRFsy06fAJ1G+6
 Bgxe/Xv+7dWFyGzQcgfwRPdQY1Bx2yGjvfjQWxs3FGr4rbho3OETWgrp38usrsE4VHs4
 KufA==
X-Gm-Message-State: AOAM530e8BCJYSfZoPx55Csp9HqQ5luDHlB2/48aN2hmwo/tjAg4jcp4
 qnkNH+Ix1EbmAATiVUKsmRzek58ePnSKkg==
X-Google-Smtp-Source: ABdhPJwlpXtEqdTlxz36TLSXvGU5G2gALqy4nfWzorlP3HkFCPY2GHb4j4GA2XlR2drJqWKWK5DkwA==
X-Received: by 2002:a63:c948:: with SMTP id y8mr4537817pgg.164.1601406346119; 
 Tue, 29 Sep 2020 12:05:46 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:45 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 10/68] target/riscv: rvv-1.0: check MSTATUS_VS when accessing
 vector csr registers
Date: Wed, 30 Sep 2020 03:03:45 +0800
Message-Id: <20200929190448.31116-11-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x541.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

If VS field is off, accessing vector csr registers should raise an
illegal-instruction exception.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cf9718908e..21eeb4b791 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -56,6 +56,11 @@ static int fs(CPURISCVState *env, int csrno)
 static int vs(CPURISCVState *env, int csrno)
 {
     if (env->misa & RVV) {
+#if !defined(CONFIG_USER_ONLY)
+        if (!env->debugger && !riscv_cpu_vector_enabled(env)) {
+            return -1;
+        }
+#endif
         return 0;
     }
     return -1;
-- 
2.17.1



Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF88C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881C920758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XTtfh/wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881C920758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7awk-0001Gt-L4
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aql-0006MK-DF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:34174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqh-0004v8-9J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id g7so6030073plq.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AQZx9YbV8nCQY8I5II6BVIu2nX25I8qFRmz3CCFuRpo=;
 b=XTtfh/wxroJgHOBZDSUokB50RLPSUpwR6ywS1/GJ3DYiEoNnBwUIUOqiItqCrLVYKP
 OOyL/8n0aGIIuQj0aq9M/wAJ7yRmKXrUSra1BMCo8YU6ucu8QAUS64pTlR3kHFdJtHoQ
 zjNMUA3wxCVK2+8Tl9XmJamV8xNO4ZES5mH+JUtYWTmSUp78+uH0WfV5kerp/xPTB7Ru
 iZ89wAfJfFv1cG20ymmtfdk0jZepnoTVtJDi/AbiWQLbd9GI9sghu2bSKpJd6sdfB2pl
 cr4P/zzOXtxp7h3aiL0s0FMcvvmUsNHMK0NVCd2QfLWZjfdVnGXs+XlUtc8y7wzEaYkQ
 Nxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AQZx9YbV8nCQY8I5II6BVIu2nX25I8qFRmz3CCFuRpo=;
 b=hCKMx5oLtm4o4IQYJ48/A8kvPsq1ewNgyXVkgjfGSvTSCw6MkzGAD46jTOxMRfKpK2
 4ZwoXs45OhYviaUwjJKo+0Er/HPDBJmymMXubt1+9bQFPd6J1IHPybWJXzf23xPwjl13
 NIkccrZh3MlJBtjR2nSBDXddNo5DNwGzFd3ELJxHHB991pEvgRfHwu3CZkqqQy0iYqK3
 +FqM7PsctmbfDDheedMJpo5ctPAnO1pGGqBnvy54bYaXir+3c3mBioneEz9sCSP2bf30
 8asO3UpZJx/9z0Aj3mFNp2Mgq1lkdg02O8s2U1ItIzj/D12omUmj3d/Hz/DVAoXLiLVm
 jO2g==
X-Gm-Message-State: AOAM533MUHfFZWthrMCSMLfysZDSLII0Wy9qN6ZWm0BbALzIcBrDGyWV
 l5mjqZzM76WBKNfPgODOoIGQa5BqrqzPtA==
X-Google-Smtp-Source: ABdhPJw4mkAGUeVFxTATUV+fXhN4e0n+dj1wSFDNzoV5MrJwyB83+Xgoes4YgsvWcZT0JSqGh2DAFQ==
X-Received: by 2002:a17:90a:1f8c:: with SMTP id
 x12mr11834765pja.186.1597654233777; 
 Mon, 17 Aug 2020 01:50:33 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:33 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 10/70] target/riscv: rvv-1.0: check MSTATUS_VS when accessing
 vector csr registers
Date: Mon, 17 Aug 2020 16:48:55 +0800
Message-Id: <20200817084955.28793-11-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
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
index 6379718e1b6..ed8f6e175f4 100644
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



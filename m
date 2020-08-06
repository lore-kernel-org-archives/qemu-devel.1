Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F3FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7137204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y20454jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7137204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3daX-0001sT-7V
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dR6-0001Du-O5
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:45776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dR5-0007jM-5n
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id f193so14310708pfa.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Be0XpRst97t7RY4cXW3Qtzy3ziEgiOCF9bgG3gg0AY8=;
 b=Y20454jTIM3t7f+NPhPV+bD7LNvtnvYwiJlU/PCpzDrmgavozlhtpqGlGlI4evY688
 P5b35nYivlj832hLmFTYNQZJySxIc4tey5m2aR8aYRjDRsLGRbELAYlNo/gUv1Wwe7Vt
 kJeBP4SAe3hiJiQpCIGiujsqldNyifL46J0k6vloXrPkR8p3jb+AXzWIgfjmET8YO5ZQ
 eh7BaBd25lce8QHbKCkXrUgRfNYxrvGeG6Gy/mk/LU+8RPB31AANBGQafJgOxUeoPBCU
 YW5bHs6B7hTWTwKmcSOf6J9I9DBh+QvB5+1XuUfn8vHl0pcTQCbX8bidpra1lnUKElwT
 TF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Be0XpRst97t7RY4cXW3Qtzy3ziEgiOCF9bgG3gg0AY8=;
 b=MorGhRoKzFzeYo8cKT9fJLl7xSX/h55EPKft2o4aRQLROj1IVbfewyoQbnuov1+U10
 sfV2hSZ0rGfz+UJi1ev5jkpbE7YaIamf6aeZpYQXGWe7B8NLLhkFxp69qcmfFGgE+Tos
 feg3bPlzZp7YBj5x1AgxsMXzxVaiFAnKr3WwLsCYZX52wSjBlQ4DreHOES6MXAWjcmxU
 Up/P+z8qeAZDcW+B1GlxyHj30DcIusrb+4KZJ7aQY9Db3jQWrEfnaOD/S8ropE/w7gCh
 2sndQMSCVukNXOhaYcd19nyvRgcQakuPoNqifHX0KWZOEtCso4PNt4MtARSikYQ7cGRc
 5flw==
X-Gm-Message-State: AOAM5329ZjmXMuRkkiCntAR2MPnZYtFx+SgWoOzvOqocM/ZVWJWrt2x6
 +dsPKys5xUdnimFLoZO15L0TZ5uqXdA=
X-Google-Smtp-Source: ABdhPJwOST8C6etrkmtD6y496t3clFRgQ+lPWLU+9wEfLz24+DXLlNZnqrwVh1X+d82rIlSsgUddLw==
X-Received: by 2002:a63:450d:: with SMTP id s13mr2642071pga.246.1596710865774; 
 Thu, 06 Aug 2020 03:47:45 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:45 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 10/71] target/riscv: rvv-1.0: check MSTATUS_VS when accessing
 vector csr registers
Date: Thu,  6 Aug 2020 18:46:07 +0800
Message-Id: <20200806104709.13235-11-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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

If VS field is off, accessing vector csr registers should raise an
illegal-instruction exception.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 11ce6d4576a..50a178a60d0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -60,6 +60,11 @@ static int fs(CPURISCVState *env, int csrno)
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



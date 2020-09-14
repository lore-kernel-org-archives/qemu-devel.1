Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A17CC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68D520757
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTWQhbvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68D520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxYy-00071z-SJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUO-00014y-Uj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:24 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUN-0006bC-Aw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id w7so805477pfi.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LENG1C+gvyxicL4wDRJAGnBo4QTtONcvzqY0emfT/VU=;
 b=RTWQhbvfsnpqqL0NmJGJdO9yBxZjqM+TjbWeoW9Xu2cL55iUYlIHdWtVou2zb8O5lk
 a8Pj5ulhFf1VCYKTj/NWo4pJnnOGy+q6KFLAaB15J7wjdJH25Mibf5IOhDDcK+YSvJCj
 H+g3tjdF9x2G7Tkc3QjGDpXbP9J3hsvPkyZu9Ku0mo0qmCwla1Z4xi8C6MCbNRdtTBg/
 BQK5dPc/Z06e5HxMAaEN8A5YCxCIbrtNX7LmEHQaGqjEBtrVfW29rPis1KGDAjVj3B4s
 wBOCzPUJ90iFNzTRRIDjC0JClubKR8hTiMO4EklFj6KLO1Et9m00BxuZENDf1FklnhHj
 GTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LENG1C+gvyxicL4wDRJAGnBo4QTtONcvzqY0emfT/VU=;
 b=GSwXmrqh3fSclPRAM3/b1+MAXnBWg9Tt/dbVumTLYAb5PxnVwyhF1Y0KCmlkeDxjvG
 UuNJhmbLKTBiVWPdZvUil9Gep/jv4gt0BwK9/WIZPMzUZkZU7kh7VyyC6tqxN34F+JlZ
 IxNvr+jo3cF5FcuRGo4u4U+sirwq8d8HbwusBnnK4r0wfHDh35iied42KuMhQpuzOLS1
 tzGzLPcTuIeRvKLpyI9IKC4JyvMjN0CMR02VkZScbmFwWoM3pJ+evOcBVPqvxo61haBz
 Dx22CaKOeq+LqAkSIl3LXpNnCYlVNglq1XNDW7VZvx8kMQ009HGQuowYok62wyalKYQZ
 /bRQ==
X-Gm-Message-State: AOAM532YkvmDp1m3tkJy750NzAdjy4jBj6ywGVEXlrfJztG8RbT6xmYy
 Fp/TTL20vNSRVQX+BDQojCsQHVJMBXGt/A==
X-Google-Smtp-Source: ABdhPJz1Dds4rMzQRYbFq3W3NQqCmMjeucgMMTVp6YYJOXEn+pQDEXPSsZLSgbVOPxu4nunqqoASuQ==
X-Received: by 2002:a65:5502:: with SMTP id f2mr12223968pgr.418.1600124541622; 
 Mon, 14 Sep 2020 16:02:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm9106076pgt.16.2020.09.14.16.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:02:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/10] disas: Configure capstone for aarch64 host without
 libvixl
Date: Mon, 14 Sep 2020 16:02:07 -0700
Message-Id: <20200914230210.2185860-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914230210.2185860-1-richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ifdef tangle failed to set cap_arch if libvixl itself
was not configured (e.g. due to lack of c++ compiler).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index d0ccd4b727..01c8bc6c9e 100644
--- a/disas.c
+++ b/disas.c
@@ -428,9 +428,11 @@ static void initialize_debug_host(CPUDebug *s)
 #else
 #error unsupported RISC-V ABI
 #endif
-#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
-    s->info.print_insn = print_insn_arm_a64;
+#elif defined(__aarch64__)
     s->info.cap_arch = CS_ARCH_ARM64;
+# ifdef CONFIG_ARM_A64_DIS
+    s->info.print_insn = print_insn_arm_a64;
+# endif
 #elif defined(__alpha__)
     s->info.print_insn = print_insn_alpha;
 #elif defined(__sparc__)
-- 
2.25.1



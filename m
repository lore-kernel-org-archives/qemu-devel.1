Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA54C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA16B208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA16B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWqA-0003NF-BT
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHW-0003A1-P3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHU-00005B-I7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHT-0006l2-Ff
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so1484209pls.6
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=EKsqQug7v7zszsNqo0b9Js3bl54LND9OiSrVub9vLW4=;
 b=G+ww913SqskSV/csvNAEWyObTKRHgWt/6gIAwrOoAfBPQfwuPYj9Y4K77134dMRjg8
 q6KMxVqLonZm6EBVrmu8NbPXcgnAR8Gc+SHLJh5cbTs06iKkE+fQ9Ng8p3CtwWRG93nQ
 JUU3mKBB8CabWapVcYeIuaE3Xn/d5NIHGneEyfoNeQTyzNzMXs41wK+8U875l+8SXyUO
 /qPY6zEN+UtH73G9jgYi5Xy2SP4VVXWS9n9HDXqrPp5yhCtNNGN6xovXmXvWhBV7/Ky5
 2ADlB8zCEDjBtnsd8WMEFYgegxlOMnA+66qVUbv357TydXltf6YyZ3fVWDMovXMVH62s
 vxBA==
X-Gm-Message-State: APjAAAX3rWqvywLnKO6RGvfhwwmzAJBbm0sfcNqHTetRpqIs9LrG1c2Q
 UL8D+m9rnPXNv6uaGzMVkv/qNg==
X-Google-Smtp-Source: APXvYqyRMQg2H4LjYcqHOJbejMMN+hBHC7SOa/P/+uW0VsKzuXmE5DIcEDTPnnw01BoTEWHqExXJ+A==
X-Received: by 2002:a17:902:a517:: with SMTP id
 s23mr5262268plq.306.1561649026947; 
 Thu, 27 Jun 2019 08:23:46 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id o14sm5045356pjp.29.2019.06.27.08.23.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:23:46 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:47 -0700
Message-Id: <20190627152011.18686-11-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
Subject: [Qemu-devel] [PULL 10/34] RISC-V: Fix a PMP check with the correct
 access size
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

The PMP check should be of the memory access size rather
than TARGET_PAGE_SIZE.

Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 66be83210f11..e1b079e69c60 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -452,8 +452,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
-        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
-        mode)) {
+        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
         ret = TRANSLATE_PMP_FAIL;
     }
     if (ret == TRANSLATE_PMP_FAIL) {
-- 
2.21.0



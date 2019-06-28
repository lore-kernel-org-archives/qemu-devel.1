Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B5C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332A3208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332A3208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvCE-00058X-FL
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54546)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgukY-0008Gh-MW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukV-0000Ez-G9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukV-0008P0-4v
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so3333782pfl.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Iw6+m+IE1PHOTPzSnV8qMJ+Sj/ZsLxY0VeWDR+SUS50=;
 b=Nv4LvhnxgVatGz6UXR21rBDdDdN+7YNJx6810bNQp9TQ9OQR/uaUzLO7W+YaBD+qom
 LnEBKOlAmyAQVNgW1Ghu4yT/+bTT386cJJFOhQ//wCynjsr/dgtrm9suM4/uYCFaFAml
 AYYXAhXmcnRuag1VcwqXpAdb8i5d08gEgCpL4PCee0rvnfq/HppSyf2i4OxpfuQrfaqM
 o7E7+hduIo7iWrk5xrrTx5Tmx8vnFltf6CHo8tEE/vx/XF/tGvT95Cx+l3vN0hQpRRPd
 /3igsrX721oAct6yq+icNC2gF1S1FsmImwGmpdm735DG35AezoUVWcAro0hmQq5u/ssM
 ctcQ==
X-Gm-Message-State: APjAAAWfKD5f94xhDNbVL1asTaEryWrCh1lX0PH3BkMo/4XagiXVpF8y
 AsMEBVaveLZuVGO71+rQcyM3/GXqVIYNrIq4
X-Google-Smtp-Source: APXvYqymAjwa4Tz4sKOs9VqA/HlZehAKSd62LicEez6P7ZcL1MvEl7LLM1kxtkMMt+yIEqwgIbY1wQ==
X-Received: by 2002:a63:b10:: with SMTP id 16mr10133507pgl.336.1561743174451; 
 Fri, 28 Jun 2019 10:32:54 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id l44sm2649849pje.29.2019.06.28.10.32.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:32:53 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:31:58 -0700
Message-Id: <20190628173227.31925-6-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
Subject: [Qemu-devel] [PULL 05/34] RISC-V: Only Check PMP if MMU translation
 succeeds
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

The current implementation unnecessarily checks for PMP even if MMU translation
failed. This may trigger a wrong PMP access exception instead of
a page exception.

For example, the very first instruction fetched after the first satp write in
S-Mode will trigger a PMP access fault instead of an instruction fetch page
fault.

This patch prioritises MMU exceptions over PMP exceptions and only checks for
PMP if MMU translation succeeds. This patch is required for future commits
that properly report PMP exception violations if PTW succeeds.

Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0bbfb7f48b79..a45b05ef8395 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -436,6 +436,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   " prot %d\n", __func__, address, ret, pa, prot);
 
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+        (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
         ret = TRANSLATE_FAIL;
     }
-- 
2.21.0



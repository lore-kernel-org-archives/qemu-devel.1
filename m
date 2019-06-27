Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD7C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C55620B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C55620B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWWU-0001nN-MO
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWGg-0001ld-ML
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWGc-0007g0-Ik
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:24:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWGa-0006bX-9O
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:24:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so1180450pgg.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Iw6+m+IE1PHOTPzSnV8qMJ+Sj/ZsLxY0VeWDR+SUS50=;
 b=ATFpleel2IfUltFcPQWe1Dsak8sR4bmHUUXhVi6/1rjn2EywoMp/L5GU0F/h+OlcLL
 qanlgsg02fbc3yBTM8Si1uuDcFNsSpEWBHKOk45RQd69QWXTxA5L0rbBw1v6Db1nqhsn
 qqCpiWdCc6CXPo1OqhL4hLIa9KcoB/TdmEz12GzU/qSIjzo5+yBGUkujgi0aghEIYCbY
 iMw+vnayhfz9vQB+BIvRmJa0Ia7Vnh7Lwmm5xWRAx9uGoNO7pFIB7B4BnST6jsvI+7nk
 2emZcMuOB1wTxqG/Y0wnuF0RPqEVxY8bzx3G9Ux2X2tn8M1NvCjQmfqsPbvUEDpcFK55
 HBkw==
X-Gm-Message-State: APjAAAUUe3k102ufEFkkl3SnSlfd/fZMMnuf2U9tdlPuyCyqh0drd7zV
 KXDvzARrYb8KllW4j3+eo76WAQ==
X-Google-Smtp-Source: APXvYqx7QFAz0ycxwYn64N6rMCpYYUd5z3YRPOnYVpiuJW21aJOrTXHvztilDPsGl48ZbuyUtf2fIw==
X-Received: by 2002:a63:1864:: with SMTP id 36mr2871248pgy.272.1561649014575; 
 Thu, 27 Jun 2019 08:23:34 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id i126sm3786390pfb.32.2019.06.27.08.23.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:23:34 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:42 -0700
Message-Id: <20190627152011.18686-6-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
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



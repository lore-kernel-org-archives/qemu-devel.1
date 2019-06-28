Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6617AC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DE0208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DE0208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgv8J-000164-Iu
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgukb-0008JI-0B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukW-0000H0-Jw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukW-00005I-Bw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so2876254pgp.11
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=EKsqQug7v7zszsNqo0b9Js3bl54LND9OiSrVub9vLW4=;
 b=OX9xdQrYnxaFnXFGxNO432mS2b8hoiIElt53yA69DMk+bwzCEea8pnzDqYrGCtJ01H
 HsaVkRqbVnsk+gKP7NjHv1Uliazfy+OxIGDTrEMuICnWGszw5CjaWwSswNU4rdvRiyM6
 AyQ4b0dMi89Yv08vPLbPxOLzn4sstWvxfDLD1n59v+BT93naztLB+usosnj7rNJ4Cm/Y
 4Gn5tGIBNHrTt9KlwKsqkVMXEPpk90MBo4wM4PKMv+Lke5FlCIPZ1XYbUSjeDq2JohkU
 2ZFrvon3aLTuiPQC+mRVrLRBakAuOKOzYyDTzwtiVGarpTGcFPlE3CWAUduU+/TCKm8G
 8gXw==
X-Gm-Message-State: APjAAAVAgpxRieGcwzTmkE4mtg4McL9THrRJP0lsss3WooWemcrh9tOo
 c+IhIL7H9ajdSTvkQMufKAqvZPGdtto8OvxG
X-Google-Smtp-Source: APXvYqxVSr7isnJcgN3y2zSk0W4R3AQjxDtXhBpvEQs/RVX4AaBhqSiGViOdpd4ZWcTDvCuuksUZiw==
X-Received: by 2002:a17:90a:3310:: with SMTP id
 m16mr14336684pjb.7.1561743188055; 
 Fri, 28 Jun 2019 10:33:08 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id f10sm2317571pgq.73.2019.06.28.10.33.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:07 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:03 -0700
Message-Id: <20190628173227.31925-11-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
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



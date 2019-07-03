Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6029BC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BEB218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BEB218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiarP-0007Vx-Hd
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapM-0005Qh-KZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapL-0006NG-Hp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapL-0006Ko-AV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so1183338lfe.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Iw6+m+IE1PHOTPzSnV8qMJ+Sj/ZsLxY0VeWDR+SUS50=;
 b=V8bPQAcSRUC3/4ew+umQk6QY0r0gcQMo2yRzlWfPIZISJ7kntcXE5S8QtQjjR3pDBg
 W9SJv2UisL2TQtbpauQ2QI8QcSEQp3QoukmP9z689eD/P37Q+TvIZ4EWc7s1m9MGsZeV
 4WouIPxwu9t1B4grn2g3i5MulB+MmLfdukqZ/cF2GzEl/e96ds7CppKgpgmI6YMFD3p2
 bgqMvEwSmxnKwjaAHxReE3guP1p8N73hbxx/2FtfcCuC9jn7NpJcVDBm88lVkU4hu5oR
 ZnIUAHBISAKclRwOQEpqpQ8p0Q1ywetzmZQxKwo6re4zAkIWncYfWEzCSoGH5akq698j
 qpsQ==
X-Gm-Message-State: APjAAAUpW2ybITak7NsFQAU4XVFLSQoMRTsiULD6z8vx9SrzJHuW2+AJ
 BIOUsjzgBqtxbDySwaqV4dO30K2TuREcxA==
X-Google-Smtp-Source: APXvYqyD2geL54/IecLleCVNRJhL1FuwmL1PgQ0OqEd1/qV28tqnI1mUx0wjwKSQQxY4HIbEgE8X4g==
X-Received: by 2002:a19:ca1e:: with SMTP id a30mr17007066lfg.163.1562143277601; 
 Wed, 03 Jul 2019 01:41:17 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id 126sm208684lfm.44.2019.07.03.01.41.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:16 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:21 -0700
Message-Id: <20190703084048.6980-6-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.68
Subject: [Qemu-devel] [PULL 05/32] RISC-V: Only Check PMP if MMU translation
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



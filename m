Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC8ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A784721479
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A784721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7y63-0001Ki-Qu
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvl-0007Td-MH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvk-0006Rn-GC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvk-0006RR-AY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id q12so2387415wmj.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ObpRu4yWGJ56Lce0E8Qj/S0MZ1B/JMtbNndq30ymwo0=;
 b=atrdiSZ33UkGF+IZSdUFxKLbeh4otcHxV17UAx2kp2k1x5theuhQjrbh2Wf2qexxeR
 7B7DnsS2ayHfSE4aDlIsy+Quz8MY7y5Hvl5zJoIeQyO2mb6hZvrQviOjQdXas8cRjCKR
 8JjtEy4/fXvpqoVfWaxDgfdpVkekPeMFgfHSkQ//+VoaAipIWffSXXeScjhLf6aiZraI
 1cFzdjTz7fw54kPY+Cmw7orl7id/xo1PdCZTSXekT49nO/U3z75P/MZXMdFtjngAAjlk
 bvVygUYAdu8kwDRqwXOncOwi+UkXgynbVOr3tQaxqNVj4Mxr0HdMOYLYkVdREfXxILR0
 WX+Q==
X-Gm-Message-State: APjAAAVz/o7ym3WiC0Fbm5Lxafwcq+fYUOJmSwJg2ipb8NH3ilIL/ezG
 /nS84NFocp5VOqB0H6yAxPhjDg==
X-Google-Smtp-Source: APXvYqxNqrIiqEfeTP1aB6QlMIjUB+10N7FyZyAqvpceN0arO6UlOSXNdVdzFApNV3LXtQ4yolCG8w==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr2764209wmc.30.1568190287159;
 Wed, 11 Sep 2019 01:24:47 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id j30sm24749986wrb.66.2019.09.11.01.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:46 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:35 -0700
Message-Id: <20190910190513.21160-10-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: [Qemu-devel] [PULL 09/47] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

For RV32, the root page table's PPN has 22 bits hence its address
bits could be larger than the maximum bits that target_ulong is
able to represent. Use hwaddr instead.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 96373b67d8..87dd6a6ece 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -186,12 +186,12 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     *prot = 0;
 
-    target_ulong base;
+    hwaddr base;
     int levels, ptidxbits, ptesize, vm, sum;
     int mxr = get_field(env->mstatus, MSTATUS_MXR);
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
+        base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
         sum = get_field(env->mstatus, MSTATUS_SUM);
         vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
@@ -211,7 +211,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
-        base = env->sptbr << PGSHIFT;
+        base = (hwaddr)(env->sptbr) << PGSHIFT;
         sum = !get_field(env->mstatus, MSTATUS_PUM);
         vm = get_field(env->mstatus, MSTATUS_VM);
         switch (vm) {
@@ -249,7 +249,7 @@ restart:
                            ((1 << ptidxbits) - 1);
 
         /* check that physical address of PTE is legal */
-        target_ulong pte_addr = base + idx * ptesize;
+        hwaddr pte_addr = base + idx * ptesize;
 
         if (riscv_feature(env, RISCV_FEATURE_PMP) &&
             !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
@@ -261,7 +261,7 @@ restart:
 #elif defined(TARGET_RISCV64)
         target_ulong pte = ldq_phys(cs->as, pte_addr);
 #endif
-        target_ulong ppn = pte >> PTE_PPN_SHIFT;
+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
             /* Invalid PTE */
-- 
2.21.0



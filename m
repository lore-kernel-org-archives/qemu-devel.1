Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30EEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4752070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h2S8VnqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4752070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwXf-0000Ea-Nv
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWu-0008AC-DH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWt-0002Gz-3n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:56:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWs-0002GZ-Ek; Tue, 08 Oct 2019 16:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570568182; x=1602104182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wesWJj6QvwS88ThbHC6ZBLzVjCXfFibXEQU4dzUr07U=;
 b=h2S8VnqV1KNmLdOfU+6uPmaJm6sQdOPWBcmnxzREvIwP0NGYYFbwTJM6
 seBnS1r0+c+dFKOjHmxM/1nspn4RIM8CwtOwRVCteqvjDJE5UUziubl8a
 Lyg/lw9h5Ua3cPesvmCQ5CJl7W6Ch1CnaOV1zmuHixDkgDxN0v83D9N/e
 LYZynEZz44fWKhhhPF85LmJO+p63E4d+dH5eBm159aUX9ti3lIqoUFRoQ
 jp1APTTYI3f5M1O0mImEnUIdbp+Bl9pN8HjaBbZNUWhaTuL77/pneptGC
 doKexTolKWOnPs806gRvF6RTjF8rPc7Ivty7593Qn36jfoVW/LpXhyHOn w==;
IronPort-SDR: a4v8IRJJplQwntak5Vjh+a0VRQZqzIYXzRR9Dp0soiSoWW1GHzPXGNbZANsp0byudK1S5SLcXl
 jx1WycwTIPQvacJYWQFChGWwhx9RouZQ5wHEA7AYE6qSTCZ0do1BGWPNC/Hn2FVbJ0DJUy1Vcz
 o8azeVCEEtA93ltF8/4UozHfmaq4hY5Rnpl7AKwSH6jXZsDQRtEBWtZA3PrVnQGOkwNpVKiAgP
 yPUGRceZ+5DYAlNTTrNEjrj71P26pwj7CN86XyHv8xhVxgsOneSCVy29wwAnKAy4JMRdU5s1kO
 RLU=
X-IronPort-AV: E=Sophos;i="5.67,272,1566835200"; d="scan'208";a="227047824"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 04:56:20 +0800
IronPort-SDR: O8tQ+pIRFywICgypgKdKIGPPzVbtbeZEDCfZMZuqJtKtiPZj4DoyrDjTUgK4balxYFZeX7JzCb
 Bw9rTzXoTZGh8SehuXYF6AAHMPPI2xAW2ZJmJ3iy2YNMP5A0Uzx9rgWdjax0bmOEWyxlu14Y/X
 gdTp9y1NJYtH+MyzKDd0l7DXdQDYZlWEGYrRbalAA54tcHXrmeOLhcJcznGtB6Sf54+NK+opEJ
 PnebNz/6K508eaCbgTpAK7VwqawCCTW/Yy/7Q0mGMvs1s71sk0PGeWbSBknX2JZNCOYgOvkSQG
 GgJTP0ZI189rrc19v+euW/zS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 13:52:21 -0700
IronPort-SDR: hZpQ/tawF4T7Y0qzha7L8YGo917+rHaRgn2wf/Bq04egX+E/FQXkdhNqvHDyXndZfguqXUyUnT
 gF30emQyCm3qmjEr0orrvIP9VMP+5OcW93L1Vtdm2rZIr2mHwK8hD7azEYMZAfE9pBa4yPab62
 exoy3kAVze6mjjC8Nt7yNq4Zr42Wk970QRuxDIzbtYWvahBNj76heJoL0dHwvEzyip25DWP6j6
 XJWdm6+lBcltZ2bWPtO5p6smtGG8dRGMm2bL9J7kANjbMphcS01pZG6UXc/lQ119at7qIe3LgQ
 O+Q=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Oct 2019 13:56:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/2] RISC-V: Handle bus errors in the page table walker
Date: Tue,  8 Oct 2019 13:51:50 -0700
Message-Id: <944c4c9c5ef8c134cff2a7bef6e5994685e065ee.1570567870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570567870.git.alistair.francis@wdc.com>
References: <cover.1570567870.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Palmer Dabbelt <palmer@sifive.com>

We directly access physical memory while walking the page tables on
RISC-V, but while doing so we were using cpu_ld*() which does not report
bus errors.  This patch converts the page table walker over to use
address_space_ld*(), which allows bus errors to be detected.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/riscv/cpu_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6ece..c82e7ed52b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -169,7 +169,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
      * (riscv_cpu_do_interrupt) is correct */
-
+    MemTxResult res;
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmu_idx;
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
@@ -256,11 +257,16 @@ restart:
             1 << MMU_DATA_LOAD, PRV_S)) {
             return TRANSLATE_PMP_FAIL;
         }
+
 #if defined(TARGET_RISCV32)
-        target_ulong pte = ldl_phys(cs->as, pte_addr);
+        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
 #elif defined(TARGET_RISCV64)
-        target_ulong pte = ldq_phys(cs->as, pte_addr);
+        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
 #endif
+        if (res != MEMTX_OK) {
+            return TRANSLATE_FAIL;
+        }
+
         hwaddr ppn = pte >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
-- 
2.23.0



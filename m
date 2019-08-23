Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F2C3A5A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5560C206BA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EYGb2ZWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5560C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JZZ-0007gz-5X
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCS-0001F3-C8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCR-0000LD-AQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCR-0000Il-0C; Fri, 23 Aug 2019 19:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603752; x=1598139752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WPGQbBTRtC+Hpo1q+Eow5D21d9Sh3h6nJuJ7fj9l0zw=;
 b=EYGb2ZWQsoFfdpO4ecsXU2aOQo6V4Tqkt/CqZxZdOkeFVp/x8icPKwdm
 57PHin1F+qdWDIHiHEnz5ZKR45B7PtTff71mkQNmYXaaUK5/YL+emUW9Z
 Bo1kRB0e6JoEvyIR3VH7oOG33NL3ZOWKajVwhizSM2yZT+fZ4jm8h0EN+
 ppgz6jS+fKLFU7gB7wgRG498wx+ZLBmrJuFle5REpjtas6lS8bPJa4X+K
 qc/xlfXv20Tk47ymGnajetbW6YbeiggYGPUTxHb4eorNZ19pnmlM0nfDF
 b00zpsAqKu+ryHf4b1mvLuwSyn3tqrkH1a9cKYh13Wgygp6GPAXheOkA2 g==;
IronPort-SDR: bKL2jHx7c5VxQv8wABeTxFsme5MyAS6K2vR13pFXYpM3BKq2nZoOl5i/JUiWzR7HKBj3hpeY+g
 XYHufOcW1xjffZ3Zg7eGWO7GQi4yC1yeOSIBgPx74PgyIjKjH2ZX30IR5aV8zjm8UH1gviqjDN
 W6Ye+pdAZfrRLfJ63FqhOXd6PJvE2ezaMEACA2ptnnUAkQSsfxOd5YK/K9IYSnU9yP3FKzaIfM
 qeRD/ildAmp+nErvP6ABquGiHKqOEg2MS8++weTYnWk8cp/gV3jH1hUsVl4uVCDFFFa8h8KwH6
 fPU=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486912"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:31 +0800
IronPort-SDR: n8iysQxMAhoZRpIrMQc84NmWCFQuEJUrRykHqlT5MeHkTYHhfP7leHZK4aKeSyHyXKGMoUDmhx
 U6dEOrVgiAF/f7PBaUMpMxTpl2B+5M+tNksjDe9NLgWWLMt5thsPNuKhV72GLKhXBNb5SUaRJJ
 49NaagS56DK1IOEsw5ky+M3uKTPDFPbbPYCWFLWch6MvLwHmFqDBhmsLtp+vHwOlos19UOg3Gl
 Kz4m0G7eqNZEc2PeJrQ9j/e4Sh9nHLQTeepKXKKxwCAInoS/b3umhLNZxUz/eq/MmJN5FTm2Tg
 fX08HNF5JjtXqS66eJ+hzgbl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:48 -0700
IronPort-SDR: YEOvA2E4jKGth1Rk1dTwoj0VjY53bna5Yk2MtXRLXnGML5lbo6koZOMmn/8FTcprITRBWZnfqa
 x9B5noUDD3aBhckzYuvWTr3/ssAlJWRK1gDBy/OKp5IM7Ubrt1okuQjFFTqwKOu1EEBeeQ0yBD
 9CdJ7Wpv+pZ5XaS8ZpGGCIz/60geGhy+xpArOePcNLQsptKG5oKXE7f1uEI8xfvTQBff1Bcik/
 HJf8gOD6hASzEn9DlPjeEgNcIp/q88QbOJXIkjZg6yzjC+JBKbyj0Z6nmyG4sxsFqOIPvXF13U
 BtQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:42:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:50 -0700
Message-Id: <d5ca8cc30d7f4fb8eb91afa3d9875ff0197d29e2.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 23/28] target/riscv: Allow specifying number
 of MMU stages
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9aa6906acd..8b9871f9ea 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -330,7 +330,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
                                 int access_type, int mmu_idx,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -571,9 +571,10 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
     if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
-                             true)) {
+                             true, false)) {
         return -1;
     }
+
     return phys_addr;
 }
 
@@ -634,7 +635,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   __func__, address, access_type, mmu_idx);
 
     ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
-                               true);
+                               true, false);
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(*env->mstatus, MSTATUS_MPRV)) {
-- 
2.22.0



Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2539C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E7221848
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p1m1dVnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E7221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUK8t-0001eb-VD
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:02:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK3u-0005Im-Rz
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJvF-0004is-RA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJvE-0004TN-2p; Fri, 24 May 2019 19:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741704; x=1590277704;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=0AqygypHR+JHw9NAQNJbdu1CHPr7b0EA2J50hgECIkw=;
	b=p1m1dVnrVn7XKmTpwSORhZQBJPCsUvH5dQB1MlU7AVZ8f7ZVHXX7M2kH
	PDXzjK0y1QpuDmYa1p4kpoJ611eD5fOLr+44ssl05FNNhSIxd1SmBZeA5
	0Hqsn9GqI0l98nyFalWW8iG40Fxj6LQcWOkH1GrYh99CxeFSEefOZzjD6
	Ef7jZZcQ1+zuEk59FAQQAhIiNiQpqwqIpRKQh3BrEqBPeSgTxkfTG7TtY
	IHeTifGxW7gy33xFD7Ve7pf2/TWvCXgGRk8M5AovGixGGbbUvNY4gG9ER
	UITTHoPNlUYRLMtYPcWy0QMIg59+7LiE+AXk+BpyVoX2wRIh84glSnkEK A==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265031"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:23 +0800
IronPort-SDR: NtEimrKRotSjlMXp4p8vukcRBHmzYdhUVG6Ab5ALeGMT5Fg7rIQdW8fZNU2byn2sSXIhPHWpPg
	pJfyR5Ew6Ola7SqHSZ5YIvFycyu/Tg+n+Rhhcgqh6iZufo/TrEBxKLwO3lAiGteAQNhd3ecd4J
	WwtBLmujTtQBbOOzuNV/T53GS/wTHIafjP7QLPSqF/XphVLB/JVmP5D01Q3GxReft8QNraw1wJ
	FUusiAaf+VdERvqv3BOPwMKalx6wckwXqXO92sGBwayPtsFWC3gDpmSADCSVu1NUtfWnIaYnJK
	wkKjR+ZBhQrAW6BB0ShidiBG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:26:02 -0700
IronPort-SDR: qbXRtS/fOKPngHG/iCKeD9UAY6aB6SLE0nVG7ZpFz3xhxoNzB6nCJR1VSC9iI5xkOftXEjlhi0
	9ZlTOCkte4NTV5lUOXcVePcFAq3Pobudu6dIDzhuzw+P1DA3fAQ0MUYqDJ0Yr+JEghic9hA6Jc
	oYD1L2VdGiPDsCqgssYlW4EhOkCyT182j+mKpRKv84xKr8TMQyHQJ9uPAgGN26+iH94z28TOy2
	xjdEoPAoxbbcrQPgbSOgiPnanBcV5+0aeKcBJ03zlVicToHqrDyzK3tYw31OSoRthKygG/Cz5u
	GlU=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:48:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:28 -0700
Message-Id: <b14eea3d6e68bda71e3a00a4114c01fd1a475ada.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 20/23] target/riscv: Allow specifying number
 of MMU stages
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3c963d26bc..f57e49c973 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -273,7 +273,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
                                 int access_type, int mmu_idx,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -505,9 +505,10 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
     if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
-                             true)) {
+                             true, false)) {
         return -1;
     }
+
     return phys_addr;
 }
 
@@ -566,7 +567,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   __func__, address, access_type, mmu_idx);
 
     ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
-                               true);
+                               true, false);
 
     qemu_log_mask(CPU_LOG_MMU,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-- 
2.21.0



Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497DC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FE320840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PDmDfU5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FE320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNCL-00089k-6B
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsz-00054C-0T
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsv-0002XM-B9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsu-0002KN-4n; Fri, 07 Jun 2019 17:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944732; x=1591480732;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yfOrawReFfUJUNTNIv1wqu+JtyFGHtPJ0wV6mrKafaI=;
 b=PDmDfU5aPwgh6jLiyaCAj5AmBobTDlfJlxnXi3JqHh6qx0HocEiYZmZ1
 af/33sd5j6oxLEL0fmaChMEkSU9OZPH5aBsWOS+7bdvFPInkl89a7Fyl8
 OvjBFZpwgTA9akxlhdXk4twq4NZLLUGCPA1Yd8xMjDWJunhH6U7+Yl+JH
 qtqYtyNWFV80Z9QsFOvF+QxsnHj63ZpMW77GTaEjuSHEB1AGEuqHb1boB
 PqUHvsyZqw2o8hgn7GD3AztUYn1UNiwh6l+K9yUzGmzRn4B+1I1jKQ4GY
 +kBb+unEjW1d55gNH9vKKfTrUcszoWgLS1vE2KvOU11fWVYS/OGXoeMsZ Q==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059665"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:46 +0800
IronPort-SDR: uG6rXqOqDzUC62WpxU5jIuvAK7HHiApddtbsUirRID6Pja7I6ZeQ2iwqIYfWOo9XAMPZ/VLnXk
 m5QsRHRBaXPSm7NlPOC2ADi8q7ifvt3NPQJpGq6phFUwIO6QQFDnvEq4GjtlhaFbDqfJuWtmWK
 Vvjwyq6GpAbUrq+G73qkhjacylcN8/zj3+8yThwJnxXIDbWRm6cRDMBPFvYoRzcBGfuc8AMpvi
 npV85GfXpPYBXhGg8iT+Syuk2R9MhxxU1qpRWv2mb9CIlLTAQH9cQbumdfsZZ3CW4/VQ00/Ijt
 oGxT8JunsJFgNtqLV+65rfCI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:36:02 -0700
IronPort-SDR: 9WqUcSjLOPrI/OeEoUN+IFutjo+S6bmtohoVn98hakj/UeLotHZgJQhNzEEa7rPTKyavFBfQpo
 iEvFnKHW5lW5KrHW2JY9G99icfJjqo8lFD76qLUHEPZQuQ4UUKFltpInsNbUAf8xZupGtVoDJH
 DuM4byXURlkzL6JqYlgu4PsWMcbNmbnORHj52/fz8mHBiXjSCNNSdCDU56uG2MUKqaYKuJK/pJ
 987GQaEzev9H0TtJu8Z1NmcNTLJNJo3SWMYijLj9FVrnF99gsl15oQFh7Uw9ObaFZaHUytOF+Q
 atE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:58:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:36 -0700
Message-Id: <9c5428112ee1ecd12de27a0d95ff08f9f9feb428.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 24/27] target/riscv: Allow specifying number
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6cef78a2c7..6ff4272da2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -286,7 +286,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
                                 int access_type, int mmu_idx,
-                                bool first_stage)
+                                bool first_stage, bool two_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -518,9 +518,10 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
     if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
-                             true)) {
+                             true, false)) {
         return -1;
     }
+
     return phys_addr;
 }
 
@@ -579,7 +580,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   __func__, address, access_type, mmu_idx);
 
     ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
-                               true);
+                               true, false);
 
     qemu_log_mask(CPU_LOG_MMU,
                   "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-- 
2.21.0



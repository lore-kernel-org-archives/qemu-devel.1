Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF1C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB6621901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jHt7cfUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB6621901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqitx-0007CK-PZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitS-0005WQ-N1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitR-0007VX-Q5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44369)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitR-0007O1-Cu; Thu, 25 Jul 2019 14:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564080910; x=1595616910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J8T0lQMc2FRAyXgkjU5d+ot/WX4cUBxwxEksrJCagJ4=;
 b=jHt7cfUm+1yk1PugDpDIUDNa/2lM9+mEkG1QaBEhBQZfKcx1HO9yWtv+
 36NW0IKS7eQYdSwsbi4NMZQleaLTGdOU/lDpYXAQyRGnKa27/jzhImylY
 b8kFejV0EvJNLImNzvdOFiw+cIngxZ85q8bn3emybaDzVBdkjLsT0AI75
 TIVKY4r1I4DSxsSKPYzqtbu52ZLoSbM/VxkxnoFXUD8AfCLiDuol+VQgp
 WrvNDgWRl6H1InNlq4tzl0kfDUOo1BtRogLu3Wsbs+ZNr7R+bSZgqLsGq
 i/9jdVA0ajiqrrA2dxmqalIeGBekP0H9JW7nm79wttsjQq/O7zO5/9lQd Q==;
IronPort-SDR: 71hTaEGFFuU+BpYwUlDzKcBxHObRBhQVUFkmHbkk9zi6vTW2OmjtcDX0vMKGxaV6ANnCyjy4Ex
 tmRvWjQ18pCaGfhtQ+4Hbj84TsyVGhR/Jj6l4JLrrO/yRuaKa88F3Ussnze1kMeqMZ5WQGNKD5
 cFAVGV16YRLZbW2t7Q8ndmIUDGeIKy3kinUXdqth2op2jya90h16d4OzzMsM9Wg6Ax5WrcJPJK
 iCeJ9Py/hmRIgvCaXZaXkV6hQM8QzyCD3/8xHL9gQ/KdA6HgHtsqRrH6fsGUOFAKGIRHoOEJEB
 ROM=
X-IronPort-AV: E=Sophos;i="5.64,307,1559491200"; d="scan'208";a="118779519"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 02:55:07 +0800
IronPort-SDR: IpwUdr4GML4MzTbuEj0k2cmT6qgu+YfJDxtpUcQt9Huw6cHJuAw0BdnZKL2ZjLpbKlElyiC6Pd
 X+wijt+Tg5Dy8rl+zfVaE7NBORi5s5zzV/EcWuZANXuL4X5uaYyoMtpHKGxx66cYpcNraVDG8r
 RK00pywJ3oKepMd+s9At3KzRReEtHELI5+PmYCXS9hR4kDeAiovqi8qBK+H8LXlwfcIoWJa0+O
 Jz8faO3zzviDZl0DTiomZsKfExTHfgf3hAKwU5yCtgIlL4e8RYClN0/lumwb1le2vIfTpM+mLr
 3ltAGFssoUw4kxKhpGkTAA83
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 25 Jul 2019 11:53:16 -0700
IronPort-SDR: ZqW62Y69b3DfFOrJbpSw2klLuHuVLTWHlaZINBNtUy46898k4E9V1kOJcQoJS4rLVuUj3ruEvl
 hmLJAGThF73pgpRILcMgZcotDJlJa0toCKSvaaIvOBapDjqUjAszo+PIWGDaE4OJuLnwhBoWmQ
 AHMN+PfNIPMOd5Ph6hvgzdDv/O/iB23GECHikxdg0aCg6IM9RNtjr4hRjSk1lNEmOrkjn2NzE3
 t9B0RYlNESefB4myCU0CIk4+XJXU6TnQas0otpdFuDY076RR5KnpyU23II5cUk1ljBoP9vyu8k
 rkA=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Jul 2019 11:55:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 25 Jul 2019 11:52:01 -0700
Message-Id: <6a7d3b524e7c0a41ef232d9dc21d7c337b05b97d.1564080680.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564080680.git.alistair.francis@wdc.com>
References: <cover.1564080680.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH-4.2 v1 1/6] target/riscv: Don't set write
 permissions on dirty PTEs
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

Setting write permission on dirty PTEs results in userspace inside a
Hypervisor guest (VU) becoming corrupted. This appears to be becuase it
ends up with write permission in the second stage translation in cases
where we aren't doing a store.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e32b6126af..f027be7f16 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -340,10 +340,8 @@ restart:
             if ((pte & PTE_X)) {
                 *prot |= PAGE_EXEC;
             }
-            /* add write permission on stores or if the page is already dirty,
-               so that we TLB miss on later writes to update the dirty bit */
-            if ((pte & PTE_W) &&
-                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
+            /* add write permission on stores */
+            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
                 *prot |= PAGE_WRITE;
             }
             return TRANSLATE_SUCCESS;
-- 
2.22.0



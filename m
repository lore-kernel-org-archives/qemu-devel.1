Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A334AC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0E42067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JnJhv33w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0E42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbib-0006M9-J1
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57772)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhP-0005JE-NH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhO-0001sl-Mr
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhO-0001r8-DT; Tue, 30 Jul 2019 19:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564529911; x=1596065911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TzSLaqGd1ijZpKYVZGyg4YDJEHLu4T6oDeS8B/digZY=;
 b=JnJhv33wo2q+MvYxc42I3et9SWKs1UP8Ey5K86LU0xEKHM7CUHYYHN/X
 gfgfDySa//bEE/tkSRteguuOq3PDa8e9/WUkDxitt23xKD5gTzXaknqt8
 SB0EI3P78kAHvrxk/8Y7WfzW8Yx5IB/Sohb1xeu0n7ebM7g6+bssUMXYl
 RFVcCKntGU6h1vIVSvzLrPtp04vXdyAbv5BCtKlYekN42JH7t2WcBNq+V
 aj373e4qNqlv+NEeRogAxowFwS8snm89pqRBr1tBqgi3EzPCRTKi+Ishe
 veROGgjAkOZuxJHI18e4EZZ1nNJMoVos3LOaLOuDlyc1Z0q4E6LfKOocR Q==;
IronPort-SDR: +z5KeEronAc9zV9wGgxQ2fn5sUxKOJ8cPQQjh9l9LyLfKLn51FgEbspg+tQlw+sRUE5t06BQff
 F2OxtqcFZZR7LrGRQke8JHLx5YJi7OtVNGF1cr9VBSUPXBRQzpX2aXPImJGB64iLr4c2EfjcPX
 gMog6Gaifv69wSFMnXEq/XVWnKawS7mfypn098Wt4gzlUBQ274g8n+Iff74egrS0wTF9wBYI9d
 Rz43Z3KEIFd81M5kZm9EYr59tFJz0ixwu+HPuD8wnoW4dP+eNv+VPpUuHjEyQ13M2vAIoCm99p
 +n4=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; d="scan'208";a="116132618"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 07:38:27 +0800
IronPort-SDR: 20B4XNCxalkYbjm2YTXoAa/SILbAcDi7UmYdtD3JbBlM/wmYL24lJFIczfquqgHAhZfDtX8Zb/
 jjZsbvuxjgZGuESEyzRPfweivH7wIyKf0NV6J0u3pEFaRr82nmo9yDCpry9s+r9gXhQWHLQvu0
 N9zwCV5iQXh7ROgp1dnzPsOrM8BEg+/tB6G7PSTaKrIthZSL7zbe9wMvriycQg5OwMSgkGDGoi
 +Ihh4laNS3cWCZsjl+n2HNltYWEKNwtQ2PW1adE1c7xurkyXFvr2VNfZur2g6ogLlQyFpkrf0G
 iKbQSJ7dBDSENoAfQOyd4vM8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 30 Jul 2019 16:36:28 -0700
IronPort-SDR: QHc8BU6VDFbEpaT4RGNLfWu7UO4GtqSGxx1ouVrcfMbLaZbnw5CZ7FhRr4MiuaWAt5fe7ikDDc
 9o1Kv3A6i+eyk2mr3C9vXv1QFp2+FmFOi+R820HfyVzNWfO5LqwZq5fhjSOk21OLuTgEh3vzhb
 90vucpeCHd2fZ9ubrRezOs1H3DW2Rvh4FYZBOvM2Vly8aIuSxaAWxQvPxP9NTU3eX00DSofIgb
 x6wQLzYq5OA+gbS2Xu37mgLKldSXnRkR2zjkBJ9MX227YxDepAdM3rs7s5c+q7xQIDgPMiNFMC
 EXE=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Jul 2019 16:38:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 30 Jul 2019 16:35:19 -0700
Message-Id: <868a01ec5dd656f26ebb06d0b4313452f66206e3.1564529681.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564529681.git.alistair.francis@wdc.com>
References: <cover.1564529681.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH-4.2 v2 1/5] target/riscv: Don't set write
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
Hypervisor guest (VU) becoming corrupted. This appears to be because it
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



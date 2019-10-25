Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F73CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD74214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QAFmJwA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD74214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOA4y-00052y-Pe
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO903-00046d-7E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO902-0003s7-4P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO901-0003r5-T1; Fri, 25 Oct 2019 19:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046085; x=1603582085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qq3BN6rY7UmBDtE9mG6vAdLDQL46C93+/Qlv2qhxHJg=;
 b=QAFmJwA9QODJRxgEycv/u0CsMvbonvFR07igO47CTAOa6aIBQoZLDzKj
 n7+YmkZmYUIq96/HqyjClVPj68964torxlMNP4K+GTl736ej9JnXjqDtM
 1Nqbf1LpWC7zv0GuLeS3j61fFGyqW3q/1yc7R4Eq6IAjOl6A94b23+cSo
 mIB1SKZ97zf+hOsx7UKP1ABWTkqpTsplSJ+yPOi3WpjV55NGp9Q4pWqUL
 iwUlwC19sw+5+KMrPqldSvxlWFggMwKkLxktZuTun2MsUhbbCowFQxkKk
 gFymXE+EMZvdDYOcAiTkh4KOxhGl2nFZynEptSxW/IzBT8ragfUaBCrJA A==;
IronPort-SDR: sGEVy0jQC/WDyuTxm7D3T9uQiZmWeB7Erb6Rot7BedHq/9lUKK7Kpj0iBiONil4pvgeKhZgeC7
 IuPKOKGc79kMRlg618/3QJsyJ79Coue25EM37FEF+aOFJDWjQlQydtCEgeVt5TpL8Znhs6AX2D
 qRul50Zb7ojHAl6J0q85+P8xHtPac1Ohvw9B2jRZt7K4oG/GUE4GwVsG5vFdEXgM/H4ZTuYBpg
 //DpiZTlw2wLdZ4PXaD+BwruwRYS3qhP417x8mYmaRepUbxf10IZgGsnPHl2FDGsGbTQDuEFcG
 J5A=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520354"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:05 +0800
IronPort-SDR: kwetnRu9aD3e+ay57fbishlyAfyh3WzQPcIKso8w5KBp4DsK7KE4KqJI8EU1x95C0zkBIneSDt
 5d2j9157uuNL59g/NK46T4fJPsa3OVPMIfItIOpdvY4UO0pBIJ48nvnSPfhGadunKTBPJrrs0+
 VtFgEZHy/+rYXiCF1GPvaJaOoqEWqOAYUW8tMCcCvbM1ylbBDLWdciJgTlZP0CoYl/cFLzwx37
 4+9hWJeIgm74MrKNlz4G3J0ZLEM0mAf6a1CDMky9l8mRve5yKlvMnBYn3AQfYlXJgCyLMLkU2z
 82XJJVDFYwhRizwbQVBWJFnq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:31 -0700
IronPort-SDR: RyL78MHZk9qyGuMPRju9DLHoPADQJis7Spd8vMTWdsIHFez2A8UVQfsPI9PfufFG7bsyJ8ZWto
 H1JfNAIQnxtzIc8XgapqCSeKb82GIYfKYflEFinQFeA2K2JziD8FPoWvCls1C6xJZ2FUn3hxw1
 1K14Bba8K8DZvi5GpFjByJ2AaRbLH4J4P/cpRtr7dO6+4IefZlcf46VfVLyNDSeYSURpWsjC9D
 5bTLGIQ4j2VFmeDUNkfniP/G6RmwKhYfVlUo0BngWF9WmGa6wzpnmpRs27UaPV4PWKtDceGCk1
 4QQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 01/27] target/riscv: Don't set write permissions on dirty
 PTEs
Date: Fri, 25 Oct 2019 16:23:10 -0700
Message-Id: <092c283c3e57b668490e150e8799de28171d6972.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
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

Setting write permission on dirty PTEs results in userspace inside a
Hypervisor guest (VU) becoming corrupted. This appears to be because it
ends up with write permission in the second stage translation in cases
where we aren't doing a store.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 target/riscv/cpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0e1a4d91fc..31f553efb9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -344,10 +344,8 @@ restart:
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
2.23.0



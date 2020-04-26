Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3DBC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D615E206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h8H24tid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSk91-0006RK-No
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7t-0004MK-T6
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7s-0004GP-4r
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7r-00044e-84; Sun, 26 Apr 2020 12:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918447; x=1619454447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MpFVhcEu4J169WZoNIifAq8VxH2DNU9wLFGwC30GIIM=;
 b=h8H24tidxCWuKAOvu1v+3xYt8cOrMILRaOU2vGFbHoBTsb2cCUA0ToEr
 BxLCPj3WyaYQ0O7X3wKN1jnBZ9YGsjOU1UpD1PZrOO1hRif7ZuuyA9jyU
 y964nh+uVV9dY5VVkzke2Gk9rVNVBZOFjujt+gnzHIqZFpupadhtbRIWV
 14ruQyMvUwimVbac5W8OvjMFBsTJ15oFW1xnlMUWmdX3HRkCACG9ngs7G
 0no7oN2L+0Zt4+4uRTuWobIuYsUoLl3kiSwa0dCcBkcyEs6zS1bh6a9L3
 b99gcsxkm/bHGmv35Zv7Oq7Z2AD6ASvjX14n4jq9d0TSYyJrBQeKtClKU g==;
IronPort-SDR: 3qrxOErDbmD/qPf7l2boHNqicUhpULpuzUSUyj7sHrC6YKY3aq5IT9r3KmVnAFFCqkxqCsUOR3
 D9fAMI4D6YEgsKwQAUj3Jt00F8lPCA05TIfKXTDl1QYTsP+sQHZ8xUNqVUi2I8JJFxj9D8RatU
 DutHQqYC7snqKSgqVFJnmMoBh31gs+4TGI8ZeVCXQ+rejj+Ld6CKzmR2oQKypz6HK80FEcrDbu
 ZNuBFi2nRp/P+z06trrTsxWXzXUZRamzXMb+JTKq7Hti0TLZGT14XCkfoafvW14RXtIROYC9W9
 BiQ=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193235"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:23 +0800
IronPort-SDR: ZFfVokcthCJu2+Ighx9T2FcOCMvjqiS8OgfK8yewhqrMhwBgaSZ/ZM4FhKbdPfY7XKAq+pQ4Dy
 VQP7SYpY4gWZuxBs5MfyLA5DCE8xTOuzY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:17:34 -0700
IronPort-SDR: T9xmxh18iyx9qAJVVXbPVqJq0eILJKO1tokq25yXY+d6QWCDo471crfyrf4iaIQjesscY91H5K
 9ow8Q3jqC/Ug==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 01/15] target/riscv: Set access as data_load when
 validating stage-2 PTEs
Date: Sun, 26 Apr 2020 09:19:13 -0700
Message-Id: <39013fc4929146e1d64b107c4e1be1801d51adcc.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bc80aa87cf..ed64190386 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -456,7 +456,7 @@ restart:
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
+            get_physical_address(env, &vbase, &vbase_prot, base, MMU_DATA_LOAD,
                                  mmu_idx, false, true);
 
             pte_addr = vbase + idx * ptesize;
-- 
2.26.2



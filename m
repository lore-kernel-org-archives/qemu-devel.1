Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A02C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3B02133F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LWhzaOb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3B02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BSf-0003mr-0b
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQr-0001bj-Es
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQq-00004u-0r
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQp-0008VZ-KE; Fri, 23 Aug 2019 11:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566573891; x=1598109891;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dNPHnBonHYmj24fakuU63K2w0RapOswOQO6wbRLxGds=;
 b=LWhzaOb/2uJdA5W3U9VCxeV+szHwhduyvwc0gkRkjMZmsWuRSr0y6M6T
 XaYmxX70432N+J7SVCVOQvOdgTrNB6maC/bvukXE784fPB6gohVm1y56N
 Kj5ggCfPcXwp8DUp+M5meIjZv29dok6zDKxaXIgnxNiizIqwhSZdpNwNf
 bAlbaBZXLqmKFFCDNWqChMUnFoIuMHuaiIeTWRTkIRFCrtvVZ/YTVKFSc
 5nxGDZvvbeXVQeLrMUFy9wYZbj8dCVaC7WiuGDjnVFEvCuaISUUSuMjWr
 ps7CWxaEvL72j7tsqXu8l+8JYBq52MTst5Wt5CVZOvt9bc+aP/QnvGV8f A==;
IronPort-SDR: ZWxp4ADug0MKqwU3hTcGLZ0lWp4M9GyEmhOgLXEPObRmUKCw2wXaidrF3cIzDfaqnp+An5W0L2
 LKP/IbzEA9hNVL3uz2izUzogeBCtnQJxnyhf9Q53RHQjKH9Quu+mxpRzjS3mqWTcxqSKfNm61e
 0DUcXAc32wWzunM8P5LXvJn/mDNogL9l1jozq62pxzMM8/nXPicFnZW2XJvkAtzeo1iYd2gLJe
 Nl249gtDRtsS14pYX1qIFrOOkN9PM7F6Q1NB1fubYkCnMbZku9wEPEBdrCBJGLBRMzn+6OfdJK
 hk0=
X-IronPort-AV: E=Sophos;i="5.64,421,1559491200"; d="scan'208";a="121112422"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 23:24:49 +0800
IronPort-SDR: molqb5i362KXk2lCrBNIGGyW2LmKx+dLKSYHvySIflLfVPhng1ENWbJcxjc2vdd+KwqJG7Z6L/
 I4JTHM/MmciFGJdy2Z/ELIZVyRK7FCYAQcWB5A34eXMC/sZg2msZImWoC/Pz26z6j84i0ZrcMW
 fPVXhuUa8Hnnxh9y6367u1D3RXEF/LD5to4kxeoUmKYVvNYzbBjK/53sFHwLoPmYrRoVTfEh2F
 G6xHYeTgd8eRhq1i/gwoBxSbAGBMPdRRMv/vyR+iqvsSOsvRcDJTIVSRBzbmVS4LmvNu5SCiGr
 UjNNsppLEoNyI0QpzFeis4jM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:22:06 -0700
IronPort-SDR: qwiURRZn8R6rwP3yyifFkFWs31Dq7fcZ7zXXd0CS1fWtCnqkTH2LClm1tjgDmzZzKEFayEJtET
 HA2KNHykTj6Mq0yM9G1KsLPWTMZ8/a4MBFqBLDUJVN9fPPpsSpcQzrEKoKjMaXQTxOJNi/crLM
 ko8FdMXigcYEzF7fhRUlc0hCwRKsn7FlHma6Dqly2iCkdrRV1ZfRGn+JmLIcPZhR/dEhfEfOVS
 HrR/Hi4oS1gNWY7Cjt1GHtHEny/wYfaXuiYOyEJZ0qaBLYQpL935Dxp3x4p4KglXNgp1bfA5Fv
 mX8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 08:24:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 08:21:09 -0700
Message-Id: <6532e1a327feada5bbd0631ed6ea72ec32528936.1566573576.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566573576.git.alistair.francis@wdc.com>
References: <cover.1566573576.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v4 1/7] target/riscv: Don't set write
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com
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



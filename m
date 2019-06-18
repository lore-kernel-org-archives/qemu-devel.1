Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9657C46477
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D12C2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ASPNVYy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D12C2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd36r-0003lw-TY
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd307-0006cG-Py
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd306-0008SK-OU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd306-0008QF-Bs; Mon, 17 Jun 2019 21:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821610; x=1592357610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M1eC63nLbKo5deTZERedixlrYYiXU7yvY+1DteOQC7U=;
 b=ASPNVYy6lMfsDq8k6wCpWFo0QGPoOvbr1Bsu3mjzWk/DcjubxvoH5RXR
 bZrYr+yip2vn8aR2xtXiSxXd/i/wmVQRo+hpjL7NfcCTYrNkH3wpxPIkR
 j+LhCeHK531arcyVayM8Z6J120E16HMNQyLaDHZwbuEvm/4pAmO31a2+a
 clKBfEUI2xeNnkuD2qPYlcwM/T1E351qVH8DO9KsTW/SngI0NdZbsEIla
 3uokkyjmn716ML9RwPjtE6y6d19WhSAxnRLMCml36PRQntyz1TsgNGIax
 ivfJwo31R0Yb3ZQ1sm2mwnLgg9QnEBccuJrawTgHTGFtWAOksKWPryHuq Q==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="115717022"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:29 +0800
IronPort-SDR: Ofxj6kIPdmhmNMpf2yZrgoiWwwj/W/JIsJVdv/jUEbHIB573cWbIztjHB2sZbFk660MkSmFvem
 2W0w0YI51ZPyxbor8QPjJ9bysAEpea0pzTU+imcJKV50XNpTxPXTMsK/8KyQDUw6tNF7ny2BOK
 jfy4pI3LfCHsTHHROQqRexGUpB8t8sM+JnB5l4BqJgI9OsWf6D+iaKlzcXoOzjPl3yuejv9wKl
 p0Jb4ZyAEz0yMWNZPR9olslRPaWw85xC9HMK/z3e1qczqXdM7Eo83DmSIzvH1ndAx/kFQwNIfQ
 ltlQ9EgKAWh1ZVXYWRSskN1n
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 18:33:01 -0700
IronPort-SDR: 6uJu5WczK5Mj6IXKS8b+FVfSFKlHedeA+FruTcYD+I1m3OiY6xBoM2gwJYp0NrGqSSzkc6ICjc
 17/iDvAEdIBCf01S6Z41iJArsRsshnYFh0f6iHQGktjSYqJuicR1DhcvzUCtG36iEU0tq1hYP9
 XuXfbwJeHLjnOEiAl2xticJwQZhB+oYK5b6Tk1YPTrxIBQ3jiLUP4mU/rb4/+tty0eqPpSyV8W
 IBfcU1QrbwHj2mnuklsxcbXR0APcCPdR30InCa0MJGa/wqDweUoyjh1QUEKbTpQO+j86/GgnAD
 A+Q=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 18:33:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:08 -0700
Message-Id: <b9cb270c4356301ca15d6fec3f651da64beb57d3.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 3/9] target/riscv: Comment in the
 mcountinhibit CSR
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

Add a comment for the new mcountinhibit which conflicts with the
CSR_MUCOUNTEREN from version 1.09.1. This can be updated when we remove
1.09.1.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 47450a3cdb..11f971ad5d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -136,6 +136,7 @@
 #define CSR_MCOUNTEREN      0x306
 
 /* Legacy Counter Setup (priv v1.9.1) */
+/* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
 #define CSR_MUCOUNTEREN     0x320
 #define CSR_MSCOUNTEREN     0x321
 #define CSR_MHCOUNTEREN     0x322
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c67d29e206..437387fd28 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -461,18 +461,20 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     *val = env->mcounteren;
     return 0;
 }
 
+/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+    if (env->priv_ver > PRIV_VERSION_1_09_1 && env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     env->mcounteren = val;
-- 
2.22.0



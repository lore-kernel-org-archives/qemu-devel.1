Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB06C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27BD21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dOBQgAVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27BD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BT6-00044j-59
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQz-0001kR-SS
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQy-0000BA-Sy
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQy-00006k-ES; Fri, 23 Aug 2019 11:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566573900; x=1598109900;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vHb0pnbRKCCc9XGl9i+ecqnjlhPO6xUM1eeCtHYaGKg=;
 b=dOBQgAVDXIBFclyVf0I1qbMHe/r0wgeyE0+s511FFcZpYpezGAiAueTr
 RSA05m6U4bMmKXxiMW7oJG45N1sMLGYmJkX5emsPi08YzMD8wgNWE7mvc
 VSo31qQocfnDXbAH51ptuEgxAgPvxKpRqQUByZpGUGEgBemh59DrF0smR
 Jy9gmIgt4YwP2+J1xNWYWflkz3d+bB6rlKYT7W7Gw0o+80azMQX3TeWRj
 JbfWdhCkTirlwzgzAYDHQ8OIvTD/PSkk06r1YKfmx1hcZGw7bW3MpAVCI
 axSNE1qvGQ/AD2ydYQMlMUwpealH4gzxNdBj86lvQoZZHAlRtOzsELhAw g==;
IronPort-SDR: uqizzG03OH1FlwMP2RMY29udxUqwAQmH1oIrP6cmpdllBYTxSnG90LqDiP9c+E5NZn2waQ0uWN
 Nev2Y0OBO1tyfrdWLIlQvl9mb02petf5Ix4WIfciZfQ6fwweYIpzrZk4/Cy1LI03jkK3xFfJ6p
 szq0DTheqpvUxOAT/MCr6p7h4OL5nV/iIAn0IJMWWb6iRaqRCd1UO8U++ntHJAv7mrDzZzlwSF
 /EjZoE5mZ0ihPv9caJhMiWgGAKivTTu5l9WtjqZivArAtibHufX/gH8kkT/mgwRPLG2co+gjJI
 ji4=
X-IronPort-AV: E=Sophos;i="5.64,421,1559491200"; d="scan'208";a="121112433"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 23:25:00 +0800
IronPort-SDR: xaWy9nvF0boztDZHNlIMmLuqxamjqjn2otpwSfDvFpKZzm0iqH0Bxc4UCnK4jyeQ6qhzCUw1x7
 ZofrIeIAJQQXF89GO6Ur0YKHrqHvcaWOi+QwsdMldXLoi+kbG/eAzw3O7TxzzLVmri1prXnuJI
 NYI3z49gb1slrrOSwoSgD1ubW2lnVc7nR7++geffDQsjACe2K4DRrvKJgT/AGtifSg6gSBkddh
 5RhJkOl+hcrLdcVNtr0XfL9ilW5jZ9DegBJljE6/PU/S6DROo51zfVC0/x7psjhBERnF/Pkdfg
 NRCrFwFfS007y2t7e1/OF/Tb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:22:17 -0700
IronPort-SDR: qRhFM2xJcFBWr4wozziC5WSspFxFvYNvKOZOHKVn9KQcQRJaLe/ttfGaihiJupp4d7dQg/7HQE
 xxt9x3jIR5sccJl4Y8+MdyIroB0NSi0hWMfGxwopUb7Kc5qoD2e7rpYy/iqW3Sc7V9G0gnR4ZS
 g/XBh/MTneNfwLxNvxNN/L3tCiOKJj5JcYCWuzr0/oSBHxvY0D098eMJ5hwBkp6h/VtusamQGt
 UhArcHOIIIR0OS3bkC9wuT6qzk6ZQ/NQXgwbCQP8ii8gelgtztGC3KSjVaTDkPWXx5FYRRMMNm
 dWg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 08:25:00 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 08:21:19 -0700
Message-Id: <2101ad1b795800a6f7cbf52d47de5cb0e86c568a.1566573576.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566573576.git.alistair.francis@wdc.com>
References: <cover.1566573576.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v4 5/7] target/riscv: Use both register name
 and ABI name
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

From: Atish Patra <atish.patra@wdc.com>

Use both the generic register name and ABI name for the general purpose
registers and floating point registers.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 target/riscv/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6d52f97d7c..f13e298a36 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -34,17 +34,20 @@
 static const char riscv_exts[26] = "IEMAFDQCLBJTPVNSUHKORWXYZG";
 
 const char * const riscv_int_regnames[] = {
-  "zero", "ra", "sp",  "gp",  "tp", "t0", "t1", "t2",
-  "s0",   "s1", "a0",  "a1",  "a2", "a3", "a4", "a5",
-  "a6",   "a7", "s2",  "s3",  "s4", "s5", "s6", "s7",
-  "s8",   "s9", "s10", "s11", "t3", "t4", "t5", "t6"
+  "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
+  "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
+  "x14/a4",  "x15/a5", "x16/a6", "x17/a7", "x18/s2", "x19/s3",  "x20/s4",
+  "x21/s5",  "x22/s6", "x23/s7", "x24/s8", "x25/s9", "x26/s10", "x27/s11",
+  "x28/t3",  "x29/t4", "x30/t5", "x31/t6"
 };
 
 const char * const riscv_fpr_regnames[] = {
-  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
-  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
-  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
-  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
+  "f0/ft0",   "f1/ft1",  "f2/ft2",   "f3/ft3",   "f4/ft4",  "f5/ft5",
+  "f6/ft6",   "f7/ft7",  "f8/fs0",   "f9/fs1",   "f10/fa0", "f11/fa1",
+  "f12/fa2",  "f13/fa3", "f14/fa4",  "f15/fa5",  "f16/fa6", "f17/fa7",
+  "f18/fs2",  "f19/fs3", "f20/fs4",  "f21/fs5",  "f22/fs6", "f23/fs7",
+  "f24/fs8",  "f25/fs9", "f26/fs10", "f27/fs11", "f28/ft8", "f29/ft9",
+  "f30/ft10", "f31/ft11"
 };
 
 const char * const riscv_excp_names[] = {
-- 
2.22.0



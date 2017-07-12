Received: from eggs.gnu.org ([2001:4830:134:3::10]:38046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dVI4G-0004n3-AH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dVI48-0006lC-Cc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:52:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <j.pelczar@samsung.com>)
	id 1dVI48-0006iA-6v
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:52:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OSZ00F4JD7GB4A0@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:52:28 +0100 (BST)
Received: from eusmges5.samsung.com (unknown [203.254.199.245])
	by	eucas1p2.samsung.com (KnoxPortal) with ESMTP
	id	20170712135227eucas1p2f10b52b5e3ca9f0b52bc881ec8640ef9~QmZaSM7tD3095930959eucas1p2y
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:52:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179])
	by	eucas1p1.samsung.com (KnoxPortal) with ESMTP
	id	20170712135227eucas1p1d5baf43182869329c6dd282e52143444~QmZZm-NzB0032900329eucas1p1b
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:52:27 +0000 (GMT)
Received: from AMDN1843 ([106.120.52.68])
	by eusync3.samsung.com (Oracle	Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with	ESMTPA id <0OSZ009T0D766M00@eusync3.samsung.com> for
	qemu-devel@nongnu.org;	Wed, 12 Jul 2017 14:52:27 +0100 (BST)
From: Jaroslaw Pelczar <j.pelczar@samsung.com>
Date: Wed, 12 Jul 2017 15:52:18 +0200
Message-id: <002201d2fb16$189c1460$49d43d20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: pl
References: <CGME20170712135227eucas1p1d5baf43182869329c6dd282e52143444@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH 1/1] tcg/tci: Remove unnecessary TODO() for
 INDEX_op_bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Running Ubuntu with systemd on AArch64 Cortex-A53 and qemu is compiled
with

./configure --target-list=aarch64-softmmu --enable-tcg-interpreter

System gives the following log:

Welcome to Ubuntu 16.04.1 LTS!

systemd[1]: Set hostname to <localhost.localdomain>.
TODO (...)/qemu/tcg/tci.c:1049: tcg_qemu_tb_exec()
(...)/qemu/tcg/tci.c:1049: tcg fatal error
Aborted (core dumped)

After investigation it turns out that TCG generates bswap16_i64
opcode, which looks fine in the implementation.

Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
---
 tcg/tci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 4bdc645..f39bfb9 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -1046,7 +1046,6 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t
*tb_ptr)
             break;
 #if TCG_TARGET_HAS_bswap16_i64
         case INDEX_op_bswap16_i64:
-            TODO();
             t0 = *tb_ptr++;
             t1 = tci_read_r16(&tb_ptr);
             tci_write_reg64(t0, bswap16(t1));
-- 
2.7.4

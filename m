Received: from eggs.gnu.org ([2001:4830:134:3::10]:36762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dVI1I-0000u0-Gu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dVI1D-0004sY-G5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:49:36 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:63942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <j.pelczar@samsung.com>)
	id 1dVI1D-0004s4-7P
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:49:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OSZ001LGD2DAG90@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:49:25 +0100 (BST)
Received: from eusmges1.samsung.com (unknown [203.254.199.239])
	by	eucas1p2.samsung.com (KnoxPortal) with ESMTP
	id	20170712134925eucas1p2f3355358afcef3c9257cfeca82bc62d6~QmWwHspeB1005510055eucas1p2E
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:49:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180])
	by	eucas1p1.samsung.com (KnoxPortal) with ESMTP
	id	20170712134924eucas1p128160f1573036dd5293f9167e190e9f8~QmWvdvYKJ0189401894eucas1p1B
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:49:24 +0000 (GMT)
Received: from AMDN1843 ([106.120.52.68])
	by eusync4.samsung.com (Oracle	Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with	ESMTPA id <0OSZ009APD2BQXC0@eusync4.samsung.com> for
	qemu-devel@nongnu.org;	Wed, 12 Jul 2017 14:49:23 +0100 (BST)
From: Jaroslaw Pelczar <j.pelczar@samsung.com>
Date: Wed, 12 Jul 2017 15:49:22 +0200
Message-id: <001d01d2fb15$ab737040$025a50c0$@samsung.com>
MIME-version: 1.0
Content-language: pl
References: <CGME20170712134924eucas1p128160f1573036dd5293f9167e190e9f8@eucas1p1.samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

 

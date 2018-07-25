Received: from eggs.gnu.org ([2001:4830:134:3::10]:39834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fiEmj-0000rD-6d
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fiEmg-0006bo-6i
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:04:37 -0400
Received: from mail-by2nam05on0620.outbound.protection.outlook.com
	([2a01:111:f400:fe52::620]:61439
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1fiEme-0006Y0-CG
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 04:04:34 -0400
From: Sai Pavan Boddu <saipava@xilinx.com>
Date: Wed, 25 Jul 2018 08:04:07 +0000
Message-ID: <MWHPR02MB247893FCAFB6011E0CB1AACBCA540@MWHPR02MB2478.namprd02.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] tb_flush during softreset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Edgar Iglesias <edgari@xilinx.com>

Hi,

We are seeing issue when fetching tb cache, any suggestions for debug would=
 be helpful.

Issue: Post soft reset of the core, bootloader(running over different cpu) =
reloads the program memory and releases the reset. At that point CPU crashe=
s after first tb cache fetch.

Note: cpu's have mmu disabled. So no tlb_flush_pages are called.

Question: Is tb_flush called when bootloader has written to program memory =
of the target cpu ?

Thanks & Regards,
Sai Pavan

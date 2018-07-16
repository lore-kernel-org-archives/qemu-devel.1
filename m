Received: from eggs.gnu.org ([2001:4830:134:3::10]:55145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey7w-0001EB-3x
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey7t-0006zr-2Q
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey7s-0006yo-PM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:40:56 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:25 +0300
Message-Id: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH 00/13] Misc fixes for pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

Hi,
Please review some changes i've made for pvrdma device.

Thanks,
Yuval

[Qemu-devel] [PATCH 01/13] hw/rdma: Make distinction between device init and start
[Qemu-devel] [PATCH 02/13] hw/pvrdma: Bugfix - provide the correct attr_mask to
[Qemu-devel] [PATCH 03/13] hw/rdma: Modify debug macros
[Qemu-devel] [PATCH 04/13] hw/pvrdma: Clean CQE before use
[Qemu-devel] [PATCH 05/13] hw/pvrdma: Make default pkey 0xFFFF
[Qemu-devel] [PATCH 06/13] hw/rdma: Get rid of unneeded structure
[Qemu-devel] [PATCH 07/13] hw/rdma: Do not allocate memory for non-dma MR
[Qemu-devel] [PATCH 08/13] hw/rdma: Reorder resource cleanup
[Qemu-devel] [PATCH 09/13] hw/pvrdma: Cosmetic change - indent right
[Qemu-devel] [PATCH 10/13] hw/rdma: Cosmetic change - move to generic function
[Qemu-devel] [PATCH 11/13] hw/rdma: Print backend QP number in hex format
[Qemu-devel] [PATCH 12/13] hw/rdma: Bugfix: Support non-aligned buffers
[Qemu-devel] [PATCH 13/13] hw/rdma: Save pci dev in backend_dev

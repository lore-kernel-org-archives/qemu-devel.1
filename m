Received: from eggs.gnu.org ([2001:4830:134:3::10]:48339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyMV2-0004MH-97
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyMUz-0005ES-4T
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:00:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eyMUy-0005E0-PB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 15:00:41 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 20 Mar 2018 21:00:21 +0200
Message-Id: <20180320190023.24077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] ihw/rdma: Implementation of Query QP verb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, qemu-devel@nongnu.org

Please review implementation of Query QP verb which is needed by some RDMA
applications.

Patch #1: Implementation in rdma backend layer
Patch #2: Add support to pvrdma device

v0 -> v1:
	* Split to two patches, one for rdma and one for pvrdma

[PATCH v1 1/2] hw/rdma: Add Query QP operation
[PATCH v1 2/2] hw/rdma: Add support for Query QP verb to pvrdma

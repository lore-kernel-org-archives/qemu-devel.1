Received: from eggs.gnu.org ([2001:4830:134:3::10]:51952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1eTNGk-0006E9-KJ
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 02:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1eTNGi-0001Xm-16
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 02:33:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:27716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@intel.com>) id 1eTNGh-0001W7-Od
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 02:33:51 -0500
Message-ID: <1514187226.13662.28.camel@intel.com>
From: He Junyan <junyan.he@intel.com>
Date: Mon, 25 Dec 2017 15:33:46 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Some question about savem/qcow2 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hi all:

I am now focusing on snapshot optimization for Intel NVDimm kind
memory. Different from the normal memory, the NVDimm may be 128G, 256G
or even more for just one guest, and its speed is slower than the
normal memory. So sometimes it may take several minutes to complete
just one snapshot saving. Even with compression enabled, the snapshot
point may consume more than 30G disk space. 
We decide to add incremental kind snapshot saving to resolve this. Just
store difference between snapshot points to save time and disk space.
But the current snapshot/save_vm framework seems not to support this.
We need to add snapshot dependency and extra operations when we LOAD
and DELETE the snapshot point.
Is that possible to modify the savevm framework and add some
incremental snapshot support to QCOW2 format?

Thanks

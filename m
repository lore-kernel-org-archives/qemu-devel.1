Received: from eggs.gnu.org ([2001:4830:134:3::10]:44021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fZz5q-0004BP-B0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fZz5n-00088S-6X
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:42:14 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com
	([40.107.0.100]:27607
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fZz5m-000855-Hb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:42:11 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 16:41:54 +0300
Message-Id: <20180702134156.13404-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] hyperv: ensure VP index equal to QEMU
 cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

Make sure QEMU owns the VP index (which is the number used to identify
the vCPU in Hyper-V) and make it equal to QEMU cpu_index.

Roman Kagan (2):
  hyperv: rename vcpu_id to vp_index
  hyperv: ensure VP index equal to QEMU cpu_index

---
For the reference, all of the Hyper-V / VMBus stuff can be found at
https://src.openvz.org/scm/up/qemu

 target/i386/hyperv.h     |  7 ++++--
 target/i386/kvm_i386.h   |  2 ++
 hw/i386/pc.c             |  5 +++++
 hw/misc/hyperv_testdev.c | 16 +++++++-------
 target/i386/hyperv.c     | 16 +++++++++++---
 target/i386/kvm-stub.c   |  5 +++++
 target/i386/kvm.c        | 47 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+), 13 deletions(-)

-- 
2.17.1

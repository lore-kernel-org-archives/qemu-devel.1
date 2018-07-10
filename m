Received: from eggs.gnu.org ([2001:4830:134:3::10]:46331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fcuuf-0002so-CA
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fcuuc-0005nP-37
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:50:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fcuub-0005iP-Uj
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:50:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 10 Jul 2018 16:50:35 +0100
Message-Id: <20180710155037.16834-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-scsi: fix hotplug ->reset() vs
 event race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The virtio-scsi command virtqueues run during hotplug.  This creates the
possibility of race conditions since the guest can submit commands while the
monitor is performing hotplug.

See Patch 2 for a fix for the ->reset() vs event race condition that Zhengui Li
encountered.

Zhengui Li: Sorry it took me so long to look into this.  Please let me know if
this fixes the issue you are seeing.  Thanks!

Stefan Hajnoczi (2):
  qdev: add HotplugHandler->post_plug() callback
  virtio-scsi: fix hotplug ->reset() vs event race

 include/hw/hotplug.h  | 12 ++++++++++++
 hw/core/hotplug.c     | 11 +++++++++++
 hw/core/qdev.c        |  7 +++++++
 hw/scsi/virtio-scsi.c | 11 ++++++++++-
 4 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.17.1

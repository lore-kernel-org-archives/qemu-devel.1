Received: from eggs.gnu.org ([2001:4830:134:3::10]:34249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7Rb-0007TH-WB
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7RX-0003Am-Vq
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ff7RX-00038o-QS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 16 Jul 2018 18:37:39 +0100
Message-Id: <20180716173743.133393-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 0/4] virtio migration load path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

One day I'll figure out how to convert the
virtio load path and qemu_get_virtqeueue_element into
vmstate, but until then clean up some of the error paths.

Dave

Dr. David Alan Gilbert (4):
  scsi/migration: Allow bus load request to fail
  virtio: Check qemu_get_virtqueue_element returns
  virtio-scsi/migration: Allow load_request to fail
  virtio: qemu_get_virtqueue_element fail rather than assert

 hw/block/virtio-blk.c       |  4 ++++
 hw/char/virtio-serial-bus.c |  4 ++++
 hw/scsi/scsi-bus.c          |  5 +++++
 hw/scsi/virtio-scsi.c       | 19 ++++++++++++++++---
 hw/virtio/virtio.c          | 13 ++++++-------
 5 files changed, 35 insertions(+), 10 deletions(-)

-- 
2.17.1

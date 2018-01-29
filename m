Received: from eggs.gnu.org ([2001:4830:134:3::10]:42732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egAJ9-0002fk-8M
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1egAJ6-0007WN-4d
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1egAJ5-0007Vk-Uh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:21:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 729DAC056781
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 14:21:10 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
Date: Mon, 29 Jan 2018 16:20:55 +0200
Message-Id: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gal Hammer <ghammer@redhat.com>

Using a cleanup callback function (Version 2 of this patches) in order to
support transactions fails when the same event notifier fd was used by more
than one Memory Region.

This time I ask the caller to do the event notifier cleanup by himself.

Gal Hammer (2):
  virtio: remove event notifier cleanup call on de-assign
  virtio: improve virtio devices initialization time

 hw/block/dataplane/virtio-blk.c |  2 ++
 hw/scsi/virtio-scsi-dataplane.c |  2 ++
 hw/virtio/vhost.c               |  2 ++
 hw/virtio/virtio-bus.c          | 14 ++++++++++----
 hw/virtio/virtio.c              | 22 +++++++++++++++++++++-
 include/hw/virtio/virtio-bus.h  |  2 ++
 6 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.7.5

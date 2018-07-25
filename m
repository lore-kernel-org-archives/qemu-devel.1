Received: from eggs.gnu.org ([2001:4830:134:3::10]:40427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImP-00060C-7N
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImM-000244-6g
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:14 +0200
Message-Id: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 00/10] Move virtio-ccw devices to
 separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

For more fine-grained control over the build process, it would be good
to have the possibility to disable single virtio devices, too. We already
have CONFIG_VIRTIO_* switches in the Makefiles, but currently all
virtio-ccw devices are compiled in anyway. Move them to separate files
so we can disable them in the Makefile more easily.

NB: I did not move virtio-blk-ccw and virtio-net-ccw to a separate file
yet since they are essential for the s390x-virtio machine and thus it
does IMHO not make much sense to disable net and blk. But if somebody
needs that possibility, too, I can add two more patches on top...

Thomas Huth (10):
  hw/s390x/virtio-ccw: Consolidate calls to virtio_ccw_unrealize()
  hw/s390x: Move virtio-ccw-serial code to a separate file
  hw/s390x: Move virtio-ccw-balloon code to a separate file
  hw/s390x: Move virtio-ccw-scsi code to a separate file
  hw/s390x: Move virtio-ccw-rng code to a separate file
  hw/s390x: Move virtio-ccw-9p code to a separate file
  hw/s390x: Move virtio-ccw-crypto code to a separate file
  hw/s390x: Move vhost-vsock-ccw code to a separate file
  hw/s390x: Move virtio-ccw-gpu code to a separate file
  hw/s390x: Move virtio-ccw-input code to a separate file

 MAINTAINERS                   |   2 +-
 hw/s390x/Makefile.objs        |   9 +
 hw/s390x/vhost-vsock-ccw.c    |  60 +++++
 hw/s390x/virtio-ccw-9p.c      |  65 +++++
 hw/s390x/virtio-ccw-balloon.c |  70 +++++
 hw/s390x/virtio-ccw-crypto.c  |  75 ++++++
 hw/s390x/virtio-ccw-gpu.c     |  67 +++++
 hw/s390x/virtio-ccw-input.c   | 118 +++++++++
 hw/s390x/virtio-ccw-rng.c     |  74 ++++++
 hw/s390x/virtio-ccw-scsi.c    | 125 +++++++++
 hw/s390x/virtio-ccw-serial.c  |  78 ++++++
 hw/s390x/virtio-ccw.c         | 581 +-----------------------------------------
 12 files changed, 749 insertions(+), 575 deletions(-)
 create mode 100644 hw/s390x/vhost-vsock-ccw.c
 create mode 100644 hw/s390x/virtio-ccw-9p.c
 create mode 100644 hw/s390x/virtio-ccw-balloon.c
 create mode 100644 hw/s390x/virtio-ccw-crypto.c
 create mode 100644 hw/s390x/virtio-ccw-gpu.c
 create mode 100644 hw/s390x/virtio-ccw-input.c
 create mode 100644 hw/s390x/virtio-ccw-rng.c
 create mode 100644 hw/s390x/virtio-ccw-scsi.c
 create mode 100644 hw/s390x/virtio-ccw-serial.c

-- 
1.8.3.1

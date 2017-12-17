Received: from eggs.gnu.org ([2001:4830:134:3::10]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eQfUP-00059Q-4R
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1eQfUK-00032O-6X
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:24:49 -0500
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Sun, 17 Dec 2017 23:25:53 +0300
Message-Id: <1513542355-28203-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v6 0/2] virtio: introduce `info virtio' hmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Dakinevich <jan.dakinevich@gmail.com>, Amit Shah <amit@kernel.org>, Cornelia Huck <cohuck@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Jan Dakinevich <jan.dakinevich@gmail.com>

After some discussion, I am going to suggest reworked QMP/HMP for
gathering virtio info. It would provide the following monitor output.

(qemu) info virtio
virtio-blk-device at 0000:00:02.0
  QOM path: /machine/peripheral-anon/device[0]/virtio-backend
  status: 0x0f
    VIRTIO_CONFIG_S_ACKNOWLEDGE
    VIRTIO_CONFIG_S_DRIVER
    VIRTIO_CONFIG_S_DRIVER_OK
    VIRTIO_CONFIG_S_FEATURES_OK
  host features:  0x0000000179000e54
  guest features: 0x0000000130000e54
  common features:
    VIRTIO_F_NOTIFY_ON_EMPTY
    VIRTIO_F_ANY_LAYOUT
    VIRTIO_RING_F_INDIRECT_DESC              acked
    VIRTIO_RING_F_EVENT_IDX                  acked
    VIRTIO_F_BAD_FEATURE
    VIRTIO_F_VERSION_1                       acked
  device features:
    VIRTIO_BLK_F_SEG_MAX                     acked
    VIRTIO_BLK_F_BLK_SIZE                    acked
    VIRTIO_BLK_F_FLUSH                       acked
    VIRTIO_BLK_F_TOPOLOGY                    acked

v5: http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05667.html
v4: http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00393.html
v3: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07565.html
v2: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07527.html
v1: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07247.html

Jan Dakinevich (2):
  virtio: introduce `query-virtio' QMP command
  virtio: add `info virtio' HMP command

 hmp-commands-info.hx        |  14 +++++
 hmp.c                       |  74 ++++++++++++++++++++++++
 hmp.h                       |   1 +
 hw/block/virtio-blk.c       |  20 +++++++
 hw/char/virtio-serial-bus.c |  14 +++++
 hw/display/virtio-gpu.c     |  12 ++++
 hw/net/virtio-net.c         |  34 +++++++++++
 hw/scsi/virtio-scsi.c       |  15 +++++
 hw/virtio/Makefile.objs     |   3 +
 hw/virtio/virtio-balloon.c  |  14 +++++
 hw/virtio/virtio-qmp.c      | 134 ++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-stub.c     |   9 +++
 hw/virtio/virtio.c          |  41 ++++++++++++++
 include/hw/virtio/virtio.h  |   6 ++
 qapi-schema.json            |  70 +++++++++++++++++++++++
 15 files changed, 461 insertions(+)
 create mode 100644 hw/virtio/virtio-qmp.c
 create mode 100644 hw/virtio/virtio-stub.c

--
2.1.4

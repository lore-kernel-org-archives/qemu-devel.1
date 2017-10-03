Received: from eggs.gnu.org ([2001:4830:134:3::10]:51446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dzMcC-0005KV-D9
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@virtuozzo.com>) id 1dzMc9-0000FA-7Y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:48:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:3188 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.dakinevich@virtuozzo.com>)
	id 1dzMc8-0008Sk-Sw
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:47:57 -0400
From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Date: Tue,  3 Oct 2017 15:47:39 +0300
Message-Id: <1507034861-4661-1-git-send-email-jan.dakinevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/2] virtio: introduce `info virtio' hmp
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
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>

v4:
 * Implement `query-virtio' QMP
 * Split the work into QMP and HMP parts

v3: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07565.html
v2: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07527.html
v1: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07247.html

Jan Dakinevich (2):
  virtio: introduce `query-virtio' QMP command
  virtio: add `info virtio' HMP command

 hmp-commands-info.hx        |  14 ++++++
 hmp.c                       |  79 ++++++++++++++++++++++++++++++++++
 hmp.h                       |   1 +
 hw/block/virtio-blk.c       |  21 +++++++++
 hw/char/virtio-serial-bus.c |  15 +++++++
 hw/display/virtio-gpu.c     |  13 ++++++
 hw/net/virtio-net.c         |  35 +++++++++++++++
 hw/scsi/virtio-scsi.c       |  16 +++++++
 hw/virtio/Makefile.objs     |   2 +
 hw/virtio/virtio-balloon.c  |  15 +++++++
 hw/virtio/virtio-stub.c     |   9 ++++
 hw/virtio/virtio.c          | 101 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h  |   2 +
 qapi-schema.json            |   1 +
 qapi/virtio.json            |  94 +++++++++++++++++++++++++++++++++++++++++
 15 files changed, 418 insertions(+)
 create mode 100644 hw/virtio/virtio-stub.c
 create mode 100644 qapi/virtio.json

-- 
2.1.4

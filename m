Received: from eggs.gnu.org ([2001:4830:134:3::10]:59345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm4-0005fX-Jp
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm1-0001yf-9z
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:16 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com
	([40.107.8.118]:22409
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gXqlz-0001B5-S7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:12 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:57:05 +0000
Message-ID: <20181214165657.749-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH 0/5] expose negotiated virtio features in
 r/o properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

This series is an attempt to make virtio features acknowledged by the
guest visible as read-only QOM properties.  One potential usecase of
this is debugging; another is when the upper layer needs to do something
only when/if the guest has acknowledged the support for a feature (e.g.
hot-plug a VFIO device once the guest claims VIRTIO_NET_F_STANDBY
support).

Being an RFC, it's incomplete and fails checkpatch, but I'd be intersted
to know if the approach is sane and worthwhile before I invest more time
in it.

Roman Kagan (5):
  qom: preserve get/set presence in aliased properties
  qmp: further consolidate listing of device and object properties
  qdev-properties: add r/o 64bit bitfield property
  virtio: drop DEFINE_VIRTIO_COMMON_FEATURES
  virtio: expose negotiated features in r/o properties

 include/hw/qdev-properties.h    |  9 ++++
 include/hw/virtio/virtio-scsi.h |  2 +-
 include/hw/virtio/virtio.h      | 18 +++----
 hw/char/virtio-serial-bus.c     |  6 ++-
 hw/core/qdev-properties.c       |  9 +++-
 hw/net/virtio-net.c             | 88 +++++++++++++++++--------------
 hw/scsi/virtio-scsi.c           |  4 +-
 hw/virtio/virtio.c              | 11 +++-
 qmp.c                           | 92 ++++++++-------------------------
 qom/object.c                    |  4 +-
 10 files changed, 113 insertions(+), 130 deletions(-)

--=20
2.19.2

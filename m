Received: from eggs.gnu.org ([2001:4830:134:3::10]:60169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cJpHE-0002VC-9m
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 17:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cJpHB-00079w-5q
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 17:22:24 -0500
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com
	([104.47.38.100]:20213
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1cJpHA-00079W-NT
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 17:22:21 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 21 Dec 2016 22:22:18 +0000
Message-ID: <6412C667-59CD-4194-B46B-F432AD92CC96@nutanix.com>
References: <1482358659-4288-1-git-send-email-felipe@nutanix.com>
In-Reply-To: <1482358659-4288-1-git-send-email-felipe@nutanix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6BCB393F4E93B41B2212F77D4C2AD97@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 21 Dec 2016, at 22:17, Felipe Franciosi <felipe@nutanix.com> wrote:
>=20
> Based on various discussions on the 2016 KVM Forum, I'm sending over a
> vhost-user-scsi implementation for your consideration.
>=20
> This patchset introduces a new vhost-user SCSI device. While heavily
> based on vhost-scsi, it is implemented using vhost's userspace
> counterpart. The device has been coded and tested to work with live
> migration.
>=20
> As part of this work, a new vhost-scsi-common device was created and
> the existing vhost-scsi device moved underneath it. The new
> vhost-user-scsi device is also placed underneath it.
>=20
> A sample application based on the newly introduced libvhost-user is
> also included. It makes use of libiscsi for simplicity.
>=20
> For convenience, I'm maintaining an up-to-date version of these
> patches (including some necessary fixes for libvhost-user) on:
>=20
> https://github.com/franciozzy/qemu/tree/vus-upstream-3

My apologies. The correct URL is:
https://github.com/franciozzy/qemu/tree/vus-upstream-v3

(note the -v3 instead of -3).

Thanks,
Felipe

>=20
> See the individual patches for build and use instructions.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>=20
> v2 -> v3:
> - Rebase after vhost notifier fixes by Paolo.
> - Exposed F_HOTPLUG and F_CHANGE on vhost-user-scsi.
>=20
> v1 -> v2:
> - Introduce new vhost-scsi-common device type.
> - Move vhost-scsi device underneath vhost-scsi-common.
> - Move sample application from tests/ to contrib/.
> - Make sample application use the glib event loop.
> - Minor fixes.
>=20
> Felipe Franciosi (3):
>  vhost-scsi: create a vhost-scsi-common abstraction
>  vus: Introduce vhost-user-scsi host device
>  vus: Introduce a vhost-user-scsi sample application
>=20
> Makefile                                  |   3 +
> Makefile.objs                             |   4 +
> configure                                 |  11 +
> contrib/vhost-user-scsi/Makefile.objs     |   1 +
> contrib/vhost-user-scsi/vhost-user-scsi.c | 886 +++++++++++++++++++++++++=
+++++
> hw/scsi/Makefile.objs                     |   3 +-
> hw/scsi/vhost-scsi-common.c               | 143 +++++
> hw/scsi/vhost-scsi.c                      | 188 ++-----
> hw/scsi/vhost-user-scsi.c                 | 215 ++++++++
> hw/virtio/virtio-pci.c                    |  58 ++
> hw/virtio/virtio-pci.h                    |  15 +
> include/hw/virtio/vhost-scsi-common.h     |  48 ++
> include/hw/virtio/vhost-scsi.h            |  11 +-
> include/hw/virtio/vhost-user-scsi.h       |  35 ++
> include/hw/virtio/virtio-scsi.h           |   7 +
> 15 files changed, 1483 insertions(+), 145 deletions(-)
> create mode 100644 contrib/vhost-user-scsi/Makefile.objs
> create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
> create mode 100644 hw/scsi/vhost-scsi-common.c
> create mode 100644 hw/scsi/vhost-user-scsi.c
> create mode 100644 include/hw/virtio/vhost-scsi-common.h
> create mode 100644 include/hw/virtio/vhost-user-scsi.h
>=20
> --=20
> 1.9.4
>=20

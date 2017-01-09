Received: from eggs.gnu.org ([2001:4830:134:3::10]:35332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPNL-0001em-In
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPNI-0000ui-F8
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:55 -0500
Received: from [45.249.212.188] (port=2436 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cQPNI-0000uB-2B
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:07:52 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 9 Jan 2017 02:07:36 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1803DD@DGGEMA505-MBX.china.huawei.com>
References: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND 0/5] hotplugging support for both
 cryptdoev and virtio crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>

Hi Michael,

Ping...



Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Thursday, December 22, 2016 11:13 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; Gonglei (Arei)
> Subject: [PATCH RESEND 0/5] hotplugging support for both cryptdoev and vi=
rtio
> crypto device
>=20
> The patch set make the cryptodev object can be hot plugging
> in safety, and which are preparing works for virtio-crypto
> device hotplugging.
>=20
> Patch 5 opens the hotplugging capability for virtio crypto
> device.
>=20
> Gonglei (5):
>   cryptodev: introduce a new is_used property
>   cryptodev: wrap the ready flag
>   virtio-crypto-pci: add check for cryptodev object
>   virtio-crypto: avoid one cryptodev device is used by multiple virtio
>     crypto devices
>   virtio-crypto-pci: tag virtio-crypto device hot pluggable
>=20
>  backends/cryptodev-builtin.c  |  4 ++++
>  backends/cryptodev.c          | 34
> ++++++++++++++++++++++++++++++----
>  hw/virtio/virtio-crypto-pci.c |  6 +++++-
>  hw/virtio/virtio-crypto.c     | 22 +++++++++++++++++++---
>  include/sysemu/cryptodev.h    | 42
> ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 100 insertions(+), 8 deletions(-)
>=20
> --
> 1.8.3.1
>=20

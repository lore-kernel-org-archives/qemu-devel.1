Received: from eggs.gnu.org ([2001:4830:134:3::10]:49194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtuP-0003qN-QJ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtuM-0003MK-MZ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:19:09 -0500
Received: from [45.249.212.187] (port=2500 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtuM-0003Jy-9G
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:19:06 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 03:18:40 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA16B1E8@DGGEMA505-MBX.china.huawei.com>
References: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
	<1482376362-13804-4-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482376362-13804-4-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND 3/5] virtio-crypto-pci: add check
 for cryptodev object
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


>
> Subject: [PATCH RESEND 3/5] virtio-crypto-pci: add check for cryptodev ob=
ject
>=20
> We must assure each virtio crypto pci device has
> an invaild cryptodev backend object.
>=20
Oops, a typo.

s/an invalid/ a valid/

Michael, can you pls correct it if no other comments?

Thanks,
-Gonglei

> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  hw/virtio/virtio-crypto-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.=
c
> index a1b0906..14bd12c 100644
> --- a/hw/virtio/virtio-crypto-pci.c
> +++ b/hw/virtio/virtio-crypto-pci.c
> @@ -31,6 +31,11 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy
> *vpci_dev, Error **errp)
>      VirtIOCryptoPCI *vcrypto =3D VIRTIO_CRYPTO_PCI(vpci_dev);
>      DeviceState *vdev =3D DEVICE(&vcrypto->vdev);
>=20
> +    if (vcrypto->vdev.conf.cryptodev =3D=3D NULL) {
> +        error_setg(errp, "'cryptodev' parameter expects a valid object")=
;
> +        return;
> +    }
> +
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>      virtio_pci_force_virtio_1(vpci_dev);
>      object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> --
> 1.8.3.1
>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fazwr-00037z-0e
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fazwq-0003hT-1L
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:49:09 -0400
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-3-f4bug@amsat.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <81a35a31-e3f0-2156-0e76-1a990cca78e3@redhat.com>
Date: Thu, 5 Jul 2018 10:49:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180704153919.12432-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

On 04.07.2018 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch created mechanically by rerunning:
>=20
>   $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/s390x/virtio-ccw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b92a85d0b0..7ddb378d52 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1836,11 +1836,9 @@ static void vhost_vsock_ccw_realize(VirtioCcwDev=
ice *ccw_dev, Error **errp)
>  {
>      VHostVSockCCWState *dev =3D VHOST_VSOCK_CCW(ccw_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> -    Error *err =3D NULL;
> =20
>      qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
> -    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
> -    error_propagate(errp, err);
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>  }
> =20
>  static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

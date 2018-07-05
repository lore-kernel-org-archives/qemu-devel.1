Received: from eggs.gnu.org ([2001:4830:134:3::10]:36521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawyu-0008Kd-B5
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fawyp-0000FM-4e
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:39:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-3-f4bug@amsat.org>
Date: Thu, 05 Jul 2018 07:38:57 +0200
In-Reply-To: <20180704153919.12432-3-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Jul 2018 12:39:13
	-0300")
Message-ID: <8736wydyxa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alexander Graf <agraf@suse.de>, "Michael
	S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Patch created mechanically by rerunning:
>
>   $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/s390x/virtio-ccw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b92a85d0b0..7ddb378d52 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1836,11 +1836,9 @@ static void vhost_vsock_ccw_realize(VirtioCcwDevic=
e *ccw_dev, Error **errp)
>  {
>      VHostVSockCCWState *dev =3D VHOST_VSOCK_CCW(ccw_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> -    Error *err =3D NULL;
>=20=20
>      qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
> -    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
> -    error_propagate(errp, err);
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>  }
>=20=20
>  static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)

Reviewed-by: Markus Armbruster <armbru@redhat.com>

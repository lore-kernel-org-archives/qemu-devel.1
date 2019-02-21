Received: from eggs.gnu.org ([209.51.188.92]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrcm-0003Rn-NX
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrcl-00048c-V8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gwrcl-00048E-Mk
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D91C81F18
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:46:45 +0000 (UTC)
Date: Thu, 21 Feb 2019 17:46:38 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190221164638.GF31918@natto.ory.fergeau.eu>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20190221114330.17968-2-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] virtio-gpu: remove unused qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Reviewed-by: Christophe Fergeau <cfergeau@redhat.com>

On Thu, Feb 21, 2019 at 12:43:27PM +0100, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 1 -
>  hw/display/virtio-gpu.c        | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index c8c599f1b9..c7cb821ae3 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -97,7 +97,6 @@ typedef struct VirtIOGPU {
>      int enable;
> =20
>      int config_size;
> -    DeviceState *qdev;
> =20
>      QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index c6fab56f9b..a52c2aed0e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1268,7 +1268,6 @@ static void virtio_gpu_device_realize(DeviceState *=
qdev, Error **errp)
>      QTAILQ_INIT(&g->fenceq);
> =20
>      g->enabled_output_bitmask =3D 1;
> -    g->qdev =3D qdev;
> =20
>      for (i =3D 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =3D
> --=20
> 2.21.0.rc1
>=20
>=20

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxu1ekACgkQqdjCFCms
bIKv0RAAmEJJ1xhIhMrBw9UKk4jOviU/tDt0mRUKm6cH8IWHfKLWlDvY9uUgPOd2
d8QO4wr1+RRHQGYctZELs+FT+H7rxok5je85pjG7hSrpeXVhE2hHx7XT4livjXpU
tvHI49h4tNJJItY9b1x2WfvZpW3YPCtUhqasv1C/VSTzN51xJNILZ4zl91ZsEBnu
LXum4IkK8ktY15UvH6Fm0Dv8G+wNphOmw17oTnzAhmBiiTu8LaGZVpFd/co293JN
HUrKaXxoUEc3a2pwJGYQzUUhkfmU1NQRIHw1vxbnOeZ8BTRUX0QmOpnD8Q0repgL
5vjn0V0S5hOus8bgYTS73ma+qswDUYl1tW7YMOARfAV6Bw9GrcwiysvVKqoPOzD8
uOVQys8Ohsrfue3QJo6wKXTIIuS9I522xAeISPnXFSCr6erlSapqsYOY8pS3/hUZ
MAjDYkOkyqx2TpTGCpvVSRO5l69G8X6B0cMxmw+l96ozfyUVd+8yNP6FRUB6pZct
gPgPDlltlr2MARRe+8bqgq6poAAFYP0mmSL+naIRB7EzxuuGs0d6glLBGtc4NwdH
uYk0CCsVP278YKEwiyCC4vTdNwQlwhp1jlRUerHBQ1xBDXY8gEEpr3+xOsQtcZrV
nRknHOkh2WnjUB5+iS0YrZpRyA3ncZwD2jQBqvOs27LUhhMA3hk=
=rgJC
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

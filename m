Received: from eggs.gnu.org ([209.51.188.92]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrjX-0001qe-T2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrjP-0008Fl-0u
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:01:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gwrjC-00085n-3m
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:01:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F35EC057F2C
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:51:31 +0000 (UTC)
Date: Thu, 21 Feb 2019 17:51:24 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190221165124.GG31918@natto.ory.fergeau.eu>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20190221114330.17968-3-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] virtio-gpu: remove unused config_size
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


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Christophe Fergeau <cfergeau@redhat.com>

On Thu, Feb 21, 2019 at 12:43:28PM +0100, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 2 --
>  hw/display/virtio-gpu.c        | 3 +--
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index c7cb821ae3..a1cecd1df8 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -96,8 +96,6 @@ typedef struct VirtIOGPU {
> =20
>      int enable;
> =20
> -    int config_size;
> -
>      QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index a52c2aed0e..8f4351420b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1238,10 +1238,9 @@ static void virtio_gpu_device_realize(DeviceState =
*qdev, Error **errp)
>          }
>      }
> =20
> -    g->config_size =3D sizeof(struct virtio_gpu_config);
>      g->virtio_config.num_scanouts =3D cpu_to_le32(g->conf.max_outputs);
>      virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
> -                g->config_size);
> +                sizeof(struct virtio_gpu_config));
> =20
>      g->req_state[0].width =3D g->conf.xres;
>      g->req_state[0].height =3D g->conf.yres;
> --=20
> 2.21.0.rc1
>=20
>=20

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxu1wwACgkQqdjCFCms
bIIpNw//SSHWgjEkP7t1PnBt0Sk8j4fDu6cT8vxFnqrBWPWToFNA2aXnVkOLvmkm
zpZUxjdi39kMUL7jTUk737Mipq6RzdvXYoEE0zrmEdD7wzSLQzVpO/7DiGR79d4/
4671W4RDq67UBfcBEafn8WRJhnIFlSMuh9BAneM2TAb8Pr7Q3eBpXWMd/eCLcohB
o20pFJnE1M74QldUZruz9yPp9OADelqgt59NUonlWSHK449fNenx6POqHggi8Da5
GOUo0yj/VvISJxr1JSGwp0+MF8EFQkZ1JpKR9I50lZK6TutuMvHk0siHXIzPzNna
z5c1rJ7na43gi+OBA6SoJ0zzAK6vyeMCP2Rwgvdr7QU2kITtwf2qqjKt/hi9UajW
3LMREwINp9uneQhBVFLtXG0o5XvEuM2lmexnHVgWA0cZwSHqH30k3nZHqexeGeiU
Xuio1foF90MRwrjSPtPlZFGTm+kCcFLAAfKhGuQRYESGzSGG6TtDDkuxEPkJOUp8
xqxud1MaHptQHsTXg/jRJbM60ArPsbjhyTUqvokHi00iUuV/MYuqahJINluEBTmJ
ULjfqEURNLHBPfRMX3QggesAQuTg0BLQ5vPCdYFJYZg+HZCc1JF6ivP9Wk7f64H7
nFYtk16Lq253hVPnbbLRLfGZmTPIPQi7fUkrFPA5xJl9cvsCxQE=
=05zk
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--

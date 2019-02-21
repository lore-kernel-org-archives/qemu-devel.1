Received: from eggs.gnu.org ([209.51.188.92]:54280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrbn-0002op-TO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrbl-0003d2-5O
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:54:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gwrbd-0003Z1-Hw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:53:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EF78307DABE
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:53:48 +0000 (UTC)
Date: Thu, 21 Feb 2019 17:53:41 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190221165341.GI31918@natto.ory.fergeau.eu>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20190221114330.17968-5-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-gpu: remove useless 'waiting'
 field
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


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Reviewed-by: Christophe Fergeau <cfergeau@redhat.com>

On Thu, Feb 21, 2019 at 12:43:30PM +0100, Marc-Andr=E9 Lureau wrote:
> Let's check renderer_blocked instead directly.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 1 -
>  hw/display/virtio-gpu.c        | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index f8cd8ee96f..26a6698266 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -81,7 +81,6 @@ struct virtio_gpu_ctrl_command {
>      VirtQueue *vq;
>      struct virtio_gpu_ctrl_hdr cmd_hdr;
>      uint32_t error;
> -    bool waiting;
>      bool finished;
>      QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
>  };
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 7ada4b83ac..0baa9ac0ad 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -889,8 +889,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>      while (!QTAILQ_EMPTY(&g->cmdq)) {
>          cmd =3D QTAILQ_FIRST(&g->cmdq);
> =20
> -        cmd->waiting =3D g->renderer_blocked;
> -        if (cmd->waiting) {
> +        if (g->renderer_blocked) {
>              break;
>          }
> =20
> @@ -939,7 +938,6 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
, VirtQueue *vq)
>          cmd->vq =3D vq;
>          cmd->error =3D 0;
>          cmd->finished =3D false;
> -        cmd->waiting =3D false;
>          QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
>          cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command)=
);
>      }
> --=20
> 2.21.0.rc1
>=20
>=20

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxu15UACgkQqdjCFCms
bIKMlRAAp3MORowgjX+NyHTCzZyYItnR9iFhwTY7isM5irMPA/QPOa4jLqce55xA
nTQtsNUDsX06QfFFYd/E+cajGNXC9dPdyu8EniNbxNnEQ1ZWV7UFJHXsUyCBMRtB
jNY3AISVqp5FaB3yz/JfVb4KVbhfDdolbBrDN/R1O1kcJkwd7QRTgwfwpox0+lHb
Hf2pL0BWNDXEwx181TjwwsBp7K5w45GB5zeR7JgCGXmQArV/OBbJKnwX+Z/0ZFmU
i7eS8o0zUbbL094c1ZyHlL+iVI3U0zuJLVPuLXcqjcsA9edgI/tkCYK3ANCnG23G
kXyqcwNuPBGU/2XFlZE6bVIoLiIS1Exy2yY049vF7iRPczEOpRkrpd9R85+hjVPJ
z1lf3X0R+ADVYd3VDt94ZsLJTMQCco19QJBnI2uxXA4nCFj3rUTkIseDfJzOTUjZ
b66SFpny4UJyWzTPWnbkZSbjp1IHlyfnq02ZGztfCFnhNE/S3Xm5X9dql/TZflJB
CXAsiimdi/tA+JOsGDh7R8XHtwoCUiOh7mHVLOlt7TmIvoOxAY/9050BrUyiJDEa
MGyzYjxXfJ47cJTozEObNoOWpHSryIIKhN4P3EgpdnYjscm0hdlhV8ZZfZBaRZqZ
+omEBzgyVrhMWRUD32y0Btx7vWt/Vy8z+KBvtDDNMcP8Ffmrx8o=
=bKWV
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--

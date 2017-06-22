Received: from eggs.gnu.org ([2001:4830:134:3::10]:54598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dO7Ay-0006lf-Jz
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dO7Av-000727-Fe
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dO7Av-00071l-98
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:49:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0095642BDF
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:49:52 +0000 (UTC)
Date: Thu, 22 Jun 2017 21:49:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170622214937-mutt-send-email-mst@kernel.org>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170622124204.19407-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/31] vhost: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jun 22, 2017 at 02:41:37PM +0200, Marc-Andr=E9 Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/virtio/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6eddb099b0..0049a2c0b3 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -70,7 +70,7 @@ static void vhost_dev_sync_region(struct vhost_dev *d=
ev,
>      uint64_t end =3D MIN(mlast, rlast);
>      vhost_log_chunk_t *from =3D log + start / VHOST_LOG_CHUNK;
>      vhost_log_chunk_t *to =3D log + end / VHOST_LOG_CHUNK + 1;
> -    uint64_t addr =3D (start / VHOST_LOG_CHUNK) * VHOST_LOG_CHUNK;
> +    uint64_t addr =3D QEMU_ALIGN_DOWN(start, VHOST_LOG_CHUNK);
> =20
>      if (end < start) {
>          return;
> --=20
> 2.13.1.395.gf7b71de06

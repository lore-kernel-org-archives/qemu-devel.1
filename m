Received: from eggs.gnu.org ([2001:4830:134:3::10]:59336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eifZX-0007ws-P3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eifZU-0002hj-IA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:08:31 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eifZU-0002cq-C1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:08:28 -0500
Received: by mail-wr0-f196.google.com with SMTP id s5so29319283wra.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 04:08:27 -0800 (PST)
Date: Mon, 5 Feb 2018 13:08:24 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180205130824.79f570bc@fiorina>
In-Reply-To: <938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
References: <cover.1512476043.git.tgolembi@redhat.com>
	<938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-balloon: include statistics
 of disk/file caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>

ping

On Tue,  5 Dec 2017 13:14:46 +0100
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c                      | 1 +
>  include/standard-headers/linux/virtio_balloon.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 37cde38982..8141326a51 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -50,6 +50,7 @@ static const char *balloon_stat_names[] =3D {
>     [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
>     [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
>     [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> +   [VIRTIO_BALLOON_S_CACHES] =3D "stat-disk-caches",
>     [VIRTIO_BALLOON_S_NR] =3D NULL
>  };
> =20
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/st=
andard-headers/linux/virtio_balloon.h
> index 9d06ccd066..7b0a41b8fc 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -52,7 +52,8 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
> -#define VIRTIO_BALLOON_S_NR       7
> +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
> +#define VIRTIO_BALLOON_S_NR       8
> =20
>  /*
>   * Memory statistics structure.
> --=20
> 2.15.1
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

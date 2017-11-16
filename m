Received: from eggs.gnu.org ([2001:4830:134:3::10]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1eFKNE-00006x-MK
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1eFKNB-00027F-Bq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:38:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1eFKNB-00025U-30
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:38:29 -0500
From: Yan Vugenfirer <yvugenfi@redhat.com>
Message-Id: <181C9C1B-9119-4B1D-8327-0C5EFD42A5F5@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 16 Nov 2017 15:38:21 +0200
In-Reply-To: <13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
References: <cover.1505923516.git.tgolembi@redhat.com>
	<13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH 1/1] virtio-balloon: include
 buffers and chached memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hello All,

Michael asked me to comment regarding the possibility to get this =
statistics on Windows.
By using Win32_OperatingSystem WMI class we can calculate the amount of =
cached memory =
(https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).aspx =
<https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).aspx> =
http://brandonlive.com/2010/02/21/measuring-memory-usage-in-windows-7/ =
<http://brandonlive.com/2010/02/21/measuring-memory-usage-in-windows-7/>),=
 but Windows doesn=E2=80=99t let to distinguish between =E2=80=9Ccached =
and buffers=E2=80=9D as far as I see.=20

Best regards,
Yan.

> On 20 Sep 2017, at 19:05, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD =
<tgolembi@redhat.com> wrote:
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
> hw/virtio/virtio-balloon.c                      | 2 ++
> include/standard-headers/linux/virtio_balloon.h | 4 +++-
> 2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a705e0ec55..0434784c14 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -49,6 +49,8 @@ static const char *balloon_stat_names[] =3D {
>    [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
>    [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
>    [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> +   [VIRTIO_BALLOON_S_BUFFERS] =3D "stat-linux-buffers",
> +   [VIRTIO_BALLOON_S_CACHED] =3D "stat-linux-cached",
>    [VIRTIO_BALLOON_S_NR] =3D NULL
> };
>=20
> diff --git a/include/standard-headers/linux/virtio_balloon.h =
b/include/standard-headers/linux/virtio_balloon.h
> index 9d06ccd066..d61efbfcee 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -52,7 +52,9 @@ struct virtio_balloon_config {
> #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory =
*/
> #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc =
*/
> -#define VIRTIO_BALLOON_S_NR       7
> +#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /proc =
*/
> +#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
> +#define VIRTIO_BALLOON_S_NR       9
>=20
> /*
>  * Memory statistics structure.
> --=20
> 2.14.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

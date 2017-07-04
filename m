Received: from eggs.gnu.org ([2001:4830:134:3::10]:43691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dSVRI-0006fI-Ld
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dSVRE-0004lt-ON
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dSVRE-0004kp-Hp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 17:32:52 -0400
Date: Wed, 5 Jul 2017 00:32:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170705002803-mutt-send-email-mst@kernel.org>
References: <1499207612-3560-1-git-send-email-peng.hao2@zte.com.cn>
	<CAJ+F1C+sWiCpSSqPdkiU0iBmdjofuv6m1FAgwPBJJUu9BJcUEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+sWiCpSSqPdkiU0iBmdjofuv6m1FAgwPBJJUu9BJcUEA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Jul 04, 2017 at 02:21:08PM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Jul 4, 2017 at 4:16 PM Peng Hao <peng.hao2@zte.com.cn> wrote:
>=20
>     vhost exists a call for g_file_get_contents, but not call g_free.
>=20
>     Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>
>=20
>=20
> =A0Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
>=20
>     ---
>     =A0hw/virtio/vhost-backend.c | 2 ++
>     =A01 file changed, 2 insertions(+)
>=20
>     diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
>     index 4e31de1..2c481d6 100644
>     --- a/hw/virtio/vhost-backend.c
>     +++ b/hw/virtio/vhost-backend.c
>     @@ -52,11 +52,13 @@ static int vhost_kernel_memslots_limit(struct v=
host_dev
>     *dev)
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&s, NULL=
, NULL)) {
>     =A0 =A0 =A0 =A0 =A0uint64_t val =3D g_ascii_strtoull(s, NULL, 10);
>     =A0 =A0 =A0 =A0 =A0if (!((val =3D=3D G_MAXUINT64 || !val) && errno)=
) {
>     +=A0 =A0 =A0 =A0 =A0 =A0 g_free(s);
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0return val;
>     =A0 =A0 =A0 =A0 =A0}
>     =A0 =A0 =A0 =A0 =A0error_report("ignoring invalid max_mem_regions v=
alue in vhost
>     module:"
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " %s", s);
>     =A0 =A0 =A0}
>     +=A0 =A0 g_free(s);
>     =A0 =A0 =A0return limit;
>     =A0}
>=20
>     --
>     1.8.3.1
>=20

Thanks for the review.
I'd like to include your tag in commit log.
For that, could you please repost your ack in text format using
some other mail client?
My scripts don't handle the way your mail client scrambles text.

>=20
>=20
> --
> Marc-Andr=E9 Lureau

Received: from eggs.gnu.org ([208.118.235.92]:54866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gbS9U-0003Kt-17
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gbS9T-0001pE-4O
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:28:20 -0500
MIME-Version: 1.0
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-3-npes87184@gmail.com>
In-Reply-To: <20181223025939.15775-3-npes87184@gmail.com>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 24 Dec 2018 13:28:07 -0200
Message-ID: <CAENf94La_5m2sn-KiRauOgLoq04hMGMAU2E+bXoob7KMPM8j5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] dmg: use enumeration type instead
 of hard coding number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Looks good to me.

Reviewed-by: Julio Faracco <jcfaracco@gmail.com>

Em dom, 23 de dez de 2018 =C3=A0s 01:03, yuchenlin <npes87184@gmail.com>
escreveu:

> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  block/dmg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/dmg.c b/block/dmg.c
> index 0e05702f5d..6b0a057bf8 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -267,7 +267,7 @@ static int dmg_read_mish_block(BDRVDMGState *s,
> DmgHeaderState *ds,
>
>          /* all-zeroes sector (type 2) does not need to be "uncompressed"
> and can
>           * therefore be unbounded. */
> -        if (s->types[i] !=3D 2 && s->sectorcounts[i] >
> DMG_SECTORCOUNTS_MAX) {
> +        if (s->types[i] !=3D UDIG && s->sectorcounts[i] >
> DMG_SECTORCOUNTS_MAX) {
>              error_report("sector count %" PRIu64 " for chunk %" PRIu32
>                           " is larger than max (%u)",
>                           s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
> @@ -706,7 +706,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset,
> uint64_t bytes,
>          /* Special case: current chunk is all zeroes. Do not perform a
> memcpy as
>           * s->uncompressed_chunk may be too small to cover the large
> all-zeroes
>           * section. dmg_read_chunk is called to find s->current_chunk */
> -        if (s->types[s->current_chunk] =3D=3D 2) { /* all zeroes block e=
ntry
> */
> +        if (s->types[s->current_chunk] =3D=3D UDIG) { /* all zeroes bloc=
k
> entry */
>              qemu_iovec_memset(qiov, i * 512, 0, 512);
>              continue;
>          }
> --
> 2.17.1
>
>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAcPr-0001Gn-9P
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAcPq-0005hC-ES
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:21:31 -0400
Date: Tue, 16 May 2017 15:21:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170516132107.GD4438@noname.redhat.com>
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-4-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170515203114.9477-4-hpoussin@reactos.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/13] vvfat: fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 15.05.2017 um 22:31 hat Herv=E9 Poussineau geschrieben:
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> ---
>  block/vvfat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 002bd86e42..57f2489689 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -404,9 +404,9 @@ static void init_mbr(BDRVVVFATState *s, int cyls, i=
nt heads, int secs)
>      /* FAT12/FAT16/FAT32 */
>      /* DOS uses different types when partition is LBA,
>         probably to prevent older versions from using CHS on them */
> -    partition->fs_type=3D s->fat_type=3D=3D12 ? 0x1:
> -                        s->fat_type=3D=3D16 ? (lba?0xe:0x06):
> -                         /*fat_tyoe=3D=3D32*/ (lba?0xc:0x0b);
> +    partition->fs_type =3D s->fat_type =3D=3D 12 ? 0x1 :
> +                         s->fat_type =3D=3D 16 ? (lba ? 0xe : 0x06) :
> +                       /*s->fat_type =3D=3D 32*/ (lba ? 0xc : 0x0b);
> =20
>      real_mbr->magic[0]=3D0x55; real_mbr->magic[1]=3D0xaa;
>  }
> @@ -806,7 +806,7 @@ static int read_directory(BDRVVVFATState* s, int ma=
pping_index)
>                  (ROOT_ENTRIES - cur) * sizeof(direntry_t));
>      }
> =20
> -     /* reget the mapping, since s->mapping was possibly realloc()ed *=
/
> +    /* reset the mapping, since s->mapping was possibly realloc()ed */

Are you sure that this was a typo? It seems to make more sense to me as
"re-get" (maybe easer to read with the hyphen).

>      mapping =3D array_get(&(s->mapping), mapping_index);
>      first_cluster +=3D (s->directory.next - mapping->info.dir.first_di=
r_index)
>          * 0x20 / s->cluster_size;

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da7NR-0003bo-9d
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da7NQ-0004BX-Aa
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:28:25 -0400
References: <20170721183243.22706-1-eblake@redhat.com>
	<20170721183243.22706-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <76a5ebbd-5261-a3f0-2dc1-a236c6c3f97a@redhat.com>
Date: Tue, 25 Jul 2017 17:28:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170721183243.22706-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] dirty-bitmap: Report
 BlockDirtyInfo.count in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>



On 07/21/2017 02:32 PM, Eric Blake wrote:
> We've been documenting the value in bytes since its introduction
> in commit b9a9b3a4 (v1.3), where it was actually reported in bytes.
>=20
> Commit e4654d2 (v2.0) then removed things from block/qapi.c, in
> preparation for a rewrite to a list of dirty sectors in the next
> commit 21b5683 in block.c, but the new code mistakenly started
> reporting in sectors.
>=20
> Fixes: https://bugzilla.redhat.com/1441460
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

I must have forgotten about this -- Didn't this get reviewed as part of=20
your byte series? Is this a resend for a stable branch?

> ---
> Too late for 2.9, since the regression has been unnoticed for
> nine releases. But worth putting in 2.9.1 and 2.10.
>=20
> v2-v4: no change
> ---
>   block/dirty-bitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 543bddb9b5..30462d4f9a 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -461,7 +461,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockD=
riverState *bs)
>       QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>           BlockDirtyInfo *info =3D g_new0(BlockDirtyInfo, 1);
>           BlockDirtyInfoList *entry =3D g_new0(BlockDirtyInfoList, 1);
> -        info->count =3D bdrv_get_dirty_count(bm);
> +        info->count =3D bdrv_get_dirty_count(bm) << BDRV_SECTOR_BITS;
>           info->granularity =3D bdrv_dirty_bitmap_granularity(bm);
>           info->has_name =3D !!bm->name;
>           info->name =3D g_strdup(bm->name);
>=20

--=20
=E2=80=94js

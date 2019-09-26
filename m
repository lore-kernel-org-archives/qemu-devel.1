Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86755C352A9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54448217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54448217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZAh-0003tc-O8
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iDYh6-0003zz-4z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iDYh4-0001tM-0m
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iDYgu-0001mQ-Vq; Thu, 26 Sep 2019 14:40:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3836B8A1CA6;
 Thu, 26 Sep 2019 18:40:30 +0000 (UTC)
Received: from [10.18.17.231] (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E36B5F7C0;
 Thu, 26 Sep 2019 18:40:26 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 3/4] block/dirty-bitmap: drop
 BdrvDirtyBitmap.mutex
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
 <20190916141911.5255-4-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7236affa-656f-27c2-5e9f-6bd891017fcf@redhat.com>
Date: Thu, 26 Sep 2019 14:40:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141911.5255-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 26 Sep 2019 18:40:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/16/19 10:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> mutex field is just a pointer to bs->dirty_bitmap_mutex, so no needs
> to store it in BdrvDirtyBitmap when we have bs pointer in it (since
> previous patch).
>=20
> Drop mutex field. Constantly use bdrv_dirty_bitmaps_lock/unlock in
> block/dirty-bitmap.c to make it more obvious that it's not per-bitmap
> lock. Still, for simplicity, leave bdrv_dirty_bitmap_lock/unlock
> functions as an external API.
>=20

It's convenient, but I wish it had a better name because it still
implies a per-bitmap lock, which we've never had.

It's fine for now, this patch doesn't make it worse, of course.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  block/dirty-bitmap.c | 84 +++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 43 deletions(-)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index f3dc7b3ca5..76a8e59e61 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -28,7 +28,6 @@
>  #include "block/blockjob.h"
> =20
>  struct BdrvDirtyBitmap {
> -    QemuMutex *mutex;
>      BlockDriverState *bs;
>      HBitmap *bitmap;            /* Dirty bitmap implementation */
>      bool busy;                  /* Bitmap is busy, it can't be used vi=
a QMP */
> @@ -71,12 +70,12 @@ static inline void bdrv_dirty_bitmaps_unlock(BlockD=
riverState *bs)
> =20
>  void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap)
>  {
> -    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>  }
> =20
>  void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap)
>  {
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  /* Called with BQL or dirty_bitmap lock taken.  */
> @@ -116,7 +115,6 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriv=
erState *bs,
>      }
>      bitmap =3D g_new0(BdrvDirtyBitmap, 1);
>      bitmap->bs =3D bs;
> -    bitmap->mutex =3D &bs->dirty_bitmap_mutex;
>      bitmap->bitmap =3D hbitmap_alloc(bitmap_size, ctz32(granularity));
>      bitmap->size =3D bitmap_size;
>      bitmap->name =3D g_strdup(name);
> @@ -150,9 +148,9 @@ static bool bdrv_dirty_bitmap_busy(const BdrvDirtyB=
itmap *bitmap)
> =20
>  void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy)
>  {
> -    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bitmap->busy =3D busy;
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  /* Called with BQL taken.  */
> @@ -277,10 +275,10 @@ void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBit=
map *bitmap)
>  /* Called with BQL taken. */
>  void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
>  {
> -    assert(bitmap->mutex =3D=3D bitmap->successor->mutex);
> -    qemu_mutex_lock(bitmap->mutex);
> +    assert(bitmap->bs =3D=3D bitmap->successor->bs);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bdrv_enable_dirty_bitmap_locked(bitmap->successor);
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  /* Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.  *=
/
> @@ -360,9 +358,9 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirt=
yBitmap *parent,
>  {
>      BdrvDirtyBitmap *ret;
> =20
> -    qemu_mutex_lock(parent->mutex);
> +    bdrv_dirty_bitmaps_lock(parent->bs);
>      ret =3D bdrv_reclaim_dirty_bitmap_locked(parent, errp);
> -    qemu_mutex_unlock(parent->mutex);
> +    bdrv_dirty_bitmaps_unlock(parent->bs);
> =20
>      return ret;
>  }
> @@ -434,16 +432,16 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDri=
verState *bs,
> =20
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> -    bdrv_dirty_bitmap_lock(bitmap);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bitmap->disabled =3D true;
> -    bdrv_dirty_bitmap_unlock(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> -    bdrv_dirty_bitmap_lock(bitmap);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bdrv_enable_dirty_bitmap_locked(bitmap);
> -    bdrv_dirty_bitmap_unlock(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
> @@ -484,9 +482,9 @@ bool bdrv_dirty_bitmap_get_locked(BdrvDirtyBitmap *=
bitmap, int64_t offset)
>  bool bdrv_dirty_bitmap_get(BdrvDirtyBitmap *bitmap, int64_t offset)
>  {
>      bool ret;
> -    bdrv_dirty_bitmap_lock(bitmap);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      ret =3D bdrv_dirty_bitmap_get_locked(bitmap, offset);
> -    bdrv_dirty_bitmap_unlock(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
> =20
>      return ret;
>  }
> @@ -551,9 +549,9 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *=
bitmap,
>  void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                             int64_t offset, int64_t bytes)
>  {
> -    bdrv_dirty_bitmap_lock(bitmap);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bdrv_set_dirty_bitmap_locked(bitmap, offset, bytes);
> -    bdrv_dirty_bitmap_unlock(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  /* Called within bdrv_dirty_bitmap_lock..unlock */
> @@ -567,15 +565,15 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitm=
ap *bitmap,
>  void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                               int64_t offset, int64_t bytes)
>  {
> -    bdrv_dirty_bitmap_lock(bitmap);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bdrv_reset_dirty_bitmap_locked(bitmap, offset, bytes);
> -    bdrv_dirty_bitmap_unlock(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
>  {
>      assert(!bdrv_dirty_bitmap_readonly(bitmap));
> -    bdrv_dirty_bitmap_lock(bitmap);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      if (!out) {
>          hbitmap_reset_all(bitmap->bitmap);
>      } else {
> @@ -584,7 +582,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitma=
p, HBitmap **out)
>                                         hbitmap_granularity(backup));
>          *out =3D backup;
>      }
> -    bdrv_dirty_bitmap_unlock(bitmap);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backu=
p)
> @@ -679,9 +677,9 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitm=
ap *bitmap)
>  /* Called with BQL taken. */
>  void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool valu=
e)
>  {
> -    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bitmap->readonly =3D value;
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
> @@ -699,27 +697,27 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *=
bs)
>  /* Called with BQL taken. */
>  void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap, bool p=
ersistent)
>  {
> -    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bitmap->persistent =3D persistent;
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  /* Called with BQL taken. */
>  void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
>  {
> -    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      assert(bitmap->persistent =3D=3D true);
>      bitmap->inconsistent =3D true;
>      bitmap->disabled =3D true;
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  /* Called with BQL taken. */
>  void bdrv_dirty_bitmap_skip_store(BdrvDirtyBitmap *bitmap, bool skip)
>  {
> -    qemu_mutex_lock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_lock(bitmap->bs);
>      bitmap->skip_store =3D skip;
> -    qemu_mutex_unlock(bitmap->mutex);
> +    bdrv_dirty_bitmaps_unlock(bitmap->bs);
>  }
> =20
>  bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap)
> @@ -779,9 +777,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest,=
 const BdrvDirtyBitmap *src,
>  {
>      bool ret;
> =20
> -    qemu_mutex_lock(dest->mutex);
> -    if (src->mutex !=3D dest->mutex) {
> -        qemu_mutex_lock(src->mutex);
> +    bdrv_dirty_bitmaps_lock(dest->bs);
> +    if (src->bs !=3D dest->bs) {
> +        bdrv_dirty_bitmaps_lock(src->bs);
>      }
> =20
>      if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEFAULT, errp)) {
> @@ -801,9 +799,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest,=
 const BdrvDirtyBitmap *src,
>      assert(ret);
> =20
>  out:
> -    qemu_mutex_unlock(dest->mutex);
> -    if (src->mutex !=3D dest->mutex) {
> -        qemu_mutex_unlock(src->mutex);
> +    bdrv_dirty_bitmaps_unlock(dest->bs);
> +    if (src->bs !=3D dest->bs) {
> +        bdrv_dirty_bitmaps_unlock(src->bs);
>      }
>  }
> =20
> @@ -827,9 +825,9 @@ bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitm=
ap *dest,
>      assert(!bdrv_dirty_bitmap_inconsistent(src));
> =20
>      if (lock) {
> -        qemu_mutex_lock(dest->mutex);
> -        if (src->mutex !=3D dest->mutex) {
> -            qemu_mutex_lock(src->mutex);
> +        bdrv_dirty_bitmaps_lock(dest->bs);
> +        if (src->bs !=3D dest->bs) {
> +            bdrv_dirty_bitmaps_lock(src->bs);
>          }
>      }
> =20
> @@ -842,9 +840,9 @@ bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitm=
ap *dest,
>      }
> =20
>      if (lock) {
> -        qemu_mutex_unlock(dest->mutex);
> -        if (src->mutex !=3D dest->mutex) {
> -            qemu_mutex_unlock(src->mutex);
> +        bdrv_dirty_bitmaps_unlock(dest->bs);
> +        if (src->bs !=3D dest->bs) {
> +            bdrv_dirty_bitmaps_unlock(src->bs);
>          }
>      }
> =20
>=20

--=20
=E2=80=94js


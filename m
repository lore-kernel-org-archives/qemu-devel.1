Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01163C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD1F206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW3Onxmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD1F206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVC2u-0004HX-97
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iVC1T-00032j-SU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iVC1S-0003Hd-ME
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:06:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iVBzW-0001Dz-FW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573725879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFAZ1yngqIagyrRgUBMBpJ4dQhoOpjSIgiuxNcQye9Q=;
 b=OW3OnxmuunOu401WuVSZFirs4JTxjyQLPZGSncGEmGpMmekYG7lQC71v4xAZ+SxdYqWQGA
 bZRlCTlAty7ur40ezUKKm58KbFX4uTyy0MSAvhEJPHslAi/oz5yrk4Z8Xw87KQu8HngVJB
 MCW8VP+Zqrf7efMx87dCda9lsZ9aJu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-kOQnUuwrMGClggk0YCLpVg-1; Thu, 14 Nov 2019 05:04:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8570080261F;
 Thu, 14 Nov 2019 10:04:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A66D860BDE;
 Thu, 14 Nov 2019 10:04:32 +0000 (UTC)
Message-ID: <32d52e92f4562b8f17fad9dfac8719df313529af.camel@redhat.com>
Subject: Re: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 14 Nov 2019 12:04:31 +0200
In-Reply-To: <20191114024635.11363-3-eblake@redhat.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-3-eblake@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kOQnUuwrMGClggk0YCLpVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-13 at 20:46 -0600, Eric Blake wrote:
> We document that for qcow2 persistent bitmaps, the name cannot exceed
> 1023 bytes.  It is inconsistent if transient bitmaps do not have to
> abide by the same limit, and it is unlikely that any existing client
> even cares about using bitmap names this long.  It's time to codify
> that ALL bitmaps managed by qemu (whether persistent in qcow2 or not)
> have a documented maximum length.

Strange a bit that 1023 was choosen, I guess implementation
uses a 1024 zero terminated string for storing the names
in memory.

>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json         |  2 +-
>  include/block/dirty-bitmap.h |  2 ++
>  block/dirty-bitmap.c         | 12 +++++++++---
>  block/qcow2-bitmap.c         |  2 ++
>  4 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index aa97ee264112..0cf68fea1450 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2042,7 +2042,7 @@
>  #
>  # @node: name of device/node which the bitmap is tracking
>  #
> -# @name: name of the dirty bitmap
> +# @name: name of the dirty bitmap (must be less than 1024 bytes)
>  #
>  # @granularity: the bitmap granularity, default is 64k for
>  #               block-dirty-bitmap-add
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 958e7474fb51..e2b20ecab9a3 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -14,6 +14,8 @@ typedef enum BitmapCheckFlags {
>                               BDRV_BITMAP_INCONSISTENT)
>  #define BDRV_BITMAP_ALLOW_RO (BDRV_BITMAP_BUSY | BDRV_BITMAP_INCONSISTEN=
T)
>=20
> +#define BDRV_BITMAP_MAX_NAME_SIZE 1023
> +
>  BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
>                                            uint32_t granularity,
>                                            const char *name,
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 4bbb251b2c9c..7039e8252009 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -104,9 +104,15 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDrive=
rState *bs,
>=20
>      assert(is_power_of_2(granularity) && granularity >=3D BDRV_SECTOR_SI=
ZE);
>=20
> -    if (name && bdrv_find_dirty_bitmap(bs, name)) {
> -        error_setg(errp, "Bitmap already exists: %s", name);
> -        return NULL;
> +    if (name) {
> +        if (bdrv_find_dirty_bitmap(bs, name)) {
> +            error_setg(errp, "Bitmap already exists: %s", name);
> +            return NULL;
> +        }
> +        if (strlen(name) > BDRV_BITMAP_MAX_NAME_SIZE) {
> +            error_setg(errp, "Bitmap name too long: %s", name);
> +            return NULL;
> +        }
>      }
>      bitmap_size =3D bdrv_getlength(bs);
>      if (bitmap_size < 0) {
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index ef9ef628a0d0..809bbc5d20c8 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -42,6 +42,8 @@
>  #define BME_MIN_GRANULARITY_BITS 9
>  #define BME_MAX_NAME_SIZE 1023
>=20
> +QEMU_BUILD_BUG_ON(BME_MAX_NAME_SIZE !=3D BDRV_BITMAP_MAX_NAME_SIZE);
> +
>  #if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
>  #error In the code bitmap table physical size assumed to fit into int
>  #endif


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky





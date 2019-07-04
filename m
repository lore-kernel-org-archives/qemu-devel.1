Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A8AC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343C421721
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343C421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4wn-0004K8-8z
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj4vL-0003cE-NU
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj4vK-0003Ox-J9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:49:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj4vH-0003Lv-JB; Thu, 04 Jul 2019 12:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 580CB30C585B;
 Thu,  4 Jul 2019 16:49:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08FAD1FC;
 Thu,  4 Jul 2019 16:49:10 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-10-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <b73e23a0-5454-c7d4-f1b3-da99e07b1edb@redhat.com>
Date: Thu, 4 Jul 2019 18:49:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-10-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aQyEr6J4DWjYS8406gbcx2MbqOmweOHhd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 04 Jul 2019 16:49:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/18] block/dirty-bitmap: add
 bdrv_dirty_bitmap_merge_internal
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQyEr6J4DWjYS8406gbcx2MbqOmweOHhd
Content-Type: multipart/mixed; boundary="rSYEPRvc2JSQ2tOwyDBf7LxEqjPfACsAX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <b73e23a0-5454-c7d4-f1b3-da99e07b1edb@redhat.com>
Subject: Re: [PATCH v2 09/18] block/dirty-bitmap: add
 bdrv_dirty_bitmap_merge_internal
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-10-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-10-jsnow@redhat.com>

--rSYEPRvc2JSQ2tOwyDBf7LxEqjPfACsAX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> I'm surprised it didn't come up sooner, but sometimes we have a +busy
> bitmap as a source. This is dangerous from the QMP API, but if we are
> the owner that marked the bitmap busy, it's safe to merge it using it a=
s
> a read only source.
>=20
> It is not safe in the general case to allow users to read from in-use
> bitmaps, so create an internal variant that foregoes the safety
> checking.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c      | 51 +++++++++++++++++++++++++++++++++------=

>  include/block/block_int.h |  3 +++
>  2 files changed, 47 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 95a9c2a5d8..b0f76826b3 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -810,11 +810,15 @@ bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyB=
itmap *bitmap,
>      return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
>  }
> =20
> +/**
> + * bdrv_merge_dirty_bitmap: merge src into dest.
> + * Ensures permissions on bitmaps are reasonable; use for public API.
> + *
> + * @backup: If provided, make a copy of dest here prior to merge.
> + */
>  void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBit=
map *src,
>                               HBitmap **backup, Error **errp)
>  {
> -    bool ret;
> -
>      qemu_mutex_lock(dest->mutex);
>      if (src->mutex !=3D dest->mutex) {
>          qemu_mutex_lock(src->mutex);
> @@ -833,6 +837,37 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest=
, const BdrvDirtyBitmap *src,
>          goto out;
>      }
> =20
> +    assert(bdrv_dirty_bitmap_merge_internal(dest, src, backup, false))=
;

Please keep the explicit @ret.  We never define NDEBUG, but doing things
with side effects inside of assert() is bad style nonetheless.

> +
> +out:
> +    qemu_mutex_unlock(dest->mutex);
> +    if (src->mutex !=3D dest->mutex) {
> +        qemu_mutex_unlock(src->mutex);
> +    }
> +}
> +
> +/**
> + * bdrv_dirty_bitmap_merge_internal: merge src into dest.
> + * Does NOT check bitmap permissions; not suitable for use as public A=
PI.
> + *
> + * @backup: If provided, make a copy of dest here prior to merge.
> + * @lock: If true, lock and unlock bitmaps on the way in/out.
> + * returns true if the merge succeeded; false if unattempted.
> + */
> +bool bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
> +                                      const BdrvDirtyBitmap *src,
> +                                      HBitmap **backup,
> +                                      bool lock)
> +{
> +    bool ret;
> +
> +    if (lock) {
> +        qemu_mutex_lock(dest->mutex);
> +        if (src->mutex !=3D dest->mutex) {
> +            qemu_mutex_lock(src->mutex);
> +        }
> +    }
> +

Why not check for INCONSISTENT and RO still?

Max

>      if (backup) {
>          *backup =3D dest->bitmap;
>          dest->bitmap =3D hbitmap_alloc(dest->size, hbitmap_granularity=
(*backup));


--rSYEPRvc2JSQ2tOwyDBf7LxEqjPfACsAX--

--aQyEr6J4DWjYS8406gbcx2MbqOmweOHhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eLgUACgkQ9AfbAGHV
z0ATIwf/ZB3jIuzP7aJqaJwgC0A8yPULXrX6uS0NhqiLq16gTH7EwQHFQpDlNvXj
fF/VzcRdvAh79wThtPIWxGQb2UA5OX8iYOQnrUb2HNH3HzSKz+RQIMbC4EN10YnN
u05ezBcIO3nBGoWCHrxBQ7FV+ella5gDI+iPJvpd9NVHlm/ZZ1HK09JsHDWJk3E6
x3x73rEfBw2MfFQcOcfmatrYb6xOun3JPHDbQV6k+49V44ULW7a7uSiHpaVB+E/g
rqOOrDPpwRGOxA5PFfQLtcqAXZHE0pLRNmz5Ii+HuAM89+M2kQoqmaNlotqNWNAL
vtI/qcg/YbUsEHLk0ZoQTXXe+tGv+g==
=fbbI
-----END PGP SIGNATURE-----

--aQyEr6J4DWjYS8406gbcx2MbqOmweOHhd--


Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021FC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DE2218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DE2218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj5nT-0007Qp-CU
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 13:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj5mC-0006un-Sc
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj5mB-0007ZC-PB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj5m9-0007XH-6x; Thu, 04 Jul 2019 13:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21E5481F01;
 Thu,  4 Jul 2019 17:43:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D089C4D2;
 Thu,  4 Jul 2019 17:43:47 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-13-jsnow@redhat.com>
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
Message-ID: <ee65fb7c-1f19-17f8-ea32-7aa3cc2a1b3d@redhat.com>
Date: Thu, 4 Jul 2019 19:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-13-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wgwfzhQbbgmchWHJ8aQaGS4EwV3ppU121"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 04 Jul 2019 17:43:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/18] block/backup: add 'always' bitmap
 sync policy
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
--wgwfzhQbbgmchWHJ8aQaGS4EwV3ppU121
Content-Type: multipart/mixed; boundary="BSYcZ9pKHgj5hA4enARb8lC3nULXM6U1Y";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <ee65fb7c-1f19-17f8-ea32-7aa3cc2a1b3d@redhat.com>
Subject: Re: [PATCH v2 12/18] block/backup: add 'always' bitmap sync policy
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-13-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-13-jsnow@redhat.com>

--BSYcZ9pKHgj5hA4enARb8lC3nULXM6U1Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> This adds an "always" policy for bitmap synchronization. Regardless of =
if
> the job succeeds or fails, the bitmap is *always* synchronized. This me=
ans
> that for backups that fail part-way through, the bitmap retains a recor=
d of
> which sectors need to be copied out to accomplish a new backup using th=
e
> old, partial result.
>=20
> In effect, this allows us to "resume" a failed backup; however the new =
backup
> will be from the new point in time, so it isn't a "resume" as much as i=
t is
> an "incremental retry." This can be useful in the case of extremely lar=
ge
> backups that fail considerably through the operation and we'd like to n=
ot waste
> the work that was already performed.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c       | 25 +++++++++++++++++--------
>  qapi/block-core.json |  5 ++++-
>  2 files changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 9cc5a7f6ca..495d8f71aa 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -266,16 +266,25 @@ static void backup_cleanup_sync_bitmap(BackupBloc=
kJob *job, int ret)
>  {
>      BdrvDirtyBitmap *bm;
>      BlockDriverState *bs =3D blk_bs(job->common.blk);
> +    bool sync =3D (((ret =3D=3D 0) || (job->bitmap_mode =3D=3D BITMAP_=
SYNC_MODE_ALWAYS)) \
> +                 && (job->bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER));
> =20
> -    if (ret < 0 || job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER) {
> -        /* Failure, or we don't want to synchronize the bitmap.
> -         * Merge the successor back into the parent, delete nothing. *=
/
> -        bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
> -        assert(bm);
> -    } else {
> -        /* Everything is fine, delete this bitmap and install the back=
up. */
> +    if (sync) {
> +        /* We succeeded, or we always intended to sync the bitmap.
> +         * Delete this bitmap and install the child. */
>          bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);=

> -        assert(bm);
> +    } else {
> +        /* We failed, or we never intended to sync the bitmap anyway.
> +         * Merge the successor back into the parent, keeping all data.=
 */
> +        bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
> +    }
> +
> +    assert(bm);
> +
> +    if (ret < 0 && job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {

=E2=80=9Cret < 0 && sync=E2=80=9D would be simpler =E2=80=93 your choice.=


> +        /* If we failed and synced, merge in the bits we didn't copy: =
*/
> +        bdrv_dirty_bitmap_merge_internal(bm, job->copy_bitmap,
> +                                         NULL, true);

I presume this is for sync=3Dfull?

If so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      }
>  }
> =20


--BSYcZ9pKHgj5hA4enARb8lC3nULXM6U1Y--

--wgwfzhQbbgmchWHJ8aQaGS4EwV3ppU121
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eOtIACgkQ9AfbAGHV
z0ACsQf+NpC99HuW4UngkvJK80fvIMl02x1MMxAf+LCSjjOcbD5VvDDH2pqz0ajW
29qW70WjJbSu+iHhlfIHdNgGyCv7U8yaaEDuOWcr3WUJhr1LZrh/369SiMb+4F/r
7wT9p+pSq3i540ltylhBb/2KSbftGLH93j4pZhyZ/j38+ZFCZDymEJEOu3iheMOo
1lHOxiQYfS6yfBMiwG50I051cPVr9RnkKD4tUhWxBlo+1R27L16GbOTZlYghWoXI
O1LMDta7chd9GLb+zUnFXGd65azWug9usHmi6rQzU/7ekdDDCCxS1XY/qWNdoaov
Yb7YBkn/UTiITBsyfBG37tHHzD+itQ==
=4HUp
-----END PGP SIGNATURE-----

--wgwfzhQbbgmchWHJ8aQaGS4EwV3ppU121--


Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ADAC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141CE2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141CE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he0pH-00082I-C5
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 13:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1he0gi-0000nF-9Q
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1he0Ql-0002Vh-To
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1he0QR-0002Mg-5H; Thu, 20 Jun 2019 13:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3387430811C7;
 Thu, 20 Jun 2019 17:00:36 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D9FC60BFB;
 Thu, 20 Jun 2019 17:00:26 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
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
Message-ID: <9f5578c5-e513-d848-6f64-2e1c494e12e1@redhat.com>
Date: Thu, 20 Jun 2019 19:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6LQNmG1AQvJY2G0ZRgHout9sgBA9qUTHb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 20 Jun 2019 17:00:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap
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
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6LQNmG1AQvJY2G0ZRgHout9sgBA9qUTHb
Content-Type: multipart/mixed; boundary="zXp0aVoRenqDt0eJGd1ocwO6ezq6KY0AK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <9f5578c5-e513-d848-6f64-2e1c494e12e1@redhat.com>
Subject: Re: [PATCH 07/12] block/backup: add 'always' bitmap sync policy
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-8-jsnow@redhat.com>

--zXp0aVoRenqDt0eJGd1ocwO6ezq6KY0AK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
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
>  qapi/block-core.json |  5 ++++-
>  block/backup.c       | 10 ++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0332dcaabc..58d267f1f5 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1143,6 +1143,9 @@
>  # An enumeration of possible behaviors for the synchronization of a bi=
tmap
>  # when used for data copy operations.
>  #
> +# @always: The bitmap is always synchronized with remaining blocks to =
copy,
> +#          whether or not the operation has completed successfully or =
not.
> +#
>  # @conditional: The bitmap is only synchronized when the operation is =
successul.
>  #               This is useful for Incremental semantics.
>  #
> @@ -1153,7 +1156,7 @@
>  # Since: 4.1
>  ##
>  { 'enum': 'BitmapSyncMode',
> -  'data': ['conditional', 'never'] }
> +  'data': ['always', 'conditional', 'never'] }
> =20
>  ##
>  # @MirrorCopyMode:
> diff --git a/block/backup.c b/block/backup.c
> index 627f724b68..beb2078696 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -266,15 +266,17 @@ static void backup_cleanup_sync_bitmap(BackupBloc=
kJob *job, int ret)
>      BlockDriverState *bs =3D blk_bs(job->common.blk);
> =20
>      if (ret < 0 || job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER) {
> -        /* Failure, or we don't want to synchronize the bitmap.
> -         * Merge the successor back into the parent, delete nothing. *=
/
> +        /* Failure, or we don't want to synchronize the bitmap. */
> +        if (job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
> +            bdrv_dirty_bitmap_claim(job->sync_bitmap, &job->copy_bitma=
p);

Hmm...  OK, bitmaps in backup always confuse me, so bear with me, please.=


(Hi, I=E2=80=99m a time traveler from the end of this section and I can t=
ell you
that everything is fine.  I was just confused.  I=E2=80=99ll still keep t=
his
here, because it was so much work.)

The copy_bitmap is copied from the sync_bitmap at the beginning, so the
sync_bitmap can continue to be dirtied, but that won=E2=80=99t affect the=
 job.
In normal incremental mode, this means that the sync point is always at
the beginning of the job.  (Well, naturally, because that=E2=80=99s how b=
ackup
is supposed to go.)

But then replacing the sync_bitmap with the copy_bitmap here means that
all of these dirtyings that happened during the job are lost.  Hmm, but
that doesn=E2=80=99t matter, does it?  Because whenever something was dir=
tied in
sync_bitmap, the corresponding area must have been copied to the backup
due to the job.

Ah, yes, it would actually be wrong to keep the new dirty bits, because
in this mode, sync_bitmap should (on failure) reflect what is left to
copy to make the backup complete.  Copying these newly dirtied sectors
would be wrong.  (Yes, I know you wrote that in the documentation of
@always.  I just tried to get a different perspective.)

Yes, yes, and copy_bitmap is always set whenever a CBW to the target
fails before the source can be updated.  Good, good.


Hi, I=E2=80=99m the time traveler from above.  I also left the section he=
re so I
can give one of my trademark =E2=80=9CRamble, ramble,

Reviewed-by: Max Reitz <mreitz@redhat.com>

=E2=80=9D

> +        }
> +        /* Merge the successor back into the parent. */
>          bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
> -        assert(bm);
>      } else {
>          /* Everything is fine, delete this bitmap and install the back=
up. */
>          bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);=

> -        assert(bm);
>      }
> +    assert(bm);
>  }
> =20
>  static void backup_commit(Job *job)
>=20



--zXp0aVoRenqDt0eJGd1ocwO6ezq6KY0AK--

--6LQNmG1AQvJY2G0ZRgHout9sgBA9qUTHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Lu6gACgkQ9AfbAGHV
z0AsSAf/WWI1boYQzVpozaiQJQR/ATxLZVrI7nC2ugNcupmxjKJBsMNm9TOhE+94
IZPVAUhG1yZH66U9d+qv5USVryCbnKiOP6ML6auLx3SjlgHidYFVlBcCrBSzemxx
7rDQiAiEYbOOMAlZTNqW9WhTxCY1tsWuRQGT5z01yyQI465qDZOhMlgTcx8/GHO3
QZvQSpbO6iWubJ9cdcBFsIZ4qfRZyOaRoIKAyWe/E4f/bIjhqU1zmJp1euDtFt21
Imr/M1OnCqSerxW8DaQBhZSD5kZwYpEulLo+qYvPsJgrLDcz7oV9ieZvRSjoFKa6
XGt6bHvbE6fRiOuIVlnSekKqp8Gxag==
=Fjon
-----END PGP SIGNATURE-----

--6LQNmG1AQvJY2G0ZRgHout9sgBA9qUTHb--


Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6702BC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FDB2085A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FDB2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hil6t-0000gI-IF
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 15:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hil5Z-0008H4-L2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hil5X-0005wx-8A
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hil5U-0005vU-Mm; Wed, 03 Jul 2019 15:38:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04EEF308339F;
 Wed,  3 Jul 2019 19:38:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-65.brq.redhat.com
 [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E6EF3DBC;
 Wed,  3 Jul 2019 19:38:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190701201330.29718-1-jsnow@redhat.com>
 <20190701201330.29718-3-jsnow@redhat.com>
 <0bd996a0-877f-6658-c120-09512bdacd1b@redhat.com>
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
Message-ID: <c1b0f271-38a3-4a3d-8433-50ebf61ec5e4@redhat.com>
Date: Wed, 3 Jul 2019 21:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0bd996a0-877f-6658-c120-09512bdacd1b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5YQiEb6iIy2YDsEUXXlm79UQ5tR6ZsbS2"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 19:38:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: implement
 block-dirty-bitmap-remove transaction action
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5YQiEb6iIy2YDsEUXXlm79UQ5tR6ZsbS2
Content-Type: multipart/mixed; boundary="JnfN1fyB6GMlHtT33aKCUDFvJ4b1W6xpH";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
Message-ID: <c1b0f271-38a3-4a3d-8433-50ebf61ec5e4@redhat.com>
Subject: Re: [PATCH v2 2/3] qapi: implement block-dirty-bitmap-remove
 transaction action
References: <20190701201330.29718-1-jsnow@redhat.com>
 <20190701201330.29718-3-jsnow@redhat.com>
 <0bd996a0-877f-6658-c120-09512bdacd1b@redhat.com>
In-Reply-To: <0bd996a0-877f-6658-c120-09512bdacd1b@redhat.com>

--JnfN1fyB6GMlHtT33aKCUDFvJ4b1W6xpH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 21:30, Max Reitz wrote:
> On 01.07.19 22:13, John Snow wrote:
>> It is used to do transactional movement of the bitmap (which is
>> possible in conjunction with merge command). Transactional bitmap
>> movement is needed in scenarios with external snapshot, when we don't
>> want to leave copy of the bitmap in the base image.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  qapi/transaction.json          |  2 +
>>  include/block/dirty-bitmap.h   |  3 +-
>>  block.c                        |  2 +-
>>  block/dirty-bitmap.c           | 16 +++----
>>  blockdev.c                     | 79 +++++++++++++++++++++++++++++++--=
-
>>  migration/block-dirty-bitmap.c |  2 +-
>>  6 files changed, 87 insertions(+), 17 deletions(-)
>=20
> [...]
>=20
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 95a9c2a5d8..8551f8219e 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -48,10 +48,9 @@ struct BdrvDirtyBitmap {
>>      bool inconsistent;          /* bitmap is persistent, but inconsis=
tent.
>>                                     It cannot be used at all in any wa=
y, except
>>                                     a QMP user can remove it. */
>> -    bool migration;             /* Bitmap is selected for migration, =
it should
>> -                                   not be stored on the next inactiva=
tion
>> -                                   (persistent flag doesn't matter un=
til next
>> -                                   invalidation).*/
>> +    bool squelch_persistence;   /* We are either migrating or deletin=
g this
>> +                                 * bitmap; it should not be stored on=
 the next
>> +                                 * inactivation. */
>=20
> I like the English lessons you give me, but why not just dont_store?  O=
r
> skip_storing?
>=20
>>      QLIST_ENTRY(BdrvDirtyBitmap) list;
>>  };
>> =20
>=20
> [...]
>=20
>> diff --git a/blockdev.c b/blockdev.c
>> index 01248252ca..4143ab7bbb 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>=20
> [...]
>=20
>> +static void block_dirty_bitmap_remove_abort(BlkActionState *common)
>> +{
>> +    BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,=

>> +                                             common, common);
>> +
>> +    if (state->bitmap) {
>> +        bdrv_dirty_bitmap_squelch_persistence(state->bitmap, false);
>> +        bdrv_dirty_bitmap_set_busy(state->bitmap, false);
>=20
> Don=E2=80=99t you need to undo the removal?  Like, re-add it to state->=
bs, and
> re-store it?

Ah, right, no need to re-add it because without *release(), it was never
removed from state->bs.

Having removed the persistent bitmap makes without doing anything here
to re-add it to the qcow2 file makes me a bit uneasy, though...  (It
should be stored automatically when the qcow2 file is closed or
anything, but, you know.  Feel free to say =E2=80=9CYes, it will be store=
d
automatically, don=E2=80=99t worry.=E2=80=9D)

Max

> [...]
>=20
>> @@ -2892,13 +2944,28 @@ void qmp_block_dirty_bitmap_remove(const char =
*node, const char *name,
>>          aio_context_acquire(aio_context);
>>          bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
>>          aio_context_release(aio_context);
>> +
>>          if (local_err !=3D NULL) {
>>              error_propagate(errp, local_err);
>> -            return;
>> +            return NULL;
>>          }
>>      }
>> =20
>> -    bdrv_release_dirty_bitmap(bs, bitmap);
>> +    if (release) {
>> +        bdrv_release_dirty_bitmap(bs, bitmap);
>> +    }
>> +
>> +    if (bitmap_bs) {
>> +        *bitmap_bs =3D bs;
>> +    }
>> +
>> +    return bitmap;
>=20
> I=E2=80=99d prefer =E2=80=9Crelease ? NULL : bitmap=E2=80=9D.
>=20
> Max
>=20
>> +}
>> +
>> +void qmp_block_dirty_bitmap_remove(const char *node, const char *name=
,
>> +                                   Error **errp)
>> +{
>> +    do_block_dirty_bitmap_remove(node, name, true, NULL, errp);
>>  }
>> =20
>>  /**
>=20



--JnfN1fyB6GMlHtT33aKCUDFvJ4b1W6xpH--

--5YQiEb6iIy2YDsEUXXlm79UQ5tR6ZsbS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0dBDEACgkQ9AfbAGHV
z0AAZgf+Jf4jReceFxAx/dxmMa6qMZtOLvjfF4dQ8IoAc6CCiReiI5I+jzFAWxOK
aAeaBrXkzt2e/in+wqLT+DkGDBBUr+KqkZ17NbbU9+iVZLm7jv5dQNRdZmcCB7J+
HiA1rMYD9LmzyXNtl0MTLvqj6VO+66f94vHl3b3z9tVcsVKPLmQQpEk6Mcb5X8Us
PgH9MZLqhT1IkA0dnAgkyJlHEINq70PX9Ze3TLoTYfbf0c3GUXpASoRXYj7yQ3Vn
qkTZoGCmUIFts/5u2BvpLxcPJuJdU+q2DWCWEFpRrrx3rRXZRiYFq3GcCehHfDjo
7bvCgZ7AcOOavESXEHYyeUAc0n9YWA==
=aMz5
-----END PGP SIGNATURE-----

--5YQiEb6iIy2YDsEUXXlm79UQ5tR6ZsbS2--


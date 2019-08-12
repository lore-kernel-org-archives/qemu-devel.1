Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51551C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BE620651
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BE620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAMS-0004Pl-Cd
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxALk-0003b2-Nb
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxALj-0007oW-Iz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxALd-0007fN-Rq; Mon, 12 Aug 2019 09:26:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 599F664D32;
 Mon, 12 Aug 2019 13:26:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CBFB6FDB0;
 Mon, 12 Aug 2019 13:26:47 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
 <586c3836-66b6-2a67-3f2c-de38f9a52bcd@virtuozzo.com>
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
Message-ID: <cbbe5704-7e50-e6b5-a9bd-1b14a6c86019@redhat.com>
Date: Mon, 12 Aug 2019 15:26:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <586c3836-66b6-2a67-3f2c-de38f9a52bcd@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jEEhjxfFw6DUwPDios4mH4ObOMePpzApE"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 12 Aug 2019 13:26:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 25/42] mirror: Deal with filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jEEhjxfFw6DUwPDios4mH4ObOMePpzApE
Content-Type: multipart/mixed; boundary="Prkjm0cv2giXFNyw4UjNtQMuMufffZIIH";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <cbbe5704-7e50-e6b5-a9bd-1b14a6c86019@redhat.com>
Subject: Re: [PATCH v6 25/42] mirror: Deal with filters
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
 <586c3836-66b6-2a67-3f2c-de38f9a52bcd@virtuozzo.com>
In-Reply-To: <586c3836-66b6-2a67-3f2c-de38f9a52bcd@virtuozzo.com>

--Prkjm0cv2giXFNyw4UjNtQMuMufffZIIH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 13:09, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:13, Max Reitz wrote:
>> This includes some permission limiting (for example, we only need to
>> take the RESIZE permission for active commits where the base is smalle=
r
>> than the top).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/mirror.c | 117 ++++++++++++++++++++++++++++++++++++++---------=
--
>>   blockdev.c     |  47 +++++++++++++++++---
>>   2 files changed, 131 insertions(+), 33 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 54bafdf176..6ddbfb9708 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>=20
>=20
> [..]
>=20
>> @@ -1693,15 +1734,39 @@ static BlockJob *mirror_start_job(
>>       /* In commit_active_start() all intermediate nodes disappear, so=

>>        * any jobs in them must be blocked */
>>       if (target_is_backing) {
>> -        BlockDriverState *iter;
>> -        for (iter =3D backing_bs(bs); iter !=3D target; iter =3D back=
ing_bs(iter)) {
>> -            /* XXX BLK_PERM_WRITE needs to be allowed so we don't blo=
ck
>> -             * ourselves at s->base (if writes are blocked for a node=
, they are
>> -             * also blocked for its backing file). The other options =
would be a
>> -             * second filter driver above s->base (=3D=3D target). */=

>> +        BlockDriverState *iter, *filtered_target;
>> +        uint64_t iter_shared_perms;
>> +
>> +        /*
>> +         * The topmost node with
>> +         * bdrv_skip_rw_filters(filtered_target) =3D=3D bdrv_skip_rw_=
filters(target)
>> +         */
>> +        filtered_target =3D bdrv_filtered_cow_bs(bdrv_find_overlay(bs=
, target));
>> +
>> +        assert(bdrv_skip_rw_filters(filtered_target) =3D=3D
>> +               bdrv_skip_rw_filters(target));
>> +
>> +        /*
>> +         * XXX BLK_PERM_WRITE needs to be allowed so we don't block
>> +         * ourselves at s->base (if writes are blocked for a node, th=
ey are
>> +         * also blocked for its backing file). The other options woul=
d be a
>> +         * second filter driver above s->base (=3D=3D target).
>> +         */
>> +        iter_shared_perms =3D BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRI=
TE;
>> +
>> +        for (iter =3D bdrv_filtered_bs(bs); iter !=3D target;
>> +             iter =3D bdrv_filtered_bs(iter))
>> +        {
>> +            if (iter =3D=3D filtered_target) {
>> +                /*
>> +                 * From here on, all nodes are filters on the base.
>> +                 * This allows us to share BLK_PERM_CONSISTENT_READ.
>> +                 */
>> +                iter_shared_perms |=3D BLK_PERM_CONSISTENT_READ;
>=20
>=20
> Hmm, I don't understand, why read from upper nodes is not shared?

Because they don=E2=80=99t represent a consistent disk state during the c=
ommit.

Please don=E2=80=99t ask me details about CONSISTENT_READ, because I alwa=
ys
pretend I understand it, but I never really do, actually.

(My problem is that I do understand why the intermediate nodes shouldn=E2=
=80=99t
share CONSISTENT_READ: It=E2=80=99s because they only read garbage, effec=
tively.
 But I don=E2=80=99t understand how any block job target (like our base h=
ere)
can have CONSISTENT_READ.  Block job targets are mostly written front to
back (except with sync=3Dnone), so they too don=E2=80=99t =E2=80=9C[repre=
sent] the
contents of a disk at a specific point.=E2=80=9D
But that is how it was, so that is how it should be kept.)

If it makes you any happier, BLK_PERM_CONSISTENT_READ=E2=80=99s descripti=
on
explicitly notes that it will not be shared on intermediate nodes of a
commit job.

Max

>> +            }
>> +
>>               ret =3D block_job_add_bdrv(&s->common, "intermediate nod=
e", iter, 0,
>> -                                     BLK_PERM_WRITE_UNCHANGED | BLK_P=
ERM_WRITE,
>> -                                     errp);
>> +                                     iter_shared_perms, errp);
>>               if (ret < 0) {
>>                   goto fail;
>>               }
>=20
> [..]
>=20



--Prkjm0cv2giXFNyw4UjNtQMuMufffZIIH--

--jEEhjxfFw6DUwPDios4mH4ObOMePpzApE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RaRYACgkQ9AfbAGHV
z0D6mgf9FXNatEXCLJwjng85u4ndmnaVuwS5LpMvmJVQ+2WShzZmqPGZMYkdAi1v
OFjDd3xN57VvYj0dH7b2kxv7OvpvyTzBpniygEKxOu7OXc6Rb0SCUxXRk+DmeMFm
jlzoTAG/bq1FlkMzYMOws+1WecS46b8LgF/u+6K4duFsmiJcJKxrdi7p+WoVJTkp
2HbDRfmkd5j8Gn+lcv1ZgyJSc6WV1/J0T6TjlhWtc7D2YIV+LKv9TEfwUWFGJU8D
auCLMCEg5veDxK4hEOI5g3EKP3W4h+rq4dnYjI4EDmySQAK4rr/CnUHVhyEaAUBP
whHSW1rC/fhtV3FbVnu3lMRC6zKT6g==
=SjS8
-----END PGP SIGNATURE-----

--jEEhjxfFw6DUwPDios4mH4ObOMePpzApE--


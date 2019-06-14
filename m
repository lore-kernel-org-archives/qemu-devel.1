Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF2C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E24C20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E24C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbn88-0006as-Bs
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmbS-0000Pt-Fx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmbR-0005Ne-0b
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmbL-0004zH-Um; Fri, 14 Jun 2019 09:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16F0F3082A8F;
 Fri, 14 Jun 2019 13:50:26 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E20432CE56;
 Fri, 14 Jun 2019 13:50:24 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
 <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
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
Message-ID: <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
Date: Fri, 14 Jun 2019 15:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6HEAMF8GBcBG0nz38dU23yy6s3EUrDVBH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 14 Jun 2019 13:50:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 14/42] block: Use CAFs when working with
 backing chains
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
--6HEAMF8GBcBG0nz38dU23yy6s3EUrDVBH
Content-Type: multipart/mixed; boundary="AEHiwxGZ3AF3Pk9Sz6WJnk3OIa7jgkwKk";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
Subject: Re: [PATCH v5 14/42] block: Use CAFs when working with backing chains
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
 <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
In-Reply-To: <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>

--AEHiwxGZ3AF3Pk9Sz6WJnk3OIa7jgkwKk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 15:26, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> Use child access functions when iterating through backing chains so
>> filters do not break the chain.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c | 40 ++++++++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 11f37983d9..505b3e9a01 100644
>> --- a/block.c
>> +++ b/block.c

[...]

>> @@ -4273,11 +4274,18 @@ int bdrv_change_backing_file(BlockDriverState =
*bs,
>>   BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>>                                       BlockDriverState *bs)
>>   {
>> -    while (active && bs !=3D backing_bs(active)) {
>> -        active =3D backing_bs(active);
>> +    bs =3D bdrv_skip_rw_filters(bs);
>> +    active =3D bdrv_skip_rw_filters(active);
>> +
>> +    while (active) {
>> +        BlockDriverState *next =3D bdrv_backing_chain_next(active);
>> +        if (bs =3D=3D next) {
>> +            return active;
>> +        }
>> +        active =3D next;
>>       }
>>  =20
>> -    return active;
>> +    return NULL;
>>   }
>=20
> Semantics changed for this function.
> It is used in two places
> 1. from bdrv_find_base wtih @bs=3DNULL, it should be unchanged, as I ho=
pe we will never have
>     filter node as a bottom of some valid chain
>=20
> 2. from qmp_block_commit, only to check op-blocker... hmmm. I really do=
n't understand,
> why do we check BLOCK_OP_TYPE_COMMIT_TARGET on top_bs overlay.. top_bs =
overlay is out of the job,
> what is this check for?

There is a loop before this check which checks that the same blocker is
not set on any nodes between top and base (both inclusive).  I guess
non-active commit checks the node above @top, too, because its backing
file will change.

>>   /* Given a BDS, searches for the base layer. */

[...]

>> @@ -5149,7 +5165,7 @@ BlockDriverState *bdrv_find_backing_image(BlockD=
riverState *bs,
>>               char *backing_file_full_ret;
>>  =20
>>               if (strcmp(backing_file, curr_bs->backing_file) =3D=3D 0=
) {
>=20
> hmm, interesting, what bs->backing_file now means? It's strange enough =
to store such field on
> bds, when we have backing link anyway..

Patch 37 has you covered. :-)

Max


--AEHiwxGZ3AF3Pk9Sz6WJnk3OIa7jgkwKk--

--6HEAMF8GBcBG0nz38dU23yy6s3EUrDVBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Dph8ACgkQ9AfbAGHV
z0DXGAgAjnQGJOuB6+oLr19OWlferPhv6WMbDB8f4b2EOiQuW328qm1jDgBGbRBF
S4V4bffPmMBB3il1wh3qw+LOf0hm2/D14yzqmq3Vqx7ryhRKwNcpeFTJqKs4mLl1
8+VeDcwofBiOwORhhV/z+poAu+K4CldoTKaE8qW+cLL5T+0oHpRs5PbwBiuc3bwB
5IJb0OzfTaHrRIr3qhNA42Y5393nIJBsT0G7dCdjrg2251jYW1FtEbWbWwA8ykFZ
Zjz+3UQ553MfEwkC/HcQMxuv1LLEQR/elRSDIw4eghsZmPO9UPn5JaH47nXm6lQP
uCOy6Qe/ZeyS+wNfrcZ8/Dp5hj1k0A==
=cLVy
-----END PGP SIGNATURE-----

--6HEAMF8GBcBG0nz38dU23yy6s3EUrDVBH--


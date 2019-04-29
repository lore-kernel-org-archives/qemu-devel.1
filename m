Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596ABC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205AF20652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205AF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAHC-00060g-E5
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:41:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9hX-0007Rm-DI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9hV-0008KN-MG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hL9hR-0008HJ-H6; Mon, 29 Apr 2019 13:04:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBC4830018E0;
	Mon, 29 Apr 2019 17:04:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-144.brq.redhat.com
	[10.40.204.144])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C288F1000049;
	Mon, 29 Apr 2019 17:04:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
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
Message-ID: <29689dc3-9d7a-ec86-9725-a053b950c7e6@redhat.com>
Date: Mon, 29 Apr 2019 19:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 29 Apr 2019 17:04:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pbonzini@redhat.com, berto@igalia.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170411.L6ifG_Dtxf_uA1i3Y8dohQdqorhuM9ri8kuzrLZRgqM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <29689dc3-9d7a-ec86-9725-a053b950c7e6@redhat.com>
Subject: Re: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-8-vsementsov@virtuozzo.com>
 <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
In-Reply-To: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.19 18:37, Max Reitz wrote:
> On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
>> Background: decryption will be done in threads, to take benefit of it,=

>> we should move it out of the lock first.
>=20
> ...which is safe after your commit c972fa123c73501b4, I presume.
>=20
> (At first glance, the patched looked a bit weird to me because it
> doesn't give a reason why dropping the lock around
> qcrypto_block_decrypt() would be OK.)

On second thought, I guess the actual reason it's safe is because the
crypto code never yields.

Max

>> But let's go further: it turns out, that for locking around switch
>> cases we have only two variants: when we just do memset(0) not
>> releasing the lock (it is useless) and when we actually can handle the=

>> whole case out of the lock. So, refactor the whole thing to reduce
>> locked code region and make it clean.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2.c | 46 ++++++++++++++++++++++------------------------
>>  1 file changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 46e8e39da5..fcf92a7eb6 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1983,6 +1983,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDri=
verState *bs, uint64_t offset,
>> =20
>>          ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &clu=
ster_offset);
>=20
> Isn't this the only function in the loop that actually needs the lock?
> Wouldn't it make more sense to just take it around this call?
>=20
> Max
>=20
>>          if (ret < 0) {
>> +            qemu_co_mutex_unlock(&s->lock);
>>              goto fail;
>>          }
>> =20
>=20



--2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzHLosACgkQ9AfbAGHV
z0Dr5wgAk7auvTJkpU3dpCuYklzekHeXLZHN/bZNLC16FBcaBY/nNbHjSc7rKHvK
KtC3x8Ri3mCtCVj19IbxDUu4NaZWP4I3Ef8fYmBlZCw2OjXBpIQHzSrW66hdeMaZ
9JnVadY0NWA+5HJbMkouEv0KgU9yx8dSThWNFt9pYWTPmVq5VXzkAvuKHT7a39Yh
dbBQEPWc0LMNIsrMKCicHjAjQJlPxmLOfYRY1+hbKBJzXnJWoZdjdnsyzJQhzKOx
EFEphs6sC4FDEzeRvdKKUmS2cv3jfm9CL3PBceBk1RQ2gVwPIUlAIG/S9lUvPj7k
EA7TW/KC/PurvXPnzZTkNx7eA1tUXA==
=TYVn
-----END PGP SIGNATURE-----

--2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7--


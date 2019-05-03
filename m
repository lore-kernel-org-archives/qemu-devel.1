Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9431BC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575032075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575032075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYt0-0002BI-H5
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:10:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYs0-0001gl-6m
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYrz-0006W0-4k
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hMYrw-0006Ud-Mg; Fri, 03 May 2019 10:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9983430198A7;
	Fri,  3 May 2019 14:08:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-131.brq.redhat.com
	[10.40.204.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E965E2C169;
	Fri,  3 May 2019 14:08:50 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
	<66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
	<35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
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
Message-ID: <52acdba2-a13a-5323-a804-9cc6b680f2fb@redhat.com>
Date: Fri, 3 May 2019 16:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZppAl84phsH03XPiN6meRlOuYLnzJPjyN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 03 May 2019 14:08:55 +0000 (UTC)
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503140849.J9JvGfgZ5yCEJmbh8c8KHhVP9T-zq1N-8RIFh5fNYNk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZppAl84phsH03XPiN6meRlOuYLnzJPjyN
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com"
 <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>
Message-ID: <52acdba2-a13a-5323-a804-9cc6b680f2fb@redhat.com>
Subject: Re: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-8-vsementsov@virtuozzo.com>
 <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
 <66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
 <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
In-Reply-To: <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.04.19 11:44, Vladimir Sementsov-Ogievskiy wrote:
> 30.04.2019 11:38, Vladimir Sementsov-Ogievskiy wrote:
>> 29.04.2019 19:37, Max Reitz wrote:
>>> On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
>>>> Background: decryption will be done in threads, to take benefit of i=
t,
>>>> we should move it out of the lock first.
>>>
>>> ...which is safe after your commit c972fa123c73501b4, I presume.
>>>
>>> (At first glance, the patched looked a bit weird to me because it
>>> doesn't give a reason why dropping the lock around
>>> qcrypto_block_decrypt() would be OK.)
>>>
>>>> But let's go further: it turns out, that for locking around switch
>>>> cases we have only two variants: when we just do memset(0) not
>>>> releasing the lock (it is useless) and when we actually can handle t=
he
>>>> whole case out of the lock. So, refactor the whole thing to reduce
>>>> locked code region and make it clean.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>> ---
>>>> =C2=A0 block/qcow2.c | 46 ++++++++++++++++++++++--------------------=
----
>>>> =C2=A0 1 file changed, 22 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 46e8e39da5..fcf92a7eb6 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -1983,6 +1983,7 @@ static coroutine_fn int qcow2_co_preadv(BlockD=
riverState *bs, uint64_t offset,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2=
_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
>>>
>>> Isn't this the only function in the loop that actually needs the lock=
?
>>> Wouldn't it make more sense to just take it around this call?
>>>
>>
>> Hmm, looks correct, I'll resend.
>>
>>
>=20
> Or not, actually, we may have several qcow2_get_data_offset calls under=
 one lock,
> if clusters are different kinds of ZERO. So, I think better to keep it =
as is for now.

Hm, but how is this relevant?  For one thing, if that was a problem if
some other party concurrently changes the image, then that would be a
problem in general.  Keeping the lock would hide it for different kinds
of read-as-zero clusters, but it would still appear if data clusters and
other clusters are interleaved, wouldn=E2=80=99t it?

Also, this is a coroutine.  As long as nothing yields, nothing gets
concurrent access.  I don=E2=80=99t see anything outside of
qcow2_get_cluster_offset() that could yield as long as we only see
read-as-zero clusters.

Max


--ZppAl84phsH03XPiN6meRlOuYLnzJPjyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzMS3EACgkQ9AfbAGHV
z0BCGAgAgkgtEKuwKn2/BRPFl9bw8gk3AKwlVquIcDKq8vvzQFpPydbsSqloFEhA
Ysm/Oxq7kUx+nyT5okf0kG2riJ2muKS3YVMsgmeKcSRrfi9iEgfztfYF3qIwrIiz
veA9rji6xIWYTdBSIprKQ8QJuRmCE28ahUfzFVpTBFed8F1iSgnbyI06VbHjnBxo
3QaRgRzw43ktIaEAXYGzB6PbOxXOEz1zeI6QnJSjcUgBZ8AFj3/mbqF4bNv4M1dd
vglUAF8a8KepBRj/sum3kqaA64BIHmCzEj778pQK471PB+Hq2XxKW5dROK6rcYzt
D5jkjjc+2Vn4uE8PGRoCFY5f/yV47A==
=uQu1
-----END PGP SIGNATURE-----

--ZppAl84phsH03XPiN6meRlOuYLnzJPjyN--


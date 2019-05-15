Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3BAC04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 04:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF19A20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 04:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF19A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQlEq-0005vs-FH
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 00:09:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQlDe-0005Am-N5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 00:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQlDd-00027r-HZ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 00:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQlDa-0001vF-Gd; Wed, 15 May 2019 00:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F40D120C0;
	Wed, 15 May 2019 04:08:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-29.brq.redhat.com
	[10.40.204.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2507C10021B2;
	Wed, 15 May 2019 04:08:35 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190514214230.22601-1-mreitz@redhat.com>
	<20190514214230.22601-2-mreitz@redhat.com>
	<88ab9614-e1ec-650f-8834-4a906768aedb@redhat.com>
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
Message-ID: <61ff8c16-e849-0aab-0bae-230128b692dc@redhat.com>
Date: Wed, 15 May 2019 06:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <88ab9614-e1ec-650f-8834-4a906768aedb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oKiIdsmPXJSgdtJduFUGTunuLfUYvbegS"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 15 May 2019 04:08:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] block/file-posix: Unaligned O_DIRECT
 block-status
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKiIdsmPXJSgdtJduFUGTunuLfUYvbegS
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
Message-ID: <61ff8c16-e849-0aab-0bae-230128b692dc@redhat.com>
Subject: Re: [PATCH 1/2] block/file-posix: Unaligned O_DIRECT block-status
References: <20190514214230.22601-1-mreitz@redhat.com>
 <20190514214230.22601-2-mreitz@redhat.com>
 <88ab9614-e1ec-650f-8834-4a906768aedb@redhat.com>
In-Reply-To: <88ab9614-e1ec-650f-8834-4a906768aedb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.05.19 23:50, Eric Blake wrote:
> On 5/14/19 4:42 PM, Max Reitz wrote:
>> Currently, qemu crashes whenever someone queries the block status of a=
n
>> unaligned image tail of an O_DIRECT image:
>> $ echo > foo
>> $ qemu-img map --image-opts driver=3Dfile,filename=3Dfoo,cache.direct=3D=
on
>> Offset          Length          Mapped to       File
>> qemu-img: block/io.c:2093: bdrv_co_block_status: Assertion `*pnum &&
>> QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset'
>> failed.
>>
>> This is because bdrv_co_block_status() checks that the result returned=

>> by the driver's implementation is aligned to the request_alignment, bu=
t
>> file-posix can fail to do so, which is actually mentioned in a comment=

>> there: "[...] possibly including a partial sector at EOF".
>>
>> Fix this by rounding up those partial sectors.
>>
>> There are two possible alternative fixes:
>> (1) We could refuse to open unaligned image files with O_DIRECT
>>     altogether.  That sounds reasonable until you realize that qcow2
>>     does necessarily not fill up its metadata clusters, and that nobod=
y
>>     runs qemu-img create with O_DIRECT.  Therefore, unpreallocated qco=
w2
>>     files usually have an unaligned image tail.
>=20
> Yep, non-starter.
>=20
>>
>> (2) bdrv_co_block_status() could ignore unaligned tails.  It actually
>>     throws away everything past the EOF already, so that sounds
>>     reasonable.
>>     Unfortunately, the block layer knows file lengths only with a
>>     granularity of BDRV_SECTOR_SIZE, so bdrv_co_block_status() usually=

>>     would have to guess whether its file length information is inexact=

>>     or whether the driver is broken.
>=20
> Well, if I ever get around to my thread of making the block layer honor=

> byte-accurate sizes, instead of rounding up, then there is no longer
> than inexactness. I think our mails crossed, and you missed another ide=
a
> of mine of having block drivers (probably only file-posix, per your
> audit) set BDRV_BLOCK_EOF when returning an unaligned answer due to EOF=
,
> as the key for letting the block layer know whether the unaligned answe=
r
> was due to size rounding.

Yes, that EOF change makes sense, I think.  Not least because right now
the EOF detection in block/io.c has to be a bit wonky considering that
it's inexact...  But to be honest, returning the EOF flag from the
drivers would have required me to modify all drivers.  I felt like maybe
that something to be left for another time. :-)

OTOH, I don=E2=80=99t know whether returning the EOF flag from the driver=
s would
still sense if we had a byte-accurate bdrv_getlength()...

>> Fixing what raw_co_block_status() returns is the safest thing to do.
>=20
> Agree.
>=20
>>
>> There seems to be no other block driver that sets request_alignment an=
d
>> does not make sure that it always returns aligned values.
>=20
> Thanks for auditing.
>=20
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/file-posix.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index e09e15bbf8..f489a5420c 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2488,6 +2488,9 @@ static int coroutine_fn raw_co_block_status(Bloc=
kDriverState *bs,
>>      off_t data =3D 0, hole =3D 0;
>>      int ret;
>> =20
>> +    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment) &&
>> +           QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
>> +
>=20
> Can write in one line as:
>=20
> assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));

Ah, yeah, sure, why not.

>>      ret =3D fd_open(bs);
>>      if (ret < 0) {
>>          return ret;
>> @@ -2513,6 +2516,20 @@ static int coroutine_fn raw_co_block_status(Blo=
ckDriverState *bs,
>>          /* On a data extent, compute bytes to the end of the extent,
>>           * possibly including a partial sector at EOF. */
>>          *pnum =3D MIN(bytes, hole - offset);
>> +
>> +        /*
>> +         * We are not allowed to return partial sectors, though, so
>> +         * round up if necessary.
>> +         */
>> +        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
>> +            int64_t file_length =3D raw_getlength(bs);
>> +            if (file_length > 0) {
>> +                /* Ignore errors, this is just a safeguard */
>> +                assert(hole =3D=3D file_length);
>> +            }
>> +            *pnum =3D ROUND_UP(*pnum, bs->bl.request_alignment);
>> +        }
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

I'll send a v2 with shorter assert().

Max

> bl.request_alignment is normally 1 (making this a no-op), but is
> definitely larger for O_DIRECT images (where rounding up and treating
> the post-EOF hole the same as the rest of the sector is the same thing
> that NBD chose to do).


--oKiIdsmPXJSgdtJduFUGTunuLfUYvbegS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzbkMIACgkQ9AfbAGHV
z0B7vwf/c9cTbIvJ3ze52GdmE7zVAGjHSwe8y1QDyARhaixfBIi5KHVMzVJFkPdI
MEL9gYHrktvD+2mlfd4WfCJFRMx7UyI/+GQbEhWmGCo1iXP28inTZmjjG7m8Yznz
HYleAve4yHcA3MbLXITt5BP9Nv4fG2JOJYNXE56X4dgyx9DL4ilvGF76KZ8nJhep
490+XNAMziGi3/QI7UU8zEhZnnjHk3Dv2NSjR558Uy+mrPm8azqI7QhI3PZK0g0a
9wxXwHWUfppoGyiTJrpjL0R+a7brVoZdfGE7aJr2+pbB0X0StnuG+gGYCG0sI2vO
gKORtObtVI7ntmnF1cNBQKjf/DoH1w==
=NMgk
-----END PGP SIGNATURE-----

--oKiIdsmPXJSgdtJduFUGTunuLfUYvbegS--


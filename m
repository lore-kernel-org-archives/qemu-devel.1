Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F79AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E0E2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 19:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E0E2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36791 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEIvh-0005ky-Qc
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 15:30:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEIuN-0004sO-E4
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEItG-0004be-38
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:28:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEItE-0004ah-HE; Wed, 10 Apr 2019 15:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC3A23086218;
	Wed, 10 Apr 2019 19:28:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 86678608EB;
	Wed, 10 Apr 2019 19:28:04 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190401145741.28322-1-eblake@redhat.com>
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
Message-ID: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Date: Wed, 10 Apr 2019 21:28:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401145741.28322-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 10 Apr 2019 19:28:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410192802.UQ1CDz4hw-sXVBZNCWxMIf23qbO2zbWjpsjC0HT-YE8@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Subject: Re: [PATCH for-4.1 v2] qemu-img: Saner printing of large file sizes
References: <20190401145741.28322-1-eblake@redhat.com>
In-Reply-To: <20190401145741.28322-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.19 16:57, Eric Blake wrote:
> Disk sizes close to INT64_MAX cause overflow, for some pretty
> ridiculous output:
>=20
>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info $=
nbd'
>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>   file format: raw
>   virtual size: -8388607T (9223372036854775296 bytes)
>   disk size: unavailable
>=20
> But there's no reason to have two separate implementations of integer
> to human-readable abbreviation, where one has overflow and stops at
> 'T', while the other avoids overflow and goes all the way to 'E'. With
> this patch, the output now claims 8EiB instead of -8388607T, which
> really is the correct rounding of largest file size supported by qemu
> (we could go 511 bytes larger if we used byte-accurate sizing instead
> of rounding up to the next sector boundary, but that wouldn't change
> the human-readable result).
>=20
> Quite a few iotests need updates to expected output to match.
>=20
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2 - actually update iotests to match; no change to block/ code so R-b =
added

There are more iotests this breaks.  First, there is 059 for vmdk, which
looks just like the rest.

But for -m32, it gets a bit more difficult.  Every size above 999 GB
(1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
"inf [unit]":

$ ./qemu-img create -f qcow2 /tmp/foo.qcow2 1T
$ ./qemu-img info /tmp/foo.qcow2
[...]
virtual size: inf TiB (1099511627776 bytes)
[...]

$ ./qemu-img create -f qcow2 /tmp/foo.qcow2 1P
$ ./qemu-img info /tmp/foo.qcow2
[...]
virtual size: inf PiB (1125899906842624 bytes)
[...]

This breaks the iotests that test the maximum disk size of more exotic
formats.  I can see failures for vdi, vhdx, and parallels.

But regardless of the iotests, we shouldn=E2=80=99t show the size as infi=
nite
just because of -m32.

Max


--LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuQ8IACgkQ9AfbAGHV
z0Dozwf8CKH5VQnBcHBXDQ2qt/VzI9o8gKDNDrIstgFW2C67jCUK2Rf5ebMYfBCy
TagUJN+vRpyJgltOG+OVBe0SeiW2GsCcvlQtUfC67LDcHT5ycoPC9o9LSsyhQRHw
wC6KNswyLDPxMz+z/lSpSinGh9NbGGtvzKd2K+PfkKPZ657++4Uj7RDiCReTWN4A
1BAR2U2PCmy01n+222GVuJm5vj8BLEF6MAS/pLVADq9jngoV+k4bC5EBN9p5g3VY
Se4a5O+MD9X9feq82+ad8snFUy68g/J7QT7GpG9+v1PigJOjGgTjvU22QpEg/R69
GLobqdfAAv+ymsJrgtqD3jAK0mPiXw==
=jIJr
-----END PGP SIGNATURE-----

--LTnHzBBIahXPJq4ZVlHP2MvzhL74LnGpN--


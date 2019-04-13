Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A4BC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1B3218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1B3218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF74T-0006OX-Vf
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 21:03:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF73Q-00061p-3D
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF73O-0003Hi-UO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hF73M-0003GF-9J; Fri, 12 Apr 2019 21:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37A9E2D7F5;
	Sat, 13 Apr 2019 01:01:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-22.brq.redhat.com
	[10.40.204.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 344CB5D9CD;
	Sat, 13 Apr 2019 01:01:52 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410205715.2209-1-mreitz@redhat.com>
	<20190410205715.2209-3-mreitz@redhat.com>
	<acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
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
Message-ID: <c2ff2802-7093-ca78-da7e-2c68bd0ac91c@redhat.com>
Date: Sat, 13 Apr 2019 03:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Sat, 13 Apr 2019 01:01:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qemu-img: Add salvaging mode to
 convert
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413010151.S29XSFZKIx2fNT0H6cUNLP0r33uO7lKH-G5AThMNjNw@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <c2ff2802-7093-ca78-da7e-2c68bd0ac91c@redhat.com>
Subject: Re: [PATCH v2 2/6] qemu-img: Add salvaging mode to convert
References: <20190410205715.2209-1-mreitz@redhat.com>
 <20190410205715.2209-3-mreitz@redhat.com>
 <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
In-Reply-To: <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 16:33, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:57, Max Reitz wrote:
>> This adds a salvaging mode (--salvage) to qemu-img convert which ignor=
es
>> read errors and treats the respective areas as containing only zeroes.=

>> This can be used for instance to at least partially recover the data
>> from terminally corrupted qcow2 images.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
> [..]
>=20
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -175,6 +175,11 @@ improve performance if the data is remote, such a=
s with NFS or iSCSI backends,
>>   but will not automatically sparsify zero sectors, and may result in =
a fully
>>   allocated target image depending on the host support for getting all=
ocation
>>   information.
>> +@item --salvage
>> +Try to ignore I/O errors when reading.  Unless in quiet mode (@code{-=
q}), errors
>> +will still be printed.  Areas that cannot be read from the source wil=
l be
>> +treated as containing only zeroes.  This option has no effect in copy=
 offloading
>> +mode (@code{-C}).
>=20
> Isn't it better to restrict such it, instead of creating meaningless co=
mbination?
> And drop the restriction if we support it in future, instead of silent =
move from
> noop to the feature?

You=E2=80=99re right, I should do that.

> Otherwise, looks OK for me. I dislike mixing byte-based and sector-base=
d logic, but it
> is not about the series, we should move to byte-based like in other pla=
ces, and it may
> be done later.

Thanks for having a look!

Max


--NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyxNP8ACgkQ9AfbAGHV
z0B34Qf/Tu+v9qW4JyWhvQi6GRXe1UFi86d3EaXIwXiXjkDYpQu3QSR6fQlOxaeg
Y2DUexQggJzmk6AsoxQww0g6vAbK3ZmMjJsRTYkIrmr1RZcfG2gXVp8qxxZex56O
iDRW5bsLWvTSV6+DbmVh4ZvzUL+njZyivhT/WVxx47IjN2Pb76DMLqq0AWyncXMD
V22ZWvESAbGAQSLk6g1TMHRtvunHRjdvCYHvIYKwq1XIZO8ZkPCAjdr7g8J1XxKR
0EX/r/DSq/CZIRiF1xml/c0/d4LTyyB0EfIJxNGb6j2aCW4e4AEazZr4NrTMEW4B
OJvxefxb6rxTeBbc0SnmNZlAz9LQQg==
=xhYB
-----END PGP SIGNATURE-----

--NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF--


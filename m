Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB35CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8625F217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hl+f6NRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8625F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwGF-0005pi-HH
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itwET-0004KB-AE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itwEP-0006us-EH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:18:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itwEP-0006ud-9m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579623500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9mWEvk1/eK/izwiQJZJ2XKIfX9K2ttj/W+/jQWZ2+Yo=;
 b=Hl+f6NRpQoGenlkVIjMftRb3X4UJ6EC+lGyw6hqZ3FDGh4bKygeCuqcKAN2dla3M4tX3+l
 b5WJRb2FjsjueSJiWGzwir5sTDPZa/NFbpAS6X8YxF5eI71kTvJVdsFkxt/2Ui4hyX08pU
 ivZufG8zcJnbjJTOKgJGUQogRCneEXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-a2JPrw-6Pp-pNEQj3AYvoQ-1; Tue, 21 Jan 2020 11:18:11 -0500
X-MC-Unique: a2JPrw-6Pp-pNEQj3AYvoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95387800D53;
 Tue, 21 Jan 2020 16:18:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F245D9E2;
 Tue, 21 Jan 2020 16:18:05 +0000 (UTC)
Subject: Re: [PATCH v10 1/2] docs: improve qcow2 spec about extending image
 header
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-2-vsementsov@virtuozzo.com>
 <e457c8c4-ae37-9b30-5580-40b34bbf458c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <92ff41e1-be36-ddd3-e46d-a867096b6865@redhat.com>
Date: Tue, 21 Jan 2020 17:18:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e457c8c4-ae37-9b30-5580-40b34bbf458c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mwbd4OrmD998Rdu7fUz1wqeDJiH6cU3Fe"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, den@openvz.org, dplotnikov@virtuozzo.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mwbd4OrmD998Rdu7fUz1wqeDJiH6cU3Fe
Content-Type: multipart/mixed; boundary="DPrpV1jqxqjnesJPWls0PtJlpQdedgrB8"

--DPrpV1jqxqjnesJPWls0PtJlpQdedgrB8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.01.20 20:42, Eric Blake wrote:
> On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Make it more obvious how to add new fields to the version 3 header and
>> how to interpret them.
>>
>> The specification is adjusted so for new defined optional fields:
>=20
> s/so for/so that for/
>=20
>>
>> 1. Software may support some of these optional fields and ignore the
>> =A0=A0=A0 others, which means that features may be backported to downstr=
eam
>> =A0=A0=A0 Qemu independently.
>> 2. If we want to add incompatible field (or a field, for which some its
>> =A0=A0=A0 values would be incompatible), it must be accompanied by
>> =A0=A0=A0 incompatible feature bit.
>>
>> Also the concept of "default is zero" is clarified, as it's strange to
>> say that the value of the field is assumed to be zero for the software
>> version which don't know about the field at all and don't know how to
>> treat it be it zero or not.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 docs/interop/qcow2.txt | 44 +++++++++++++++++++++++++++++++++++++++-=
--
>> =A0 1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index af5711e533..355925c35e 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file
>> header:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Offset i=
nto the image file at which the snapshot
>> table
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 starts. =
Must be aligned to a cluster boundary.
>> =A0 -If the version is 3 or higher, the header has the following
>> additional fields.
>> -For version 2, the values are assumed to be zero, unless specified
>> otherwise
>> -in the description of a field.
>> +For version 2, the header is exactly 72 bytes in length, and finishes
>> here.
>> +For version 3 or higher, the header length is at least 104 bytes,
>> including
>> +the next fields through header_length.
>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 72 -=A0 79:=A0 incompatible_features
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Bitmask =
of incompatible features. An
>> implementation must
>> @@ -164,6 +164,44 @@ in the description of a field.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 100 - 103:=A0 header_length
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Length o=
f the header structure in bytes. For
>> version 2
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 images, =
the length is always assumed to be 72
>> bytes.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 For version 3=
 it's at least 104 bytes and must be
>> a multiple
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of 8.
>> +
>> +
>> +=3D=3D=3D Additional fields (version 3 and higher) =3D=3D=3D
>> +
>> +In general, these fields are optional and may be safely ignored by
>> the software,
>> +as well as filled by zeros (which is equal to field absence), if
>> software needs
>=20
> We're inconsistent on 'zeros' (git grep has 201 hits) vs. 'zeroes' (688
> hits); I prefer the latter, but won't object if you don't tweak it since
> this is the first use of either spelling in qcow2.txt.
>=20
>> +to set field B, but does not care about field A, which precedes B. More
>=20
> s/A, which/A which/

I=92ve heard before that one should always use a comma before =93which=94 a=
nd
never before =93that=94 (in that a subordinate clause opened by =93that=94 =
is a
mandatory description, whereas those that start with =93why=94 are not
necessary for understanding).

So if this is a mandatory description (which I suppose it is), shouldn=92t
it also be s/which/that/?

I suppose =93field A that precedes B=94 sounds a bit weird because =93A=94
hasn=92t been introduced before.  That is, =93the field that precedes B=94
would sound more natural.  Or is that precisely the kind of instance
where one would use =93which=94 without comma? :-)

All in all, I was wondering whether there isn=92t a more natural way to
rephrase the whole paragraph.  (No, I don=92t have an excuse why I didn=92t
say so in the last revision.)

Maybe:

In general, these fields are optional and may be safely ignored when
read and filled with zeroes when written.  For example, say software
wants to set field B but does not care about its preceding field A.  It
may then set A to zero, B to its desired value, and adjust header_length
to include A and B.

?

Max


--DPrpV1jqxqjnesJPWls0PtJlpQdedgrB8--

--Mwbd4OrmD998Rdu7fUz1wqeDJiH6cU3Fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4nJDwACgkQ9AfbAGHV
z0A7tQf9GtJIjN1F/b/HPB9UFbI+TKdoWLcRuzg7NCJ1z1m9gYfdq0Q76q0dP3wu
7e7PkFYEhhSQL9KH4yc2Dlf6HkfOs0tbNbjMksHv3EO5lZblSCP2HDJcRShufA6u
yw+qbizXBdg182h1kwAfGEs/EiDsDRuaXCtbPeT9LK83fpvfXpACiFv/V0zcLv4K
A3qefxzbUxuR3VZLeyrS3GAhLKFC7inKvyYWdPpmEM33qOO/MZKiwiedSzbKwmJv
abFipXUF1qSrRTt3dAPxXlXAuYC81nzQbhmvN+CV3eE1Q2NzDV8m/29CsCSxXeqM
yqAZSDnyKFiQtyMXw0K05//v1mnpZQ==
=yNoR
-----END PGP SIGNATURE-----

--Mwbd4OrmD998Rdu7fUz1wqeDJiH6cU3Fe--



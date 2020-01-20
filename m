Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C0A22314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5+BO04H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C0A22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZXm-0007QQ-BI
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itZWc-0006GY-1s
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itZWY-0001MF-E6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:03:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itZWY-0001M4-AL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579536213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z6eNFUDmrtsy0UHSaNM6j7zOzvNAI7eMxWcpuByNLIQ=;
 b=G5+BO04Hz5AWI2TT8AHOQiENc+NZ7FwBJEJKrspfhnvq5nroJXz3PcYcYw8ySCLdCvuXM7
 qa9cZktcKIMYAtZ21JGnikirIeB1gsA7oSswKUsZzRQCueGCo7AXXK0QU6wO8GkRX8Je8t
 XC2gQZolVhInTUmA1Y4WtpTJlPP6tuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-jzvy9kVuMuKDyy_VnTt9vw-1; Mon, 20 Jan 2020 11:03:30 -0500
X-MC-Unique: jzvy9kVuMuKDyy_VnTt9vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18AC5800D48;
 Mon, 20 Jan 2020 16:03:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E0E484DBC;
 Mon, 20 Jan 2020 16:03:26 +0000 (UTC)
Subject: Re: [PATCH v9 1/2] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191216121733.63562-1-vsementsov@virtuozzo.com>
 <20191216121733.63562-2-vsementsov@virtuozzo.com>
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
Message-ID: <5ec4a89e-ea37-d46c-f006-2f47d6f9b736@redhat.com>
Date: Mon, 20 Jan 2020 17:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191216121733.63562-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jbah3ijyEU0rOhGTw44xIsG4MPkPvrIx6"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jbah3ijyEU0rOhGTw44xIsG4MPkPvrIx6
Content-Type: multipart/mixed; boundary="wSLA8SKpzGHOFK4bFFfRsWr6ngXqOUW31"

--wSLA8SKpzGHOFK4bFFfRsWr6ngXqOUW31
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.12.19 13:17, Vladimir Sementsov-Ogievskiy wrote:
> Make it more obvious how to add new fields to the version 3 header and
> how to interpret them.
>=20
> The specification is adjusted so for new defined optional fields:
>=20
> 1. Software may support some of these optional fields and ignore the
>    others, which means that features may be backported to downstream
>    Qemu independently.
> 2. If we want to add incompatible field (or a field, for which some its
>    values would be incompatible), it must be accompanied by
>    incompatible feature bit.
>=20
> Also the concept of "default is zero" is clarified, as it's strange to
> say that the value of the field is assumed to be zero for the software
> version which don't know about the field at all and don't know how to
> treat it be it zero or not.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/interop/qcow2.txt | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)

I put review of this off for so long because I always waited for Eric to
give his R-b, but maybe not.

I generally think that he=92s stricter on what to write in documentation,
and accordingly I only have nit picks on spelling and structure:

> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..d92c827763 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file he=
ader:
>                      Offset into the image file at which the snapshot tab=
le
>                      starts. Must be aligned to a cluster boundary.
> =20
> -If the version is 3 or higher, the header has the following additional f=
ields.
> -For version 2, the values are assumed to be zero, unless specified other=
wise
> -in the description of a field.
> +For version 2, the header is exactly 72 bytes in length, and finishes he=
re.
> +For version 3 or higher, the header length is at least 104 bytes, includ=
ing
> +the next fields through header_length.
> =20
>           72 -  79:  incompatible_features
>                      Bitmask of incompatible features. An implementation =
must
> @@ -164,6 +164,39 @@ in the description of a field.
>          100 - 103:  header_length
>                      Length of the header structure in bytes. For version=
 2
>                      images, the length is always assumed to be 72 bytes.
> +                    For version 3 it's at least 104 bytes and must be a =
multiply

s/multiply/multiple/

> +                    of 8.
> +
> +Additional fields (version 3 and higher)

If this is supposed to be a heading, maybe it should enclosed by =93=3D=3D=
=3D=94
on both sides.

> +
> +In general, these fields are optional and may be safely ignored by the s=
oftware,
> +as well as filled by zeros (which is equal to field absence), if softwar=
e needs
> +to set field B, but don't want to care about field A, which precedes B. =
More

s/don't/does not/ (or maybe s/don't want/does not/)

> +formally, additional fields have the following compatibility rules:
> +
> +1. If the value of the additional field must not be ignored for correct
> +handling of the file, it will be accompanied by a corresponding incompat=
ible
> +feature bit.
> +
> +2. If there are no unrecognized incompatible feature bits set, an unknow=
n
> +additional field may be safely ignored other than preserving its value w=
hen
> +rewriting the image header.
> +
> +3. An explicit value of 0 will have the same behavior as when the field =
is not
> +present*, if not altered by specific incompatible bit.

s/by specific/by a specific/

> +
> +*. Field is not present when header_length is less or equal to field's o=
ffset.

s/Field/A field/, s/field's/the field's/

(maybe also +considered, as in "A field is considered not present...")

> +Also, all additional fields are not present for version 2.
> +
> +        < ... No additional fields in the header currently ... >

This looks a bit weird to me, but the next patch will remove it again,
so who cares.

> +Header padding

Same heading note here (I=92d make this =93=3D=3D=3D Header padding =3D=3D=
=3D=94).

> +
> +@header_length must be a multiply of 8, which means that if last additio=
nal field

s/multiply/multiple/

> +end is not aligned, some padding is needed. This padding must be zeroed,=
 so that,

I think s/last additional field end/the last additional field=92s end/, or
maybe s/last additional field end/the end of the last additional field/.

> +if some existing (or future) additional field will fall into the padding=
, it
> +will be interpreted accordingly to point [3.] of the previous paragraph,=
 i.e.
> +in same manner as when this field is not present.

s/in same/in the same/

> =20

I think there should be a new heading here
(=93=3D=3D=3D Header extensions =3D=3D=3D=94).

Max

>  Directly after the image header, optional sections called header extensi=
ons can
>  be stored. Each extension has a structure like the following:
>=20


--wSLA8SKpzGHOFK4bFFfRsWr6ngXqOUW31--

--jbah3ijyEU0rOhGTw44xIsG4MPkPvrIx6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lz0wACgkQ9AfbAGHV
z0CZhggAnzvY6luTZO/SaLiyJ/2M5HnSnj2p04mrgaHciNXiVzFzEEuBXVlYhtWk
4jwR8GXQhCeyMqChEoboiM9L25yoe5OiPnqU3BDYS9F3QZfjxoboU37BMzPP6jt9
cuC7YRTReitERBf8y5gYS9ZsTsdi9X0ZaiVFdrssL32s1liVydylo2/6xVW+OWzt
O7eMucKxVnJFbHmKD+Rwp/mYfRprJKnawUIs06hfn0FjT8R1EU6Rs/nonO9Sbt0i
ysyLzC242IVl0NXE9/UcbjIapzmtZahI1VjZW53ZNR8H0kfemgfsI4uk36y7ynP9
Y7Ucf9+42OUc1d4FyVdAVF2TeqibIA==
=m1dh
-----END PGP SIGNATURE-----

--jbah3ijyEU0rOhGTw44xIsG4MPkPvrIx6--



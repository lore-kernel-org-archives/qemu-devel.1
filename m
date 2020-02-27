Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F14C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D0A2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjGjiP2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D0A2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7L2T-0004Vt-Q3
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7L1n-000408-3v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7L1m-0002E3-1n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:24:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7L1l-0002CZ-UP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582817081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ELsC4mDRskQI9qopuS2Rg/JObLtLTr+WfUxUMgQSj4w=;
 b=CjGjiP2nixSsPTjlmZ5mtNI0xOp0LvoCqGbkrump9lFJIV3ndX7gqvZBlS1h7Vp1MFAGWC
 1i3ZTB3qRUQoS1UeafON0hfQQa/Dw/m1YzJ0zP/D2fyNymuuWr37VZYG4B8mZJkaOzyL4N
 PoWAqc/HEiavegw1GuHdlyd1wUK418A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-gZumRejLNTCdT1NQEJ4U0A-1; Thu, 27 Feb 2020 10:24:28 -0500
X-MC-Unique: gZumRejLNTCdT1NQEJ4U0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB58418C43C2;
 Thu, 27 Feb 2020 15:24:26 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 742CB19757;
 Thu, 27 Feb 2020 15:24:24 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] fix two small memleaks
To: Pan Nengyuan <pannengyuan@huawei.com>, kwolf@redhat.com
References: <20200227012950.12256-1-pannengyuan@huawei.com>
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
Message-ID: <04e239b7-606e-c2dd-b9cd-38662048557a@redhat.com>
Date: Thu, 27 Feb 2020 16:24:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227012950.12256-1-pannengyuan@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uMp8vIMsCqChNfICviBFHjsJPkcbYtzdQ"
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
Cc: euler.robot@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uMp8vIMsCqChNfICviBFHjsJPkcbYtzdQ
Content-Type: multipart/mixed; boundary="uL07wH029v4HSA0r6EksfcGDJCF9kSVrQ"

--uL07wH029v4HSA0r6EksfcGDJCF9kSVrQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 02:29, Pan Nengyuan wrote:
> This series fix two small memleaks.
> 1. 'crypto_opts' forgot to free in qcow2_close(), do this cleanup in qcow=
2_close();
> 2. Do free filename/format in collect_image_check() when we re-allocate i=
t. =20
>=20
> v2->v1:
> - Instead of freeing part of fields in collect_image_check(), do discard =
the old check object and allocate a new one in the caller to make more sens=
e.(suggested by Max Reitz)
>=20
> Pan Nengyuan (2):
>   block/qcow2: do free crypto_opts in qcow2_close()
>   qemu-img: free memory before re-assign
>=20
>  block/qcow2.c | 1 +
>  qemu-img.c    | 2 ++
>  2 files changed, 3 insertions(+)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--uL07wH029v4HSA0r6EksfcGDJCF9kSVrQ--

--uMp8vIMsCqChNfICviBFHjsJPkcbYtzdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5X3ycACgkQ9AfbAGHV
z0BtEAf9HrjtQ0tyveZ0ZiJG75lhxfUvCbBbLafcMNlGWOgrk1KsaUbEx4jiuwC7
6/ucXcsESQuESdROjIA844TuUHWJUOgmXtc/AlZdYWmpL7AFuUtuKpUhg6Brwi9H
EB06ayo0vQYoJyN1ZE3+zTGpvqddqMRsNk5cuB8W5iwaQiQ0GJFSTQISC5merRsm
wqts1r/BTpIr558kFy9nTcxcljZMoTtjd/gMTJvjuOpiO4OkD5cGLDKa+HQPbhzv
AMvroyne+VGBk9OGfJ2Z83mHVXlOcIQYpLH9goPCjB6B0Vw5zYCzJ4aWg8U2fve1
y2mMzRgBr3R9jd6obulLJSBMuTbXPw==
=Et2+
-----END PGP SIGNATURE-----

--uMp8vIMsCqChNfICviBFHjsJPkcbYtzdQ--



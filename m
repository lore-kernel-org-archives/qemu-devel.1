Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9706DC3F34D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6165720801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjdB1yuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6165720801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JWX-0008LC-HX
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7JVP-0007oX-Ml
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7JVO-0006i3-Gr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:47:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7JVO-0006gR-Bs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582811229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6qMFUbe+9veNZGjnqtEPOFSda73VZS02foL4EH0Tx2s=;
 b=gjdB1yuz8q9GbXZfFKO/Aj9gRM2P2a1vmRaavYuCbN6LbGEyMtND9Ut2bqGVe3Zati4A73
 TKS7eckVJcrxBeKQq6tDyYsDtyesDUofK3Nx4hDvVwbyvlyCQcxpNm/EHVcZ0OUl4zlA0o
 dCb8OWrIk09x95OgobODYW2BFE82ir4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-I0SV8NSiOTWSpFUlmCW--Q-1; Thu, 27 Feb 2020 08:47:07 -0500
X-MC-Unique: I0SV8NSiOTWSpFUlmCW--Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E49A18AB2C3;
 Thu, 27 Feb 2020 13:47:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7507219C58;
 Thu, 27 Feb 2020 13:47:05 +0000 (UTC)
Subject: Re: [PATCH v6 2/9] iotests: add script_initialize
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-3-jsnow@redhat.com>
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
Message-ID: <54340b90-9b8e-6636-af38-c64b9ad9fee9@redhat.com>
Date: Thu, 27 Feb 2020 14:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dvRyyCtH5ewcLfWtDX9INNs2Al72RST90"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dvRyyCtH5ewcLfWtDX9INNs2Al72RST90
Content-Type: multipart/mixed; boundary="w69xfwXJniJwQj2PbjEaO4YqztKUHPTGT"

--w69xfwXJniJwQj2PbjEaO4YqztKUHPTGT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 01:06, John Snow wrote:
> Like script_main, but doesn't require a single point of entry.
> Replace all existing initialization sections with this drop-in replacemen=
t.
>=20
> This brings debug support to all existing script-style iotests.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/149        |  3 +-
>  tests/qemu-iotests/194        |  4 +-
>  tests/qemu-iotests/202        |  4 +-
>  tests/qemu-iotests/203        |  4 +-
>  tests/qemu-iotests/206        |  2 +-
>  tests/qemu-iotests/207        |  6 ++-
>  tests/qemu-iotests/208        |  2 +-
>  tests/qemu-iotests/209        |  2 +-
>  tests/qemu-iotests/210        |  6 ++-
>  tests/qemu-iotests/211        |  6 ++-
>  tests/qemu-iotests/212        |  6 ++-
>  tests/qemu-iotests/213        |  6 ++-
>  tests/qemu-iotests/216        |  4 +-
>  tests/qemu-iotests/218        |  2 +-
>  tests/qemu-iotests/219        |  2 +-
>  tests/qemu-iotests/222        |  7 ++--
>  tests/qemu-iotests/224        |  4 +-
>  tests/qemu-iotests/228        |  6 ++-
>  tests/qemu-iotests/234        |  4 +-
>  tests/qemu-iotests/235        |  4 +-
>  tests/qemu-iotests/236        |  2 +-
>  tests/qemu-iotests/237        |  2 +-
>  tests/qemu-iotests/238        |  2 +
>  tests/qemu-iotests/242        |  2 +-
>  tests/qemu-iotests/246        |  2 +-
>  tests/qemu-iotests/248        |  2 +-
>  tests/qemu-iotests/254        |  2 +-
>  tests/qemu-iotests/255        |  2 +-
>  tests/qemu-iotests/256        |  2 +-
>  tests/qemu-iotests/258        |  7 ++--
>  tests/qemu-iotests/260        |  4 +-
>  tests/qemu-iotests/262        |  4 +-
>  tests/qemu-iotests/264        |  4 +-
>  tests/qemu-iotests/277        |  2 +
>  tests/qemu-iotests/280        |  8 ++--
>  tests/qemu-iotests/283        |  4 +-
>  tests/qemu-iotests/iotests.py | 73 +++++++++++++++++++++++------------
>  37 files changed, 128 insertions(+), 80 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

[...]

> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index e8a0ea14fc..fdcf8a940c 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py

[...]

> @@ -1092,13 +1105,18 @@ def execute_unittest(output, verbosity, debug):
> =20
>              sys.stderr.write(out)
> =20
> -def execute_test(test_function=3DNone,
> -                 supported_fmts=3D[],
> -                 supported_platforms=3DNone,
> -                 supported_cache_modes=3D[], supported_aio_modes=3D{},
> -                 unsupported_fmts=3D[], supported_protocols=3D[],
> -                 unsupported_protocols=3D[]):
> -    """Run either unittest or script-style tests."""
> +def execute_setup_common(supported_fmts: Collection[str] =3D (),

First time I see something like this, but I suppose it means any
collection (i.e. list or tuple in this case) that has str values?

Max

> +                         supported_platforms: Collection[str] =3D (),
> +                         supported_cache_modes: Collection[str] =3D (),
> +                         supported_aio_modes: Collection[str] =3D (),
> +                         unsupported_fmts: Collection[str] =3D (),
> +                         supported_protocols: Collection[str] =3D (),
> +                         unsupported_protocols: Collection[str] =3D ()) =
-> bool:


--w69xfwXJniJwQj2PbjEaO4YqztKUHPTGT--

--dvRyyCtH5ewcLfWtDX9INNs2Al72RST90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5XyFgACgkQ9AfbAGHV
z0BBZgf/ZEFa8lbvsoL3WywOT6LX1Me5ePkU8YVjEYXQ+pakJhK469TWrfK/TcMD
9N/Wn3Yts7zlJ4hMSqXjEm2CV/UdJQwVs+aXfsvjQ1I3a7B8ElEUqYukdDw+0sUB
T600CK3fkG8sUNRTv64pLWq4GsPZjXzhdJyLEc5+i3brcIzlMc3vJfCeoksb4zuh
nYg/Yz2XSueSnMBLPUGeCNMih5LSSu9b9tuwmecYWQdW/BUdL6Vx6nBR9rOp4qhC
bixFJJ5I+5seSi2Pt/fEFj8g9m6/A8pKUKpEcNd4eaR6Dt7Sq2EzxU2vhRq8MS06
Cs+YzNrbgAMn3FNSRlq2Z0rra0P6hw==
=qEbn
-----END PGP SIGNATURE-----

--dvRyyCtH5ewcLfWtDX9INNs2Al72RST90--



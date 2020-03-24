Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EC220774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcWksWFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EC220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkxf-00076B-B6
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGkwv-0006Bg-Qb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGkwu-0004yE-Lr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:54:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGkwu-0004x0-GU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585061675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hLkRz7Bb6L5M18zYXIfMHV0CZScVvyrKDlbUbo0m0As=;
 b=QcWksWFdEo1eH33wT8eVAg0SZXC1RD2BFYCN1AYB4R56QXuvoZTcqI6ALSE7xPQIsLGO9F
 jgSe5/9uava9FaYyEWd7IKSb4/JuLsqxF3bqquN9k9btcnbSPXcHeMTOLElatm85AG8oev
 37nGxuyAY0LV7SrHSL8QU+KxxIGExpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-bYlGHsReOqC6bjYf3ikUcQ-1; Tue, 24 Mar 2020 10:54:33 -0400
X-MC-Unique: bYlGHsReOqC6bjYf3ikUcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA87B190A7A7;
 Tue, 24 Mar 2020 14:54:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 363491BC6D;
 Tue, 24 Mar 2020 14:54:29 +0000 (UTC)
Subject: Re: [PATCH v8 06/11] iotests: drop Python 3.4 compatibility code
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200317004105.27059-1-jsnow@redhat.com>
 <20200317004105.27059-7-jsnow@redhat.com>
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
Message-ID: <688928bc-a5d5-ada4-d7ae-78551274eec1@redhat.com>
Date: Tue, 24 Mar 2020 15:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317004105.27059-7-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZPMPXmLaxNtv4Qoq0sJ4NSDYa4VJ4ieSY"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZPMPXmLaxNtv4Qoq0sJ4NSDYa4VJ4ieSY
Content-Type: multipart/mixed; boundary="kC2XdkCXcWHjU49YMOBph5AO9l45Qj0aY"

--kC2XdkCXcWHjU49YMOBph5AO9l45Qj0aY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 01:41, John Snow wrote:
> We no longer need to accommodate 3.4, drop this code.

Pre-3.4, actually.

> (Also, the line is over 79 characters, so drop it.)
>=20
> Touch up the docstring a little bit while we're here.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 7cd74e7cb1..3d90fb157d 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -22,6 +22,7 @@
>  import unittest
>  import sys
>  import struct
> +from typing import Optional
>  import json
>  import signal
>  import logging
> @@ -350,18 +351,17 @@ def _filter(_key, value):
>          return value
>      return filter_qmp(qmsg, _filter)
> =20
> -def log(msg, filters=3D(), indent=3DNone):
> -    '''Logs either a string message or a JSON serializable message (like=
 QMP).
> -    If indent is provided, JSON serializable messages are pretty-printed=
.'''
> +def log(msg, filters=3D(), indent: Optional[int] =3D None) -> None:
> +    """
> +    Logs either a string message or a JSON serializable message (like QM=
P).
> +    If indent is provided, JSON serializable messages are pretty-printed=
.
> +    """

I feel like I should complain about this unrelated (I think?) change,
but I won=E2=80=99t.

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      for flt in filters:
>          msg =3D flt(msg)
>      if isinstance(msg, (dict, list)):
> -        # Python < 3.4 needs to know not to add whitespace when pretty-p=
rinting:
> -        separators =3D (', ', ': ') if indent is None else (',', ': ')
>          # Don't sort if it's already sorted
>          do_sort =3D not isinstance(msg, OrderedDict)
> -        print(json.dumps(msg, sort_keys=3Ddo_sort,
> -                         indent=3Dindent, separators=3Dseparators))
> +        print(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dindent))
>      else:
>          print(msg)
> =20
>=20



--kC2XdkCXcWHjU49YMOBph5AO9l45Qj0aY--

--ZPMPXmLaxNtv4Qoq0sJ4NSDYa4VJ4ieSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl56HyQACgkQ9AfbAGHV
z0ADPAgAqTVR/b1UMLsJnyQBRY75r3CVpdFO3n9fO33PubzojSLkLvIarj05AR1M
YE7o2NsGbbFgJ1GwfesTIalCL2ptRE9Hkhn/6PeCLyk8sLNxu06w6EHFomPtyIGR
ZijPngD+Nja9PB+w1s2UB7s+cB/uRTqOBM6pnUH0hAKSlIt1qnJNbVBn2Q0NXu4M
NJD/LDB6bret2sJZ3IIuBYSYr+EoZMnVOyQsnA2KchlQJ/x7In4YCsrQAyEuTWQF
AlUlcDdnAKBvsOOedE3h2zHplEvVT5ZWXlRLfkcPd7gJh2GWW1+EzkHqGiXG8XNB
C9AjdUsVYiT8ovLnmN+NGwD1mY4RlQ==
=NDnN
-----END PGP SIGNATURE-----

--ZPMPXmLaxNtv4Qoq0sJ4NSDYa4VJ4ieSY--



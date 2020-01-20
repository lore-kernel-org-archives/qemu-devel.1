Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1814C217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXFBKw6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1814C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYHL-0003YN-1N
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itYA9-0002qb-W3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itYA6-0007JM-1G
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itYA5-0007Hj-Rx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579530977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Kat6JIyyrzttqUFMWHX0UDiNhaAbuyJjENFKaHGC10=;
 b=TXFBKw6rzGkQMuGdCosGPJEjXsBkhoCyft+HKaOPbgnYVNxZ7o/IupU72lZzhHnPm8DQ29
 siRsSgm1HCjrQC0Odh2HeauhjMp56sInz6IW1yJhmT17f68zDWBvck0by1ON/DwEPidcKD
 rtxqjzJKPAa0nqK6Qut8G7M5m3ECV88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-1Z7f8TamO1-5xFEh4PS_EQ-1; Mon, 20 Jan 2020 09:36:13 -0500
X-MC-Unique: 1Z7f8TamO1-5xFEh4PS_EQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 061198010D1;
 Mon, 20 Jan 2020 14:36:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D1D426FA4;
 Mon, 20 Jan 2020 14:36:07 +0000 (UTC)
Subject: Re: [PATCH v4 3/6] iotests: Test 183 does not work on macOS and
 OpenBSD
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
 <20191202101039.8981-4-thuth@redhat.com>
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
Message-ID: <99340090-0575-9b4e-4156-dac823e34be3@redhat.com>
Date: Mon, 20 Jan 2020 15:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191202101039.8981-4-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jJc9wdZgsapjjJmKuanbnsyl2UdRlyHLV"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jJc9wdZgsapjjJmKuanbnsyl2UdRlyHLV
Content-Type: multipart/mixed; boundary="K0KS1K07mgxHI416A1LtuMHrG7cO9070G"

--K0KS1K07mgxHI416A1LtuMHrG7cO9070G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.12.19 11:10, Thomas Huth wrote:
> In the long term, we might want to add test 183 to the "auto" group
> (but it still fails occasionally, so we cannot do that yet). However,
> when running 183 in Cirrus-CI on macOS, or with our vm-build-openbsd
> target, it currently always fails with an "Timeout waiting for return
> on handle 0" error.
>=20
> Let's mark it as supported only on systems where the test is working
> fine (i.e. Linux, FreeBSD and NetBSD).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/183 | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
> index bced83fae0..0bbae13647 100755
> --- a/tests/qemu-iotests/183
> +++ b/tests/qemu-iotests/183
> @@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.filter
>  . ./common.qemu
> =20
> +_supported_os Linux FreeBSD NetBSD

I don=E2=80=99t suppose you have data on OpenBSD?

(And maybe it would be best to let _unsupported_os just check whether
$HOSTOS contains any of these strings (ideally in a case-insensitive
way) instead of checking for equality, but that=E2=80=99s for another serie=
s to
decide.)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--K0KS1K07mgxHI416A1LtuMHrG7cO9070G--

--jJc9wdZgsapjjJmKuanbnsyl2UdRlyHLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lutUACgkQ9AfbAGHV
z0BS0QgAunZv/FuPMfgDPe4BP1EhuxFU3WNKEZJS3ybBlDv4oY8bYLTvp0Iggs72
cN2jhULzUiMJ9RXXSnZMKM1pwLukyE4TRkmhh8gnn4Dj13M6Bw1kpzEZPXxy6bZB
0O9VJ41J1shj6wgzS33cvYFREAGkWT6GQ24YbbjhMT9ALDHM+qV6Xp884FO6+4Z7
BKNjqK/RZBfXU+4XuCBZ8BLvo/Ly6qSF0Fx5ldYIPJdbns6twWOwg57sGvePqyI+
xH8BY8CJlPfxgp0B5U3paQISvM3naRkJcUNkFKZKPLesuI6cNdCE3Ke3UeRQouug
Ls+1c8yTWYBz75pYjnzYDN4HewAcWw==
=q4N1
-----END PGP SIGNATURE-----

--jJc9wdZgsapjjJmKuanbnsyl2UdRlyHLV--



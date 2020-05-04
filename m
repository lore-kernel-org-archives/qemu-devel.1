Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE65C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C3E2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt9pAwi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C3E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVanj-0000cW-B9
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVamu-00080U-7V
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:05:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34432
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVams-0000KT-6S
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588597533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rd1gmHPpzb6F5QG3vqL9ZqRdmRBgochnqqmq0JA+ZRw=;
 b=Gt9pAwi+vXhpPBkcDjng69Nxw+s15pQhEX5kbSxzZDSE5VhBSTOErc8QH45JxfRMYoajBA
 viEQfnL0Uk1GMeciziBH+vZvrVa/J/6baP9znIN5t3Zf1ZyHPIQJHWhhV/n+OyBwxvqUZ+
 qIO6vZ/ShjARduLo6QpPfhvhHoT8xo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-Fq08SJP-OxWGdrSGjw0Qow-1; Mon, 04 May 2020 09:05:31 -0400
X-MC-Unique: Fq08SJP-OxWGdrSGjw0Qow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142708015CB;
 Mon,  4 May 2020 13:05:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 603311002388;
 Mon,  4 May 2020 13:05:27 +0000 (UTC)
Subject: Re: [PATCH v2 6/6] iotests: Add test 291 to for qemu-img bitmap
 coverage
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-7-eblake@redhat.com>
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
Message-ID: <7fb923a4-0ea8-c29b-2b05-86c4336c1286@redhat.com>
Date: Mon, 4 May 2020 15:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421212019.170707-7-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iHSunjPWiVjwNcynqOQybVaVJB9EEUWA8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iHSunjPWiVjwNcynqOQybVaVJB9EEUWA8
Content-Type: multipart/mixed; boundary="jSAsuEbynFHLD9lG67LBxyRtMS4eJFg0z"

--jSAsuEbynFHLD9lG67LBxyRtMS4eJFg0z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 23:20, Eric Blake wrote:
> Add a new test covering the 'qemu-img bitmap' subcommand, as well as
> 'qemu-img convert --bitmaps', both added in recent patches.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/291     | 103 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/291.out |  78 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 182 insertions(+)
>  create mode 100755 tests/qemu-iotests/291
>  create mode 100644 tests/qemu-iotests/291.out
>=20
> diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
> new file mode 100755
> index 000000000000..77713c0cfea7
> --- /dev/null
> +++ b/tests/qemu-iotests/291

[...]

> +echo
> +echo "=3D=3D=3D Bitmap preservation not possible to non-qcow2 =3D=3D=3D"
> +echo
> +
> +mv "$TEST_IMG" "$TEST_IMG.orig"

=E2=80=9Cmv=E2=80=9D doesn=E2=80=99t work images with external data files.

(ORIG_IMG=3D$TEST_IMG; TEST_IMG=3D"$TEST_IMG".orig should work)

> +$QEMU_IMG convert --bitmaps -O raw "$TEST_IMG.orig" "$TEST_IMG"
> +
> +echo
> +echo "=3D=3D=3D Convert with bitmap preservation =3D=3D=3D"
> +echo
> +
> +# Only bitmaps from the active layer are copied

That=E2=80=99s kind of obvious when you think about (whenever an image is
attached to a VM, only the active layer=E2=80=99s bitmaps are visible, not =
those
from the backing chain), but maybe this should be noted in the
documentation?

> +$QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG.orig" "$TEST_IMG"
> +$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
> +# But we can also merge in bitmaps from other layers
> +$QEMU_IMG bitmap --add --disabled -f $IMGFMT "$TEST_IMG" b0
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" tmp
> +$QEMU_IMG bitmap --merge b0 -b "$TEST_IMG.base" -F $IMGFMT "$TEST_IMG" t=
mp
> +$QEMU_IMG bitmap --merge tmp "$TEST_IMG" b0
> +$QEMU_IMG bitmap --remove -f $IMGFMT "$TEST_IMG" tmp

Why do we need tmp here?  Can=E2=80=99t we just merge base=E2=80=99s b0 dir=
ectly into
$TEST_IMG=E2=80=99s b0?

[...]

> diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
> new file mode 100644
> index 000000000000..d716c0c7cc0b
> --- /dev/null
> +++ b/tests/qemu-iotests/291.out

[...]

> +=3D=3D=3D Check bitmap contents =3D=3D=3D
> +
> +[{ "start": 0, "length": 3145728, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
> +{ "start": 3145728, "length": 1048576, "depth": 0, "zero": false, "data"=
: false},
> +{ "start": 4194304, "length": 6291456, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET}]
> +[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
> +{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data"=
: false},
> +{ "start": 2097152, "length": 8388608, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET}]
> +[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
> +{ "start": 2097152, "length": 1048576, "depth": 0, "zero": false, "data"=
: false},
> +{ "start": 3145728, "length": 7340032, "depth": 0, "zero": false, "data"=
: true, "offset": OFFSET}]

Am I looking at this wrong or does the bitmap data seem to be inverted?
 Everywhere where I=E2=80=99d expect the bitmaps to be cleared, this map re=
ports
data=3Dtrue, whereas where I=E2=80=99d expect them to be set, it reports da=
ta=3Dfalse.

I suppose that=E2=80=99s intentional, but can you explain this behavior to =
me?

Max

> +*** done


--jSAsuEbynFHLD9lG67LBxyRtMS4eJFg0z--

--iHSunjPWiVjwNcynqOQybVaVJB9EEUWA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6wExUACgkQ9AfbAGHV
z0BgUwf/XuGu6U7z9R6fdhmY2trwq+L1tahgkTZJvdd75HXLc8qW9twlOTrw8y9L
r5SR8mHpC5OlOi53H303R5Ziz2cmpYiXJXBoCsWahsF2EjaVFa/thlGK33fYmQSN
IQWg9GmorDNYbA9kjG7gjGYiZy7Xpo2esTO/nyWniWpDUtN07SddhGE4asTgDiA4
Wvm8CUrJbvS+5poarFPju6od+Qh6uEuFv2ygXK2fQl1pFxYjlif0s3OtbMA5/V1r
TnfDpBr9pluwjykSCGH24qqHwjinnyo9gwn26WyvCCjF32itY8C0QHNhNkSzSb6O
V8f7LTImito0Jjfht51uPKBUzXRhtg==
=DHR/
-----END PGP SIGNATURE-----

--iHSunjPWiVjwNcynqOQybVaVJB9EEUWA8--



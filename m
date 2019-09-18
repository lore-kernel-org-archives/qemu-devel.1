Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4937BC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F584214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F584214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWAE-0007zu-6d
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAW8X-0006ha-Vn
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAW8W-00057j-Sj
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAW8Q-00055i-GU; Wed, 18 Sep 2019 05:20:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 988CF316E535;
 Wed, 18 Sep 2019 09:20:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-168.ams2.redhat.com
 [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B9460C05;
 Wed, 18 Sep 2019 09:20:14 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190918085519.17290-1-kwolf@redhat.com>
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
Message-ID: <726ed3db-fe67-98ff-5829-344dc6e04278@redhat.com>
Date: Wed, 18 Sep 2019 11:20:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918085519.17290-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ei7LQwYpI96SJNKR7ZIzTAox4XZC7qscW"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 18 Sep 2019 09:20:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Require Python 3.5 or later
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
Cc: jsnow@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ei7LQwYpI96SJNKR7ZIzTAox4XZC7qscW
Content-Type: multipart/mixed; boundary="xBtHbp0kzXvNLb1rWlWNz0IaWNb83WfC9";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Message-ID: <726ed3db-fe67-98ff-5829-344dc6e04278@redhat.com>
Subject: Re: [PATCH] iotests: Require Python 3.5 or later
References: <20190918085519.17290-1-kwolf@redhat.com>
In-Reply-To: <20190918085519.17290-1-kwolf@redhat.com>

--xBtHbp0kzXvNLb1rWlWNz0IaWNb83WfC9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 10:55, Kevin Wolf wrote:
> Running iotests is not required to build QEMU, so we can have stricter
> version requirements for Python here and can make use of new features
> and drop compatibility code earlier.
>=20
> This makes qemu-iotests skip all Python tests if a Python version befor=
e
> 3.5 is used for the build.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/check | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 875399d79f..a68f414d6c 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -633,6 +633,13 @@ then
>      export SOCKET_SCM_HELPER=3D"$build_iotests/socket_scm_helper"
>  fi
> =20
> +# Note that if the Python conditional here evaluates True we will exit=

> +# with status 1 which is a shell 'false' value.

I=E2=80=99d expect everything to exit with 1 if something does not work. =
 Thus,
I find the short script confusing (I think you do, too, or you wouldn=E2=80=
=99t
have written this comment).  Why not make it =E2=80=9Csys.exit(0 if
sys.version_info >=3D (3, 5) else 1)=E2=80=9D?

> +python_usable=3Dfalse
> +if ! $PYTHON -c 'import sys; sys.exit(sys.version_info >=3D (3,5))'; t=
hen
> +    python_usable=3Dtrue
> +fi
> +
>  default_machine=3D$($QEMU_PROG -machine help | sed -n '/(default)/ s/ =
=2E*//p')
>  default_alias_machine=3D$($QEMU_PROG -machine help | \
>     sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
> @@ -809,7 +816,12 @@ do
>          start=3D$(_wallclock)
> =20
>          if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/=
env python" ]; then
> -            run_command=3D"$PYTHON $seq"
> +            if $python_usable; then
> +                run_command=3D"$PYTHON $seq"
> +            else
> +                run_command=3D"false"
> +                echo "Unsupported Python version" > $seq.notrun
> +            fi
>          else
>              run_command=3D"./$seq"
>          fi

But it isn=E2=80=99t wrong, so I suppose:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xBtHbp0kzXvNLb1rWlWNz0IaWNb83WfC9--

--Ei7LQwYpI96SJNKR7ZIzTAox4XZC7qscW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2B9swACgkQ9AfbAGHV
z0B+xQf9G00ynIdl1oEQSOTwnk/oouUeyAnDwOturAom7b9HC1mf7lHK3Omg6Nmy
qYCCh3C5LxkU+g9Jla4uJVyDoGCac4Fascv8VOo32aTPbpEXXeCDn+vEf4Zatpfa
fC4O5MRGtcg/285Gxf1PAt1S+aQOIevTzzpqOcmGWpzOq8PgR0V4vbKaJQrvlNHw
DYjjLRfZV4Qt0Jzks7oxjVYK9hKmBuEalFHjcvZeRciEcpgYPmFSNHxwdZXlvinG
vlSJVDjhLAiA0qz9LUZuIy3zC7KNeRdBVrXVBP2qQAAuoFpzxmO8vlBRYmv8V6US
PISkhBKZv4VTGMfVsKXDhMxW0/XINQ==
=VBb+
-----END PGP SIGNATURE-----

--Ei7LQwYpI96SJNKR7ZIzTAox4XZC7qscW--


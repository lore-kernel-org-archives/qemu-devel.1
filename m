Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E9C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CDF22DBF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CDF22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05fI-0001Y3-IE
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i05dS-0000Y5-Pt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i05dR-0005sI-GJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i05dO-0005pM-J6; Tue, 20 Aug 2019 11:01:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF56E4F1DC;
 Tue, 20 Aug 2019 15:01:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC7960C4E;
 Tue, 20 Aug 2019 15:01:14 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190819075348.4078-1-thuth@redhat.com>
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
Message-ID: <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
Date: Tue, 20 Aug 2019 17:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819075348.4078-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NBGaq3rsrS04bis4HDZsLBkRn1MzaMA14"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 20 Aug 2019 15:01:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Check for enabled drivers before
 testing them
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NBGaq3rsrS04bis4HDZsLBkRn1MzaMA14
Content-Type: multipart/mixed; boundary="KjBqFgCqh17cs7j1Lrb8cBzs3upvoTQnX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
Subject: Re: [PATCH] iotests: Check for enabled drivers before testing them
References: <20190819075348.4078-1-thuth@redhat.com>
In-Reply-To: <20190819075348.4078-1-thuth@redhat.com>

--KjBqFgCqh17cs7j1Lrb8cBzs3upvoTQnX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 09:53, Thomas Huth wrote:
> It is possible to enable only a subset of the block drivers with the
> "--block-drv-rw-whitelist" option of the "configure" script. All other
> drivers are marked as unusable (or only included as read-only with the
> "--block-drv-ro-whitelist" option). If an iotest is now using such a
> disabled block driver, it is failing - which is bad, since at least the=

> tests in the "auto" group should be able to deal with this situation.
> Thus let's introduce a "_require_drivers" function that can be used by
> the shell tests to check for the availability of certain drivers first,=

> and marks the test as "not run" if one of the drivers is missing.

Well, the reasoning for generally not making blkdebug/blkverify explicit
requirements was that you should just have both enabled when running
iotests.

Of course, that no longer works as an argument now that we
unconditionally run some iotests in make check.

But still, the question is how strict you want to be.  If blkdebug
cannot be assumed to be present, what about null-co?  What about raw?

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/071       |  1 +
>  tests/qemu-iotests/081       |  1 +
>  tests/qemu-iotests/099       |  1 +
>  tests/qemu-iotests/184       |  1 +
>  tests/qemu-iotests/common.rc | 13 +++++++++++++
>  5 files changed, 17 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
> index 1cca9233d0..fab526666b 100755
> --- a/tests/qemu-iotests/071
> +++ b/tests/qemu-iotests/071
> @@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> =20
>  _supported_fmt qcow2
>  _supported_proto file
> +_require_drivers blkdebug blkverify

Because this test also requires the raw driver.

> =20
>  do_run_qemu()
>  {
> diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
> index c418bab093..1695781bc0 100755
> --- a/tests/qemu-iotests/081
> +++ b/tests/qemu-iotests/081
> @@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt raw
>  _supported_proto file
>  _supported_os Linux
> +_require_drivers quorum

This test has already a check whether quorum is supported, that should
be removed now.

(Also, this test requires the raw driver.)

>  do_run_qemu()
>  {

[...]

> diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
> index cb0c181228..33dd8d2a4f 100755
> --- a/tests/qemu-iotests/184
> +++ b/tests/qemu-iotests/184
> @@ -33,6 +33,7 @@ trap "exit \$status" 0 1 2 3 15
>  . ./common.filter
> =20
>  _supported_os Linux
> +_require_drivers throttle

This test also requires null-co.

>  do_run_qemu()
>  {

I found two more check-block tests that may or may not require use of
_require_drivers (depending on which drivers we deem absolutely essential=
):
- 120: Needs raw
- 186: Needs null-co

> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.r=
c
> index 5502c3da2f..7d4e68846f 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -520,5 +520,18 @@ _require_command()
>      [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
>  }
> =20
> +# Check that a set of drivers has been whitelisted in the QEMU binary
> +#
> +_require_drivers()
> +{
> +    available=3D$($QEMU -drive format=3Dhelp | grep 'Supported formats=
:')
Seems a bit shortcut-y to not remove the =E2=80=9CSupported formats:=E2=80=
=9D prefix,
but I don=E2=80=99t suppose we=E2=80=99ll ever have block drivers with ei=
ther name...

> +    for driver
> +    do
> +        if ! echo "$available" | grep -q "$driver"; then

162 greps like this:

> grep '^Supported formats:.* ssh\( \|$\)'

Maybe the same should be done here, i.e. grep -q " $driver\( \|\$\)"?  I
can well imagine that something like =E2=80=9Cssh=E2=80=9D might appear a=
s a substring
in some other driver.

(Speaking of which, why not change 162 to using this new function?  Yes,
it isn=E2=80=99t in auto, but still...)

Max

> +            _notrun "$driver not available"
> +        fi
> +    done
> +}
> +
>  # make sure this script returns success
>  true
>=20



--KjBqFgCqh17cs7j1Lrb8cBzs3upvoTQnX--

--NBGaq3rsrS04bis4HDZsLBkRn1MzaMA14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cCzgACgkQ9AfbAGHV
z0BcVAf/fSMSZF69o5WTFjWNvDIuEKNijfm51jprnAJWZA5SCqEqV92S+KFuOo9n
oJdNfxxyb6iBeIHKW4q+a77DizTddhfBZtFAret0uTHxGMu/4jim2s37SToz+/8d
tHZwhrBBF/YIKSoZtL9CnckDo7PKXLcFlBR/jiz157xOJ5RPM43D/HKPjR5n84uk
waoNLIpIWm011c3UrAtnNllk5mnDYaDzvVVl5cWV1z2pZVyikMwcnDdZj3EkxrCQ
0PZNhJowlB2QH9elduFFtFJQPOPdv0pGQRJIfSjtIV6oLHhc0W5sT3+i0wsiJ6fg
cABEhSopwnJSIf/VC2eaYijGaVWKIg==
=N+GU
-----END PGP SIGNATURE-----

--NBGaq3rsrS04bis4HDZsLBkRn1MzaMA14--


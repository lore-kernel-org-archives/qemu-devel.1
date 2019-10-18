Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D3BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1821521835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1821521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVna-0003gM-5L
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iLVkF-0000jB-HQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iLVkE-0002mX-Fb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iLVkC-0002iJ-2p; Fri, 18 Oct 2019 13:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FD1E2D6A0F;
 Fri, 18 Oct 2019 17:08:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 569BA19C7F;
 Fri, 18 Oct 2019 17:08:46 +0000 (UTC)
Subject: Re: [PATCH 4/5] iotests: Skip "make check-block" if QEMU does not
 support virtio-blk
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191011145047.19051-1-thuth@redhat.com>
 <20191011145047.19051-5-thuth@redhat.com>
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
Message-ID: <d3f83068-d512-4a57-cf9a-ddc7370614a0@redhat.com>
Date: Fri, 18 Oct 2019 19:08:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011145047.19051-5-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WRd9LoDzEH3TtX2dy3fefcc4Ez7FDLYO3"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 17:08:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WRd9LoDzEH3TtX2dy3fefcc4Ez7FDLYO3
Content-Type: multipart/mixed; boundary="ysKrFdKSEllybvdIBryRpKvINTdfWBAsc"

--ysKrFdKSEllybvdIBryRpKvINTdfWBAsc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 16:50, Thomas Huth wrote:
> The next patch is going to add some python-based tests to the "auto"
> group, and these tests require virtio-blk to work properly. Running
> iotests without virtio-blk likely does not make too much sense anyway,
> so instead of adding a check for the availability of virtio-blk to each=

> and every test (which does not sound very appealing), let's rather add
> a check for this at the top level in the check-block.sh script instead
> (so that it is possible to run "make check" without the "check-block"
> part for qemu-system-tricore for example).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/check-block.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index 679aedec50..7582347ec2 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/=
dev/null ; then
>      exit 0
>  fi
> =20
> -if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +if [ -n "$QEMU_PROG" ]; then
> +    qemu_prog=3D"$QEMU_PROG"
> +else
> +    for binary in *-softmmu/qemu-system-* ; do
> +        if [ -x "$binary" ]; then
> +            qemu_prog=3D"$binary"
> +            break
> +        fi
> +    done
> +fi
> +if [ -z "$qemu_prog" ]; then
>      echo "No qemu-system binary available =3D=3D> Not running the qemu=
-iotests."
>      exit 0
>  fi
> +if ! "$qemu_prog" -M none -device help | grep virtio-blk >/dev/null 2>=
&1 ; then

Maybe grep -q?

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ysKrFdKSEllybvdIBryRpKvINTdfWBAsc--

--WRd9LoDzEH3TtX2dy3fefcc4Ez7FDLYO3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2p8Z0ACgkQ9AfbAGHV
z0CY+Qf+MMVZi4aJgRKJCVSg3jVecIJedEVx1yOdZvGEHp+LCcI9VkY4Bx72Uszg
kn3v/24C+d7DMynec7IgUaIE7aeUX2/LVLWtSu3S7JcCzy+X5q0QaddcmmY/7sEt
fSRLw5Vv/l+3rLBWEvgYJXVX/dTuNrhQaUUJzoe9q6ceI/yCBT5rYdf8wv8ElYR7
9XaOdGkihWT2s5tMgHw1F8P882mCsCVS2Yb3+Hyd/OKWEo+7LkSn1jBis0+SeTxO
IU2bYh765o+1/fJkIp8HsoFQyBMgmbR8bkyPZbLDwYM7XRg3CmaF9TRHcXUhTMDk
ybVhyv6g2r9BVuiH/4jP9hWLxiiTEQ==
=eUjV
-----END PGP SIGNATURE-----

--WRd9LoDzEH3TtX2dy3fefcc4Ez7FDLYO3--


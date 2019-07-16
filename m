Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB04C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047EF2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047EF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMCZ-0006nY-65
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49451)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnMCO-0006Mr-Hq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnMCN-0003PG-DE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnMCK-0003Nv-Ol; Tue, 16 Jul 2019 08:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3AB6C065112;
 Tue, 16 Jul 2019 12:04:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D70D600C4;
 Tue, 16 Jul 2019 12:04:38 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-12-jsnow@redhat.com>
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
Message-ID: <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
Date: Tue, 16 Jul 2019 14:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716000117.25219-12-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wRuytGVt9eqqdDGVmeTHhCDmeajQI5RwJ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 16 Jul 2019 12:04:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/11] iotests/257: test traditional
 sync modes
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wRuytGVt9eqqdDGVmeTHhCDmeajQI5RwJ
Content-Type: multipart/mixed; boundary="jnAMfEilacQkwX4KPy10NUXuifSGRVeYK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
Subject: Re: [PATCH v2 11/11] iotests/257: test traditional sync modes
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-12-jsnow@redhat.com>
In-Reply-To: <20190716000117.25219-12-jsnow@redhat.com>

--jnAMfEilacQkwX4KPy10NUXuifSGRVeYK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 02:01, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/257     |   41 +-
>  tests/qemu-iotests/257.out | 3089 ++++++++++++++++++++++++++++++++++++=

>  2 files changed, 3128 insertions(+), 2 deletions(-)

This needs a %s/specify Bitmap sync mode/specify bitmap sync mode/.

> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
> index 53ab31c92e..c2a72c577a 100755
> --- a/tests/qemu-iotests/257
> +++ b/tests/qemu-iotests/257

[...]

> @@ -393,7 +399,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitm=
ap', failure=3DNone):
>              # group 1 gets cleared first, then group two gets written.=

>              if ((bsync_mode =3D=3D 'on-success' and not failure) or
>                  (bsync_mode =3D=3D 'always')):
> -                ebitmap.clear_group(1)
> +                ebitmap.clear()

Hmmm...  Why?

>              ebitmap.dirty_group(2)
> =20
>          vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
> @@ -404,8 +410,19 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bit=
map', failure=3DNone):
>          log('')
> =20
>          if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate=
':
> +            # TOP treats anything allocated as dirty, expect to see:
> +            if msync_mode =3D=3D 'top':
> +                ebitmap.dirty_group(0)
> +
>              # We manage to copy one sector (one bit) before the error.=

>              ebitmap.clear_bit(ebitmap.first_bit)
> +
> +            # Full returns all bits set except what was copied/skipped=

> +            if msync_mode =3D=3D 'full':
> +                fail_bit =3D ebitmap.first_bit
> +                ebitmap.clear()
> +                ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARITY=
))
> +

So sync=3Dtop didn=E2=80=98t copy anything?  Is that because it now error=
s out
before getting to copy something?

(The rest looks good to me.)

Max

>          ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))=

> =20
>          # 2 - Writes and Reference Backup


--jnAMfEilacQkwX4KPy10NUXuifSGRVeYK--

--wRuytGVt9eqqdDGVmeTHhCDmeajQI5RwJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0tvVMACgkQ9AfbAGHV
z0D7Ugf/WhmIs3FlpjiJzqQqI5Ef0nNXsnCnUx3ZwuMdXW7U+ilahPVApXhoHDO1
Y/bxEa2t7fhApswMHOzanzGGlTkrBW8E+8eBm2Up/TJK7dSayolczFhvD7ER0GwY
LJk9SYpXbGG+Cc/qbxZB2lzj7jIRb+LxSJF7pqVU/OGdmlTFrj0fsxnqO/GOS36+
qDypO+WF7PUjckTAG5N/I4eDMHj0FguybXtlo4Rf22PPw5uqhCajW3eNhceN5qf+
dSzHEB10WartbQgxPIzqp/XR0NwgvmZAtKoxrOhyTMNQ9dpLUXD5S2oucO2u8Idy
qIT9KsJxNi0iWB/ny9gz9zKnBSC4VA==
=7GK7
-----END PGP SIGNATURE-----

--wRuytGVt9eqqdDGVmeTHhCDmeajQI5RwJ--


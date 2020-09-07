Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 08:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030F1208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0En2DqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030F1208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFCWP-0000ak-QE
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 04:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kFCVG-0007sh-DM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 04:27:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24399
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kFCVE-0003FW-3e
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 04:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599467270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g9Kg9VvwQAKReyD3FqfrQFvovn/OKyzhLxTw0XpUMb0=;
 b=D0En2DqPMvLMwV9VlHjBYJj2+minPRRnLciQl3uJx90mrwAmrt9xDxSjYyNyPNugHrEKvi
 HWrzpclM1pUBwMi4dEBgT/zA2puQKJXjz1WB2ofaMU21zXTEC2LRvieJ2Bl3IKKIJI6TDQ
 jwiXQbVZNUCme6lXkh/rN3ZSXMafPWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-b6-ydCZ0ONGda8imlku3gQ-1; Mon, 07 Sep 2020 04:27:46 -0400
X-MC-Unique: b6-ydCZ0ONGda8imlku3gQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B091DDEC;
 Mon,  7 Sep 2020 08:27:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-5.ams2.redhat.com
 [10.36.113.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 309D47EEDC;
 Mon,  7 Sep 2020 08:27:44 +0000 (UTC)
Subject: Re: [PATCH] iotests: Skip test_stream_parallel in test 030 when doing
 "make check"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20200905112445.718881-1-thuth@redhat.com>
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
Message-ID: <e414b62b-7fc4-0b7d-2db8-77fde2d9e5f6@redhat.com>
Date: Mon, 7 Sep 2020 10:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200905112445.718881-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SiOjWHdp8uxcJ1m40kuUteWHot6FY7OAs"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SiOjWHdp8uxcJ1m40kuUteWHot6FY7OAs
Content-Type: multipart/mixed; boundary="147mdxdD8IC8jwaJEtCuRWQMLVVzwXBQl"

--147mdxdD8IC8jwaJEtCuRWQMLVVzwXBQl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.09.20 13:24, Thomas Huth wrote:
> The test_stream_parallel test still occasionally fails in the CI.
> Thus let's disable it during "make check" for now so that it does
> not cause trouble during merge tests. We can enable it again once
> the problem has been resolved.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  See e.g. these URLs for the failure:
>   https://cirrus-ci.com/task/5449330930745344?command=3Dmain#L6482
>   https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00136.html
>=20
>  tests/check-block.sh   | 3 +++
>  tests/qemu-iotests/030 | 4 ++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index 8e29c868e5..a5a69060e1 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -55,6 +55,9 @@ fi
> =20
>  cd tests/qemu-iotests
> =20
> +# QEMU_CHECK_BLOCK_AUTO is used to disable some unstable sub-tests
> +export QEMU_CHECK_BLOCK_AUTO=3D1
> +
>  ret=3D0
>  for fmt in $format_list ; do
>      ./check -makecheck -$fmt $group || ret=3D1
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 31c028306b..8c3af2f658 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -231,6 +231,10 @@ class TestParallelOps(iotests.QMPTestCase):
>      def test_stream_parallel(self):
>          self.assert_no_active_block_jobs()
> =20
> +        # The test occasionally failed in the CI, so disable it for "mak=
e check":
> +        if os.environ.get('QEMU_CHECK_BLOCK_AUTO'):
> +            return

What do you think about a decorator, i.e.

@unittest.skipIf(os.environ.get('QEMU_CHECK_BLOCK_AUTO'),
                 'test disabled in CI')

?

Max


--147mdxdD8IC8jwaJEtCuRWQMLVVzwXBQl--

--SiOjWHdp8uxcJ1m40kuUteWHot6FY7OAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9V7v4ACgkQ9AfbAGHV
z0DHRAgAgRyy74+Gx7kwCz4uFofnwP05KtZ5v/2ZeuLAQiUjNdTOUV2OwnNf977f
MGhZYAvRRYTd1DbPR67B+V83Wp5vR+NvIWIXfi2C/sctLxQWKIfiVAFpXHJfF8lJ
K0PN0crWkTwUHjlKsqn7WQ12I891ReH6da2X2ssVZSx3rsir2tNu9o6VdlGTqvq/
MBS7WQZyaabccXTACcifLATP3PpulioC7DUWqOFvSlawKoarpDJkFZGtSvIXW90Q
sleBcJEiDpjVdqVeXDc2ruW3O9RdD1k/3Yuzwqv67xuG1c9OwcH1+AaEwxLIBD5t
NlSgy7SYZLj4PlKn1azV9EjZZK1G/g==
=vzhB
-----END PGP SIGNATURE-----

--SiOjWHdp8uxcJ1m40kuUteWHot6FY7OAs--



Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F45AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FC62068E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzprYUPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FC62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWWE-0001Jq-JN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAWVX-0000VX-8A
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:48:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAWVV-0000Qb-H8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598352528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D1pfi8jk/giCbKrSFkxk0Z9NCfLaHCPgvpJA5VF8X7c=;
 b=PzprYUPZSn20e27iEff9dZw2a0fPdk6dDDI2qNgMxCP6nr8JO8iQcZTYEM4/kNXSUHmqdf
 iJPRrV3L+xHHOVNSwsWmbUm3fOQWD9Ge0WAP3iMVrJbAUpNXlneAZu2cQtOYG1nbRMIt7T
 8sZ2c0h2wvVXzqf/eCBzsQczho8S79M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-NKRWqcUCNaKGdd3pvbuV2A-1; Tue, 25 Aug 2020 06:48:44 -0400
X-MC-Unique: NKRWqcUCNaKGdd3pvbuV2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D9F807352;
 Tue, 25 Aug 2020 10:48:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-72.ams2.redhat.com
 [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E347C667;
 Tue, 25 Aug 2020 10:48:41 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] qemu-iotests: Fix FilePaths docstring
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
References: <20200820235427.374645-1-nsoffer@redhat.com>
 <20200820235427.374645-3-nsoffer@redhat.com>
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
Message-ID: <23efdc31-9715-ab6d-5a84-4ab412b4ed7b@redhat.com>
Date: Tue, 25 Aug 2020 12:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820235427.374645-3-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BP0ixzwICU0SZcqhznWQxRPjh3TccOiEt"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BP0ixzwICU0SZcqhznWQxRPjh3TccOiEt
Content-Type: multipart/mixed; boundary="nI988DmtCWCpU0aW6lxFq1V1zxXerTX7t"

--nI988DmtCWCpU0aW6lxFq1V1zxXerTX7t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.20 01:54, Nir Soffer wrote:
> When this class was extracted from FilePath, the docstring was not
> updated for generating multiple files, and the example usage was
> referencing unrelated file.
>=20
> Fixes: de263986b5dc
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 16a04df8a3..f34a1d7ef1 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -450,14 +450,16 @@ def file_pattern(name):
> =20
>  class FilePaths:
>      """
> -    FilePaths is an auto-generated filename that cleans itself up.
> +    Context manager generating multiple file names. The generated files =
are
> +    removed when exiting the context.
> =20
> -    Use this context manager to generate filenames and ensure that the f=
ile
> -    gets deleted::
> +    Example usage:
> +
> +        with FilePaths(['test.img', 'test.sock']) as (img_path, sock_pat=
h):

On second thought, this isn=E2=80=99t a great example because image files a=
nd
sockets should go into different base directories.

Max

> +            # Use img_path and sock_path here...
> +
> +        # img_path and sock_path are automatically removed here.
> =20
> -        with FilePaths(['test.img']) as img_path:
> -            qemu_img('create', img_path, '1G')
> -        # migration_sock_path is automatically deleted
>      """
>      def __init__(self, names, base_dir=3Dtest_dir):
>          self.paths =3D []
>=20



--nI988DmtCWCpU0aW6lxFq1V1zxXerTX7t--

--BP0ixzwICU0SZcqhznWQxRPjh3TccOiEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9E7IcACgkQ9AfbAGHV
z0BmQggAn7LVD7cWgcl4pbPyqI20ydSttyvNZwlM5nnh1gRuf1K7FHpQBl6CYAuw
v5ttyXwzA2UOfBWmJp3o8XxHluT21eGpc7s05qFgBbNN3VLMXt+dqBRCRbXbNjm9
cxua5rtcT0HeYatAjqkzp+cFVzpib+/HHmXP6YEkSFUv3Z1JTf52k2nie2sWlI5R
rQe5QT8XOpSpdBJlabyBzgrQUdDQE+mEFt2wGn8NOFlq7rMfg7cmU9zmVxXUyDxs
s4uyoCuaSedTrnZto1sK8rEckbbwnA+3nfI7D9rFeujvjn/x0vw8Ga4VCP1QGn9o
zml2CP9f9Lf12EDV/jcCFLNSK3Qepw==
=GsV+
-----END PGP SIGNATURE-----

--BP0ixzwICU0SZcqhznWQxRPjh3TccOiEt--



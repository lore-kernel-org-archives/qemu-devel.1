Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94113C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A79208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdCi0Ozl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A79208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLj4p-0002Iw-RK
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLj4E-0001hp-K0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLj4C-00025z-G9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:26:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601022415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6amoN+weJ/K6AKCFXWNIfAXJfOuVF6bWcGMuLGiFPec=;
 b=LdCi0OzlOOTEr1M37IB7byXAu9Glz+kVBoWrVq3U+Lbd8Y2lY/F5eV/0/jq3rhvldD3iH6
 P94c/tIFttBZI0/KMVbjsQmpeJBEmGwvrYGnEkYWiqWymHGLUxPBhpsuAr5RUMiOlwMH1F
 RIdaapgHDp7ZcMUOrb+eUKbRSz6EeZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-YBpOPn5DOnygZ0HF-xuEBw-1; Fri, 25 Sep 2020 04:26:52 -0400
X-MC-Unique: YBpOPn5DOnygZ0HF-xuEBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A816802EA5;
 Fri, 25 Sep 2020 08:26:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-113.ams2.redhat.com
 [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7FEE5D9F3;
 Fri, 25 Sep 2020 08:26:43 +0000 (UTC)
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
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
Message-ID: <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
Date: Fri, 25 Sep 2020 10:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918181951.21752-12-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7JtpRTbvbyi3leFYCXueYooKAvyZdxtfK"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7JtpRTbvbyi3leFYCXueYooKAvyZdxtfK
Content-Type: multipart/mixed; boundary="BbueRYiqQnutP70Q7GMx6JsqAiAW6wVFR"

--BbueRYiqQnutP70Q7GMx6JsqAiAW6wVFR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/298     | 186 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/298.out |   5 +
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 192 insertions(+)
>  create mode 100644 tests/qemu-iotests/298
>  create mode 100644 tests/qemu-iotests/298.out
>=20
> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> new file mode 100644
> index 0000000000..fef10f6a7a
> --- /dev/null
> +++ b/tests/qemu-iotests/298

[...]

> +class TestPreallocateBase(iotests.QMPTestCase):

Perhaps a

@iotests.skip_if_unsupported(['preallocate'])

here?

> +    def setUp(self):
> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB=
))

[...]

> +class TestTruncate(iotests.QMPTestCase):

The same decorator could be placed here, although this class doesn=E2=80=99=
t
start a VM, and so is unaffected by the allowlist.  Still may be
relevant in case of block modules, I don=E2=80=99t know.

> +    def setUp(self):
> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB=
))
> +        iotests.qemu_img_create('-f', iotests.imgfmt, refdisk, str(10 * =
MiB))
> +
> +    def tearDown(self):
> +        os.remove(disk)
> +        os.remove(refdisk)
> +
> +    def do_test(self, prealloc_mode, new_size):
> +        ret =3D iotests.qemu_io_silent('--image-opts', '-c', 'write 0 10=
M', '-c',
> +                                     f'truncate -m {prealloc_mode} {new_=
size}',
> +                                     drive_opts)
> +        self.assertEqual(ret, 0)
> +
> +        ret =3D iotests.qemu_io_silent('-f', iotests.imgfmt, '-c', 'writ=
e 0 10M',
> +                                     '-c',
> +                                     f'truncate -m {prealloc_mode} {new_=
size}',
> +                                     refdisk)
> +        self.assertEqual(ret, 0)
> +
> +        stat =3D os.stat(disk)
> +        refstat =3D os.stat(refdisk)
> +
> +        # Probably we'll want preallocate filter to keep align to cluste=
r when
> +        # shrink preallocation, so, ignore small differece
> +        self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
> +
> +        # Preallocate filter may leak some internal clusters (for exampl=
e, if
> +        # guest write far over EOF, skipping some clusters - they will r=
emain
> +        # fallocated, preallocate filter don't care about such leaks, it=
 drops
> +        # only trailing preallocation.

True, but that isn=E2=80=99t what=E2=80=99s happening here.  (We only write=
 10M at 0, so
there are no gaps.)  Why do we need this 1M margin?

> +        self.assertLess(abs(stat.st_blocks - refstat.st_blocks) * 512,
> +                        1024 * 1024)

[...]

> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index ff59cfd2d4..15d5f9619b 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -307,6 +307,7 @@
>  295 rw
>  296 rw
>  297 meta
> +298 auto quick

I wouldn=E2=80=99t mark it as quick, there is at least one preallocate=3Dfu=
ll of
140M, and one of 40M, plus multiple 10M data writes and falloc
preallocations.

Also, since you mark it as =E2=80=9Cauto=E2=80=9D, have you run this test o=
n all
CI-relevant hosts?  (Among other things I can=E2=80=99t predict) I wonder h=
ow
preallocation behaves on macOS.  Just because that one was always a bit
weird about not-really-data areas.

Max


--BbueRYiqQnutP70Q7GMx6JsqAiAW6wVFR--

--7JtpRTbvbyi3leFYCXueYooKAvyZdxtfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9tqcIACgkQ9AfbAGHV
z0AbCQgAt9fM2CdTEil8/KYKIP937E7+l5Hu865H2aAN7HHGc4/WUW3efMWkJkA3
lP6FSnClmxBwShRlz5ZLw4N2VSmBH791CLejejAfPqhdTD9MRMHAHHFumYMMeMc0
tG/Dj5aDzSSPmrHAwWyhAaT9kEITvtqi/nNZQ+xag3vy1vwJ9hl7Sndu4y4uy+hU
VQzi/QOX+NX+ajun5sJgis6miW5q3VySuUxXv4YuvvHF5E1tmfOCIrI09iyfABQ9
Ir2Kg4pyYwgJ1Z8jWwGHJJQJm8rwhsUaxcG/UG6Cz8M26QxCzTpON2AwAGmuxJ1n
Awb8v8b1C7ZgGlmmMP5j9n86ag1o8Q==
=R8iY
-----END PGP SIGNATURE-----

--7JtpRTbvbyi3leFYCXueYooKAvyZdxtfK--



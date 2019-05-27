Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D1C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8AD2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8AD2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46821 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVGsG-00005u-EZ
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 10:45:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVGrT-0008Dn-9p
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVGrS-0001sE-EC
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVGrQ-0001qs-AH; Mon, 27 May 2019 10:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F32E3087932;
	Mon, 27 May 2019 14:44:23 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C28E10027B6;
	Mon, 27 May 2019 14:44:21 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Qemu-block <qemu-block@nongnu.org>
References: <d9016c33-ef8f-7e79-d15f-4220c67efb10@redhat.com>
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
Message-ID: <915afb49-cc9b-5c3e-3a1b-d3af25ca8e6f@redhat.com>
Date: Mon, 27 May 2019 16:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d9016c33-ef8f-7e79-d15f-4220c67efb10@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aonHS0naZnSWNhXeY9pjbKPr461VGaSp4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 27 May 2019 14:44:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing qemu-iotest 211 with -vdi
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aonHS0naZnSWNhXeY9pjbKPr461VGaSp4
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <915afb49-cc9b-5c3e-3a1b-d3af25ca8e6f@redhat.com>
Subject: Re: Failing qemu-iotest 211 with -vdi
References: <d9016c33-ef8f-7e79-d15f-4220c67efb10@redhat.com>
In-Reply-To: <d9016c33-ef8f-7e79-d15f-4220c67efb10@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.04.19 17:43, Thomas Huth wrote:
> QEMU iotest 211 is failing for me, too, when I run it with -vdi:
>=20
> tests/qemu-iotests$ ./check -vdi 211
> QEMU          -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x=
86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=3Dqtest
> QEMU_IMG      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../q=
emu-img"=20
> QEMU_IO       -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../q=
emu-io"  --cache writeback -f vdi
> QEMU_NBD      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../q=
emu-nbd"=20
> IMGFMT        -- vdi
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
> TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
> SOCKET_SCM_HELPER -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/sock=
et_scm_helper
>=20
> 211         - output mismatch (see 211.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/211.out	2019-04-23 16:43:=
12.000000000 +0200
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/211.out.bad	2019-04-2=
8 17:41:19.000000000 +0200
> @@ -55,8 +55,7 @@
>  virtual size: 32M (33554432 bytes)
>  cluster_size: 1048576
> =20
> -[{ "start": 0, "length": 3072, "depth": 0, "zero": false, "data": true=
, "offset": 1024},
> -{ "start": 3072, "length": 33551360, "depth": 0, "zero": true, "data":=
 true, "offset": 4096}]
> +[{ "start": 0, "length": 33554432, "depth": 0, "zero": true, "data": t=
rue, "offset": 1024}]
> =20
>  =3D=3D=3D Invalid BlockdevRef =3D=3D=3D
> =20
> Failures: 211
> Failed 1 of 1 tests
>=20
> Any ideas how to fix this?

=2E..now I see this, too.  Time to investigate.

Max


--aonHS0naZnSWNhXeY9pjbKPr461VGaSp4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzr98QACgkQ9AfbAGHV
z0Dklgf/TDzMELPaUlOEVkmbC9P4ip75ahiYt287kt/xttonGUWYw2/mnF843One
05fxaZ9U5KLkdW2dFZRM0v/gE1dMi8tdyJrdXYZWR6hLAmWo/k4+bTyJVPIznjDZ
B3lEf0E+fy+FLqTusX7S3FuYrMrrwDEzi580ePPEHWlqJG3Carw4KKx1BfnEWqBW
e4BGZlmDQYGAb4RZqzwbVIllg7qwq8PFjAjP80O058zCWdI5r5+pDHrG8eVmM4cj
y2IaXcgGttV1RUkNv86P4ZZ0+ofcftWPe1VsU18HfLkIJZ6GuokBl6IQGhRkObEB
wcCi5BQikwqugaisuF/LMCjyqJNFbw==
=cCHz
-----END PGP SIGNATURE-----

--aonHS0naZnSWNhXeY9pjbKPr461VGaSp4--


Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCFC21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCFC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP633-0005Cy-CU
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:58:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hP5zG-0001jn-G8
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hP5zF-0006HM-Hs
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hP5zB-000693-81; Fri, 10 May 2019 09:54:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8CE8821EF;
	Fri, 10 May 2019 13:54:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-59.brq.redhat.com
	[10.40.204.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2085C6012E;
	Fri, 10 May 2019 13:54:49 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
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
Message-ID: <b121ec96-4cfe-47fe-0415-533cfd842777@redhat.com>
Date: Fri, 10 May 2019 15:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gw9HAtHnzEPR7qVt5hkFlp1ExAwg7Fi55"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 10 May 2019 13:54:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gw9HAtHnzEPR7qVt5hkFlp1ExAwg7Fi55
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Message-ID: <b121ec96-4cfe-47fe-0415-533cfd842777@redhat.com>
Subject: Re: Failing QEMU iotest 175
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
In-Reply-To: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.04.19 17:18, Thomas Huth wrote:
> QEMU iotest 175 is failing for me when I run it with -raw:
>=20
> $ ./check -raw 175
> QEMU          --
> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x86_64-softmmu/qem=
u-system-x86_64"
> -nodefaults -machine accel=3Dqtest
> QEMU_IMG      --
> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache
> writeback -f raw
> QEMU_NBD      --
> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- raw
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
> TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
> SOCKET_SCM_HELPER --
> /home/thuth/tmp/qemu-build/tests/qemu-iotests/socket_scm_helper
>=20
> 175         - output mismatch (see 175.out.bad)
> --- /home/thuth/devel/qemu/tests/qemu-iotests/175.out	2019-04-23
> 16:43:12.000000000 +0200
> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/175.out.bad	2019-04-2=
8
> 17:17:32.000000000 +0200
> @@ -2,17 +2,17 @@
>=20
>  =3D=3D creating image with default preallocation =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
> -size=3D1048576, blocks=3D0
> +size=3D1048576, blocks=3D2
>=20
>  =3D=3D creating image with preallocation off =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocat=
ion=3Doff
> -size=3D1048576, blocks=3D0
> +size=3D1048576, blocks=3D2
>=20
>  =3D=3D creating image with preallocation full =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocat=
ion=3Dfull
> -size=3D1048576, blocks=3D2048
> +size=3D1048576, blocks=3D2050
>=20
>  =3D=3D creating image with preallocation falloc =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
> preallocation=3Dfalloc
> -size=3D1048576, blocks=3D2048
> +size=3D1048576, blocks=3D2050
>   *** done
> Failures: 175
> Failed 1 of 1 tests
>=20
> Any ideas how to fix this?

Hm.  What output does

$ touch foo
$ stat -c "size=3D%s, blocks=3D%b" foo
$ truncate -s 1M foo
$ stat -c "size=3D%s, blocks=3D%b" foo

give for you?

If any of that returns blocks=3D2, we can probably just use that operatio=
n
to fix the result, then.

Max


--Gw9HAtHnzEPR7qVt5hkFlp1ExAwg7Fi55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzVgqgACgkQ9AfbAGHV
z0BFwQf/aBMoHzWe1Es8DzmLSyAOb93/F50ancXNwh32Dixyj8/pXyQCCCTJq2ax
NxuxGhH7eWcgMnJRMrfUM649ZqhwYDo31S5DlP6br6rZtL1HIWpADvU7gOT69usp
LOYNjWEQRW/czk0gASEaoxAheFS2nKAoZFvBFphIZOwCxXx5EOMEU71/4iNGo21e
qPRN+bTh2fHbYZjYR0ZrP4PK5HfeH1NF76cODKTXHjZbl1rXdKS4gougigvzuBLE
lGBSpS4I9zlvf6SDNAwiLMrk2oZrhrdKs/ELEbyDSCC1XUZX8QVJmqR2T3tBRmha
kBzBJQ710P7K+mh5JShMXMpbdPPkYg==
=Vq7k
-----END PGP SIGNATURE-----

--Gw9HAtHnzEPR7qVt5hkFlp1ExAwg7Fi55--


Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270F7C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92CC20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92CC20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtmy-0002Ga-GZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDtMb-0002FH-RP
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDtMX-0003XI-8p
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:45:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDtMP-0002ii-K5; Fri, 27 Sep 2019 12:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 369E710CC1F4;
 Fri, 27 Sep 2019 16:44:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-76.brq.redhat.com
 [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D03A460BE2;
 Fri, 27 Sep 2019 16:44:46 +0000 (UTC)
Subject: Re: iotest failure -- test possibly not using sufficiently unique
 temp filename?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8fwM03PXzkMvLdOWAL0R1Mq8hLmt8O-+NFSri6oHun1w@mail.gmail.com>
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
Message-ID: <010553d9-9dc6-907f-fc74-4cd5614f4a0e@redhat.com>
Date: Fri, 27 Sep 2019 18:44:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8fwM03PXzkMvLdOWAL0R1Mq8hLmt8O-+NFSri6oHun1w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ARa8UgMdQCdZDapeUAbpgWbCxCI9OkMY4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 27 Sep 2019 16:44:48 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARa8UgMdQCdZDapeUAbpgWbCxCI9OkMY4
Content-Type: multipart/mixed; boundary="54wArcY6snVGyFYCffQdXQSSjDq1iS656"

--54wArcY6snVGyFYCffQdXQSSjDq1iS656
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.09.19 18:39, Peter Maydell wrote:
> Hi; I just saw this iotest failure (on an s390x box, as it happens):
>=20
>   TEST    iotest-qcow2: 130 [fail]
> QEMU          --
> "/home/linux1/qemu/build/all/tests/qemu-iotests/../../s390x-softmmu/qem=
u-system-s390x"
> -nodefaults -display none -machine accel=3Dqtest
> QEMU_IMG      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../../=
qemu-img"
> QEMU_IO       --
> "/home/linux1/qemu/build/all/tests/qemu-iotests/../../qemu-io"
> --cache writeback -f qcow2
> QEMU_NBD      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../../=
qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/s390x lxub05 4.15.0-58-generic
> TEST_DIR      -- /home/linux1/qemu/build/all/tests/qemu-iotests/scratch=

> SOCKET_SCM_HELPER --
> /home/linux1/qemu/build/all/tests/qemu-iotests/socket_scm_helper
>=20
> --- /home/linux1/qemu/tests/qemu-iotests/130.out        2019-05-10
> 12:27:16.948075733 -0400
> +++ /home/linux1/qemu/build/all/tests/qemu-iotests/130.out.bad
> 2019-09-27 12:01:23.649722655 -0400
> @@ -18,20 +18,22 @@
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) commit testdisk
>  (qemu)
> -image: TEST_DIR/t.IMGFMT
> -file format: IMGFMT
> -virtual size: 64 MiB (67108864 bytes)
> -backing file: TEST_DIR/t.IMGFMT.orig
> -backing file format: raw
> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "wr=
ite" lock
> +Is another process using the image [TEST_DIR/t.IMGFMT]?
>=20
>  =3D=3D=3D Marking image dirty (lazy refcounts) =3D=3D=3D
>=20
> +qemu-img: TEST_DIR/t.IMGFMT: Failed to get "write" lock
> +Is another process using the image [TEST_DIR/t.IMGFMT]?
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> -wrote 4096/4096 bytes at offset 0
> -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +qemu-io: can't open device
> /home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2: Failed
> to get "write" lock
> +Is another process using the image
> [/home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2]?
> +no file open, try 'help open'
>  image: TEST_DIR/t.IMGFMT
>  file format: IMGFMT
>  virtual size: 64 MiB (67108864 bytes)
> +backing file: TEST_DIR/t.IMGFMT.orig
> +backing file format: raw
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> backing_file=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
>  wrote 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>=20
>=20
>=20
> This looks suspiciously like the test isn't using a unique
> filename for its disk image: "qemu-iotests/scratch/t.qcow2"
> in the build directory, and so perhaps it has collided with
> another iotest ?
>=20
> If we run 'make check' with a -j<something> option do the
> iotests all get run serially anyway, or do they run in
> parallel against each other ?

As far as I know, all iotests are executed serially.  Anything else
would not work with the same scratch directory.

The only thing I suspect is that some tool has been accidentally left
running by some previous test that still accesses its own image.  But I
don=E2=80=99t know.

Max

(I=E2=80=99m personally still very skeptical of running some iotests in m=
ake
check, so I don=E2=80=99t have an opinion on the matter other than =E2=80=
=9CIf it fails,
we should remove it from make check=E2=80=9D.)


--54wArcY6snVGyFYCffQdXQSSjDq1iS656--

--ARa8UgMdQCdZDapeUAbpgWbCxCI9OkMY4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2OPH0ACgkQ9AfbAGHV
z0B2Hwf9EaUzf96MeFFBYdAiNzgpAz4ssbbRzjBgWClKiMZcoTAXkDmldK2k6hUR
KWrtvNZPaxejzN8r1nTkvpD4X4hXzSzB6cBkWLe98lJJgHtAJauNToQOfY9ClwG5
re9S5yE+zaSM/DrAF2/sy9GOwMKuajNPWbD9N4QHJEPA6YrcAnob3lFM3KPltaLw
vHKY8MNY3+Fa013s+sz1rWQBgndcyG2a0lMAnyY8rBIjiV5/OleC2z9MpSuzLd59
6gtZ73W+pcvr7UIINNBBgCy8qZwNX2cPBYXKzrKvmBpMYfDVEHRGdJFn3aKrWpU5
ZvQTGSxG2aS/Jm5sTHm18p844PkydA==
=1Sgc
-----END PGP SIGNATURE-----

--ARa8UgMdQCdZDapeUAbpgWbCxCI9OkMY4--


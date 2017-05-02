Received: from eggs.gnu.org ([2001:4830:134:3::10]:50923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5YvS-0000bo-7Q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5YvN-0003ru-Ja
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:37:14 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5YvN-0003re-CX
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:37:09 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so17887206wrc.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:37:09 -0700 (PDT)
Date: Tue, 2 May 2017 15:37:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502143706.GL22502@stefanha-x1.localdomain>
References: <20170502061649.6668.93083.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/GiYV45wF7IL3Iq"
Content-Disposition: inline
In-Reply-To: <20170502061649.6668.93083.stgit@PASHA-ISP>
Subject: Re: [Qemu-devel] [PATCH] maintainers: add maintainer for replay*
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, armbru@redhat.com


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 09:16:49AM +0300, Pavel Dovgalyuk wrote:
> Updating MAINTAINERS to set Pavel Dovgalyuk as record/replay maintainer.
>=20
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  MAINTAINERS |    9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1d2b3a4d3..8be1c74ac5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1546,6 +1546,15 @@ F: net/colo*
>  F: net/filter-rewriter.c
>  F: net/filter-mirror.c
> =20
> +Record/replay
> +M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> +W: http://wiki.qemu.org/Features/record-replay
> +S: Supported
> +F: replay/*
> +F: block/blkreplay.c
> +F: net/filter-replay.c
> +F: include/sysemu/replay.h

+ F: docs/replay.txt
+ F: stubs/replay.c

Are these missing?

--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCJmSAAoJEJykq7OBq3PI6SoH/12pnANxINJ0Xs8K/Dg0SYas
kRI3t5J6A876eP4ssj7pjkVhi5BWb7eHRXzFF+Il0aZTmtsa6kk6LydUmwPqT4FS
CSa/Qlz4BhZdoGwAA95KZ8I9GV4vDgIKo6jm4IOS4yR+95bYcDyF5ctQAhKehRa9
B5uO+td2qFcx5Ggi2IYFbxFVaROsdxvItFE5s2nyO18dk896QE2x7cjAZctvwjXd
e0d/acBsnXpTGcy+YMiFvWR2hwFPSXh10fGbEVPlHWC70JLAcrAPej8xxlizyunD
9V5Hm08ZQ7Ddl8DYS/e4jdscCnzLOTcxLFua3mWt/hKa23QbdSqI57VB+iOqqUo=
=u5sA
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--

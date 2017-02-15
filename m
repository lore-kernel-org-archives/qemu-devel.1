Received: from eggs.gnu.org ([2001:4830:134:3::10]:39660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1cdprG-0008TI-Jx
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1cdprF-0004qj-9a
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:02:18 -0500
Received: from dev.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]:36059
	helo=smtp.gentoo.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vapier@gentoo.org>) id 1cdprF-0004qD-3C
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:02:17 -0500
Date: Tue, 14 Feb 2017 22:02:11 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20170215030211.GL28432@vapier>
References: <20170210061200.15373-1-vapier@gentoo.org>
	<CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 10 Feb 2017 09:04, Peter Maydell wrote:
> I still think that it's a shame that glibc is breaking
> compatibility with where these macros have always been
> kept on every OS that's implemented them back to 2BSD...

i don't think that characterization is accurate.  if it were,
autoconf wouldn't have a AC_HEADER_MAJOR helper.
https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Particular-Headers.html#index-AC_005fHEADER_005fMAJOR-616
-mike

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlijxLMACgkQQWM7n+g3
9YE8ohAA10nzAysRkcGOAYZiI6a0Kq60CGubqtPxhVMiwY4ilL0qSJFjWbFVCZSW
IVGPCzpNMn1xWTj7VrNG8FucH+xuazmSC2Y2w4TH5o2HLfBxYO/Gz4OrnuSOb56J
5nEh8Rk2pJaKeZ+0APUiA7fvIJvM/gqDboEAYx2ISe+qeiqul1Qa0tCXTlMpNCnM
UcVbtJA28Dg+wtCGGx1ekTh+QfGHSO79h+2I4lmqgYHjP5dqLvSUYjxcQ6Yq81kU
YsyOjawEE6Q/n/vMCxGhul8selU62YTYB7YpRY75ZY07oHaq5JeI3WW8ye8S8RpO
BzXM67SUWfZ5eMliolLx96S/CiBjrMTBOT+O6vNejf8w1Debzp1Q825fIZh8vkgy
IU39PRpWuPuuuqZfOOFwFlQg1Mns0Us54BH55n5stgKjrIpOIeIBhgDfO/7FVB3W
r1X4nGZEpVV9HP5Yy4G8zUGPsgT7S2kKDlHmKQAziXt8aJKTcCSaKu7CPXMNFFpW
wOJ1qAdwmKvSAm80/Rp7yWyUKw85l8kMxKjrpUtWLSwGtjXAkW6o09g725pBaDU4
5TdjRU67NpZqe9IOXWm0//mdn09kp1J9nDEJEKxh97SqhL+KTM1hEfWwGtgHdc+B
/2o5eqE/qfD/ZO832HPJJXGluCDJ0dW8vxhEnDp8ua5JRKDbvqo=
=CwSA
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--

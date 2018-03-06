Received: from eggs.gnu.org ([2001:4830:134:3::10]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAoj-0000Ek-2q
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etAof-0007Js-3i
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:31:37 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etAoe-0007IV-Sw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:31:33 -0500
Received: by mail-wr0-x241.google.com with SMTP id o8so9055314wra.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:31:32 -0800 (PST)
Date: Tue, 6 Mar 2018 11:31:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306113129.GD31045@stefanha-x1.localdomain>
References: <CAMyPS3QVbV2FPNfE-Y_-kgpcpOTWr9zFWED50oCkJaBjJ3XtRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <CAMyPS3QVbV2FPNfE-Y_-kgpcpOTWr9zFWED50oCkJaBjJ3XtRg@mail.gmail.com>
Subject: Re: [Qemu-devel] make error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ronald Delobel <rdelobel@gmail.com>
Cc: qemu-devel@nongnu.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 04:40:49PM +0100, Ronald Delobel wrote:
> Hello,
>=20
> This is the error I get when building qemu-2.11.[0-1] with
> gcc-7.3.0/glibc-2.27, removing the static attribute suffice to finnish the
> build using the glibc provided memfd_create and qemu don't crash, but I
> miss some knowledge here about what a static function really is, a kind of
> private one? Shouldn't it be renamed instead and stay as static?
>=20
> Just to report it.

Thanks for reporting this.  Peter Maydell looked into this and answered
it in another email thread:

  "this looks like a QEMU incompatibility with newer glibc that
  we fixed in QEMU commit 75e5b70e6b5dcc4. That didn't quite make
  the 2.11.0 release, but will be in 2.12.0."

>   CC      util/qemu-thread-posix.o
>   CC      util/memfd.o
> util/memfd.c:40:12: error: la d=E9claration statique de =AB memfd_create =
=BB suit
> une d=E9claration non statique
>  static int memfd_create(const char *name, unsigned int flags)
>             ^~~~~~~~~~~~
> In file included from /usr/include/bits/mman-linux.h:115:0,
>                  from /usr/include/bits/mman.h:45,
>                  from /usr/include/sys/mman.h:41,
>                  from
> /usr/local/src/qemu-2.11.1/include/sysemu/os-posix.h:29,
>                  from /usr/local/src/qemu-2.11.1/include/qemu/osdep.h:104,
>                  from util/memfd.c:28:
> /usr/include/bits/mman-shared.h:46:5: note: la d=E9claration pr=E9c=E9den=
te de
> =AB memfd_create =BB =E9tait ici
>  int memfd_create (const char *__name, unsigned int __flags) __THROW;
>      ^~~~~~~~~~~~
> make: *** [/usr/local/src/qemu-2.11.1/rules.mak:66: util/memfd.o] Error 1

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJannwRAAoJEJykq7OBq3PI+EwIAMmXHgq12iC9DAydeOO2WwKw
X4btY8uqSqoW7XIzHH8bfy06OfWWaTuB7KSWbr2puOAOI87FMrrnnYivAGwLPU0n
ozub0sDZ01+V/sxn2EM9Quze7y1BQOqZprRS/6j3CSUmytY+K3uZ1P0nj2McPOfj
VRt8k/rs1REbDXFCFws/LrN4Qa5mSAIfKPU2zsWEyx+UGjYdUhlOLWyH5XRhgvxP
FEBD7UyBE0ss780rSSZSjgyXEj+GCD8yg7ppi4cWnX/T81am8tjoE+m8n++UvzTp
g6zZCV8elXzm2xCZuG1kdZA6OCaPVc9LQZZ4vCJE8/E+fgAOehjZRpaf6XsAwnQ=
=dcGn
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

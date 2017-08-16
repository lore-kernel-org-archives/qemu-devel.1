Received: from eggs.gnu.org ([2001:4830:134:3::10]:42311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhu7v-0006RM-Ic
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhu7r-0004VU-JL
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:56:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dhu7r-0004V6-CL
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:56:31 -0400
Received: by mail-wm0-x243.google.com with SMTP id y206so3998022wmd.5
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 01:56:31 -0700 (PDT)
Date: Wed, 16 Aug 2017 09:56:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170816085627.GC3180@stefanha-x1.localdomain>
References: <20170816072104.24420-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20170816072104.24420-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 03:20:55PM +0800, Fam Zheng wrote:
> Build tests in one 32 bit Linux guest and three BSD images are defined in=
 this
> series. This is a more managable way than the manually maintained virtual
> machines in patchew. Also, one big advantage of ephemeral VMs over long r=
unning
> guests is the reduced RAM usage of host, which makes it possible to have =
one
> host test all these BSD variants and probably more.
>=20
> The BSD guest templates are manually prepared following
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> as it is not easy to automate. (The ideal approach is like the ubuntu.i386
> script, which configures the guest on top of an official released image, =
fully
> automatically.)
>=20
> Need for help: "gmake check" in the added OpenBSD image fails with -ENOMEM
> errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? And =
there
> is a warning from ./configure about OpenBSD going to be unsupported in co=
ming
> releases, is it still the case?
>=20
> Fam
>=20
> Fam Zheng (9):
>   gitignore: Ignore vm test images
>   qemu.py: Add variable vga type
>   qemu.py: Add "wait()" method
>   tests: Add vm test lib
>   tests: Add ubuntu.i386 image
>   tests: Add FreeBSD image
>   tests: Add NetBSD image
>   tests: Add OpenBSD image
>   Makefile: Add rules to run vm tests
>=20
>  .gitignore                |   2 +
>  Makefile                  |   2 +
>  configure                 |   2 +-
>  scripts/qemu.py           |   8 +-
>  tests/vm/Makefile.include |  41 ++++++++
>  tests/vm/basevm.py        | 246 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/vm/freebsd          |  44 +++++++++
>  tests/vm/netbsd           |  44 +++++++++
>  tests/vm/openbsd          |  45 +++++++++
>  tests/vm/ubuntu.i386      |  88 +++++++++++++++++
>  10 files changed, 520 insertions(+), 2 deletions(-)
>  create mode 100644 tests/vm/Makefile.include
>  create mode 100755 tests/vm/basevm.py
>  create mode 100755 tests/vm/freebsd
>  create mode 100755 tests/vm/netbsd
>  create mode 100755 tests/vm/openbsd
>  create mode 100755 tests/vm/ubuntu.i386

Adding Cleber to CC since he's looking into QEMU test infrastructure
improvements.

Stefan

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlAi7AAoJEJykq7OBq3PIF3QH+gKSoZpPdHxX4vWo7yrapt0R
LZKW8/PexBMifFIC3ng3GxzA9vVsgxRAkXIWOH36yf/Uxu6ljwTWJ5yq4Ps5Tw/I
TeS6DUwLd+nraJOes73XAtkDyUOsjgG4OirquMUcfldyN3sv+EfGJbCpVJtpCUz/
grJUBXlIHp0kfpbry59nF6GKXjKfqe5rdqalwwlwWerMVSk3Wm1FTQDEOzfnVbDx
/EBdqbZ+7UbowAITxrLAY8r0m9AiUxgAIRg3jN+wDnSjj5L8BNegoHSHSKoTzIV1
/+dg6cVjdqmORuP3DFzFWb5lgn2k4SrHrJg4Gn2hjt7yXR1JRE7w4HY05my5Xho=
=ZUCb
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--

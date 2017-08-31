Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dnQFC-000348-3i
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dnQF8-0004Ig-Q8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:14:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:51105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dnQF8-0004IU-EI
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:14:50 -0400
References: <20170831064302.14427-1-famz@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
Date: Thu, 31 Aug 2017 16:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170831064302.14427-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pcbICuwVLOe30R8O3H5stwI3FUnx2kRjW"
Subject: Re: [Qemu-devel] [PATCH v5 00/12] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pcbICuwVLOe30R8O3H5stwI3FUnx2kRjW
From: Kamil Rytarowski <n54@gmx.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 eblake@redhat.com
Message-ID: <a0308f02-4716-87ea-5070-b57d567aae07@gmx.com>
Subject: Re: [PATCH v5 00/12] tests: Add VM based build tests (for non-x86_64
 and/or non-Linux)
References: <20170831064302.14427-1-famz@redhat.com>
In-Reply-To: <20170831064302.14427-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Could we please add SmartOS image. It's an Illumos distribution,
previously known as OpenSolaris.

qemu is actively maintained for SmartOS in pkgsrc.

The latest build fixes were introduced less than a week ago.
https://github.com/NetBSD/pkgsrc/commit/f2608af5433f1491a92567bf570e9349d=
ffbda7a

I'm going to submit the SmartOS patches to fix the build regardless of
the decision.

On 31.08.2017 08:42, Fam Zheng wrote:
> v5: Generate source tar file with a script.
>     Fix tmpdir, use pwd.
>     Reduce default -j to half cores.
>=20
> v4: Drop unused imports and parameters. [Cleber]
>     Use --exclude-vcs (still no --exclude-vcs-ignores because it's too =
new). [Philippe]
>     Use gtar if available. [Philippe, Kamil]
>     /dev/ld1a -> /dev/rld1a for netbsd. [Kamil]
>     Only use '-enable-kvm' if /dev/kvm is there. [Kamil]
>     Grammar fixes of README. [Stefan]
>     Rename image on the server to include version and arch. [Kamil]
>     Just ignore *.tmp. [Philippe]
>=20
> v3: Drop RFC.
>     Add Stefan's and Kamil's reviewed-bys.
>     Use optparse. [Stefan]
>     Drop the VGA patch. [Paolo, Stefan]
>     Improve exit/exit code/doc. [Stefan]
>     Drop unused line from basevm.py. [Stefan]
>     Drop "--target-list" form Makefile.
>     More intelligent '-j'.
>     Add README. [Stefan]
>=20
> v2: - Add docstring. [Stefan]
>     - Call self._load_io_lod. [Stefan]
>     - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
>     - Add image checksum.
>     - Use os.rename() and os.makedirs(). [Stefan]
>     - Fix NetBSD URL. [Kamil]
>=20
> Build tests in one 32 bit Linux guest and three BSD images are defined =
in this
> series. This is a more managable way than the manually maintained virtu=
al
> machines in patchew. Also, one big advantage of ephemeral VMs over long=
 running
> guests is the reduced RAM usage of host, which makes it possible to hav=
e one
> host test all these BSD variants and probably more.
>=20
> The BSD guest templates are manually prepared following
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> as it is not easy to automate. (The ideal approach is like the ubuntu.i=
386
> script, which configures the guest on top of an official released image=
, fully
> automatically.)
>=20
> Need for help: "gmake check" in the added OpenBSD image fails with -ENO=
MEM
> errors, even if I change "-m 2G" to "-m 8G" when starting VM. Ideas? An=
d there
> is a warning from ./configure about OpenBSD going to be unsupported in =
coming
> releases, is it still the case?
>=20
> Fam
>=20
> Fam Zheng (12):
>   gitignore: Ignore vm test images
>   qemu.py: Add "wait()" method
>   scripts: Add archive-source.sh
>   tests: Add vm test lib
>   tests: Add ubuntu.i386 image
>   tests: Add FreeBSD image
>   tests: Add NetBSD image
>   tests: Add OpenBSD image
>   Makefile: Add rules to run vm tests
>   MAINTAINERS: Add tests/vm entry
>   tests: Add README for vm tests
>   docker: Use archive-source.py
>=20
>  .gitignore                    |   2 +
>  MAINTAINERS                   |   1 +
>  Makefile                      |   2 +
>  configure                     |   2 +-
>  scripts/archive-source.sh     |  29 +++++
>  scripts/qemu.py               |   7 ++
>  tests/docker/Makefile.include |  15 +--
>  tests/docker/run              |   8 +-
>  tests/vm/Makefile.include     |  42 +++++++
>  tests/vm/README               |  63 ++++++++++
>  tests/vm/basevm.py            | 276 ++++++++++++++++++++++++++++++++++=
++++++++
>  tests/vm/freebsd              |  42 +++++++
>  tests/vm/netbsd               |  42 +++++++
>  tests/vm/openbsd              |  43 +++++++
>  tests/vm/ubuntu.i386          |  88 ++++++++++++++
>  15 files changed, 641 insertions(+), 21 deletions(-)
>  create mode 100755 scripts/archive-source.sh
>  create mode 100644 tests/vm/Makefile.include
>  create mode 100644 tests/vm/README
>  create mode 100755 tests/vm/basevm.py
>  create mode 100755 tests/vm/freebsd
>  create mode 100755 tests/vm/netbsd
>  create mode 100755 tests/vm/openbsd
>  create mode 100755 tests/vm/ubuntu.i386
>=20



--pcbICuwVLOe30R8O3H5stwI3FUnx2kRjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZqBd9AAoJEEuzCOmwLnZs8xcQAJOsnBGwEHPjn9+dZJVkeDRc
9ofpeZDiNBov7pEjJgm9snTqMOb8lqzauRLgGO7FR+VL9Ef9MFUlKpW3xWUPBtDh
R+BZKyWJWqd6Pm6l3ZKd/59FoK1bzxLdzx/v3w8nz43RtvYgLdH4oqn9enj0O54l
KtocPTASqomgJKLGZsWee+EAHNPLNjEf7A3GVLbTk0dvgQ7j7geZDA0bLaXMd+yB
xV9KtpzbkLq7UAmJuBOL9Y7/orUNvYtvQSFl+EOKEH/lo4V9Al2IjB87iKNDGGMY
UFF1ewhJHP1Rh0hUlJxfWJEIgk8T9Qo540wYLQSH8iMYh/06WNFpNAYCiHAyNqxJ
4C49Xl82y7texMwhau6maP+2C4ek1I7B+KnUWqg/xMBiYL5fQg6tnu4yOP4TyibH
N9Bj+IHRYQaW0w/pEeIdvoZIS37xSmBPRYhsLw/Hm4iNqt1WfugNPz5hLHR+ErcZ
kCUwe8N+lAEuAjJlJXPCkjZaCcMRtYIv6/IXs4I+fW7ztI/SwnHGBxofeWvA/HVv
AiaDV0SH6b8x10OnAlAIDJr1MavkmK2G9g/vCQ+NAnG2y91V1xK9okzLlvKTUlDo
UG0uE9mYPuzWSzJC0XwQoWhgfESQyEQDxB9UER4meIZ4P/YJvNIRhRDuRSn9O08x
9H6b0lCMoZXhqdkx/L4Q
=QYAx
-----END PGP SIGNATURE-----

--pcbICuwVLOe30R8O3H5stwI3FUnx2kRjW--

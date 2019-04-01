Received: from eggs.gnu.org ([209.51.188.92]:57082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAwPQ-0000Yb-M7
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAwPO-0008E4-HR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hAwPM-000832-WA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:51:25 -0400
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-10-peter.maydell@linaro.org>
	<92ffba93-e486-647a-01ef-86180fb2cbb2@redhat.com>
	<CAFEAcA8U1o7JZmAP4nhsiY+riFtZmxHBQCkOu0zmR++K70gnQA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d2c48da-dba9-6a8e-eca4-41fbd3c317b2@redhat.com>
Date: Mon, 1 Apr 2019 07:51:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8U1o7JZmAP4nhsiY+riFtZmxHBQCkOu0zmR++K70gnQA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fsSAxjTYWlquzY9H6HY1Zt3aJdfPHWrso"
Subject: Re: [Qemu-devel] [PATCH v3 09/12] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, "Richard W.M. Jones" <rjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fsSAxjTYWlquzY9H6HY1Zt3aJdfPHWrso
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <0d2c48da-dba9-6a8e-eca4-41fbd3c317b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/12] Makefile, configure: Support
 building rST documentation
References: <20190305172139.32662-1-peter.maydell@linaro.org>
 <20190305172139.32662-10-peter.maydell@linaro.org>
 <92ffba93-e486-647a-01ef-86180fb2cbb2@redhat.com>
 <CAFEAcA8U1o7JZmAP4nhsiY+riFtZmxHBQCkOu0zmR++K70gnQA@mail.gmail.com>
In-Reply-To: <CAFEAcA8U1o7JZmAP4nhsiY+riFtZmxHBQCkOu0zmR++K70gnQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 2:58 AM, Peter Maydell wrote:
> On Sat, 30 Mar 2019 at 22:05, Eric Blake <eblake@redhat.com> wrote:
>> Rich told me that qemu-nbd.8 was not being built, and I confirmed that=

>> it failed to build for me. git bisect points to this commit as the
>> reason that 'touch qemu-nbd.texi; make' no longer rebuilds qemu-nbd.8
>> automatically. Is it merely because I don't have enough stuff installe=
d,
>> or is it an actual broken dependency?
>>
>> /me goes and runs 'dnf install "*/sphinx-build"...
>>
>> Nope, even with that installed, qemu-nbd.8 is still not getting built =
by
>> 'make'; but 'make qemu-nbd.8' is working. We lost a dependency :(
>=20
> I just did a test build from clean and I get a qemu-nbd.8 in the
> build directory. I also  checked that 'touch qemu-nbd.texi; make -C bui=
ld V=3D1'
> rebuilds the manpage, and it does:
>=20
> [snip other stuff]
> perl -Ww -- /home/pm215/qemu/scripts/texi2pod.pl -I docs -I
> /home/pm215/qemu -I . "-DVERSION=3D3.1.91"
> /home/pm215/qemu/qemu-nbd.texi qemu-nbd.8.pod && pod2man --utf8
> --section=3D8 --center=3D" " --release=3D" " qemu-nbd.8.pod > qemu-nbd.=
8
> [...]
>=20
> You will need sphinx-build in order to build
> the docs now, and without that we won't build the manpage, but
> if you have sphinx-build installed then it should work.
> Can you check that your config-host.mak has BUILD_DOCS=3Dyes ?

Not seeing it.

> Did you definitely rerun configure after installing sphinx?

Trying that again.  I did not specify anything special to configure to
force-enable/disable docs, so this time, it should auto-detect that
sphinx-build is present...

and now BUILD_DOCS=3Dyes appears...

And that fixes it. Thanks for helping me spot the added build dependency.=



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--fsSAxjTYWlquzY9H6HY1Zt3aJdfPHWrso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyiCUYACgkQp6FrSiUn
Q2okTQf/af74wSorGy0hEdNZ/UHhuTJbgA0KsY9GMLr/bR4UEFiO/BiCrFfGFb8x
2yw0YbfEXD0dsO2XmEmLkuublz8FEGkOqunp2VFosSGQUM1GvXEqeqv8GpCUv03n
OpnAUgDRbmXCq8erfG5GlJtvM7kUwxab3cPVKHL1+r8D1bjbUVn9KLsHAbLXiih6
UEI1p3t9iw93E2kP9dHEIWhUYiZxIyIyfh1QOMw5Xtd+NVj+LcsgK8eF9UvbMrEs
8P2lsadNLEqfdnlqY9xBgB0dIiQDeZsCz+2Xla213GGkoHZ0gdx8BZFOJo61+BSk
Hk99tA3CdNBr6ix9Yx/RZvqA1V7TIQ==
=xkvf
-----END PGP SIGNATURE-----

--fsSAxjTYWlquzY9H6HY1Zt3aJdfPHWrso--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1defsU-0004NT-FH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1defsT-0002Vj-8Q
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:07:18 -0400
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-11-hpoussin@reactos.org>
	<CAJhHMCAZjtSZ9bVP8ARuex=kEUox=ed__LdEe39a6-gY7oKggQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e20b65fe-9cb4-2b8f-05cb-fdc10485c9d9@redhat.com>
Date: Mon, 7 Aug 2017 06:07:06 -0500
MIME-Version: 1.0
In-Reply-To: <CAJhHMCAZjtSZ9bVP8ARuex=kEUox=ed__LdEe39a6-gY7oKggQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hNQDOLIuS15qAL3JN8WCGrUb2XXSvNcCj"
Subject: Re: [Qemu-devel] [PATCH v2 10/13] vvfat: correctly generate
 numeric-tail of short file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hNQDOLIuS15qAL3JN8WCGrUb2XXSvNcCj
From: Eric Blake <eblake@redhat.com>
To: Pranith Kumar <bobby.prani@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <e20b65fe-9cb4-2b8f-05cb-fdc10485c9d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/13] vvfat: correctly generate
 numeric-tail of short file names
References: <20170522211205.14265-1-hpoussin@reactos.org>
 <20170522211205.14265-11-hpoussin@reactos.org>
 <CAJhHMCAZjtSZ9bVP8ARuex=kEUox=ed__LdEe39a6-gY7oKggQ@mail.gmail.com>
In-Reply-To: <CAJhHMCAZjtSZ9bVP8ARuex=kEUox=ed__LdEe39a6-gY7oKggQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/2017 01:52 PM, Pranith Kumar wrote:
> FYI,
>=20
> This commit breaks the build with gcc-7:
>=20
>   CC      block/vvfat.o
> qemu/block/vvfat.c: In function =E2=80=98read_directory=E2=80=99:
> qemu/block/vvfat.c:605:37: error: =E2=80=98__builtin___sprintf_chk=E2=80=
=99 may write
> a terminating nul past the end of the destination
> [-Werror=3Dformat-overflow=3D]
>              int len =3D sprintf(tail, "~%d", i);
>                                      ^~~~~

Doesn't commit 7c8730d45f6 fix that?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hNQDOLIuS15qAL3JN8WCGrUb2XXSvNcCj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmISdoACgkQp6FrSiUn
Q2pp4ggAr6nLuh6n/kdtzUChbh+cUeZFjEzFlmxRjWArYhK26Eqf4j8+7NMXLaW1
iPQ+qpkIwyDCwmD5N/czaE12+zj5fFO1o9xbcpTba+NlW0MH5BW09Qm8aCBZQN3d
pgqvsBWSOxmT938yif/Obox0vuKQFhEWrsSERa+/7Jzz+YtyLugUMKU7qU1rb2lA
5Xe4ja9Dp2hqJcD5UUHCcjRJzyYBzCI5TH5N16SPEVj6oxwl4PAeTbMCN5Aj4V/g
zSIhZC2NUyZVC0zEuOcrvLS1Rm3RNa6kCnrAZdo8ei4CfyyVifLpB2pgJ8REYLrJ
Zw5bbfFLSyL5K3YjeWtwgQz6xSLjKw==
=inzr
-----END PGP SIGNATURE-----

--hNQDOLIuS15qAL3JN8WCGrUb2XXSvNcCj--

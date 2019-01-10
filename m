Received: from eggs.gnu.org ([209.51.188.92]:49494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghaT6-00018X-En
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghaT2-0000P1-Sr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:33:54 -0500
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<8736q3ebs2.fsf@dusky.pond.sub.org>
	<d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1551373d-91fa-1345-1757-7299b073d157@redhat.com>
Date: Thu, 10 Jan 2019 07:33:45 -0600
MIME-Version: 1.0
In-Reply-To: <d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cu6cYfhW21MgwvNLIH8cutBOoArVA4tNr"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cu6cYfhW21MgwvNLIH8cutBOoArVA4tNr
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lbloch@janustech.com>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1551373d-91fa-1345-1757-7299b073d157@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
References: <20190103213320.2653-1-lbloch@janustech.com>
 <20190103213320.2653-2-lbloch@janustech.com>
 <8736q3ebs2.fsf@dusky.pond.sub.org>
 <d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
In-Reply-To: <d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 3:42 AM, Leonid Bloch wrote:

> If you've noticed, the original script was in AWK. But to be as generic=
=20
> as possible, I didn't write the generation script in AWK because even=20
> AWK is not guaranteed to be installed on the build system. The only=20
> interpreted language that is guaranteed to be there is shell (most basi=
c=20
> shell) because .configure itself needs it.
>=20
> Sure, the script could be prettier and shorter, but I wanted to keep it=
=20
> compatible with the most basic shell, not only Bash, and without needin=
g=20
> external programs.

awk is portable - autoconf-generated scripts assume it exists (same as
sed, grep, ls, ...) if you have a /bin/sh. In fact, the GNU Coding
Standards has a nice list of programs that you can blindly assume exist.
 It's true you may have to use a lowest-common-denominator when using
the tools that are globally available to be portable (not all awk
scripts are portable, even if awk is universally available on systems
with a Bourne-like shell).  So avoiding awk on the grounds that it might
not be present is the wrong approach.

> Eric - thanks for the comment about 'local' - I will get rid of it if w=
e=20
> decide to include this patch.

I'm still not convinced we need it.  I would much rather see a patch
that makes QemuOpt accept default integer values as integers rather than
as strings, so we don't have to worry about stringifying special macros.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cu6cYfhW21MgwvNLIH8cutBOoArVA4tNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw3SbkACgkQ3g5py3or
ov01Igf/cmdBZn5zXpNeLDFTuC8BghjLFIPJ4LYzCuXNt9P1w9X6G7dhVWW9Vwn3
Qphe8wI8tAOZkSdRHngRUpG3/grRED8gETJaIK/tRmTnN2Qe3Ab7rMqIn2tHZ8Y5
ZO4MstUVYKmh++vzTx3rGDHvM97GNua3FxaAi8PjoEP+Zk+F+UHTGGNyu7EDX1xg
LtLzi0rYqix6ec+oB/ZYU+MBpvFsKag64DPw84Pg5wovxCGmg4RiPkIa4WeHA3l4
z2CY5kXz8+25IxzeJAlObIH3zDQzzK0pedR8YcJe+fpCNVnXwM+h53irTi/xg+1f
K0j8QuAps/VSEdShwrGQOIuihMvIYw==
=6G+G
-----END PGP SIGNATURE-----

--cu6cYfhW21MgwvNLIH8cutBOoArVA4tNr--

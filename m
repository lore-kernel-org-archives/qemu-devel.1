Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB0Xh-0000D2-Rd
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB0Xd-0001ot-PX
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:07:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB0Xd-0001ob-Fd
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:07:09 -0400
References: <20170517124042.1430-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89400e9a-7f1e-7f86-a416-7365d943e703@redhat.com>
Date: Wed, 17 May 2017 10:07:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170517124042.1430-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KOr0diA1DmUOUMsrkNLgsIpBRtFIgPh3v"
Subject: Re: [Qemu-devel] [PATCH v2] .gdbinit: load QEMU sub-commands when
 gdb starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KOr0diA1DmUOUMsrkNLgsIpBRtFIgPh3v
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>
Message-ID: <89400e9a-7f1e-7f86-a416-7365d943e703@redhat.com>
Subject: Re: [PATCH v2] .gdbinit: load QEMU sub-commands when gdb starts
References: <20170517124042.1430-1-stefanha@redhat.com>
In-Reply-To: <20170517124042.1430-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 07:40 AM, Stefan Hajnoczi wrote:
> The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbini=
t
> file so GDB either loads qemu-gdb.py automatically or prints a message
> informing the user how to enable them (some systems disable ./.gdbinit
> loading for security reasons).
>=20
> Symlink .gdbinit and the scripts directory in order to make out-of-tree=

> builds work.  The scripts directory is used to find the qemu-gdb.py fil=
e
> specified by a relative path in .gdbinit.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Support out-of-tree builds [Daniel, Markus]

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KOr0diA1DmUOUMsrkNLgsIpBRtFIgPh3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHGcXAAoJEKeha0olJ0NqGyYIAI0+2EIuYvSZ7bD5dkgLPtBw
dLkyJi4TdwoMUKWMH8fhPOiMxZeQ2zt1PKRULt1eKnA1bDNvlE1YJRQgINVB/L4R
NLTTsXBlLVN2nVO3jgNhuGcjaeajWT+dydy3VocpXQbM0v1IatEYOoJBvDsrareJ
a4ITiDYApJfY5ta8CMYfKdDzMws1gj03d0PmCdatPsUuh25erHpeOfTzcQ5oVV94
NZwdjtvxAf1imoOFHA0NPZ+qwS0MpK3qP4RG8aKiLGusozn9jNHVD92aASvmtlNF
jwXF6P3xcqMlKuAEco4hZMP5g9tptKjoWyP4j0pdP5vJaiDSB/UbXUGX+N9RGl4=
=N0ed
-----END PGP SIGNATURE-----

--KOr0diA1DmUOUMsrkNLgsIpBRtFIgPh3v--

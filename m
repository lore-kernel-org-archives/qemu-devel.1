Received: from eggs.gnu.org ([2001:4830:134:3::10]:33839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0Hx-0002fm-IP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0Hw-0004is-Ca
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:17:13 -0400
References: <20170702150510.23276-1-mreitz@redhat.com>
	<20170702150510.23276-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <573379d4-3102-43b6-8348-72dbd5999702@redhat.com>
Date: Mon, 3 Jul 2017 07:17:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170702150510.23276-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OrU2bm2cgRIlcgwrNbo5F6Vbv6wJvSBnI"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OrU2bm2cgRIlcgwrNbo5F6Vbv6wJvSBnI
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <573379d4-3102-43b6-8348-72dbd5999702@redhat.com>
Subject: Re: [PATCH v5 1/2] iotests: Use absolute paths for executables
References: <20170702150510.23276-1-mreitz@redhat.com>
 <20170702150510.23276-2-mreitz@redhat.com>
In-Reply-To: <20170702150510.23276-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2017 10:05 AM, Max Reitz wrote:
> A user may specify a relative path for accessing qemu, qemu-img, etc.
> through environment variables ($QEMU_PROG and friends) or a symlink.
>=20
> If a test decides to change its working directory, relative paths will
> cease to work, however. Work around this by making all of the paths to
> programs that should undergo testing absolute. Besides "realpath", we
> also have to use "type -p" to support programs in $PATH.
>=20
> As a side effect, this fixes specifying these programs as symlinks for
> out-of-tree builds: Before, you would have to create two symlinks, one
> in the build and one in the source tree (the first one for common.confi=
g
> to find, the second one for the iotest to use). Now it is sufficient to=

> create one in the build tree because common.config will resolve it.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OrU2bm2cgRIlcgwrNbo5F6Vbv6wJvSBnI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWjW8AAoJEKeha0olJ0Nqq7cH/07JQaLLUlm7NTPGMewbZ1iY
TpCHgCg+dYeqzmMU6m/PbNBuFEaCMiEQFnYUXOyqJ1/m0mf6rdjxqhMaq2RV3iCc
vk9rB9nA0PYRrXKzH7SuKyan3GQow17Z0vkJzTCmSsFfNjZjsffmtjoCCDRZ23My
g8DnkAC759YO0/AbBf9/r2iUme0klKcxqlj5V3HFMeol07g6ajZcyN76r1XPaLi3
tJ0Fkm/BNzlLM+JsCojTIBFQgo9sMFlmBKBZmH7nFyGhlb1G7ka8SGPUHtaQ4Q/K
hpU0BaGt0Ru3k1FCduY/PhJoxx6dc/A0TWs+JzSCVSuieM9w1SlDvhtcVon9x9k=
=tnG+
-----END PGP SIGNATURE-----

--OrU2bm2cgRIlcgwrNbo5F6Vbv6wJvSBnI--

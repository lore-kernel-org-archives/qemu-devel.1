Received: from eggs.gnu.org ([2001:4830:134:3::10]:38064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFkz4-0003q2-QZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFkz3-0007q3-Ue
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:03:22 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-10-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f3ed740-9d05-37f5-5437-0fb564464127@redhat.com>
Date: Fri, 17 Nov 2017 12:03:11 -0600
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-10-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EFSojEknumQenbpEVGP5ENjq9ue0og95O"
Subject: Re: [Qemu-devel] [PATCH 09/10] qemu-iotests: remove unused "here"
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EFSojEknumQenbpEVGP5ENjq9ue0og95O
From: Eric Blake <eblake@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <0f3ed740-9d05-37f5-5437-0fb564464127@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] qemu-iotests: remove unused "here"
 variable
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-10-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-10-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/16/2017 11:38 AM, Cleber Rosa wrote:
> Another legacy variable that did not convince me it has any
> purpose whatsoever.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---

> +++ b/tests/qemu-iotests/001
> @@ -23,7 +23,6 @@
>  seq=3D`basename $0`
>  echo "QA output created by $seq"
> =20
> -here=3D`pwd`

Good riddance.  And in the majority of the tests, it was a needless
fork(), compared to my preference (which is also guaranteed by POSIX and
by /bin/bash):

> +++ b/tests/qemu-iotests/176
> @@ -27,7 +27,6 @@
>  seq=3D"$(basename $0)"
>  echo "QA output created by $seq"
> =20
> -here=3D"$PWD"

since $PWD and `pwd` should always produce the same thing, if we even
had a reason to use it. ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EFSojEknumQenbpEVGP5ENjq9ue0og95O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPJF8ACgkQp6FrSiUn
Q2rgBwf+Kt8G1BxNxMNXImMhkR+rLvOVop9rFjgmgEajTIcPXeggzpr66VAU4lIV
HHIgMPugmXr4QABJqQuTqPHQIo6zyd6KYpraIBESuV4v1pUi6Ol5iZ6V/JD2/1Qe
YLFmiF/d9txV/FpLZEzLCdWLwpimJi48FFqut8N8P5zxir7yqFyywk6KEu3IOVz7
LhGPx9bgNJc5sbYP17T0C2RWXZh0p1iYQW60MQ/9U9n7ZtcYJ0Qki5p3f6mKchKD
5uYWnALHDHkxBefP+xnDN9iD5en/UvjrRGtzR/zQgdPqvpy5/1CRo0hH8diWCaty
ODTPy8+N9bVhokku4SsdiMfFsLXKRA==
=FbwT
-----END PGP SIGNATURE-----

--EFSojEknumQenbpEVGP5ENjq9ue0og95O--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwzC-0006ZY-Jo
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwzB-0007pq-GF
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:25:22 -0400
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9858586d-8699-bd2f-e8c2-02f85a92b501@redhat.com>
Date: Mon, 18 Sep 2017 09:25:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170916185123.29255-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gv9gQdtTUwXEepjoDGxAWvGcqiF6Ff8mI"
Subject: Re: [Qemu-devel] [PATCH v5 6/6] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gv9gQdtTUwXEepjoDGxAWvGcqiF6Ff8mI
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <9858586d-8699-bd2f-e8c2-02f85a92b501@redhat.com>
Subject: Re: [PATCH v5 6/6] tests: Add check-qobject for equality tests
References: <20170916185123.29255-1-mreitz@redhat.com>
 <20170916185123.29255-7-mreitz@redhat.com>
In-Reply-To: <20170916185123.29255-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2017 01:51 PM, Max Reitz wrote:
> Add a new test file (check-qobject.c) for unit tests that concern
> QObjects as a whole.
>=20
> Its only purpose for now is to test the qobject_is_equal() function.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/Makefile.include |   4 +-
>  tests/check-qobject.c  | 315 +++++++++++++++++++++++++++++++++++++++++=
++++++++

We're not entirely consistent on our testsuite naming, although I'm fine
with your choice [and there's still the idea floating around in another
thread to split tests into subdirectories by whether they are part of
check-unit or check-qtest].  However, the check-* notation cannot be
automatically covered by .gitignore the way a -test suffix is, so you're
missing a change to tests/.gitignore covering the new test in an in-tree
build.

We have the idea floating around that we want to outlaw in-tree builds
altogether [although I'm not sold on that yet], and/or to generate
=2Egitignore, but until those land, it doesn't hurt to keep .gitignore
up-to-date.  So with that addition,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gv9gQdtTUwXEepjoDGxAWvGcqiF6Ff8mI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/10MACgkQp6FrSiUn
Q2qjyQf/frp9chtmWv3Zo/X7mi7cmGesOIGQBN7U/qWSohMzHexWwuf+H6lKcLZz
yKOoOWKealCvCSqI5AAdBXYFxBsKZc1KYPQ8JOeKn4bW4fqrNbFtNR2Or32JHXpl
InjKWmf2R0Uz3iS5cpWqSbwqNAajtLCk/qh30215D9QxW8EQBj82L8IOiNktgnVg
EeipoDnjTfS60JCubN9gdeoaTeoazMsP660awSfPSS6N3goaBgP7XJjDungwwfjF
x0IgXNDcKScXuHrd0ZL4F7AmeR260TCAlvAIk0KSepIlR45acim3Yf2polDM7BsG
HI2fvG8Do4CBQfjpLjnMYzpgka+v1A==
=e5Qg
-----END PGP SIGNATURE-----

--gv9gQdtTUwXEepjoDGxAWvGcqiF6Ff8mI--

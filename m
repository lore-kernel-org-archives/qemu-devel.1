Received: from eggs.gnu.org ([2001:4830:134:3::10]:41287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcf6u-00035R-LJ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcf6t-0007o0-Vu
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:53:52 -0400
References: <20170801213127.15036-1-crosa@redhat.com>
	<20170801213127.15036-2-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <648b1ac7-84e2-7fc4-6f36-fbec202700f0@redhat.com>
Date: Tue, 1 Aug 2017 16:53:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170801213127.15036-2-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qLb8pj7t4RMF9ccvC9KTKxdSmJoj8a3h6"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/1] qemu-iotests/109: Fix lock
 race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qLb8pj7t4RMF9ccvC9KTKxdSmJoj8a3h6
From: Eric Blake <eblake@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <648b1ac7-84e2-7fc4-6f36-fbec202700f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/1] qemu-iotests/109: Fix lock race
 condition
References: <20170801213127.15036-1-crosa@redhat.com>
 <20170801213127.15036-2-crosa@redhat.com>
In-Reply-To: <20170801213127.15036-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 04:31 PM, Cleber Rosa wrote:
> A race condition is currently present between the clean up attempt of
> the QEMU process and the execution of qemu-img.  The actual (bad)
> output is:
>=20
>  -Warning: Image size mismatch!
>  -Images are identical.
>  +qemu-img: Could not open '<build_dir>/tests/qemu-iotests/scratch/t.ra=
w': Failed to get "consistent read" lock
>  +Is another process using the image?
>=20
> A KILL signal is sent to the QEMU process, but qemu-img may begin to
> run before the QEMU process is really gone.  qemu-img will then
> attempt to open the TEST_IMG file before it can secure a lock on it.
>=20
> This attempts a more graceful shutdown, and waits for the QEMU process
> to exit.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/109     |  3 ++-
>  tests/qemu-iotests/109.out | 56 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Probably missed -rc1, but still okay for -rc2

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qLb8pj7t4RMF9ccvC9KTKxdSmJoj8a3h6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmA+GEACgkQp6FrSiUn
Q2rJ1wf/ZpEfYmebV1QTL7RrXsAKDct8XW087eXnWzYbd7mK8bo9kLEj8FRmvE0e
TMUfx1ZM7jUN6v5ff2GWHxfTTGeutf5IF5tKWuUuPNxZujepgYiR+/6IA1C1PYF1
cVgwtfpEvtpsc59WhysrEXh3oUT0rvPf1S/RhMMPNLeI9Z77woPkcQw6wBBjtcdF
Mwpr8GVar4tzbRCIkdwf4ORVxuZ8M1u2n/Mc39rFDml94qLp3gqtAQRdbPxZ0dBy
xoJcNa7Q3ccbrit993sWhh+fEmXWkvVOK1IsuUKmXqnQp91JuXVaQpLpHhC5utu3
FWIAxrDD0Cicd7RRyM3PyFmctRxbAw==
=FPg+
-----END PGP SIGNATURE-----

--qLb8pj7t4RMF9ccvC9KTKxdSmJoj8a3h6--

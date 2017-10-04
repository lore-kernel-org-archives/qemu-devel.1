Received: from eggs.gnu.org ([2001:4830:134:3::10]:48590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzqsh-0006RL-8D
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzqsg-0006Pj-8X
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:07:03 -0400
References: <20171004152553.30263-1-mreitz@redhat.com>
	<20171004152553.30263-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8e29104-dfab-f82a-71d0-96d4ec334605@redhat.com>
Date: Wed, 4 Oct 2017 16:06:51 -0500
MIME-Version: 1.0
In-Reply-To: <20171004152553.30263-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BwlVC7uKIgeBXDXhC3v0FhGegDirN1skp"
Subject: Re: [Qemu-devel] [PATCH v6 2/6] qapi/qlist: Add qlist_append_null()
 macro
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
--BwlVC7uKIgeBXDXhC3v0FhGegDirN1skp
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <d8e29104-dfab-f82a-71d0-96d4ec334605@redhat.com>
Subject: Re: [PATCH v6 2/6] qapi/qlist: Add qlist_append_null() macro
References: <20171004152553.30263-1-mreitz@redhat.com>
 <20171004152553.30263-3-mreitz@redhat.com>
In-Reply-To: <20171004152553.30263-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 10:25 AM, Max Reitz wrote:
> Besides the macro itself, this patch also adds a corresponding
> Coccinelle rule.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qlist.h         | 3 +++
>  scripts/coccinelle/qobject.cocci | 3 +++
>  2 files changed, 6 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BwlVC7uKIgeBXDXhC3v0FhGegDirN1skp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnVTWsACgkQp6FrSiUn
Q2pnwAf8D4dVx1FPVzDRSV3z6hE2dvsGpA0uGDm16b2mnCnkolLPnQrU6qgDb3N+
ieDtFhzy8pmQ7Bh3HCnDOldqvZmedcr0LpVzE8FJ23gVRbHNKc5fdScWZ4SnzGLi
WG8dSeMgHNXmvc4W+SJVMh+zR8TzHtFLVm8Wk2VHm8uPHHmLPgaf/aOrp+zsIFd3
rj9IEBokbUz258GxF9AZ9zUD6Q0I9Qe1kt8Urdn5S7nSDc4atFCFrNpFWKICliQU
JCIciOCPPjvXlFiKaJcggaEL2zoSlp0IYv+GztpcdJ6fI9FgdXVdV/HnbqjTfXl9
2IbDLGzcxdOwNKeW4/UMOsZrFRrzXw==
=U8PP
-----END PGP SIGNATURE-----

--BwlVC7uKIgeBXDXhC3v0FhGegDirN1skp--

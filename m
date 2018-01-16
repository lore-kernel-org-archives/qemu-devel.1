Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebX1M-00038S-3s
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebX1L-0001yQ-2b
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:35:44 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63d5617c-67c7-6ffd-e312-01ba3f63af6a@redhat.com>
Date: Tue, 16 Jan 2018 13:35:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="osYxAagBDmQt0mcEjIjKwBwnoEvGi0UP6"
Subject: Re: [Qemu-devel] [RFC PATCH 05/10] qcow2: Use BlockdevRef in
 qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--osYxAagBDmQt0mcEjIjKwBwnoEvGi0UP6
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <63d5617c-67c7-6ffd-e312-01ba3f63af6a@redhat.com>
Subject: Re: [RFC PATCH 05/10] qcow2: Use BlockdevRef in qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-6-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> Instead of passing a separate BlockDriverState* into qcow2_create2(),
> make use of the BlockdevRef that is included in BlockdevCreateOptions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  1 +
>  block.c               | 39 +++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c         | 33 +++++++++++++++++++++------------
>  3 files changed, 61 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--osYxAagBDmQt0mcEjIjKwBwnoEvGi0UP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeVAMACgkQp6FrSiUn
Q2py9QgApLP9QJRXzGzl2zJJ5YLr1McbQENZ1O3jtDGUyDzHLJAXF93R20qC27t2
QLsQho8bXI5ClQTygA3VbZV10qMhCccR9bK94H4QBSHU+uFbEkLK9FOY1wlSqcXH
j1SQaGbQtsUw0hCW1y0yuDfn2BPLmzPCW6Kqq5xpSyLX6FupGosFs0jsw39Tu5xM
2jq7ZEU8qKl/BG3P996VDdSN0meeJ5rPyCpP5FhScVwGOtMpXNHhiEUPRHJXCmuX
CMn3uksQGzHJoiZFPTOuICStYEF751YXNNQOnJqwpsw4oxglpS116+yQ2UP7ALY5
N4gavZIKBwKhS43I09utpx+zMoQibg==
=tIuf
-----END PGP SIGNATURE-----

--osYxAagBDmQt0mcEjIjKwBwnoEvGi0UP6--

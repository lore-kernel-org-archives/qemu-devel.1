Received: from eggs.gnu.org ([2001:4830:134:3::10]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehLD-0006Nj-BX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehL8-00056u-DS
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:41:03 -0400
References: <20170807123658.28772-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22de5419-2a4b-e918-298e-db4da2625512@redhat.com>
Date: Mon, 7 Aug 2017 07:40:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170807123658.28772-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6P1qg1Q1mqaVIMqKj9E2MpGGXGeh0Huu3"
Subject: Re: [Qemu-devel] [PATCH for-2.10] quorum: Set sectors-count to 0
 when reporting a flush error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6P1qg1Q1mqaVIMqKj9E2MpGGXGeh0Huu3
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <22de5419-2a4b-e918-298e-db4da2625512@redhat.com>
Subject: Re: [PATCH for-2.10] quorum: Set sectors-count to 0 when reporting a
 flush error
References: <20170807123658.28772-1-berto@igalia.com>
In-Reply-To: <20170807123658.28772-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:36 AM, Alberto Garcia wrote:
> The QUORUM_REPORT_BAD event has fields to report the sector in which
> the error was detected and the number of affected sectors starting
> from that one. This is important for read and write errors, but not
> for flush errors.
>=20
> For flush errors the current code reports the total size of the disk
> image. That is however not useful information in this case. Moreover,
> the bdrv_getlength() call can fail, and there's no good way of
> handling that failure.
>=20
> Since we're reporting useless information and we cannot even guarantee
> to do it in a consistent way, this patch changes the code to report 0
> instead in all cases.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/quorum.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6P1qg1Q1mqaVIMqKj9E2MpGGXGeh0Huu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIX80ACgkQp6FrSiUn
Q2rI+QgAn948wkTTa8/42c/LbO806J6yGxvxNNzH2z1Cl7mJF7sWuJ1rR+LxHRbR
iD/C5ya2NpS47iUjvaIMntaFYwX0n33yKF88lyqFCKkg87JYuDcz6ccw7wjNehFi
S7QOqWuNtiimTFlzg7U7f89kMQY1gzlHvr1EwBV2C4ZEuXCMdVAXTGNjo6AZfeIT
K5YzysKwBZ2oYDt4tn1uee4mnWsiSEOwnX4UXpGEvTqLMoXrv23MxYgvS9JwsFD0
ZrtjsXz2W9+UNfilfKlPs2sA5wUTYfCamMihPz+9zco9QYLKpw3GB8G8R0qP05ND
g6EizKWaKs6bN+uXPk78xng42rbk5w==
=qu6U
-----END PGP SIGNATURE-----

--6P1qg1Q1mqaVIMqKj9E2MpGGXGeh0Huu3--

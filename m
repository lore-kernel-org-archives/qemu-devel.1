Received: from eggs.gnu.org ([2001:4830:134:3::10]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEzz-0002uv-Oc
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEzP-00039Q-OE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:19:07 -0500
References: <20171205145424.24598-1-kwolf@redhat.com>
	<20171205145424.24598-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7c90b68-3b82-0fbb-332a-d2831fb97a74@redhat.com>
Date: Tue, 5 Dec 2017 09:15:31 -0600
MIME-Version: 1.0
In-Reply-To: <20171205145424.24598-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dT300KxsfJIL9E2xb4kGw80clxglvX4GT"
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Make bdrv_drain_invoke()
 recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dT300KxsfJIL9E2xb4kGw80clxglvX4GT
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <a7c90b68-3b82-0fbb-332a-d2831fb97a74@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Make bdrv_drain_invoke()
 recursive
References: <20171205145424.24598-1-kwolf@redhat.com>
 <20171205145424.24598-2-kwolf@redhat.com>
In-Reply-To: <20171205145424.24598-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 08:54 AM, Kevin Wolf wrote:
> This change separates bdrv_drain_invoke(), which calls the BlockDriver
> drain callbacks, from bdrv_drain_recurse(). Instead, the function
> performs its own recursion now.
>=20
> One reason for this is that bdrv_drain_recurse() can be called multiple=

> times bdrv_drain_recurse(),

Doesn't read right.  Should the second instance be changed to 'by
itself', or is the correct meaning something else?

> but the callbacks may only be called once.
> The separation is necessary to fix this bug.
>=20
> The other reasons is that we intend to go to model where we call all

s/reasons/reason/

> driver callbacks first, and only then start polling. This is not fully
> achieved yet with this patch, as bdrv_drain_invoke() contains a
> BDRV_POLL_WHILE() loop for the block driver callbacks which can still
> call callbacks for any unrelated event. It's a step in this direction
> anyway.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dT300KxsfJIL9E2xb4kGw80clxglvX4GT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomuBMACgkQp6FrSiUn
Q2pBMQf/fxezluwW8b9xXIzsETla0OIXpCNEXcfia930WFmTyYSXvjiHqXl+5e9r
KFT11cFoHmnBsbojvDl5kjUVsiK4yEu4a6aDQcem8lMXumfAJyAOLXgpBY7Q9k5+
BGj1ONW5KRFtFLTWbICUBZFhKAOCF9mp+VfrmEgUxEpWo7xW0LyIWgGqqA76/aem
N3SYDDvKCga0g24tyK/dKeJeHpdQBNnxIMBOa4Cfbx9AGH6qBzOpQ6dpcD+NVt5l
JgBsGtgsoWM54jx7C2/vFvPpDasi5Cug3Gk9VeXBjpBw+qtXosu3TljGGnZl/6bE
9i4YNfVf3r4i1WFMkBuTQFP+wPk6QA==
=4bUT
-----END PGP SIGNATURE-----

--dT300KxsfJIL9E2xb4kGw80clxglvX4GT--

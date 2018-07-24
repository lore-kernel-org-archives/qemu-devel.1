Received: from eggs.gnu.org ([2001:4830:134:3::10]:52374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhvzJ-0000GF-68
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhvzA-0003PO-UA
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:21 -0400
Date: Tue, 24 Jul 2018 13:00:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180724120005.GD2988@stefanha-x1.localdomain>
References: <20180723222210.11077-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20180723222210.11077-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/7] fix persistent bitmaps
 migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 06:22:03PM -0400, John Snow wrote:
> This is an updated version of Vladimir's proposal for fixing the
> handling around migration and persistent dirty bitmaps.
>=20
> Patches 1, 4, 6, and 7 update the testing for this feature.
> Patch 2 touches up an error message.
> Patch 3 removes dead code.
> Patch 5 contains the real fix.
>=20
> v2:
>  - Add a new patch 4 as a prerequisite for what's now patch 5
>  - Rework the fix to be (hopefully) cleaner, see patch 5 notes
>  - Adjust error message in patch 2 (Eric)
>  - Adjust test logic slightly (patches 6, 7) to deal with changes
>    in patch 5.
>=20
> John Snow (2):
>   iotests: 169: actually test block migration
>   dirty-bitmaps: clean-up bitmaps loading and migration logic
>=20
> Vladimir Sementsov-Ogievskiy (5):
>   iotests: 169: drop deprecated 'autoload' parameter
>   block/qcow2: improve error message in qcow2_inactivate
>   block/qcow2: drop dirty_bitmaps_loaded state variable
>   iotests: improve 169
>   iotests: 169: add cases for source vm resuming
>=20
>  block.c                        |  4 ---
>  block/dirty-bitmap.c           | 20 ------------
>  block/qcow2-bitmap.c           | 16 +++++++++
>  block/qcow2.c                  | 26 ++++-----------
>  block/qcow2.h                  |  1 -
>  include/block/dirty-bitmap.h   |  2 +-
>  migration/block-dirty-bitmap.c | 11 ++++---
>  tests/qemu-iotests/169         | 74 ++++++++++++++++++++++++++++++++++++=
++++--
>  tests/qemu-iotests/169.out     |  4 +--
>  9 files changed, 103 insertions(+), 55 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbVxTFAAoJEJykq7OBq3PIq+QH/1zuGQHhPzLJ4H8nEEuVvY07
zESKDReGU1GuHFvw0StoodVGwOQYoz5h2XXRakS9D3anXMUVMDXjjHSMJuldhzLw
jGGf5R4dP31e8hfClQVeJ5akTEA07L6HMHCc4u0zzNMkLco15LCu38qHa/rnKn+5
VRmG2oJpL4pqKJhMQ72/ix77nbHF8wglLFKnlHXNzLiuhDCbW3hB7KBHgHpkMv05
4ZwiBHCQqN1XhMqFOWmJP3koHn7YQUfLGggMsqAQK3u/lIWUaM32vfQYrC36dIBj
p7T0DWNDeVwEApcUWg6fD3lYsULZ1z65dPV18Rf682jtTzwW5OYqX+8ixH0QJ18=
=0xX7
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--

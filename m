Received: from eggs.gnu.org ([2001:4830:134:3::10]:53049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPpB-0007Wj-Cj
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPpA-0000nb-Kc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:04:57 -0400
Date: Fri, 7 Apr 2017 10:04:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407090447.GD13602@stefanha-x1.localdomain>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20170405194741.18956-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/13] qobject: Drop useless QObject
 casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:47:33PM -0500, Eric Blake wrote:
> We have macros in place to make it less verbose to add a subtype
> of QObject to both QDict and QList. While we have made cleanups
> like this in the past (see commit fcfcd8ffc, for example), having
> it be automated by Coccinelle makes it easier to maintain.
>=20
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir . --in-place
> then I verified that no manual touchups were required.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c                   | 12 ++++--------
>  block/blkdebug.c          |  4 ++--
>  block/blkverify.c         |  7 +++----
>  block/file-posix.c        |  6 +++---
>  block/file-win32.c        |  4 ++--
>  block/quorum.c            | 16 ++++++----------
>  tests/check-qdict.c       | 20 ++++++++++----------
>  tests/test-qmp-commands.c | 24 ++++++++++++------------
>  8 files changed, 42 insertions(+), 51 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51YvAAoJEJykq7OBq3PI2n8IAKdaxoRX8r/gBn5yHBXNGh9S
LaRAelqWxW/ynAVtvOHXFAjyi0hBQOHi1JFgr9d9BTy7Kl6JOMm4bwcD90e9CWx9
tcI/Y7amcpLLO0VK3XsFuVonZrYVrDNHaO1Rt3CY0OiC6fOp+JNKAqdYSooZf2O8
LzFk3ffFkvBAs+SDvvOBoTBACEs73auv4UIHttZM6si8BZ72uo4lbkX+yWkhSMIY
JDbwMQOm4VGT9hSXTD3W8EQNYQ+u2+85ygIjKpvK0OXczolYKG/lE6e2ao10S0UG
AOUTb5CpQBoGOy0gSfmcH99lAYqWPCCiJUPk+9elLif4XE49MpdLwGj20B6u0R8=
=HKwL
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--

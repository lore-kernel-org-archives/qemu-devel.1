Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGH0-0002z7-4y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGGz-00048n-Dr
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:51:02 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-32-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0c7a40d1-525a-7e85-8fba-df257ad824a5@redhat.com>
Date: Fri, 24 Feb 2017 14:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-32-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8KKWCV8ks3Pam2iVCjooT3L8JJNEPbNoc"
Subject: Re: [Qemu-devel] [PATCH 31/54] blockjob: Add permissions to
 block_job_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8KKWCV8ks3Pam2iVCjooT3L8JJNEPbNoc
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <0c7a40d1-525a-7e85-8fba-df257ad824a5@redhat.com>
Subject: Re: [PATCH 31/54] blockjob: Add permissions to block_job_create()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-32-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-32-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This functions creates a BlockBackend internally, so the block jobs nee=
d
> to tell it what they want to do with the BB.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/backup.c               | 5 +++--
>  block/commit.c               | 5 +++--
>  block/mirror.c               | 5 +++--
>  block/stream.c               | 5 +++--
>  blockjob.c                   | 6 +++---
>  include/block/blockjob_int.h | 4 +++-
>  tests/test-blockjob-txn.c    | 6 +++---
>  tests/test-blockjob.c        | 5 +++--
>  8 files changed, 24 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--8KKWCV8ks3Pam2iVCjooT3L8JJNEPbNoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwOjoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdMgH/11+svHAG1lJ62JEW4U2F+DJYVRno3L/
PrNTF+hrQvGHaWqn/Oqw37jnkWH8HU7yKFxLCGi1Ffqj+ZR9Ao06Ie3Mod+18Zb8
eMVxlkHhi3/nw4KBf6V6ezCzzu6scVj+SoJBSC8P2vUOFnBtJIzcT5/s/wXb50vC
4l1bruncaGMEqrKfJa50Th5R5S7QdATtrp6qt70M32yIy3JDgtEnJ0iAHj5ezviB
as2t/5og0Avf0l+VTH6WwD3S5+uQ9n6vL+fHX40cyD7lUPCMRzmv1RZfSHNKfppJ
HSbvG7V0nq6nGv6cnQj268Ul4Gc3PsoeW4UKCeTw/fV4lGq7OQPtJ7I=
=in/2
-----END PGP SIGNATURE-----

--8KKWCV8ks3Pam2iVCjooT3L8JJNEPbNoc--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGO3-0002iO-IU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGO2-0006nS-W9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:58:19 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-34-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1824bd0a-c0d9-6626-45b1-3562af68af17@redhat.com>
Date: Fri, 24 Feb 2017 14:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-34-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hh0uP8JwBwdjcNQNcdkQHl2AX7V61swPC"
Subject: Re: [Qemu-devel] [PATCH 33/54] block: Include details on permission
 errors in message
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
--Hh0uP8JwBwdjcNQNcdkQHl2AX7V61swPC
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1824bd0a-c0d9-6626-45b1-3562af68af17@redhat.com>
Subject: Re: [PATCH 33/54] block: Include details on permission errors in
 message
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-34-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-34-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Instead of just telling that there was some conflict, we can be specifi=
c
> and tell which permissions were in conflict and which way the conflict
> is.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
--------
>  1 file changed, 56 insertions(+), 11 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Hh0uP8JwBwdjcNQNcdkQHl2AX7V61swPC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwO/ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A01kH/2AB5aGxfPUPcib934fQqHzuuyfkWLto
rqiUqZeOoUmokKukYVY7Oz7pF5DwrmudEURo10I2zugLoFUalnb6ilxFETne1PMq
KZRU5Zgq2TpWPjEXuw6hFm3n1KbTF1LX0dMnC9xQBSSeYyD7dFPi5046eGIdQ5hW
RdQVeucmKFpB0G/SUOrEUUEvnzlYpt0Sdjmq/Befx9pCC1JUI6ozn9GD5kqHzb4N
lu8W75PthvXT4nOC0xjoUqljCRZGuD2r5ZnQWuzFCwuqJxUodu+bbU9P4NyBM84n
Mnt2RVHokY/PqzNs7AcCzFLRvPuEl5gpBVKDvqMEbe3dhXLPhsnnRVk=
=C499
-----END PGP SIGNATURE-----

--Hh0uP8JwBwdjcNQNcdkQHl2AX7V61swPC--

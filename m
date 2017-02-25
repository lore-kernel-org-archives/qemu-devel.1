Received: from eggs.gnu.org ([2001:4830:134:3::10]:46350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdCS-0002Kz-7B
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 09:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chdCR-0005sS-8u
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 09:19:52 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-45-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <204a8675-3e45-1331-b3ec-c02d82f687ee@redhat.com>
Date: Sat, 25 Feb 2017 15:19:42 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-45-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IvSOdNSCv4VqGDERrVkt1Xn1fHpkinIxw"
Subject: Re: [Qemu-devel] [PATCH 44/54] mirror: Add filter-node-name to
 blockdev-mirror
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
--IvSOdNSCv4VqGDERrVkt1Xn1fHpkinIxw
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <204a8675-3e45-1331-b3ec-c02d82f687ee@redhat.com>
Subject: Re: [PATCH 44/54] mirror: Add filter-node-name to blockdev-mirror
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-45-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-45-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Management tools need to be able to know about every node in the graph
> and need a way to address them. This new option to blockdev-mirror
> allows the client to set a node-name for the automatically inserted
> filter driver, and at the same time serves as a witness that this
> version of qemu does automatically insert a filter driver.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c            | 14 ++++++++------
>  blockdev.c                | 12 +++++++++++-
>  include/block/block_int.h |  5 ++++-
>  qapi/block-core.json      |  8 +++++++-
>  4 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

I'm not so happy about "...serves as a witness..." because that doesn't
make it less of an incompatible change.

However, since (as you know) I had plans to introduce such a filter node
myself anyway, I'll gladly let you take all the git-blame if something
breaks.

(And it should be easy for me to add the mirror target as another child
to the filter node.)

Max


--IvSOdNSCv4VqGDERrVkt1Xn1fHpkinIxw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixkn4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZMwH+wesZO8HzFge9apCr1kaap3A4oYKH2Z1
7NGZRe103a/x0Wb1xA28ntIBO9xCgLdFNpBuQmVZ/38r5od8NcJXLU9EaQa0upFE
bzrv58X4nHwq25gamUVZYxkhYAbgZ5BldnEFm4lRJS58bzfTykQAi72GrYl01t8s
SBEJORVOwW1l++3NdVvqhanvboUbOB6SamCe55hwjbDw2nlkcyZtJQ0Eg4KxM/Rx
nDmU3ES52j5IvLBojIgQcsVt7uxqU2wHoPHZusRWIdBIRJcirz3eaKtSgMkst3eZ
hfJODebMPgvv/YEZBbJ9lnf15PdVo8jWFeLNKInnmVhqqSeOmxV7+FE=
=vXmk
-----END PGP SIGNATURE-----

--IvSOdNSCv4VqGDERrVkt1Xn1fHpkinIxw--

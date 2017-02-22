Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXYJ-0008IN-7d
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXYI-0000Pp-Dc
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:05:55 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-17-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2da98f23-7d49-361f-fe9b-49db5afeabcf@redhat.com>
Date: Wed, 22 Feb 2017 15:05:42 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-17-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lhCcSB9ItXCRaAvN9mck5c9jjeskEpPL3"
Subject: Re: [Qemu-devel] [PATCH 16/54] block: Default .bdrv_child_perm()
 for filter drivers
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
--lhCcSB9ItXCRaAvN9mck5c9jjeskEpPL3
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <2da98f23-7d49-361f-fe9b-49db5afeabcf@redhat.com>
Subject: Re: [PATCH 16/54] block: Default .bdrv_child_perm() for filter
 drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-17-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Most filters need permissions related to read and write for their
> children, but only if the node has a parent that wants to use the same
> operation on the filter. The same is true for resize.
>=20
> This adds a default implementation that simply forwards all necessary
> permissions to all children of the node and leaves the other permission=
s
> unchanged.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 24 ++++++++++++++++++++++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 32 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--lhCcSB9ItXCRaAvN9mck5c9jjeskEpPL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitmrYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AG/kH/ibkZ9JXi4wAfrzLZg+b2d9+IXjphI0K
RjiqJyE5hu80MnrnYkFtgYGu6QMZFuo8bSNvblxj8kOxJ/wcALnsgHZwp21mvtD7
Epol4v8u7zcJ8Wrd/JnxakDzeybbTxkBfh/nPFfmiw6sn4YlMQZisbZ7dpC/ogpv
oWo3f7taKbgU72rSJijIs4UqDEIcdroaE6tsG2l+k6v3JWHQdxsen4HZWDtF+KXy
msQeHlqls/qJZ/NPlnVaIAzZ0ty0N32owWN3vvkqOgIZA5d3QuBzC3CsDwVhpdv7
haP9QUHSIafo6sv2RGfwb+OuMH/6K5wd4lw5j5GU3mvB9D2Ym+maZbY=
=uqlg
-----END PGP SIGNATURE-----

--lhCcSB9ItXCRaAvN9mck5c9jjeskEpPL3--

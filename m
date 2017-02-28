Received: from eggs.gnu.org ([2001:4830:134:3::10]:49476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijGp-0006Mi-Lm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijGo-0007h3-Vl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:00:55 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-6-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <897c50a1-8afc-eae1-4edc-b8a24b638a31@redhat.com>
Date: Tue, 28 Feb 2017 16:00:45 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qXTMagVpAxRWPm3vNssKSJpKn3cpnIR2w"
Subject: Re: [Qemu-devel] [PATCH v3 05/44] block: Default .bdrv_child_perm()
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
--qXTMagVpAxRWPm3vNssKSJpKn3cpnIR2w
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <897c50a1-8afc-eae1-4edc-b8a24b638a31@redhat.com>
Subject: Re: [PATCH v3 05/44] block: Default .bdrv_child_perm() for filter
 drivers
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:53, Kevin Wolf wrote:
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
>  block.c                   | 23 +++++++++++++++++++++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qXTMagVpAxRWPm3vNssKSJpKn3cpnIR2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1kJ0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A1qwH/3OdXuRKMjl+zSTq6zAS4l4c8kYDNZZh
JcSXNjoVq0EclTrgHvC5GyePRbILZ3aZk1+FqkwxNboBfzX+mc++FOwNg08zMG4u
OTHf8bT8e6gTqnJcngjbQC3zxVixFLKI7GoR8G+ODitlQiWlZoWkbiUxgt0PczJU
AU1pzQMum73NfPvUkS9LJ+a0m1hozqIl931byoIY2Y+8yWgfp91o3Xnyo/+++ggO
uMJLk5OC7C1AbiYIZojT/Zkjd5cgCC12kV7Vn7VDyqf7qre2hYpcwfdpypEvMIBI
3XaVBUGrE4lANiXtWrkBsaGERp4Fg0U+oU74LHKHb0BpLEFRtC58Cmg=
=MoZC
-----END PGP SIGNATURE-----

--qXTMagVpAxRWPm3vNssKSJpKn3cpnIR2w--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjpac-0000hw-TG
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjpac-0006df-5y
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:57:55 -0500
References: <20170303133816.30303-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14e093c3-1d0c-8061-fe87-6edde3bf17e1@redhat.com>
Date: Fri, 3 Mar 2017 09:57:44 -0600
MIME-Version: 1.0
In-Reply-To: <20170303133816.30303-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SV6FEjk4UBsJR7v8cpEPQ3p04SCiEDr6N"
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] block: More robust error
 handling around perm check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SV6FEjk4UBsJR7v8cpEPQ3p04SCiEDr6N
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <14e093c3-1d0c-8061-fe87-6edde3bf17e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] block: More robust error
 handling around perm check
References: <20170303133816.30303-1-famz@redhat.com>
In-Reply-To: <20170303133816.30303-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 07:38 AM, Fam Zheng wrote:
> These are a couple cases added with the op blocker changes, where errp =
is
> available but we still use error_abort. Fix them for obvious reasons.
>=20
> Fam Zheng (2):
>   block: Don't use error_abort in blk_new_open
>   commit: Don't use error_abort in commit_start

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  block/block-backend.c |  6 +++++-
>  block/commit.c        | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SV6FEjk4UBsJR7v8cpEPQ3p04SCiEDr6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZJ4AAoJEKeha0olJ0NqgTkH/j0sSryT4yLtL9E6gx3oI209
E8QnjZ/sa+4rbeW8KLgG6WMXErdAF46svIbUJQwuvnKrzPV3JMHygAurWPkWGbrm
oBpKcu5h2Q6AJX26xdwyX1XwD9i7qqWf5emm1D26QMNetHIzkk37OreCDzyZYX0U
AEKGDPgJ3TTwAPmDN3V2JovVee56473x7bpbNceMoHFyp2PaYLnNXYyCXC19NE/t
aTP/278ftFTC0LCrnt3AIo5Ptr3/IIq9ANpc5pKbsUS6aP2fzgVPr1RMRacssimh
zeoTieTIxvuIvcTN5cih2CagrPHsovYMrNeMzALNKXXiribGMLzQ1bwCck/GKOY=
=0nBo
-----END PGP SIGNATURE-----

--SV6FEjk4UBsJR7v8cpEPQ3p04SCiEDr6N--

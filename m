Received: from eggs.gnu.org ([2001:4830:134:3::10]:58645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cl05H-0008Mj-Gd
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cl05G-0003ho-Fi
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 16:22:23 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-11-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <281e6fb5-0be8-3dec-1526-24bb204af7fa@redhat.com>
Date: Mon, 6 Mar 2017 15:22:15 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-11-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="81maN9o2mUndt9458rRWiqaQwrDo0m05V"
Subject: Re: [Qemu-devel] [PATCH 10/10] block: Fix error handling in
 bdrv_replace_in_backing_chain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--81maN9o2mUndt9458rRWiqaQwrDo0m05V
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <281e6fb5-0be8-3dec-1526-24bb204af7fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/10] block: Fix error handling in
 bdrv_replace_in_backing_chain()
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-11-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:22 AM, Kevin Wolf wrote:
> When adding an Error parameter, bdrv_replace_in_backing_chain() would
> become nothing more than a wrapper around change_parent_backing_link().=

> So make the latter public, renamed as bdrv_replace_node(), and remove
> bdrv_replace_in_backing_chain().
>=20
> Most of the callers just remove a node from the graph that they just
> inserted, so they can use &error_abort, but completion of a mirror job
> with 'replaces' set can actually fail.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 25 ++++++-------------------
>  block/mirror.c            | 15 +++++++++------
>  blockdev.c                |  2 +-
>  include/block/block.h     |  4 ++--
>  include/block/block_int.h |  4 ++--
>  5 files changed, 20 insertions(+), 30 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--81maN9o2mUndt9458rRWiqaQwrDo0m05V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvdMHAAoJEKeha0olJ0Nq0ykIAJUO1QKE5bqWcKQGWRAPUiGe
S2lMvNlAbWEeFMyjLJbBRKBpwuvLjoYYXsFHj439G45LY1+ouBQD0Uxjt2B0ZDrK
pAlCmSRa3gkgFctcogAvmYhu/EbuZIf5r9+LlEkUxvF2b2whKdwNm/EPSxh5xyhP
GNxpG15MHE2YygR9C4KS12dFo9MZsHsb9M9/mmvY2/jMmPEBdaIVpFk6g/toXqLS
ye8JuFnJV1BNrPsuvXqJDzTR72vElAByPzQi1ggZ1mtcq1cA4Yv+Sbuk92HtghiG
hVT4SSFLjZN9PG2MYB4WBMdcJ6ibCGqZUToKSjYlJcMFQGzl4yQcde4hASnaGiQ=
=6vAi
-----END PGP SIGNATURE-----

--81maN9o2mUndt9458rRWiqaQwrDo0m05V--

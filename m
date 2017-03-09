Received: from eggs.gnu.org ([2001:4830:134:3::10]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clyyU-0000i6-2z
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clyyS-0005o0-V9
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:23:26 -0500
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d8b28b7-fd17-64c9-e305-59092f1f5749@redhat.com>
Date: Thu, 9 Mar 2017 08:23:14 -0600
MIME-Version: 1.0
In-Reply-To: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1gXI1k6QdUtTWV3O0uG4o7U7hk52w6036"
Subject: Re: [Qemu-devel] [PATCH 0/6] block: More op blocker fixes
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
--1gXI1k6QdUtTWV3O0uG4o7U7hk52w6036
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <8d8b28b7-fd17-64c9-e305-59092f1f5749@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: More op blocker fixes
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2017 05:38 AM, Kevin Wolf wrote:
> Kevin Wolf (6):
>   block: Remove check_new_perm from bdrv_replace_child()
>   block: Request block status from *file for BDRV_BLOCK_RAW
>   commit: Implement bdrv_commit_top.bdrv_co_get_block_status
>   block: Refresh filename after changing backing file
>   mirror: Implement .bdrv_refresh_filename
>   commit: Implement .bdrv_refresh_filename
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

>  block.c        | 23 ++++++++++++++++-------
>  block/commit.c | 28 ++++++++++++++++++++++++----
>  block/io.c     |  2 +-
>  block/mirror.c |  9 +++++++++
>  4 files changed, 50 insertions(+), 12 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1gXI1k6QdUtTWV3O0uG4o7U7hk52w6036
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwWVTAAoJEKeha0olJ0NqQYcH/RCZsl7vVMSuOLs5PdLW6SLE
FgBTB+wl65CT5Mvl3YkYYY5q8fvbMfWP7R63001LoSw+QDF8tIi4VwCAG77XHMLY
dWXmMHhqYvzbJnAlQKkuohsA91T7zZNrS/4VVmllZ/ok1/WQiDdRZFCOPrcqps9v
w5NyK43HK4AW7oaSNRVDeg/f+0KPSbtclKZx2HBu/y5OueAb6ft3RF1yQe52KJjQ
zm1OmCGr8DGyvWrlkJd3QvIT52gWAeAegNzW1uDqqCSMAi3yV9K6aoCd2D/9HgQe
gGDDCqSaZlNtMrsAiexMQntFP1pNJSIL28y289D6wsDpV2YJvF1xr4Z9ov+1cX8=
=6WYX
-----END PGP SIGNATURE-----

--1gXI1k6QdUtTWV3O0uG4o7U7hk52w6036--

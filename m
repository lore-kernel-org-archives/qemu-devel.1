Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwOY-0001M7-RG
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 15:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwOX-0007cs-6U
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 15:31:46 -0500
References: <cover.1541595424.git.berto@igalia.com>
	<37b20c1e4ca5ef29ec7fbba2fa62dbf7acc292a5.1541595424.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d32282ce-d375-e3de-2fea-c06d63fc727a@redhat.com>
Date: Sun, 11 Nov 2018 21:31:35 +0100
MIME-Version: 1.0
In-Reply-To: <37b20c1e4ca5ef29ec7fbba2fa62dbf7acc292a5.1541595424.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5WTLL7BIpBWnmuDejzCmboag1CJkFHuwQ"
Subject: Re: [Qemu-devel] [PATCH v4 11/15] block: Clean up
 reopen_backing_file() in block/replication.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5WTLL7BIpBWnmuDejzCmboag1CJkFHuwQ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d32282ce-d375-e3de-2fea-c06d63fc727a@redhat.com>
Subject: Re: [PATCH v4 11/15] block: Clean up reopen_backing_file() in
 block/replication.c
References: <cover.1541595424.git.berto@igalia.com>
 <37b20c1e4ca5ef29ec7fbba2fa62dbf7acc292a5.1541595424.git.berto@igalia.com>
In-Reply-To: <37b20c1e4ca5ef29ec7fbba2fa62dbf7acc292a5.1541595424.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.11.18 13:59, Alberto Garcia wrote:
> This function is used to put the hidden and secondary disks in
> read-write mode before launching the backup job, and back in read-only
> mode afterwards.
>=20
> This patch does the following changes:
>=20
>   - Use an options QDict with the "read-only" option instead of
>     passing the changes as flags only.
>=20
>   - Simplify the code (it was unnecessarily complicated and verbose).
>=20
>   - Fix a bug due to which the secondary disk was not being put back
>     in read-only mode when writable=3Dfalse (because in this case
>     orig_secondary_flags always had the BDRV_O_RDWR flag set).
>=20
>   - Stop clearing the BDRV_O_INACTIVE flag.
>=20
> The flags parameter to bdrv_reopen_queue() becomes redundant and we'll
> be able to get rid of it in a subsequent patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/replication.c | 45 +++++++++++++++++++++------------------------=

>  1 file changed, 21 insertions(+), 24 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5WTLL7BIpBWnmuDejzCmboag1CJkFHuwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvokacACgkQ9AfbAGHV
z0CyXwgAwX6clVtxeaywFwUQ0s4JbPDYo1iLDmiZtCxfvbpigkurNFkB2RoyHOGe
AdVX960eGTwkfS8jmY5UKQWPFgoX9ukOlLVKa4+IwYjDLo7dQimKF/sSdTgfhaeK
sw3b13C9/j676E11j9wAfDnsBVST3RmEwaV7un8AzdcLwEM6x2kHH10aqx7DhL5d
GhPAMjQ3v14GtsD9noinJG5JQpHzSU1kNAMmnE7iGdnUfOKSQN5bBWpY9qzYB/MS
wfjnQO+xQZQAE6O0JSTPqED9RsMR0ARRPMPYVBTIM77zMqt1yNvt/tfcos6Q7Ztv
kT7qTvppEW5lUBy9tk9sjDzsN09vcw==
=qYJl
-----END PGP SIGNATURE-----

--5WTLL7BIpBWnmuDejzCmboag1CJkFHuwQ--

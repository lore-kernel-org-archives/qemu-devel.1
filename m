Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KJB-0005FC-GL
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KJA-00014T-Db
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:12:53 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0338b15e-741c-726d-5eaa-2864c601d05e@redhat.com>
Date: Thu, 4 May 2017 12:12:37 -0500
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MANRbugIaqsJUJXT1Wchnj6JFTiplf8Pc"
Subject: Re: [Qemu-devel] [PATCH 1/6] migration: Unify block node activation
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MANRbugIaqsJUJXT1Wchnj6JFTiplf8Pc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <0338b15e-741c-726d-5eaa-2864c601d05e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] migration: Unify block node activation
 error handling
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
 <1493916761-32319-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 11:52 AM, Kevin Wolf wrote:
> Migration code activates all block driver nodes on the destination when=

> the migration completes. It does so by calling
> bdrv_invalidate_cache_all() and blk_resume_after_migration(). There is
> one code path for precopy and one for postcopy migration, resulting in
> four function calls, which used to have three different failure modes.
>=20
> This patch unifies the behaviour so that failure to activate all block
> nodes is non-fatal, but the error message is logged and the VM isn't
> automatically started. 'cont' will retry activating the block nodes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/migration.c | 16 +++++-----------
>  migration/savevm.c    | 12 +++++-------
>  qmp.c                 | 18 +++++++++---------
>  3 files changed, 19 insertions(+), 27 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MANRbugIaqsJUJXT1Wchnj6JFTiplf8Pc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC2EFAAoJEKeha0olJ0NqC+IIAIIROdA0cYLse4l998CXSoGG
M6Nc9YW1OPr6JfU6A+gpyzO0si6LkB02yZIUMloD5fchA1f9zxaybR/gNkogz0aE
nqC44ptzOAZaUg2lL+9zQVZyxnMRSGhgv7iPyNUzBWP7cd1Ga0SuWlwcAsgDVzX9
HJR9Rv4WhX0xcUKgJvXivYlKhq/ZC9BrbuXDZXQC8QvHMsh3SttkmIn65wREKLuO
Xeh69hoNUOfINFK8buExkkeNHExSTQvD9ikHKv0YWJuXDIESknegiUu4e1LWnwWB
yo2Ax6Xtul3SMI1UmPKiQ+MSyOp3Tv/6i7kg/X8+stOzyKZEsBlwFni0lO5STX4=
=AVrO
-----END PGP SIGNATURE-----

--MANRbugIaqsJUJXT1Wchnj6JFTiplf8Pc--

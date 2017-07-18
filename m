Received: from eggs.gnu.org ([2001:4830:134:3::10]:45338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWQD-00087B-AW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXWQC-0000zC-JR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:36:33 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc1bf7d1-2d26-74cb-395a-5aacfa5df018@redhat.com>
Date: Tue, 18 Jul 2017 12:36:24 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2nRJiA6GVE4spiRIJxeTuDKJw49pAN7K9"
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/10] migration: Clean up around
 tls_creds, tls_hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2nRJiA6GVE4spiRIJxeTuDKJw49pAN7K9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <bc1bf7d1-2d26-74cb-395a-5aacfa5df018@redhat.com>
Subject: Re: [PATCH for-2.10 07/10] migration: Clean up around tls_creds,
 tls_hostname
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> Optional MigrationParameters members tls_creds and tls_hostname can't
> actually be absent outside qmp_migrate_set_parameters() since commit
> 4af245d (v2.9.0).
>=20
> Note that commit 4af245d reverted the part of commit de63ab6 (v2.8.0)
> that made tls_creds and tls_hostname absent instead of "" in the value
> of query-migrate-parameters, even though commit de63ab6 called that a
> mistake.  What a mess.
>=20
> Drop the redundant tests for presence, and update documentation.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c                 |  6 ++++--
>  migration/migration.c |  4 ++--
>  qapi-schema.json      | 11 +++++------
>  3 files changed, 11 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2nRJiA6GVE4spiRIJxeTuDKJw49pAN7K9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluRxgACgkQp6FrSiUn
Q2oSsggArtzyq/hM1/KPUiw0OgqeY/y7tHTKu8d0K4nOv9EusDG4QcsY64+ibntd
tSheJrCXXy0ZP5eNni73FNwx9PebDERvexWdL6g1s9zdjlYEKhT39u6Ex7vWxPk2
PwxJykEHuP8rMK6y5Pj8vJy8lUIzeHN8dGDLOwAeNX+7BIRJRrB8vc19mmYxCNL8
6H+aLp+Cxk6ROdR336wjLlH3JvJWGEWFlrCZKnV8CYnd+S4lpaRRVKTUUoI6ODps
OBGPPm+P9jh/5pVkgRdthMGbMmm4esAUlscTxR/oNBd5oJuO6TiyfjY3u9c0k3o1
2rxZz9d/xcqQ8E04lLDJPcjIgKg7qQ==
=JVUr
-----END PGP SIGNATURE-----

--2nRJiA6GVE4spiRIJxeTuDKJw49pAN7K9--

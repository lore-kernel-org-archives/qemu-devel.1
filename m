Received: from eggs.gnu.org ([2001:4830:134:3::10]:59197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxam5-0007JZ-Vo
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxam5-00073k-65
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:58:38 -0400
References: <20170410075451.21329-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9757e7ea-a538-57f0-77db-3d20e68c8566@redhat.com>
Date: Mon, 10 Apr 2017 09:58:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170410075451.21329-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LlghtMRb495Wg5fWW9UsPApomrfSaxtDu"
Subject: Re: [Qemu-devel] [PATCH for-2.9] iscsi: Fix iscsi_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LlghtMRb495Wg5fWW9UsPApomrfSaxtDu
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9757e7ea-a538-57f0-77db-3d20e68c8566@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] iscsi: Fix iscsi_create
References: <20170410075451.21329-1-famz@redhat.com>
In-Reply-To: <20170410075451.21329-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 02:54 AM, Fam Zheng wrote:
> Since d5895fcb (iscsi: Split URL into individual options), creating
> qcow2 image on an iscsi LUN fails:
>=20
>     qemu-img create -f qcow2 iscsi://$SERVER/$IQN/0 1G
>     qemu-img: iscsi://$SERVER/$IQN/0: Could not create image: Invalid
>         argument
>=20
> The problem is iscsi_open now expects that transport_name, portal and
> target are already parsed into structured options by
> iscsi_parse_filename, but it is not called in iscsi_create.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/iscsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LlghtMRb495Wg5fWW9UsPApomrfSaxtDu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY652FAAoJEKeha0olJ0NqFYEH/j+hsTNorhsNTd7yq01bjnGv
gFpl7twxijqzvrErurRENJFqFE8UUZsu1DLOBsnn3cQLoLdC2ikPmr4k0Xgu0OId
tDfOPuDn2s3oUfiF3222scGrbOGE3MzAzAurmJJWSW9IlRj/JPrUQD/gUqmp/hTw
pXhx9Z2kmv/TC0rda6q04t9GLZQJcCm0X6PGPL/fMKd9bIEctuFW1o6YmyZ5tiNY
yH8QBKt/xr+MeOEnXnNwwxGLZ64zx1uwxiYSfP7VbT+OEWLz34uwFp30Wz0szIdl
UKIIuWUDB3lr58Qui+KG3Rhi+Vx66G40lNVkvU5DI0Tt1Cx1/C1X2ScH6Eakmg4=
=890v
-----END PGP SIGNATURE-----

--LlghtMRb495Wg5fWW9UsPApomrfSaxtDu--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTEBB-0006y5-OF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTEBB-0002s9-20
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:47:01 -0500
References: <20170113205237.30386-1-mreitz@redhat.com>
	<20170113205237.30386-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebc78c0c-35cb-9a33-6ff3-02fca6a3502a@redhat.com>
Date: Mon, 16 Jan 2017 14:46:54 -0600
MIME-Version: 1.0
In-Reply-To: <20170113205237.30386-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hwR3nmxtN3r8QSswG5LpnNJrJrk6DIp5B"
Subject: Re: [Qemu-devel] [PATCH v6 3/9] block: Avoid
 BlockDriverState.filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hwR3nmxtN3r8QSswG5LpnNJrJrk6DIp5B
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ebc78c0c-35cb-9a33-6ff3-02fca6a3502a@redhat.com>
Subject: Re: [PATCH v6 3/9] block: Avoid BlockDriverState.filename
References: <20170113205237.30386-1-mreitz@redhat.com>
 <20170113205237.30386-4-mreitz@redhat.com>
In-Reply-To: <20170113205237.30386-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 02:52 PM, Max Reitz wrote:
> In places which directly pass a filename to the OS, we should not use
> the filename field at all but exact_filename instead (although the
> former currently equals the latter if that is set).
>=20
> In raw_open_common(), we do not need to access BDS.filename because we
> already have a local variable pointing to the filename.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c            | 5 +++--
>  block/file-posix.c | 6 +++---
>  block/file-win32.c | 4 ++--
>  block/gluster.c    | 3 ++-
>  4 files changed, 10 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hwR3nmxtN3r8QSswG5LpnNJrJrk6DIp5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfTE+AAoJEKeha0olJ0NqHNQH/jwSXpgPRc4CgcOdzVz0VVT+
3bsxRbXGyumRQpUJEhVZ5ahicVqEnrq0ZGKI+gVcE2T+DcqvrvBdLtl75Jw2LZL5
0X5wkc7ErUk9xrIqSXt7uGl1b4PH4sXZ7gPo5NwDu84rXkQ7aWnfcfiauPd55YOd
/mY2aohtbFy5qileTHbcUQVEu03CTrYhocjsoAy98fml097t3QQ/Vnd8lAkY+JWD
ojPZCmm9/I97q+QQgt0vP60Iaj1S7RGApaYV81zT/eXu2VxGnx2ErG1zyimkwYLu
UHU2XWLAl5jI6dGM5MM80T0Hyhusi3mwzTMKrOsvPbyDHqzBLWOfrlkPH9O7Jvk=
=RyHI
-----END PGP SIGNATURE-----

--hwR3nmxtN3r8QSswG5LpnNJrJrk6DIp5B--

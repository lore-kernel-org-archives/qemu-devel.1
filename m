Received: from eggs.gnu.org ([2001:4830:134:3::10]:42364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDBrP-00075r-8a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDBrO-0006Au-8u
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:36:35 -0400
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <feb15924-6939-a0ad-cb89-033cb0aa7641@redhat.com>
Date: Tue, 23 May 2017 10:36:20 -0500
MIME-Version: 1.0
In-Reply-To: <1495548064-10926-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="csN93PLnkdpDOfb5I3wirW5Gv0nvlu9WW"
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: Inactivate images after
 .save_live_complete_precopy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--csN93PLnkdpDOfb5I3wirW5Gv0nvlu9WW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com
Message-ID: <feb15924-6939-a0ad-cb89-033cb0aa7641@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: Inactivate images after
 .save_live_complete_precopy()
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
 <1495548064-10926-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495548064-10926-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:01 AM, Kevin Wolf wrote:
> Block migration may still access the image during its
> .save_live_complete_precopy() implementation, so we should only
> inactivate the image afterwards.
>=20
> Another reason for the change is that inactivating an image fails when
> there is still a non-device BlockBackend using it, which includes the
> BBs used by block migration. We want to give block migration a chance t=
o
> release the BBs before trying to inactivate the image (this will be don=
e
> in another patch).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/migration.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--csN93PLnkdpDOfb5I3wirW5Gv0nvlu9WW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJFb1AAoJEKeha0olJ0NqRf4H/0xU6pswSGVbv6ZelRiAACAw
piQXL95gA4k9+gIokp+zD7HaLcShKlR1bqNpgKIodZMbUn2jXb9qFMFxqLUGlEUh
LwWxIbdiMhacCsJv+aYlSiKBefJomlu+hDgeGEgDwE+0Q802jpf//RAht/sk3P3X
FobTn4rzD3af0sS9M6PwkdxTSb6FcG64cDLVuOtd24TbdbEVzh0x41E5y50ISd6y
ShwQFnB0S5ylH9kXTDaoQDQ5Tebq7Sa9j5EPRGOXBU8OgMBb1nHTKTFNmz8pUvg4
SllEMDR4RCBcQgpieNT1cxThH+NL8DxzSQCHBGwEiqI6TQ57X8Jv2v0tL99nLSs=
=jIgE
-----END PGP SIGNATURE-----

--csN93PLnkdpDOfb5I3wirW5Gv0nvlu9WW--

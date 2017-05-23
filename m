Received: from eggs.gnu.org ([2001:4830:134:3::10]:40375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDBle-0005Ue-Qb
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDBld-0003xt-U4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:30:38 -0400
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30b8251f-6e0f-152c-6899-9c388364e2ea@redhat.com>
Date: Tue, 23 May 2017 10:30:26 -0500
MIME-Version: 1.0
In-Reply-To: <1495548064-10926-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j82SnKbxJ6J8lAlPF00iGrdrd66w6kFTW"
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Fix anonymous BBs in
 blk_root_inactivate()
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
--j82SnKbxJ6J8lAlPF00iGrdrd66w6kFTW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com
Message-ID: <30b8251f-6e0f-152c-6899-9c388364e2ea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Fix anonymous BBs in
 blk_root_inactivate()
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
 <1495548064-10926-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495548064-10926-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:01 AM, Kevin Wolf wrote:
> blk->name isn't an array, but a pointer that can be NULL. Checking for
> an anonymous BB must involve a NULL check first, otherwise we get
> crashes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j82SnKbxJ6J8lAlPF00iGrdrd66w6kFTW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJFWSAAoJEKeha0olJ0NqUeoH/RJOFaZUjfCfHsy6lPCIyqUE
tFFic4Mbe6PYSlVo4VCsWcbHupey/Besdl22NBugqI9F5JVjgT1BMqyLBGz/IJ5w
34NUbKaqU+kaSFBXuShEVHy/SyocilOP7Q2AvEdom/A1msZ4LUPuysJZ+ANtIaOI
uivZbxA8qZXFFs2NXjYjWbFDN58kInFlvUs2AfMW5bl8wVywxHxEx3/AleyiYPde
Kj0yPFyDHPlqanzrHt8tseD5lda7GTSMXIceKbwo5fxM7ln4Ev+n1U8H1Zw8Pg0t
MxiegsGd0rJCl9ZAvFKKsIqH2mXPCX3QQ9ZCo3ZCYa+HUcd20YRqaelTlf/+O9Q=
=V2eM
-----END PGP SIGNATURE-----

--j82SnKbxJ6J8lAlPF00iGrdrd66w6kFTW--

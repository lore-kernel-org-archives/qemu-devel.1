Received: from eggs.gnu.org ([2001:4830:134:3::10]:48791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFS3-0006xb-9S
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFRz-0008Dm-C1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:38:47 -0400
References: <20170526101337.4096-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86c34b52-15df-8c57-ae43-308c17f321aa@redhat.com>
Date: Fri, 26 May 2017 08:38:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170526101337.4096-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ALv5RmJNQAKbv7pxmB6XODeFtmmRxN5Fu"
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: remove useless allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ALv5RmJNQAKbv7pxmB6XODeFtmmRxN5Fu
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <86c34b52-15df-8c57-ae43-308c17f321aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: remove useless allocation
References: <20170526101337.4096-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170526101337.4096-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 05:13 AM, Marc-Andr=C3=A9 Lureau wrote:
> There is no need to duplicate a fixed string.
>=20
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/commands-posix.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ALv5RmJNQAKbv7pxmB6XODeFtmmRxN5Fu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKC/eAAoJEKeha0olJ0Nq6GAH/3izaHwACPicTOgbZJPUQvO1
784vySPqIUZ7RpV6RCs1IY1gIIofi16mOfTlOJAmKkMHifcdTeMfX7zgJ+O4kKUZ
E5/HCZVBKrzhLplK2SCg7D4HHoxpB+2QWHrcUlnkQLKbkCJ5Uhf8ypxH3tzPD91T
2xeBVAhY7/nmstzaH10UlEiSyWLAIVYZrrugaROCu1yRZWDThZCMQ6bHu4kaUp0L
FGsLwYp6MT+8TSCEhZlM5ctVuU/FaropW6GLaiLwaJEUFXJPLnU5msyOeMpuUZB1
tRaPqfic905sjtJ233+g0RVSZ21V8OFw4R7gngoGJ65P/D8zBzfKOX8REU00Y0A=
=/OhK
-----END PGP SIGNATURE-----

--ALv5RmJNQAKbv7pxmB6XODeFtmmRxN5Fu--

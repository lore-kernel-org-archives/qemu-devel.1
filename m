Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1canse-0003id-Il
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cansc-00060Q-Ao
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:19:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cansc-00060B-37
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:19:10 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05AC28046D
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 18:19:10 +0000 (UTC)
References: <20170206132835.9440-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8014ca2-ebf5-0124-353d-3b37a206f677@redhat.com>
Date: Mon, 6 Feb 2017 12:19:07 -0600
MIME-Version: 1.0
In-Reply-To: <20170206132835.9440-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vnROu6P2U7MF86hHeN7NIpxVI67U2xrmP"
Subject: Re: [Qemu-devel] [PATCH] qemu-option: reject empty number value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vnROu6P2U7MF86hHeN7NIpxVI67U2xrmP
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <d8014ca2-ebf5-0124-353d-3b37a206f677@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-option: reject empty number value
References: <20170206132835.9440-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170206132835.9440-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2017 07:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> When no number is provided, return an invalid number error.
> (note: this may break some users relying on default 0 value)

Anyone that writes 'size=3D' instead of 'size=3D0' deserves the breakage.=


>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1417864
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-option.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vnROu6P2U7MF86hHeN7NIpxVI67U2xrmP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmL4bAAoJEKeha0olJ0NqB+0H/19/Pi+niSnKg284HtwcbPX/
n6EWYmiJvfhibQfOsdoUTEFOGTGiCs1v7yiv3i41/bpoNPErwIsVzdtvmy2sUMcv
wS0dSr4ROiWeYfe7ZJPEObhxPrOd+mFlEkYJ6e7Jlwe7MIoQHWEgscJeFUIeN/6Y
JQVzO5DxgASdZyoh1EA+qJB357OnRvWqejp0yIjkH5PsAbXq/BWCdsDptBKzPD7u
vWwioubEu2LfKo8DQqB8DBMC0vz2P0q+IYHVwtGPuhVBCIsP8Shu4nKabWUtyTC7
tXQj3WAbV9raSmUH/BUZu3FltA0skf1z1zZy8vgQe2JDcN2Lc88V+brDd0Jf4gA=
=/TQA
-----END PGP SIGNATURE-----

--vnROu6P2U7MF86hHeN7NIpxVI67U2xrmP--

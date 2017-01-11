Received: from eggs.gnu.org ([2001:4830:134:3::10]:41837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRQQZ-0000B2-9k
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRQQV-0003uy-Bs
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:27:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRQQV-0003uo-5E
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:27:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BCA3552CE
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 21:27:23 +0000 (UTC)
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
	<20170110174810.17748-21-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2148de4b-9a79-7f6e-13c4-936d24fff04f@redhat.com>
Date: Wed, 11 Jan 2017 15:27:20 -0600
MIME-Version: 1.0
In-Reply-To: <20170110174810.17748-21-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3GFLqCjNnjeL2OCLBgau6eraexxPHjIcj"
Subject: Re: [Qemu-devel] [PATCH v2 20/20] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3GFLqCjNnjeL2OCLBgau6eraexxPHjIcj
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <2148de4b-9a79-7f6e-13c4-936d24fff04f@redhat.com>
Subject: Re: [PATCH v2 20/20] chardev: qom-ify
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
 <20170110174810.17748-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 11:48 AM, Marc-Andr=C3=A9 Lureau wrote:
> Turn Chardev into Object.
>=20
> qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
> will call qemu_char_open() to open/intialize the chardev with the
> ChardevCommon *backend settings.
>=20

> -ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend=
,
> -                               Error **errp)
> +static const ChardevClass *char_get_class(const char *driver, Error **=
errp)
> +{

Your followup "[PATCH 16/40] char: get rid of CharDriver" hoists this up
earlier in the file. Can you minimize churn by just declaring it earlier
to begin with?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3GFLqCjNnjeL2OCLBgau6eraexxPHjIcj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdqM4AAoJEKeha0olJ0Nq8wkH/0y2GdJ9fO86mYP8mwkbDCf/
1zaqldE3KZtw4XsJbobj7I+ICUK0ONV+C3p89eG9pDyo6c2/QOHWIsqaKPPof9wr
A71+f7QIWmcBDc+A5KzpYS6/G4Nxpu3KPfzUIiz1zAmzq+MzGe04BZHp7lE7LaFR
rKUJPpt3PTx9ihpozx4SwHn+CvkYa9wcRUZe2u0Y+87O3SbbJrJhGGxhcoFDVXh0
4/HjG7QAda9JGzUVxyRS9rg+ywMNDH2D3qLojtEAHpXnhcstAknEfXbigz2+3h0z
w9S2c3Z8teIKdRtKaJA8DC/iP7pJSRvrU2Uzh3zmcE8Q0YmsOsGwjRM6A1mZUG8=
=BgaJ
-----END PGP SIGNATURE-----

--3GFLqCjNnjeL2OCLBgau6eraexxPHjIcj--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgk8-00072S-AH
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgk5-0004Bw-8P
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPgk5-0004Bl-02
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 23:00:41 -0400
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ce1f317-6502-d4e0-e67a-d4795e87aed2@redhat.com>
Date: Mon, 26 Jun 2017 22:00:37 -0500
MIME-Version: 1.0
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gu6IR69X6SPMhXdIr302HEeopJBur0jkd"
Subject: Re: [Qemu-devel] [RFC PATCH v9 00/26] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gu6IR69X6SPMhXdIr302HEeopJBur0jkd
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <6ce1f317-6502-d4e0-e67a-d4795e87aed2@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v9 00/26] translate: [tcg] Generic
 translation framework
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/25/2017 03:43 AM, Llu=C3=ADs Vilanova wrote:
> This series proposes a generic (target-agnostic) instruction translatio=
n
> framework.
>=20
> It basically provides a generic main loop for instruction disassembly, =
which
> calls target-specific functions when necessary. This generalization mak=
es
> inserting new code in the main loop easier, and helps in keeping all ta=
rgets in
> synch as to the contents of it.
>=20
> This series also paves the way towards adding events to trace guest cod=
e
> execution (BBLs and instructions).
>=20
> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fit=
s in the
> current organization, but will port the rest when this series gets merg=
ed.
>=20
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> ---
>=20
> Changes in v9
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Further increase inter-mail sleep time during sending.
>=20
>=20
> Changes in v8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Increase inter-mail sleep time during sending (list keeps refusing so=
me emails
>   due to an excessive send rate).

It's more likely that your rejection message was from your SMTP
connection than from the list (I've had to deal with my ISP's SMTP
server prohibiting me from sending more than 10 patches in a minute;
while using my company's SMTP server did not have that rate-limiting
restriction).

But yes, it would be neat if 'git send-email' had a knob to easily tweak
things to avoid flooding beyond a picky SMTP server's rate limits.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gu6IR69X6SPMhXdIr302HEeopJBur0jkd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUcpVAAoJEKeha0olJ0Nq8doH/A0yFiQLTtvcbCnOPltXGenN
sYqYV9L7U6PFOx6Ufbp8/l1IGzV7lKvf8hfZdUmLXGMyz2JAbra71Tzf77wVVi8L
5DsvviTetRSardSgsjD9mUl92pwOs50AEU9xWKye1b5yWwF8yaRa38QbA8yEs3Bg
QGXx6iFx28Id2wvetPrEbqBr8esaSAs5IpSDuBI74W8lBQuMTtnX965r9i2y1qGo
U2a80P1Qo/0+2uaXWYP7wlzzEzxJ1MirE7M0EirJ6Cg1TziAYAerzm05KfKBNTtf
QTLdYzRqFZY32bBd6bDK4XiadFJN+Btogc1rLGA3aHjJVAlRWmqO1UUcWQlzuEo=
=47Ls
-----END PGP SIGNATURE-----

--gu6IR69X6SPMhXdIr302HEeopJBur0jkd--

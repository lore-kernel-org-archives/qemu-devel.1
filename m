Received: from eggs.gnu.org ([2001:4830:134:3::10]:33690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBLYJ-0001D6-A9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBLYG-0008PR-64
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBLYG-0008PG-0X
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:44 -0400
References: <152460739715.2265.8996313982715372139@71c20359a636>
	<9ffb6634-3480-4ad8-1c9b-e1caa8425628@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dfd1330-64b9-fb7d-78f9-7c058731f022@redhat.com>
Date: Wed, 25 Apr 2018 09:37:23 -0500
MIME-Version: 1.0
In-Reply-To: <9ffb6634-3480-4ad8-1c9b-e1caa8425628@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qTGx0N98B7IG5aTlcRNLzW0M7Q35G4MJM"
Subject: Re: [Qemu-devel] [PATCH 0/6] qapi: introduce the SysEmuTarget
 enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, crosthwaite.peter@gmail.com, famz@redhat.com, sagark@eecs.berkeley.edu, kchamart@redhat.com, kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu, armbru@redhat.com, mjc@sifive.com, palmer@sifive.com, kraxel@redhat.com, dgibson@redhat.com, pbonzini@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qTGx0N98B7IG5aTlcRNLzW0M7Q35G4MJM
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, crosthwaite.peter@gmail.com, famz@redhat.com,
 sagark@eecs.berkeley.edu, kchamart@redhat.com,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 armbru@redhat.com, mjc@sifive.com, palmer@sifive.com, kraxel@redhat.com,
 dgibson@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Message-ID: <9dfd1330-64b9-fb7d-78f9-7c058731f022@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] qapi: introduce the SysEmuTarget
 enumeration
References: <152460739715.2265.8996313982715372139@71c20359a636>
 <9ffb6634-3480-4ad8-1c9b-e1caa8425628@redhat.com>
In-Reply-To: <9ffb6634-3480-4ad8-1c9b-e1caa8425628@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:26 AM, Laszlo Ersek wrote:
> On 04/25/18 00:03, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed docker-mingw@fedora build test. Please find the tes=
ting commands and
>> their output below. If you have Docker installed, you can probably rep=
roduce it
>> locally.
>=20
> [snip]
>=20
>> qapi/qapi-types-misc.h:654:20: error: expected identifier or '(' befor=
e numeric constant
>>          CpuInfoX86 i386;
>>                     ^

> Wow, is "i386" a macro on mingw, one that expands to a number? That is
> incredibly st...range.
>=20
> I do need this enum constant to be "i386" in the QAPI schema, because
> that's what TARGET_NAME will map to.
>=20
> Can I let the generator use the "q_" prefix here somehow?
>=20

> Alright, I'll add "i386" to "polluted_words" in "scripts/qapi/common.py=
".
>=20
> Sigh, what else is there already... I see Eric's commit 86ae191163d4 :(=


Yep, that's the right fix for working around header pollution.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qTGx0N98B7IG5aTlcRNLzW0M7Q35G4MJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgkqMACgkQp6FrSiUn
Q2r+Mgf+KjGjxBIs9mO9Dqi5zJV+NZtlaxuszF1uM3fiqVUd0Op5E10vb03sbwYe
pwSeA7qhMjpfjgaO1quewZVe/oiMBJMV81aU6VJW2ItCE2xKwNy9uiTC4scUa6H6
r1FOH/qHwc6PUU9OLSl4kWRkDmeZ9ocDrvxS6VWFyRpXdvbX9I518N0pEHlKZbvv
17gfEwfUF3PXAt6ut5yn4se009CkmF+Og1i7XHuGnDLL7SeFppg99NFFogp8CeAh
d1gBnqr5d4ezZ+RVWAX2OKf6fpxlnJ/7n97GDLmZbtd2X0dCJTijGbBAfzWvxPQU
rNLVb9ou5FVRj/fND/eYNpGn6/dYsQ==
=vhpN
-----END PGP SIGNATURE-----

--qTGx0N98B7IG5aTlcRNLzW0M7Q35G4MJM--

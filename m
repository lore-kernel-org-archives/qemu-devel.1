Received: from eggs.gnu.org ([2001:4830:134:3::10]:33829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeiq3-0000Gj-Py
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeiq2-00057o-RS
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:49:15 -0500
References: <20180124061728.GA99621@localhost>
	<d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
	<20180125045926.GA4720@localhost>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
Date: Thu, 25 Jan 2018 08:48:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180125045926.GA4720@localhost>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yuO4L3qbcPrXeCpOQ7DF0c8LDeiLNdhs4"
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM
 has heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliang.opensource@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yuO4L3qbcPrXeCpOQ7DF0c8LDeiLNdhs4
From: Eric Blake <eblake@redhat.com>
To: Liang Li <liliang.opensource@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huaitong Han <hanhuaitong@didichuxing.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <b54574f8-ff1a-24bd-f86f-d908447c3459@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM has
 heavy BLK IO
References: <20180124061728.GA99621@localhost>
 <d49dfbf5-b6e4-43d2-c24d-5c493aa5bfe5@redhat.com>
 <20180125045926.GA4720@localhost>
In-Reply-To: <20180125045926.GA4720@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2018 10:59 PM, Liang Li wrote:
>>
>> There's ongoing work on adding async mirroring; this may be a better
>> solution to the issue you are seeing.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg05419.html
>>
> Hi Eric,
>=20
> Thinks for your information, I didn't know libvirt depends on 'block-jo=
b-cancel'
> for some of the block related operations.
>=20
> It's seems a new interface should provided by qemu for use case that ju=
st
> for aborting block job and don't care abort the mirror data integrality=
, and
> libvirt can make use of this new interface.
>=20
> Do you think this is the right direction?

I don't know if it is better to wait for the new async mirroring code to
land, or to just propose a new QMP command that can force-quit an
ongoing mirror in the READY state, but you are correct that the only
safe way to do it is by adding a new command (or a new optional flag to
the existing block-job-cancel command).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--yuO4L3qbcPrXeCpOQ7DF0c8LDeiLNdhs4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpp7jYACgkQp6FrSiUn
Q2r0rwgAj2pbXWLWNHj1M3tYVNqSvWI52Y44ZWKxMqHDtlsqVj3ELwsR2O9muVT4
HvWZsOB56xiDA+sveZhvoBFs3xWueL6itWHUzAkW9l6vFlvxIqb8JwcZFW+0pykB
C2xesX3OW7oXsVbkqRaOgvX5XDS17HIhCacYsYW8ljzBV417ZTVPKma1wDLaFrFS
sMLPg/iDZzQYKNbe8Z43lFzS4cSfhuPTM9ZD8Qe4fHugBs/D0OoxI3McmSRPUcfs
ErPWgfVcTEdmGTYx/RKJQr9fRkHze9GK7eGfjpgye1amslXUeyymUbjBETTXLe1X
RNxBQVqtBoJFI89Zcvl+pZcJ15bAFw==
=HKEh
-----END PGP SIGNATURE-----

--yuO4L3qbcPrXeCpOQ7DF0c8LDeiLNdhs4--

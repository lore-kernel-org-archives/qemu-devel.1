Received: from eggs.gnu.org ([209.51.188.92]:32985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopa3-000571-Qt
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopa3-000464-6b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:07:03 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-6-mreitz@redhat.com>
	<4c417f84-3c3e-1fa4-7d69-987e5f6a17fe@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8a72a636-9998-ea66-e6a5-9b32e89dd739@redhat.com>
Date: Wed, 30 Jan 2019 14:06:50 +0100
MIME-Version: 1.0
In-Reply-To: <4c417f84-3c3e-1fa4-7d69-987e5f6a17fe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RdWf7Tk6daFRWQipSkX6GeB5OdaUgJ20h"
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Fix 237 for Python 2.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RdWf7Tk6daFRWQipSkX6GeB5OdaUgJ20h
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8a72a636-9998-ea66-e6a5-9b32e89dd739@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Fix 237 for Python 2.x
References: <20190123144610.8842-1-mreitz@redhat.com>
 <20190123144610.8842-6-mreitz@redhat.com>
 <4c417f84-3c3e-1fa4-7d69-987e5f6a17fe@redhat.com>
In-Reply-To: <4c417f84-3c3e-1fa4-7d69-987e5f6a17fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.19 22:21, John Snow wrote:
>=20
> On 1/23/19 9:46 AM, Max Reitz wrote:
>> It is not quite clear whether we want to support Python 2.x for any
>> prolonged time, but this may as well be fixed along with the other
>> issues some iotests have right now.
>>
>=20
> I'd have shuffled this above patch 01 (or immediately below) with a not=
e
> in either commit saying that the test is still broken without both patc=
hes.

It's only broken for Python 2.x. :-)

I don't have any real order in this series, though, so whatever makes
someone happy makes me happy, too.

> I'd also say what you're actually fixing in the commit
> (range wants ints, not floats.)

Sure, I can add that.

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> But, like, that's just my opinion, man,,
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

Max


--RdWf7Tk6daFRWQipSkX6GeB5OdaUgJ20h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxRoWoACgkQ9AfbAGHV
z0BP3Af/R56l+ROkC7LPOWdLdMkFKER7XnsaqUeTklG/cbxW8iq5mUk3g/Gv2k+M
eNbB3ZCOHF0vP/YFt1tnX24DzqOTCv5wZLA3cKmJZC5vUw17PVNruxyl7WYgOMHd
4AANQ+45RszDjKU5rdmsHKrMwKT92tN4TMUM8H+sbAPhFMF1pWH1fxn5qS2e81WV
fSkJmtonAaDIwOD4fY02Y7JYmkruVaFk3OTHamAJroNEfyIZk9tWG03IgSiAhC4W
Sodr3XL/QcqqiR3XMp9QN5G/5D7/wwdMB1KrH/J/WZj7NBjIzGWZpxK5xamHswMk
QdqT44s5gsJ3HzprbatcmRXAvxO2og==
=qVHA
-----END PGP SIGNATURE-----

--RdWf7Tk6daFRWQipSkX6GeB5OdaUgJ20h--

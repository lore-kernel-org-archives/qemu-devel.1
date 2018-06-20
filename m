Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fVfDJ-00078W-W2
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fVfDG-0003v5-0e
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:40:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fVfDF-0003uq-R1
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:40:01 -0400
Date: Wed, 20 Jun 2018 16:39:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180620153958.GB4714@stefanha-x1.localdomain>
References: <20180618225131.13113-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20180618225131.13113-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] python: Revert sys.path hacks used for
 compat modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 07:51:28PM -0300, Eduardo Habkost wrote:
> Now that the 'argparse' and 'ordereddict' compat modules were
> removed, we can remove some sys.path hacks added because of them.
>=20
> Eduardo Habkost (3):
>   device-crash-test: No need for sys.path hack
>   Revert "docker.py: Python 2.6 argparse compatibility"
>   Revert "tests: migration/guestperf Python 2.6 argparse compatibility"
>=20
>  scripts/device-crash-test          | 1 -
>  tests/docker/docker.py             | 4 +---
>  tests/migration/guestperf/shell.py | 8 +++-----
>  3 files changed, 4 insertions(+), 9 deletions(-)
>=20
>=20
> base-commit: 2ef2f16781af9dee6ba6517755e9073ba5799fa2
> prerequisite-patch-id: 4d0af8c27a87cf124ad37fd18e3adf47fd45a93a
> prerequisite-patch-id: 4376551471959cc464ac8f061e84780710dd9121
> prerequisite-patch-id: 0e23e8822f87d5d0e77d897ff9ff2a952297b1ef
> prerequisite-patch-id: b8acae4f74302b01f4d6805b39d27ce2cdaceafa
> prerequisite-patch-id: f11e7b483ff5f356f52d16b3ae252688002518a0
> prerequisite-patch-id: 4db77f7dd9ff0bc89641e3cce8a4634eb661b476
> prerequisite-patch-id: afd96367ba6e592a33fef5003a01a6560596c204
> --=20
> 2.18.0.rc1.1.g3f1ff2140
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbKnVOAAoJEJykq7OBq3PIoWwIAKZmtiZVaVx4ji711QC2jxlD
oqU1Amomq0r/O/LuBVXv9yxl0rInpkmwH0GuHZIbRgiOoaKBvz3d0I8fDSG9rzDd
KXp4J53f+LEhHCwv9pqFKSt1klQbgoqIBh8w1fC7k2WCavSL7yVv7IWGQPQQ79WD
ch5dhSHb2KArxqeHLx9Ow8iXwZYjFk2cxsARpHac5R1TIINwWmSq7aI36iYd7iWK
SKZK5PR6Xe0le2IswpjUssnQNPH1s1V6Bs1Jxt/Ru3AhriZEiuHb/ozsMvLgSazr
y7sBLlyUgoDf2c+VS/OHZXvUAkukWBFYm6d6Mn2gnNKIOsjLMDo9FB5b//R7Rqk=
=gYR/
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

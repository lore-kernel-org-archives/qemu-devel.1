Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNiOA-0006Ex-Tn
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNiOA-0002XO-0q
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:54:10 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-10-mreitz@redhat.com>
	<cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
Date: Sat, 9 Dec 2017 10:53:57 -0600
MIME-Version: 1.0
In-Reply-To: <cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vTuq5duDw8e1FeHB77xuFKLSXJao83rH9"
Subject: Re: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vTuq5duDw8e1FeHB77xuFKLSXJao83rH9
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <11870f68-db17-cff2-b010-afd42e6c9a44@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123020832.8165-10-mreitz@redhat.com>
 <cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
In-Reply-To: <cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 07:46 PM, John Snow wrote:
>=20
>=20
> On 11/22/2017 09:08 PM, Max Reitz wrote:
>> Tests 080, 130, 137, and 176 simply do not work with compat=3D0.10 for=
 the
>> reasons stated there.
>>
>> 177 is a bit more interesting:  Originally, it was actually very much
>> intended to work with compat=3D0.10 (it even had a special case for th=
at).
>> However, it now prints the test image's map twice, and short of just n=
ot
>> doing that, there is no solution I can imagine that is both simple and=

>> would leave compat=3D0.10 support intact.
>>
>=20
> So we lost that support in
> f0a9c18f9e7
> and
> 81c219ac6ce
>=20
> Eric, any input before we downscope your test?

Ouch, I broke my own test.

Maybe the best thing would be to split 177 into two tests: the original
test (as it was before f0a9c18) that works on both compats, and a new
test that works on just compat=3D1.1 images for the things added in later=

commits.

Since I'm the author for all commits (so far) to that file, I guess I
can sign up for that work...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vTuq5duDw8e1FeHB77xuFKLSXJao83rH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlosFSYACgkQp6FrSiUn
Q2qhXQf+JqQ6c7BKkzFFVn+I32FFSyLa2UjDPANhYEDBps5OjKsTr6GZ74u58A6t
q7no7/9S++VvaDDdttgjEEnND0EalB6wJDFEiPpF3wfw7K1XiGayS7sIYeoR/373
UfCAZPuaD+floZ3TwMRQVPUzzFJ+pCjCZjBWMGZ6we0k70BvXzoCHiD5be2+S1G3
LLCoVjhlzLwKAEPB4hk8RS+EQ3koiZmAfWrxYEnvOnVDkyXnqzQzPo5KdklhZbaA
Fwnv7CJQmQn28e8c16yLWe7MvXT6fFPvz1nIVPPIbUS+NxJVrc96t19jdKfwdzrD
5YBz6qkQITo1h2ujOB7DFoDGEVqhJw==
=O2ky
-----END PGP SIGNATURE-----

--vTuq5duDw8e1FeHB77xuFKLSXJao83rH9--

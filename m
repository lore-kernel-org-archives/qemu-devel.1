Received: from eggs.gnu.org ([2001:4830:134:3::10]:56701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkdXv-0008Ub-IK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkdXu-0005WA-Jl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 17:50:43 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
	<5d84655b-d82a-956a-f434-023961b23552@redhat.com>
	<2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com>
Date: Wed, 23 Aug 2017 23:50:28 +0200
MIME-Version: 1.0
In-Reply-To: <2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EjcLTmk294VWlvLCtAk15tsTxuCCKPQh8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EjcLTmk294VWlvLCtAk15tsTxuCCKPQh8
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 08/13] tests: Rely more on global_qtest
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-9-eblake@redhat.com>
 <e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
 <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
 <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
 <5d84655b-d82a-956a-f434-023961b23552@redhat.com>
 <2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
In-Reply-To: <2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/08/2017 23:30, Eric Blake wrote:
>> Well, whatever is assigning to global_qtest should be using the long f=
orm.
> Question - what about going the other way, and switching ALL callers to=

> always use the explicit form?  I'd really like to maintain only one
> form, but if we think maintaining the explicit form is better, then I'd=

> rather see:
>=20
> s =3D qtest_init(...);
> qmp(s, "{'execute':'foo'}");

I think the short form is not problematic per se, but when e.g.
migration is involved, then the tests are abusing it...

Paolo


--EjcLTmk294VWlvLCtAk15tsTxuCCKPQh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmd+KQACgkQv/vSX3jH
roP2VAf5AQDBIaKLhHpUTPdPy3eCoVdNc6UZ4lo6vJFjMaG9gN5WM6RywHBPTMF4
15NUDNsslB6SzJgWnw7wtULp5SLv33H7nS2jOYLFDIR5+qbZgRgKLscwMKzCczM+
GlcnRymKBfrg9Pt/b+0R/eWNNPNVKO6VUASdwsTm4MS6sch7fElC1ryyybNz+GoV
kcxc3uU/bmw1AXpMUU2kUohdNNq2a9vCnAvZtt0b/OqzjVur6B5ZOvWhYuvp12nK
DMqDysezLJYGiheqCm25ooGKz6Bt2NuDKHnqf9QnbfhUYCSyojOSz/6HDd5kpGPa
AxUHZsLGcZ4ZEIsWWwONmdTclyqoKA==
=qBU5
-----END PGP SIGNATURE-----

--EjcLTmk294VWlvLCtAk15tsTxuCCKPQh8--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgH6-0003rB-T9
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPgH3-0007vs-N5
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:30:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPgH3-0007vj-DQ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:30:41 -0400
References: <20170616101246.1550-1-berrange@redhat.com>
	<20170616101246.1550-6-berrange@redhat.com>
	<a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af6452ce-af71-1f92-e744-a370d35ac8dc@redhat.com>
Date: Mon, 26 Jun 2017 21:30:38 -0500
MIME-Version: 1.0
In-Reply-To: <a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i5biihCQ3oPRs6jSKJxKbhQW1fMKE6gmV"
Subject: Re: [Qemu-devel] [PATCH v4 5/5] tests: add functional test
 validating ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i5biihCQ3oPRs6jSKJxKbhQW1fMKE6gmV
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af6452ce-af71-1f92-e744-a370d35ac8dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] tests: add functional test validating
 ipv4/ipv6 address flag handling
References: <20170616101246.1550-1-berrange@redhat.com>
 <20170616101246.1550-6-berrange@redhat.com>
 <a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
In-Reply-To: <a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/26/2017 09:10 PM, Eric Blake wrote:
> On 06/16/2017 05:12 AM, Daniel P. Berrange wrote:
>> The semantics around handling ipv4=3Don|off & ipv6=3Don|off are quite
>> subtle to understand in combination with the various hostname addresse=
s
>> and backend types. Introduce a massive test matrix that launches QEMU
>> and validates the ability to connect a client on each protocol as
>> appropriate.
>>
>> The test requires that the host has ability to bind to both :: and
>> 0.0.0.0, on port 9000. If either protocol is not available, or if
>> something is already listening on that port the test will skip.
>>
>> Although it isn't using the QTest APIs, it expects the
>> QTEST_QEMU_BINARY env variable to be set.
>=20
> I note that on failure, v3 created test-sockets-proto.pid in the curren=
t
> working directory (the top level, if I ran 'make check-qtest') rather
> than under the tests/ subdirectory or even better under a scratch
> location that gets automatically cleaned up regardless of failure mode.=

>=20
> Since v3 failed for me, but v4 passes (and cleans up on success), I
> can't say if that is still a problem in v4.

Scratch that - I just confirmed that 'test-sockets-proto.pid' is still
created and now listed by 'git status' as a stray file after my in-tree
build 'make check', even though the test passed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--i5biihCQ3oPRs6jSKJxKbhQW1fMKE6gmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUcNOAAoJEKeha0olJ0NqFYkIAJ7FYzaq/IQRnIph1IHuMbsb
AMmfmrkOQaul7Gzy+eMWe5omuhX+TCZZIfDiFfh75abJ/w/PuqTKd+vfhaMNJq+a
seTRcVSy2cpxeAPYB6OkjpekJIacCgYsoO7FoVCbAeV1/IueMqMwm/pk6+a9LrPj
O15nvaxjIAeRmZMGQZd8KpIXZtdKRpaUI+DSO0EYm5ALbtflrJD2HA8r80iy1KWC
G0JUrx0fUKbu1NhKVtVRv7mBKmZcrl48ThD7/mNY3sRKrfeI1GlSGiDm192RrJD2
xNy+ymtBhqnUbY48Y2FdySPx7gpCJK6pBYg/Er5RZmUZ43VjPlUwgsCF+7g+a6M=
=fh+k
-----END PGP SIGNATURE-----

--i5biihCQ3oPRs6jSKJxKbhQW1fMKE6gmV--

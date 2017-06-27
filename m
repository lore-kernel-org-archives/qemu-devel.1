Received: from eggs.gnu.org ([2001:4830:134:3::10]:51915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPfxT-0006Ns-NX
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPfxO-0005JW-Su
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPfxO-0005Id-Jj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:10:22 -0400
References: <20170616101246.1550-1-berrange@redhat.com>
	<20170616101246.1550-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
Date: Mon, 26 Jun 2017 21:10:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170616101246.1550-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m6mAQgjCp7LQqlvFRwDAfHIJbHopWvL9D"
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m6mAQgjCp7LQqlvFRwDAfHIJbHopWvL9D
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9cce9f7-27eb-34dd-bb9a-efc9049c00b1@redhat.com>
Subject: Re: [PATCH v4 5/5] tests: add functional test validating ipv4/ipv6
 address flag handling
References: <20170616101246.1550-1-berrange@redhat.com>
 <20170616101246.1550-6-berrange@redhat.com>
In-Reply-To: <20170616101246.1550-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/16/2017 05:12 AM, Daniel P. Berrange wrote:
> The semantics around handling ipv4=3Don|off & ipv6=3Don|off are quite
> subtle to understand in combination with the various hostname addresses=

> and backend types. Introduce a massive test matrix that launches QEMU
> and validates the ability to connect a client on each protocol as
> appropriate.
>=20
> The test requires that the host has ability to bind to both :: and
> 0.0.0.0, on port 9000. If either protocol is not available, or if
> something is already listening on that port the test will skip.
>=20
> Although it isn't using the QTest APIs, it expects the
> QTEST_QEMU_BINARY env variable to be set.

I note that on failure, v3 created test-sockets-proto.pid in the current
working directory (the top level, if I ran 'make check-qtest') rather
than under the tests/ subdirectory or even better under a scratch
location that gets automatically cleaned up regardless of failure mode.

Since v3 failed for me, but v4 passes (and cleans up on success), I
can't say if that is still a problem in v4.

Otherwise, the diff between v3 and v4 looks sane, and it passes my
tests, so you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m6mAQgjCp7LQqlvFRwDAfHIJbHopWvL9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUb6LAAoJEKeha0olJ0Nq/UgH/jPnD55oqF5z7cdhLvt9pUbP
qzSGALK0WMFulk4a8VD76V3PjMSC9PWyU9zmHcC+LXadBPXdKGPVNdTmjxDkoT//
VMF1qDdzaVr/fJcAXpCHpEQxcC3ZJ7lIVQhcSTwWmfM21OH+srtLoXb/90W3mnz8
8gALMpM3Qn6fOpvqMhcCif2DTsphkTCNn7uslsWQgNjdcy27Q4vBeQBVn25LY78m
S2BZz2I9gtdX/lk50Pk+aZr638hykIuunoXxAa2NqbdsRdRKc9MPOuSFD9OvB3Bb
mcRjfX8r9xsCEm0RBwwbK5DNJzVNM0hWuHm0XCG56rc9MN6Kmyt7LhbgSFhel8c=
=OHhY
-----END PGP SIGNATURE-----

--m6mAQgjCp7LQqlvFRwDAfHIJbHopWvL9D--

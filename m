Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjW5X-0002zV-Fg
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjW5U-00080x-Qj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjW5U-0007z9-In
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:08:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8ABAB19D053
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 19:08:28 +0000 (UTC)
References: <20170302161921.10181-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e8da3a1-9533-cd39-34e9-e4fd27f53f15@redhat.com>
Date: Thu, 2 Mar 2017 13:08:25 -0600
MIME-Version: 1.0
In-Reply-To: <20170302161921.10181-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TuVqXJPUXQBXnd0UbDhennbNkb9NBjWKH"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/2] migration: fixes to
 handling tls-hostname/tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TuVqXJPUXQBXnd0UbDhennbNkb9NBjWKH
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Message-ID: <6e8da3a1-9533-cd39-34e9-e4fd27f53f15@redhat.com>
Subject: Re: [PATCH for-2.9 v3 0/2] migration: fixes to handling
 tls-hostname/tls-creds
References: <20170302161921.10181-1-berrange@redhat.com>
In-Reply-To: <20170302161921.10181-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 10:19 AM, Daniel P. Berrange wrote:
> The need for these two patches was identified during implementation  of=

> TLS encrypted migration in libvirt.
>=20
> Changed in v3:
>=20
>  - Add to qapi-schema.json docs
>=20
> Daniel P. Berrange (2):
>   migration: allow clearing migration string parameters
>   migration: always report tls-creds & tls-hostname migrate parameters
>=20
>  migration/migration.c | 22 ++++++++++++++++------
>  qapi-schema.json      |  8 +++++++-
>  2 files changed, 23 insertions(+), 7 deletions(-)

The discoverability of whether "" works is not visible in introspection,
but reporting "" on output helps.  For the series:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TuVqXJPUXQBXnd0UbDhennbNkb9NBjWKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuG2pAAoJEKeha0olJ0NqR8cH/2EtpYqbDUdWqlpdPWIFXsOW
RMF7q8N9PsVBLHvT3YrDEfF5rQRXs+CUqb5S3+EVXGS7sOqQ4RKxz62D3esz5+/u
g0NAA5+Wk8Ud2v5x+KzJFbp4ohgku9npA+ilTB8JzGTCEiENCx1lij7mb0llHemq
xkk9TZyGbR1p/YOWuLQ/qq2jBE5G8awbqc0qhe63LlXlRZXOSBnaYQtBI0LP1x2R
B3gy8ZU8ffl76b/xWTPJJckN0zU3syTCUsYdlvQqyfsu48cSmpN27xuTJCG0feyC
Xnsp7YhcYOIvRHxj51lLlPecx9w+KCeUjDIXRoKJHCcimrbLgoRzIco5dXgYRgc=
=/06a
-----END PGP SIGNATURE-----

--TuVqXJPUXQBXnd0UbDhennbNkb9NBjWKH--

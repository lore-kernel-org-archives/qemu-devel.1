Received: from eggs.gnu.org ([2001:4830:134:3::10]:45599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW4YO-0004wX-TH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW4YN-0002iS-U7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:39:00 -0400
References: <87379zhrhn.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1229e9b6-d675-ee15-ce98-6ee85a4f421b@redhat.com>
Date: Fri, 14 Jul 2017 12:38:50 -0500
MIME-Version: 1.0
In-Reply-To: <87379zhrhn.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wDa2N0xQMRNsToHlRAgXHqrEwNEXR8HNp"
Subject: Re: [Qemu-devel] qapi: Stop abusing "special" values for something
 entirely different
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wDa2N0xQMRNsToHlRAgXHqrEwNEXR8HNp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <1229e9b6-d675-ee15-ce98-6ee85a4f421b@redhat.com>
Subject: Re: qapi: Stop abusing "special" values for something entirely
 different
References: <87379zhrhn.fsf@dusky.pond.sub.org>
In-Reply-To: <87379zhrhn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 12:12 PM, Markus Armbruster wrote:
>=20
> Instead of the last part, I prefer either
>=20
> * so we add a *new* value, such as JSON null.

I like that idea.

>=20
> 1. Stop abusing values the schema accepts, but are invalid to mean "do
> something else entirely".
>=20
> 2. Add a first class null type to QAPI.
>=20
> 3. Turn MigrationParameters members tls-creds and tls-hostname into
> alternate of str and null.  Deprecate "".
>=20
> 4. Add a null member to alternate BlockdefRef.  Deprecate "".

Back-compat concerns: would we still accept "" in place of null for a
release or two?  Is it time to figure out how to add deprecation
notices/events to QMP?  Or would this be a clean break-over point (since
introspection exists), where if introspection shows there is an
alternate between string and null, then libvirt MUST use null instead of
"" to get the desired semantics?

>=20
> I got patches for 2., and I intend to work on 3. and 4.
>=20
> Since this is "only" about "less than general and ugly", we may decide
> to leave things as they are if my patches turn out even uglier.
>=20
> Meanwhile, opinions?

Not much time left for soft freeze (which kind of echoes the dilemma we
had at 2.9).  Is this something you are aiming for in 2.10, or will it
be all the harder to worry about back-compat (because we'll have two
releases rather than one before we introduce the alternate-with-null
semantics)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wDa2N0xQMRNsToHlRAgXHqrEwNEXR8HNp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaQGqAAoJEKeha0olJ0NqRHEH/R3qNDNGumxGaPosClnxnd48
AlaGerLkzh2Sl3uvQGuHUNwSCv/iGZ05sfubpqebNWHkbFweCLwa9TCzA/SYsyvR
u5/axKxLBDq1O6BqUr0qdWemz6d+LfGuof4CdlwsN2QSoLVAh1XxofWK/1LJC6GT
/ZxyfnBgp2JqfenXSEjPaDqMuVx6TZZ24vPZ2m31jR9SRPothnAdPkjeLE0pnTge
XKWSgftEjdJLPeSiH6acHpKDJ347UxCHZ7HWAZlvVOySMrJdNKnAeUwnfGCVkokh
icVYv2Y5gAyYhWg8RTd3tFRrTslx2HvmKuUHcia/+ffuEBvxSQ4iiQEMKFSjkeU=
=7QQe
-----END PGP SIGNATURE-----

--wDa2N0xQMRNsToHlRAgXHqrEwNEXR8HNp--

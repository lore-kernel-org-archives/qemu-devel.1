Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dky09-0005mv-LZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dky05-0003Xc-Dm
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:41:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dky05-0003W1-3f
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:41:09 -0400
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcdd4567-684a-5ca6-3a34-bbb9ad35bf11@redhat.com>
Date: Thu, 24 Aug 2017 14:41:01 -0500
MIME-Version: 1.0
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PNL8HiIdITBjb999a2ibnawb0WpcSCW1k"
Subject: Re: [Qemu-devel] [PATCH v2 00/16] qapi-schema: Reorganize along
 maintenance boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNL8HiIdITBjb999a2ibnawb0WpcSCW1k
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcdd4567-684a-5ca6-3a34-bbb9ad35bf11@redhat.com>
Subject: Re: [PATCH v2 00/16] qapi-schema: Reorganize along maintenance
 boundaries
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 02:13 PM, Markus Armbruster wrote:
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Alberto Garcia <berto@igalia.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Much of the QAPI schema really belongs to a subsystem, but MAINTAINERS
> can't tell when it's all in a big ball of mud (qapi-schema.json) with
> a small ball of mud (event.json) on the side.
>=20
> Create sub-schemas for the subsystems with the most substantial QAPI
> footprint in the mud.  The big ball shrinks by half, and the small
> ball goes away.
>=20
> Bonus: the generated documentation's structure makes more sense now.
> It needs further improvement (see last patch), but it's a start.
>=20
> I generally kept the order intact when moving source code.  It may be
> smarter to reorder it for improved legibility (both source and
> generated doc).  Subsystem maintainers, please tell me whether you'd
> like things reordered.

Ideally, moving from one file to another should be kept separate from
reordering within a file, to make review easier.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PNL8HiIdITBjb999a2ibnawb0WpcSCW1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfK80ACgkQp6FrSiUn
Q2rOqAf/Vh1GqggTXNufdKum4sCoUq+Ot5GlHUtuqAxdTPkm2Z3xbEb0EdDboMiI
Ub+noHmfzOBAHsov18luV4JvkQgOk3YhCVrs+25j5XmWQeOL4EkguHEiULSW4R1/
Cas4YEPtWc7IdtYPw8O/ymNFTchCPKfUD8fduuKzZyaVW2c+bbyjzAK1hVOViMBT
CNYyRhantURtfZhCN1gG/v5kqQjawkGc0keWfF+58C2806Z6oB7tqxEv8XtCyjjt
c+hXV3B6ZPzTkKtJTj6UksX/SJVaFo3tSc8MxwW7Q+bX8Ck3jycXm3kC3hzknJCn
xINogTLMkXC/B2V+69I3zm31DPT0rA==
=STc3
-----END PGP SIGNATURE-----

--PNL8HiIdITBjb999a2ibnawb0WpcSCW1k--

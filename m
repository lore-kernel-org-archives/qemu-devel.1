Received: from eggs.gnu.org ([2001:4830:134:3::10]:56127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUey0-0007EE-4M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 14:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUexv-0001JS-Ad
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 14:35:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUexu-0001Hw-QT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 14:35:15 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<442dcfe4-8704-2898-655e-da383a0caf76@virtuozzo.com>
	<220990D0-ACB6-4F25-BADF-63898FE71BED@alex.org.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0654e27f-9c2f-993c-befd-1f1e8e75aabf@redhat.com>
Date: Fri, 20 Jan 2017 13:35:10 -0600
MIME-Version: 1.0
In-Reply-To: <220990D0-ACB6-4F25-BADF-63898FE71BED@alex.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8vNEchuKpJDuSeioMELa7VErvIRVwCTSj"
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, Wouter Verhelst <w@uter.be>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8vNEchuKpJDuSeioMELa7VErvIRVwCTSj
From: Eric Blake <eblake@redhat.com>
To: Alex Bligh <alex@alex.org.uk>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pavel Borzenkov <pborzenkov@virtuozzo.com>,
 "Stefan stefanha@redhat. com" <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>,
 Wouter Verhelst <w@uter.be>, John Snow <jsnow@redhat.com>
Message-ID: <0654e27f-9c2f-993c-befd-1f1e8e75aabf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
References: <20161214150840.10899-1-alex@alex.org.uk>
 <442dcfe4-8704-2898-655e-da383a0caf76@virtuozzo.com>
 <220990D0-ACB6-4F25-BADF-63898FE71BED@alex.org.uk>
In-Reply-To: <220990D0-ACB6-4F25-BADF-63898FE71BED@alex.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 12:00 PM, Alex Bligh wrote:
>=20
>> On 20 Jan 2017, at 17:04, Vladimir Sementsov-Ogievskiy <vsementsov@vir=
tuozzo.com> wrote:
>>
>> About extents: is 32bit length enough? We will have to send 4096 for e=
mpty 16tb disk..
>=20
> The nbd protocol uniformly uses 32 bit lengths (for better or for worse=
). This is baked into the specification heavily.
>=20
> I'm not sure sending 4,096 items for an empty 16TB disk is any great ha=
rdship to be honest.

If it truly matters, an idea that has already been floated on the list
is to add a new NBD_CMD_FLAG_SCALE (or some other spelling) that states
that a particular command is sending lengths scaled by a particular
factor (by the block size? obviously it would have to be better
specified).  Under this idea, the scaling factor would allow you to
report larger extents for fewer back-and-forth operations, but it gets
tricky if the scaling is allowed to get larger than the minimum
granularity between extent changes.

The other idea that has been floated is a way to report whether the
entire export is known to be all-zero content at the time the client
connects, which would trade 4096+ queries (you'd actually have to do
more than 4096 queries, since length is < 4G, not <=3D 4G) with a single
piece of information at the time the client connects.

Either way, discussion on such enhancements are probably worth a new thre=
ad.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8vNEchuKpJDuSeioMELa7VErvIRVwCTSj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgmZuAAoJEKeha0olJ0NqjMcH/3KGxNPE/Hwl2BQZyzB138aG
9KnbOc3hqB6FIO6J4MThiyJHZK+rkuND5J4+lkGhim1ASRw3JkwlNFQcX2XVUyi2
okiFj1g8TtfVtixkYzMfdfH98bou+nWlf1/aw1dcHVKDrLzCOro3FeIUVWcHratX
1SrLvcs1Y3TfIde+5L4i5JvwpEvI+91Q1uuhqrhWoZEh264kmYgHtMdlGKKWJHzV
DL2EOSTAV8A/39mzHDga9SrPAXHlLNJPB/e3jd1xU4H0mQXmPMAqVvPdVqLTmGN4
Kr1jAuWAGISGvC5QsizLU2euDKSs/cr7x8O06CzCHIQRs3kyeOCv6H28iI3tKBc=
=iDpI
-----END PGP SIGNATURE-----

--8vNEchuKpJDuSeioMELa7VErvIRVwCTSj--

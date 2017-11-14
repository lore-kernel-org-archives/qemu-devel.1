Received: from eggs.gnu.org ([2001:4830:134:3::10]:53412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcqL-0002iX-7I
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcqF-0002L4-G7
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:09:41 -0500
References: <20171110203111.7666-1-mreitz@redhat.com>
	<20171110203111.7666-6-mreitz@redhat.com>
	<w51y3n8zypa.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6b0680e6-e934-ac2c-659f-8e22ac2c3480@redhat.com>
Date: Tue, 14 Nov 2017 16:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <w51y3n8zypa.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SGiQ19PgQXgnScKCxkLASc19qa2lL9adn"
Subject: Re: [Qemu-devel] [PATCH for-2.11 5/5] qcow2: Refuse to get
 unaligned offsets from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SGiQ19PgQXgnScKCxkLASc19qa2lL9adn
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <6b0680e6-e934-ac2c-659f-8e22ac2c3480@redhat.com>
Subject: Re: [PATCH for-2.11 5/5] qcow2: Refuse to get unaligned offsets from
 cache
References: <20171110203111.7666-1-mreitz@redhat.com>
 <20171110203111.7666-6-mreitz@redhat.com>
 <w51y3n8zypa.fsf@maestria.local.igalia.com>
In-Reply-To: <w51y3n8zypa.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 16:06, Alberto Garcia wrote:
> On Fri 10 Nov 2017 09:31:11 PM CET, Max Reitz wrote:
>> +static inline const char *qcow2_cache_get_name(BDRVQcow2State *s, Qco=
w2Cache *c)
>> +{
>> +    if (c =3D=3D s->refcount_block_cache) {
>> +        return "refcount block";
>> +    } else if (c =3D=3D s->l2_table_cache) {
>> +        return "L2 table";
>> +    } else {
>> +        /* Do not abort, because this is not critical */
>> +        return "unknown";
>> +    }
>> +}
>=20
> Why is an unknown cache not critical?

Because this is debugging information.  I know others disagree with my
opinion that I'd rather not abort qemu just because someone forgot to
add a 'return "foo";' here when adding a new cache, but that's my
opinion so I wanted to at least be told by someone that we should abort
here before doing it.

Max


--SGiQ19PgQXgnScKCxkLASc19qa2lL9adn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLBxwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A43oH+wdN4+/QRVZ3fRsnZ5A8JvWcR5ADkzzk
4XDfuu2+eXItFnZObiq4TEhnRRvzCLHKaRL1eCZPbNujTw0MIJR01KIOBCByZ5zp
0UhvPF4CIMqUxyeq/5hCGjJKdqbyvKil38IWk943TwKj/UDpzgrLpPlyBmPLzSd4
Z5316lVUOfFM5F+asN4kXVKAfsyKXbXjxI70VwIx14SyRRgTxPbIo/7gAyRAPD5G
WL0tcMcAQOz+Ge592ibzN0++x/Cjszsxq3n9N7JUz6JNgMXvA9+xYct2m2qeiaVB
2KJ1U+bsgZ/kmm1u7+f5i1WKGbwOYuz9x3EGhj/4HIb1BHvB9LWifCI=
=HGQu
-----END PGP SIGNATURE-----

--SGiQ19PgQXgnScKCxkLASc19qa2lL9adn--

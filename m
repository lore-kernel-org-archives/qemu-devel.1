Received: from eggs.gnu.org ([2001:4830:134:3::10]:38281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLz75-00012z-9j
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLz74-00028z-Ck
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:21:23 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
	<a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
Date: Mon, 4 Dec 2017 23:21:10 +0100
MIME-Version: 1.0
In-Reply-To: <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eneSWQEeO8TeFifH9LBOoinvAKdVEbEHN"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eneSWQEeO8TeFifH9LBOoinvAKdVEbEHN
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com
Message-ID: <a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
Subject: Re: [Qemu-block] [PATCH] blockdev-backup: enable non-root nodes for
 backup
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
 <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
 <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
In-Reply-To: <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-04 23:15, John Snow wrote:
>=20
>=20
> On 12/01/2017 02:41 PM, Max Reitz wrote:
>> ((By the way, I don't suppose that's how it should work...  But I don'=
t
>> suppose that we want propagation of dirtying towards the BDS roots, do=

>> we? :-/))
>=20
> I have never really satisfactorily explained to myself what bitmaps on
> intermediate notes truly represent or mean.
>=20
> The simple case is "This layer itself serviced a write request."
>=20
> If that information is not necessarily meaningful, I'm not sure that's =
a
> problem except in configuration.
>=20
>=20
> ...Now, if you wanted to talk about bitmaps that associate with a
> Backend instead of a Node...

But it's not about bitmaps on intermediate nodes, quite the opposite.
It's about bitmaps on roots but write requests happening on intermediate
nodes.

Say you have a node I and two filter nodes A and B using it (and they
are OK with shared writers).  There is a dirty bitmap on A.

Now when a write request goes through B, I will obviously have changed,
and because A and B are filters, so will A.  But the dirty bitmap on A
will still be clean.

My example was that when you run a mirror over A, you won't see dirtying
from B.  So you can't e.g. add a throttle driver between a mirror job
and the node you want to mirror, because the dirty bitmap on the
throttle driver will not be affected by accesses to the actual node.

Max


--eneSWQEeO8TeFifH9LBOoinvAKdVEbEHN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolylYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3VUIAKyBkzGv+HaOHYJ46Q/jh7ItDUn4s7Lv
SBtTTp3MEvq34RWB5QC8gMPtz/edrz9zFZtH+cLJvD93D3gf+r1W4Vqkk1DoyCEE
aK5rGUXN6WF9gtG6qXCC39t0nckCYp1AqrmQ3yQfzyaXCeVuNMh/En1OA/9EkypE
myqbFELEKI1KfDLdZYzJsACvJVcfkwJf4bysWtb9h2eR66Cz21PSZXIJdpJ5UiFH
opkeF1bHVHAxiPsLYnk+YcC7qL9cTXAfSUyZHESFUDSN7gou0U2/2S1crqtMSS83
XRvLNPA6ZgQ/jEzwVcbmY06RvKhlWCf7ZrBdIya5gW/53QhYltH+imM=
=lKG6
-----END PGP SIGNATURE-----

--eneSWQEeO8TeFifH9LBOoinvAKdVEbEHN--

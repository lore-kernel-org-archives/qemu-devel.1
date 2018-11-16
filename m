Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNg1y-0007OO-Qj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNg1w-0004pa-Ju
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:27:38 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
	<20181116151834.GA5066@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
Date: Fri, 16 Nov 2018 16:27:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181116151834.GA5066@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7A2azze5vv7RgbhKbDjAUVE13B7Pyh2b0"
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7A2azze5vv7RgbhKbDjAUVE13B7Pyh2b0
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
Subject: Re: KVM Forum block no[td]es
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
 <w511s7p9fkk.fsf@maestria.local.igalia.com>
 <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
 <w51efbmh0tp.fsf@maestria.local.igalia.com>
 <2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
 <w51in0xuksv.fsf@maestria.local.igalia.com>
 <20181116151834.GA5066@localhost.localdomain>
In-Reply-To: <20181116151834.GA5066@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.11.18 16:18, Kevin Wolf wrote:
> Am 16.11.2018 um 16:03 hat Alberto Garcia geschrieben:
>>> I don't think anything needs a way to generally block graph changes
>>> around some node.  We only need to prevent changes to very specific
>>> sets of edges.  This is something that the permission system just
>>> cannot do.
>>
>> But what would you do then?
>=20
> I agree with you mostly in that I think that most problems that Max
> mentioned aren't readl. The only real problem I see with GRAPH_MOD as a=

> permission on the node level is this overblocking

I wholeheartedly disagree.  Yes, it is true that most of the issues I
thought of can be fixed, and so those problems are not problems in a
technical sense.  But to me this whole discussion points to the greatest
issue I have, which is that GRAPH_MOD is just too complicated to
understand.  And I don't like a solution that works on a technical level
but that everybody is too afraid to touch because it's too weird.

We have this discussion again and again, and in the end we always come
up with something that looks like it might work, but it's just so weird
that we can't even remember it.

Maybe it's just me, though.  Frankly, I think the permission system
itself is already too complicated as it is, but I don't have a simpler
solution there.

Max


--7A2azze5vv7RgbhKbDjAUVE13B7Pyh2b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvu4dgACgkQ9AfbAGHV
z0ALSwf+Li0sr8Z6qjj7CMBmm4O2+ANv2NX4yd646z42RUg+7JBDmKXjL5I76k1L
TDB8jBqFVjZdwOLBJILDFPl+OVgxPy5FCjVnGLxaxOXwZ5HvGhfBKHLGp+M2hI4s
9FNaTOzxTZDuMtyAzHqgE8kFYpW6OviWRqUC7jH4P3vSemJ83IvtAOy9wTCJzgtH
70/+1uzOu2RzjXBL3nlJh6A63+o8OOcyQWj2EzWKmnTHVBeQ6hecfvBCwYCXiY21
hj3COkWTGP+xNHLnLtF/YQWVZvMEm/InbHtDVn7LYoQsdRB6TnExt59pqjhNjdTY
5mHxwl3/D9sfCjc/h98sStJEXz293Q==
=LFQM
-----END PGP SIGNATURE-----

--7A2azze5vv7RgbhKbDjAUVE13B7Pyh2b0--

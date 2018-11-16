Received: from eggs.gnu.org ([2001:4830:134:3::10]:42042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNimd-0004z4-HL
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNimc-0004gp-I0
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:23:59 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
	<20181116151834.GA5066@localhost.localdomain>
	<001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
	<20181116155106.GD5066@localhost.localdomain>
	<1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
	<20181116171302.GG5066@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff559202-1d07-3dd5-d55b-3b586ba5cd32@redhat.com>
Date: Fri, 16 Nov 2018 19:23:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181116171302.GG5066@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X9d2R9QCWf5VxtKHYG0RHaanfCccrSf5G"
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X9d2R9QCWf5VxtKHYG0RHaanfCccrSf5G
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ff559202-1d07-3dd5-d55b-3b586ba5cd32@redhat.com>
Subject: Re: KVM Forum block no[td]es
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
 <w511s7p9fkk.fsf@maestria.local.igalia.com>
 <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
 <w51efbmh0tp.fsf@maestria.local.igalia.com>
 <2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
 <w51in0xuksv.fsf@maestria.local.igalia.com>
 <20181116151834.GA5066@localhost.localdomain>
 <001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
 <20181116155106.GD5066@localhost.localdomain>
 <1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
 <20181116171302.GG5066@localhost.localdomain>
In-Reply-To: <20181116171302.GG5066@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I feel bad for trimming your mail so much, but that's just because I've
read it and I agree.  So, it's trimming of the good kind.
(Then again, when is trimming of a long mail ever bad?)

On 16.11.18 18:13, Kevin Wolf wrote:

[...]

> What we noted down about counters was more meaningful progress because
> we think this can actually provide the semantics that we need. Of
> course, there is still some hand-waving involved (we'll just check the
> counter when modifying the graph), which might not be that trivial to
> implement because bdrv_replace_child() can't return an error...

Sure, there is much to talk about there.  You're right, we probably need
a transaction system there, too, which makes things not so simple again.

And then there's the fact that bdrv_detach_child() currently cannot
fail, and we really don't want it to fail in e.g. bdrv_close().
Expressing that may be tricky, too.

>>> It doesn't feel too bad to me, but that's subjective.
>>
>> It's not worse than quiescing/draining, that's for sure.
>=20
> How would _you_ know? :-)

I seem to recall to at least have read your patches... ;-)

[...]

> For the implementation with counters, maybe we actually need two of the=
m
> like perm/shared in the permission system. One that means that we're
> going to modify the graph, and the other one that means that we can't
> tolerate graph modifications.
>=20
> For the public interface, we might actually treat it mostly like
> permissions, just edge permissions, not node permissions.

Hm.  I see your point.  But having a "perm" field which would allow a
party to be able to do graph modifications for as long as it has claimed
that field would mean that the probably also want other parties not to
modify that exact same part of the graph in the meantime.  Like commit
which will modify part of the graph while over the whole lifetime of the
job it doesn't want that part to be modified by something else.

But then again, exactly that "perm" field solves the issue, too.  If you
are required to take the permission (and in the process block other
modifications on that edge) before doing graph modifications, the check
function can simply see that there is exactly one blocker, and infer
that this must be the party doing the modification itself.

>> So, no, I do not have a good technical counter-argument.  But my
>> argument of complexity still stands after having gone through
>> understanding how GRAPH_MOD might actually work for at least the third=

>> time now, without it ever having made the next time any easier.
>>
>> Even if GRAPH_MOD were correctly implemented tomorrow, in a way
>> conforming to what we've discussed now, I have the strong feeling that=
 I
>> still would get to a point where I forgot its meaning and would have t=
o
>> go through all of this again.
>>
>> And that's completely disregarding people new to the codebase.
>=20
> As I said, it's moot anyway. It doesn't provide the right semantics.

True, but the discussion itself isn't moot to me.  I wanted to stress
that given something that is rather hard to grasp, I prefer to throw it
away as long as it is not functional yet, whenever a more intuitive
alternative presents itself.

Max


--X9d2R9QCWf5VxtKHYG0RHaanfCccrSf5G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvvCzQACgkQ9AfbAGHV
z0Bt/wgArK0LvJSS2EYmRBkfBL+Pe4A4ytrgvuHSEB8zYiy8/0YdwZUWLUfa8ghT
VCYaqmsrD8hR8MNKlNpWDKqbh5Uwa2k71xp2Caj9SJTFOmCk+iVZA93aDtWTFhvD
b8iHMG0kcNO5w0AdYG+rUhtmUa6cAm6kLJM1TjmPOM8E4HsGtuEJhmA4Acc+Ydg8
lLjmQBMFX3J4bchJxwdDA8OqX6f9IdcTSsWRsUY6rP+mi553niid15AGDCBfO7cY
Zhq1y9aEzQrvtx0eW30qK4ni0uzPnnBibHqYM7xu2SHo6/Zs/IHsAtOvC2a1lBMH
AOT4pQcMoVzWe8pUO0Y29Qxn1buytQ==
=u6H6
-----END PGP SIGNATURE-----

--X9d2R9QCWf5VxtKHYG0RHaanfCccrSf5G--

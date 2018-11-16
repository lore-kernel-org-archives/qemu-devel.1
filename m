Received: from eggs.gnu.org ([2001:4830:134:3::10]:39819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNh5B-0004Cy-L2
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNh5A-0006hN-8g
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:35:01 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
	<20181116151834.GA5066@localhost.localdomain>
	<001ec125-35f3-e1fb-56a7-1ed4a1974cc6@redhat.com>
	<20181116155106.GD5066@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
Date: Fri, 16 Nov 2018 17:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181116155106.GD5066@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PITOTR2fxcK1Q7TjWLooz8Re0Yr4V0HXT"
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
--PITOTR2fxcK1Q7TjWLooz8Re0Yr4V0HXT
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1d65ed3f-7353-002f-9000-3b824d5892ce@redhat.com>
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
In-Reply-To: <20181116155106.GD5066@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16.11.18 16:51, Kevin Wolf wrote:
> Am 16.11.2018 um 16:27 hat Max Reitz geschrieben:
>> On 16.11.18 16:18, Kevin Wolf wrote:
>>> Am 16.11.2018 um 16:03 hat Alberto Garcia geschrieben:
>>>>> I don't think anything needs a way to generally block graph changes=

>>>>> around some node.  We only need to prevent changes to very specific=

>>>>> sets of edges.  This is something that the permission system just
>>>>> cannot do.
>>>>
>>>> But what would you do then?
>>>
>>> I agree with you mostly in that I think that most problems that Max
>>> mentioned aren't readl. The only real problem I see with GRAPH_MOD as=
 a
>>> permission on the node level is this overblocking
>>
>> I wholeheartedly disagree.  Yes, it is true that most of the issues I
>> thought of can be fixed, and so those problems are not problems in a
>> technical sense.  But to me this whole discussion points to the greate=
st
>> issue I have, which is that GRAPH_MOD is just too complicated to
>> understand.  And I don't like a solution that works on a technical lev=
el
>> but that everybody is too afraid to touch because it's too weird.
>=20
> GRAPH_MOD with the meaning that Berto suggested isn't weird or
> complicated to understand. It's only the wrong tool because it blocks
> more than we want to block. But if we didn't care about that, it could
> be just another permission like any other.

The meaning Berto has suggested (AFAIU) is never taking the permission
at all but just querying whether it is shared by all current parents
before doing a graph change.

That is very weird to me because permissions are there to be taken.


The meaning I have suggested is that it would be taken before a graph
change and released right afterwards.  I think this is still weird
because we don't take, say, the WRITE permission before every
bdrv*_write*() call and release it afterwards.

Sure you could say "actually, why not".  Please don't.[1]

> If you want to change the graph, you'd need to get the permission first=
,
> and bdrv_replace_child_noperm() could assert that at least one parent o=
f
> the parent node has acquired the permission (unless you want to pass th=
e
> exact parent BdrvChild to it; maybe this is what we would really do
> then).

Yep, that assertion would be like we do it in bdrv_co_write_req_prepare()=
=2E

Thing is, you (as in "the caller that actually wants to do something",
like mirror) don't just "get the permission".  Permissions are
associated with children, so you cannot get this permission before you
create your child.

So this is where "parent of a parent node" comes in?  I'm afraid I don't
understand that.

What would make sense to me would be for the generic block layer to take
this permission on new children (and drop it immediately after having
attached the child) and children that are about to be detached.  Which
again is just different from any other permission, because things
outside of block.c can never take it, they can only choose not to share
it.  So it'd be an internal permission, which is visible to the outside,
and I think this is at least weirder than just having an internal
counter with a clear external interface (inc/dec).


Also, please excuse me for it being Friday and all, but I don't quite
believe in "It's actually clear, I have no idea why you claim to always
take so long to understand it."  The code clearly has no idea what it's
supposed to do, and I do not believe that the sole reason for that is
that someone who did understand didn't have the time or the need to fix
it, or to implement it correctly in the first place.

On the other hand it sounded a bit like Berto was about to fix it,
though, so there's that.

Or I just got you wrong and this is just the usual case of "Now that
we've talked about this through a couple of lengthy emails, it does make
sense" which is just all too familiar and exactly my issue with the
whole thing.

>> We have this discussion again and again, and in the end we always come=

>> up with something that looks like it might work, but it's just so weir=
d
>> that we can't even remember it.
>=20
> I don't think we ever come up with something, weird or not, that
> achieves what we wanted to achieve - because the problem simply can't b=
e
> solved properly at the node level.

Yes, I've phrased my disagreement wrong.  Of course I don't disagree
with you on that.  I just disagree that this is the only issue with
GRAPH_MOD.

>> Maybe it's just me, though.  Frankly, I think the permission system
>> itself is already too complicated as it is, but I don't have a simpler=

>> solution there.
>=20
> It doesn't feel too bad to me, but that's subjective.

It's not worse than quiescing/draining, that's for sure.

Max


[1] Please don't because on one hand I wouldn't have a counter-argument
for this.  Yes, maybe we should actually take permissions right before
the operations that require them.  Maybe keeping them around for as long
as a child stays attached to a parent is just being lazy.

I suppose the main argument against taking permissions just when you
need them is that this introduces additional points of failure that are
mostly unnecessary.  For GRAPH_MOD, however, these points would be
limited and easily handled, because they just involve making
bdrv_attach_child() fail.

So, no, I do not have a good technical counter-argument.  But my
argument of complexity still stands after having gone through
understanding how GRAPH_MOD might actually work for at least the third
time now, without it ever having made the next time any easier.

Even if GRAPH_MOD were correctly implemented tomorrow, in a way
conforming to what we've discussed now, I have the strong feeling that I
still would get to a point where I forgot its meaning and would have to
go through all of this again.

And that's completely disregarding people new to the codebase.


--PITOTR2fxcK1Q7TjWLooz8Re0Yr4V0HXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvu8YAACgkQ9AfbAGHV
z0AJFgf9FmaXVMqjdbTEOdCPcahsMDE0cMzflY1BXR7aKAwsX2ZfBexuotVOwJo/
+/zSN9feWxEpazZ9ekWRpQoYTOuEs4xkzpmb28gmCn4DEOO4123VXYcnWbSft1qT
Njzrg20+rL4KsyMWvgxoG4+Jnu1jBIoQrT58n93Py1jkOBYqCD+ACVLIj6JOXFAS
xrDwWktv/vkFdPn2s85mAIeyba5oSKVR8slMifwZMUOUarmTzLe07lXjAW218NE7
9KWm1xhPXzAYtWi6QDZS1v6ZtO/rWnlHfLPxRilFfj/XYSKluPYD/N6tdyQKvVLg
dRYbj9rABeKyd5Euqryo3bp1BwbnNA==
=fqX4
-----END PGP SIGNATURE-----

--PITOTR2fxcK1Q7TjWLooz8Re0Yr4V0HXT--

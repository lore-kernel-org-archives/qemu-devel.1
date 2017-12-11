Received: from eggs.gnu.org ([2001:4830:134:3::10]:38051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eORW8-000236-Uh
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eORW7-00053W-GI
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:05:24 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
	<a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
	<a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
	<6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
	<115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
	<5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
	<09cebfbf-e95c-8f09-5a0a-9345e1e1804d@redhat.com>
	<23523fec-96b1-f50b-6937-85daea8a832a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f3918f16-774b-4c73-7df4-8ec3e757ae3c@redhat.com>
Date: Mon, 11 Dec 2017 18:05:09 +0100
MIME-Version: 1.0
In-Reply-To: <23523fec-96b1-f50b-6937-85daea8a832a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u1NncPPOiR9kHPwFcwx1J4mXJwcsVnulH"
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
--u1NncPPOiR9kHPwFcwx1J4mXJwcsVnulH
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com
Message-ID: <f3918f16-774b-4c73-7df4-8ec3e757ae3c@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
 <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
 <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
 <a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
 <6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
 <115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
 <5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
 <09cebfbf-e95c-8f09-5a0a-9345e1e1804d@redhat.com>
 <23523fec-96b1-f50b-6937-85daea8a832a@redhat.com>
In-Reply-To: <23523fec-96b1-f50b-6937-85daea8a832a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-11 17:47, John Snow wrote:
>=20
>=20
> On 12/11/2017 11:31 AM, Max Reitz wrote:
>> On 2017-12-08 18:09, John Snow wrote:
>>>
>>>
>>> On 12/08/2017 09:30 AM, Max Reitz wrote:
>>>> On 2017-12-05 01:48, John Snow wrote:
>>>>>
>>>>>
>>>>> On 12/04/2017 05:21 PM, Max Reitz wrote:
>>>>>> On 2017-12-04 23:15, John Snow wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 12/01/2017 02:41 PM, Max Reitz wrote:
>>>>>>>> ((By the way, I don't suppose that's how it should work...  But =
I don't
>>>>>>>> suppose that we want propagation of dirtying towards the BDS roo=
ts, do
>>>>>>>> we? :-/))
>>>>>>>
>>>>>>> I have never really satisfactorily explained to myself what bitma=
ps on
>>>>>>> intermediate notes truly represent or mean.
>>>>>>>
>>>>>>> The simple case is "This layer itself serviced a write request."
>>>>>>>
>>>>>>> If that information is not necessarily meaningful, I'm not sure t=
hat's a
>>>>>>> problem except in configuration.
>>>>>>>
>>>>>>>
>>>>>>> ...Now, if you wanted to talk about bitmaps that associate with a=

>>>>>>> Backend instead of a Node...
>>>>>>
>>>>>> But it's not about bitmaps on intermediate nodes, quite the opposi=
te.
>>>>>> It's about bitmaps on roots but write requests happening on interm=
ediate
>>>>>> nodes.
>>>>>>
>>>>>
>>>>> Oh, I see what you're saying. It magically doesn't really change my=

>>>>> opinion, by coincidence!
>>>>>
>>>>>> Say you have a node I and two filter nodes A and B using it (and t=
hey
>>>>>> are OK with shared writers).  There is a dirty bitmap on A.
>>>>>>
>>>>>> Now when a write request goes through B, I will obviously have cha=
nged,
>>>>>> and because A and B are filters, so will A.  But the dirty bitmap =
on A
>>>>>> will still be clean.
>>>>>>
>>>>>> My example was that when you run a mirror over A, you won't see di=
rtying
>>>>>> from B.  So you can't e.g. add a throttle driver between a mirror =
job
>>>>>> and the node you want to mirror, because the dirty bitmap on the
>>>>>> throttle driver will not be affected by accesses to the actual nod=
e.
>>>>>>
>>>>>> Max
>>>>>>
>>>>>
>>>>> Well, in this case I would say that a root BDS is not really any
>>>>> different from an intermediate one and can't really know what's goi=
ng on
>>>>> in the world outside.
>>>>>
>>>>> At least, I think that's how we model it right now -- we pretend th=
at we
>>>>> can record the activity of an entire drive graph by putting the bit=
map
>>>>> on the root-most node we can get a hold of and assuming that all wr=
ites
>>>>> are going to go through us.
>>>>
>>>> Well, yeah, I know we do.  But I consider this counter-intuitive and=
 if
>>>> something is counter-intuitive it's often a bug.
>>>>
>>>>> Clearly this is increasingly false the more we modularise the block=
 graph.
>>>>>
>>>>>
>>>>> *uhm*
>>>>>
>>>>>
>>>>> I would say that a bitmap attached to a BlockBackend should behave =
in
>>>>> the way you say: writes to any children should change the bitmap he=
re.
>>>>>
>>>>> bitmaps attached to nodes shouldn't worry about such things.
>>>>
>>>> Do we have bitmaps attached to BlockBackends?  I sure hope not.
>>>>
>>>> We should not have any interface that requires the use of BlockBacke=
nds
>>>> by now.  If we do, that's something that has to be fixed.
>>>>
>>>> Max
>>>>
>>>
>>> I'm not sure what the right paradigm is anymore, then.
>>>
>>> A node is just a node, but something has to represent the "drive" as =
far
>>> as the device model sees it. I thought that *was* the BlockBackend, b=
ut
>>> is it not?
>>
>> Yes, and on the other side the BB represents the device model for the
>> block layer.  But the thing is that the user should be blissfully
>> unaware...  Or do you want to make bitmaps attachable to guest devices=

>> (through the QOM path or ID) instead?
>>
>=20
> OK, sure -- the user can specify a device model to attach it to instead=

> of a node. They don't have to be aware of the BB itself.
>=20
> The implementation though, I imagine it associates with that BB.

But that would be a whole new implementation...

>> (The block layer would then internally translate that to a BB.  But
>> that's a bad internal interface because the bitmap is still attached t=
o
>> a BDS, and it's a bad external interface because currently you can
>> attach bitmaps to nodes and only to nodes...)
>=20
> What if the type of bitmap we want to track trans-node changes was not
> attached to a BDS? That'd be one way to obviously discriminate between
> "This tracks tree-wide changes" and "This tracks node-local changes."

A new type of bitmap? :-/

> Implementation wise I don't have any actual thought as to how this coul=
d
> possibly be efficient. Maybe a bitmap reference at each BDS that is a
> child of that particular BB?
>=20
> On attach, the BDS gets a set-only reference to that bitmap.
> On detach, we remove the reference.
>=20
> Then, any writes anywhere in the tree will coagulate in one place. It
> may or may not be particularly true or correct, because a write down th=
e
> tree doesn't necessarily mean the visible data has changed at the top
> layer, but I don't think we have anything institutionally set in place
> to determine if we are changing visible data up-graph with a write
> down-graph.

Hmmm...  The first thing to clarify is whether we want two types of
bitmaps.  I don't think there is much use to node-local bitmaps, all
bitmaps should track every dirtying of their associated node (wherever
it comes from).

However, if that is too much of a performance penalty...  Then we
probably do have to distinguish between the two so that users only add
tree-wide bitmaps when they need them.

OTOH, I guess that in the common case it's not a performance penalty at
all, if done right.  Usually, a node you attach a bitmap to will not
have child nodes that are written to by other nodes.  So in the common
case your tree-wide bitmap is just a plain local bitmap and thus just as
efficient.

And if some child node is indeed written to by some other node...  I
think you always want a tree-wide bitmap anyway.

So I think all bitmaps should be tree-wide and the fact that they
currently are not is a bug.

Max


--u1NncPPOiR9kHPwFcwx1J4mXJwcsVnulH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlouusUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtusIAIWwVqLMjThGmM6OavpFHrr831snVpQY
V/wYmO6UvwpI/qtppkAGF4GQfo2IutWcyP8ZFNCFSmKa/rqqg/xz7Q+f10yv2JNw
OvFttW1FW5YKOoObwizZ34Zpoa/A5YCa2DuB8BhRvVanDZjEbwFCJExTaD1jWdVY
wHUPj7S0KWIk9TL/nb7tVM3wHtI4kEgu/NJntiIaZzfAyjT3zMDfhcN+qzBllQzr
6dkp/DVvfQWQUa02LncZR+TkYUj10uaktDpW8P3sPgZLEBsgcf1Mr/jTwnTcPFNi
NAJUcTVZTp2Wc5mcqkCjMva1XqdXgAmoYh/CL9QHrPAu/MmWVtfSB1M=
=iDYa
-----END PGP SIGNATURE-----

--u1NncPPOiR9kHPwFcwx1J4mXJwcsVnulH--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eOQz8-00029I-Mr
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eOQz7-0000fc-Ib
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:31:18 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
	<a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
	<a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
	<6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
	<115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
	<5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <09cebfbf-e95c-8f09-5a0a-9345e1e1804d@redhat.com>
Date: Mon, 11 Dec 2017 17:31:01 +0100
MIME-Version: 1.0
In-Reply-To: <5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wNFCm33xWeGfiBXmG7bAX0hQ6Ej1xQjEM"
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
--wNFCm33xWeGfiBXmG7bAX0hQ6Ej1xQjEM
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com
Message-ID: <09cebfbf-e95c-8f09-5a0a-9345e1e1804d@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
 <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
 <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
 <a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
 <6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
 <115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
 <5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
In-Reply-To: <5f704858-1983-f1bb-2281-f12f43c5f2b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-08 18:09, John Snow wrote:
>=20
>=20
> On 12/08/2017 09:30 AM, Max Reitz wrote:
>> On 2017-12-05 01:48, John Snow wrote:
>>>
>>>
>>> On 12/04/2017 05:21 PM, Max Reitz wrote:
>>>> On 2017-12-04 23:15, John Snow wrote:
>>>>>
>>>>>
>>>>> On 12/01/2017 02:41 PM, Max Reitz wrote:
>>>>>> ((By the way, I don't suppose that's how it should work...  But I =
don't
>>>>>> suppose that we want propagation of dirtying towards the BDS roots=
, do
>>>>>> we? :-/))
>>>>>
>>>>> I have never really satisfactorily explained to myself what bitmaps=
 on
>>>>> intermediate notes truly represent or mean.
>>>>>
>>>>> The simple case is "This layer itself serviced a write request."
>>>>>
>>>>> If that information is not necessarily meaningful, I'm not sure tha=
t's a
>>>>> problem except in configuration.
>>>>>
>>>>>
>>>>> ...Now, if you wanted to talk about bitmaps that associate with a
>>>>> Backend instead of a Node...
>>>>
>>>> But it's not about bitmaps on intermediate nodes, quite the opposite=
=2E
>>>> It's about bitmaps on roots but write requests happening on intermed=
iate
>>>> nodes.
>>>>
>>>
>>> Oh, I see what you're saying. It magically doesn't really change my
>>> opinion, by coincidence!
>>>
>>>> Say you have a node I and two filter nodes A and B using it (and the=
y
>>>> are OK with shared writers).  There is a dirty bitmap on A.
>>>>
>>>> Now when a write request goes through B, I will obviously have chang=
ed,
>>>> and because A and B are filters, so will A.  But the dirty bitmap on=
 A
>>>> will still be clean.
>>>>
>>>> My example was that when you run a mirror over A, you won't see dirt=
ying
>>>> from B.  So you can't e.g. add a throttle driver between a mirror jo=
b
>>>> and the node you want to mirror, because the dirty bitmap on the
>>>> throttle driver will not be affected by accesses to the actual node.=

>>>>
>>>> Max
>>>>
>>>
>>> Well, in this case I would say that a root BDS is not really any
>>> different from an intermediate one and can't really know what's going=
 on
>>> in the world outside.
>>>
>>> At least, I think that's how we model it right now -- we pretend that=
 we
>>> can record the activity of an entire drive graph by putting the bitma=
p
>>> on the root-most node we can get a hold of and assuming that all writ=
es
>>> are going to go through us.
>>
>> Well, yeah, I know we do.  But I consider this counter-intuitive and i=
f
>> something is counter-intuitive it's often a bug.
>>
>>> Clearly this is increasingly false the more we modularise the block g=
raph.
>>>
>>>
>>> *uhm*
>>>
>>>
>>> I would say that a bitmap attached to a BlockBackend should behave in=

>>> the way you say: writes to any children should change the bitmap here=
=2E
>>>
>>> bitmaps attached to nodes shouldn't worry about such things.
>>
>> Do we have bitmaps attached to BlockBackends?  I sure hope not.
>>
>> We should not have any interface that requires the use of BlockBackend=
s
>> by now.  If we do, that's something that has to be fixed.
>>
>> Max
>>
>=20
> I'm not sure what the right paradigm is anymore, then.
>=20
> A node is just a node, but something has to represent the "drive" as fa=
r
> as the device model sees it. I thought that *was* the BlockBackend, but=

> is it not?

Yes, and on the other side the BB represents the device model for the
block layer.  But the thing is that the user should be blissfully
unaware...  Or do you want to make bitmaps attachable to guest devices
(through the QOM path or ID) instead?

(The block layer would then internally translate that to a BB.  But
that's a bad internal interface because the bitmap is still attached to
a BDS, and it's a bad external interface because currently you can
attach bitmaps to nodes and only to nodes...)

Max


--wNFCm33xWeGfiBXmG7bAX0hQ6Ej1xQjEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloussUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFgYH/0Q5X+iM/rWq3mqASbEtQKLzImS9Nf6j
YLJM1xHroMc+NNSRQYnJkg1xJ7HMJ3ePbjpzSUYkyVrCIwq99WECbgLuKtVFJPMO
V+y4NWJY9IpNbX5HWfAcvp+++FAmIpR4nWWkK/1otDszu7h2JVJ0uoxRqQhUdHeY
ODrjYJOi0SZuRzMhmcwPaux+vUusDroSQ5IUp7c3PaMeZ0bpME3cAZXwTXnyeJeA
+KgQlOBK/pHCc+3psaiQj6WpzMRzwrQADUJw/q7zEC70HZG82G3v+r+y3tlAxtdn
ROrnGuRQ43yMKoJS/znD3SlJW7iQ4P+evWyZ4IFHLJgP8sKSyHRCzKY=
=g4ub
-----END PGP SIGNATURE-----

--wNFCm33xWeGfiBXmG7bAX0hQ6Ej1xQjEM--

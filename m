Received: from eggs.gnu.org ([2001:4830:134:3::10]:48709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frnl9-0005Ov-J3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frnl4-0001jJ-LG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:14:31 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
	<8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
	<7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
	<c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
	<cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
	<37d9972a-77c5-647f-c103-b40281744a40@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1c1b2056-19d6-843d-619d-0208b837970b@redhat.com>
Date: Mon, 20 Aug 2018 19:13:59 +0200
MIME-Version: 1.0
In-Reply-To: <37d9972a-77c5-647f-c103-b40281744a40@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dw1ePkI33W8see70rpno6STNOoPLgvQbY"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dw1ePkI33W8see70rpno6STNOoPLgvQbY
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <1c1b2056-19d6-843d-619d-0208b837970b@redhat.com>
Subject: Re: [PATCH v2 1/3] qapi: add x-query-block-graph
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
 <20180817180440.49687-1-vsementsov@virtuozzo.com>
 <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
 <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
 <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
 <7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
 <c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
 <cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
 <37d9972a-77c5-647f-c103-b40281744a40@virtuozzo.com>
In-Reply-To: <37d9972a-77c5-647f-c103-b40281744a40@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 19:04, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2018 19:35, Max Reitz wrote:
>> On 2018-08-20 17:13, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.08.2018 16:44, Max Reitz wrote:
>>>> On 2018-08-20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>> [...]
>>
>>>>> My goal is to get graphviz representation of block graph with all t=
he
>>>>> parents for debugging. And I'm absolutely ok to do it with x-debug-=
=2E
>>>>> Then we shouldn't care about enum for role type now. So, it the
>>>>> patch ok
>>>>> for you with x-debug- prefix?
>>>> Actually, no, because I'm not sure whether using points for the IDs
>>>> is a
>>>> good idea.=C2=A0 That may defeat ASLR, and that would be a problem e=
ven with
>>>> x-debug-.
>>> Good point, agree.
>>>
>>>> So I'd prefer using e.g. a hash map to map pointers to freshly
>>>> generated
>>>> IDs (just incrementing integers).
>> (By the way, that would also improve the speed of checking whether a
>> certain node needs to be added to the @nodes list still.)
>>
>>>> In any case, I'll take a further look at the patch later, but anothe=
r
>>>> thing that I've just seen is that using the opaque pointers to ident=
ify
>>>> a parent is something that doesn't look like it's guaranteed to work=
=2E
>>> Hm, isn't it a bug? Can you point to an example?
>> Ah, no, it's OK.=C2=A0 Well, kind of.=C2=A0 It's OK in the sense that =
it is unique
>> when set.=C2=A0 I didn't notice that you only use it for the non-node
>> parents, sorry.
>=20
> hm, no, I use opaque for all. So, it can be zero? In what case? In this=

> case, I cant get its parent?

As far as I can see, you only use it for BLOCK_GRAPH_NODE_TYPE_OTHER,
and you only do it when the parent is indeed not a BDS (because BDS are
always children of some sort, so they'll be automatically accounted for
anyway).

Ah, but you set edge->parent =3D (uint64_t)child->opaque.  I see, because=

you assume it's always going to point to the BDS.

Yeah, generally, you can't get the parent.  That's the whole point.  I
suppose in practice your code works, but that's not how it's supposed to
be.  You generally cannot go from child to parent, only through the
interface defined through BdrvChildRole (which uses the opaque pointer).

As I said, a safe way to do this would be to enumerate all possible
block graph roots; those being (as far as I know) all BlockBackends and
all monitor-owned BDSs (see bdrv_close_all(), which handles exactly
those two cases).  Then you can walk down from the roots through the tree=
s.

>> Still, it probably would be better to just use the BdrvChild object, a=
s
>> that should be unique as well, and it is obviously non-NULL.
>> (BdrvChild.opaque may be NULL, even though it isn't in practice.)
>=20
> but BdrvChild corresponds to edge in a graph, not to the node. I need
> identificators for nodes..

But an edge identifies two nodes.  All edges have at least one BDS on
one end.

Since you can identify all BDS through the BDS itself, if you have a
non-BDS node, you can use the edge to identify it (because the other end
of the edge is going to be a BDS which you can identify by itself).

Or, well, if you take my suggestion and walk down the trees starting at
the roots, you'll see that the only non-BDS nodes in the block graph are
BlockBackends.  And you can just use their addresses to identify them
(just internally, of course; externally you'll still want to generate a
new ID).

Max


--dw1ePkI33W8see70rpno6STNOoPLgvQbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt69tcACgkQ9AfbAGHV
z0As7Qf/T2/BwW2XRQ6B4TLwznMmTY1vRWIxBqP36AFKLtLwjZzAd/t7fGvEYbzq
+kKIgKLIWTJzNTv7YYwycIGSABANLVhPeLZKfC5lkvPk3adm7gx8D6geCww9P/2b
58Hu6kxXjgcZYOmGkv7lam1ebLFc8U6ZkE/KNVHuG7q41BenQe3xKooae85IXgH0
06N619msF6I8iffXmpn+H4rEPZD0GPp+Pug7Kjf0nQb6bLfSfv/PdgXKs4jaz/yk
voTNs0T1cvveI9yvMFONvuH+57mzbeWiyJyf+yTpigOdxLOzaMJoZzuMayCQbNG4
phizg2KI2gxSiZparS10ysI3Z5mGNg==
=Dsqb
-----END PGP SIGNATURE-----

--dw1ePkI33W8see70rpno6STNOoPLgvQbY--

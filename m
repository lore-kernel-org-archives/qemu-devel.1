Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsOa8-00052b-Oa
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsOa6-0006bl-ND
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:33:36 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
	<8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
	<7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
	<aa17dfe6-3ed8-6bff-cb5e-9421dd7d608a@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c45ec13e-3df0-b6c3-bf74-a726434fe115@redhat.com>
Date: Wed, 22 Aug 2018 10:33:04 +0200
MIME-Version: 1.0
In-Reply-To: <aa17dfe6-3ed8-6bff-cb5e-9421dd7d608a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="92BkcfODNsu2MjvXYTUVEBvqMxUb1SmaD"
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
--92BkcfODNsu2MjvXYTUVEBvqMxUb1SmaD
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <c45ec13e-3df0-b6c3-bf74-a726434fe115@redhat.com>
Subject: Re: [PATCH v2 1/3] qapi: add x-query-block-graph
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
 <20180817180440.49687-1-vsementsov@virtuozzo.com>
 <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
 <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
 <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
 <7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
 <aa17dfe6-3ed8-6bff-cb5e-9421dd7d608a@virtuozzo.com>
In-Reply-To: <aa17dfe6-3ed8-6bff-cb5e-9421dd7d608a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 20:38, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2018 16:44, Max Reitz wrote:
>> On 2018-08-20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>> 18.08.2018 00:03, Max Reitz wrote:
>>>> On 2018-08-17 22:32, Eric Blake wrote:
>>>>> On 08/17/2018 01:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Add a new command, returning block nodes graph.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy
>>>>>> <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0=C2=A0 qapi/block-core.json=C2=A0 | 116
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>> +##
>>>>>> +# @BlockGraphEdge:
>>>>>> +#
>>>>>> +# Block Graph edge description for x-query-block-graph.
>>>>>> +#
>>>>>> +# @parent: parent id
>>>>>> +#
>>>>>> +# @child: child id
>>>>>> +#
>>>>>> +# @name: name of the relation (examples are 'file' and 'backing')=

>>>>> Can this be made into a QAPI enum? (It would have ripple effects to=

>>>>> existing code, but might be a worthwhile cleanup).
>>>>>
>>>>>> +#
>>>>>> +# @perm: granted permissions for the parent operating on the chil=
d
>>>>>> +#
>>>>>> +# @shared-perm: permissions that can still be granted to other us=
ers
>>>>>> of the
>>>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 child while it is still attached this parent
>>>>>> +#
>>>>>> +# Since: 3.1
>>>>>> +##
>>>>>> +{ 'struct': 'BlockGraphEdge',
>>>>>> +=C2=A0 'data': { 'parent': 'uint64', 'child': 'uint64',
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'name': 'str', 'perm': [ 'BlockPermission' ],
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'shared-perm': [ 'BlockPermission' ] } }
>>>>>> +
>>>>>> +##
>>>>>> +# @x-query-block-graph:
>>>>>> +#
>>>>>> +# Get the block graph.
>>>>>> +#
>>>>>> +# Since: 3.1
>>>>>> +##
>>>>>> +{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }
>>>>> Why is this command given an x- prefix?=C2=A0 What would it take to=
 promote
>>>>> it from experimental to fully supported?
>>>> This is just a very bad reasons, but I'll give it anyway: We really
>>>> want
>>>> such a command but still don't have one.=C2=A0 So I doubt this is ex=
actly
>>>> what we want. :-)
>>>>
>>>> A better reason is that we probably do not want a single command to
>>>> return the whole block graph.=C2=A0 Do we want the command to just r=
eturn
>>>> info for a single node, including just the node names of the childre=
n?
>>>> Do we want the command to include child info on request (but start f=
rom
>>>> a user-specified root)?
>>>>
>>>> Also, the interface is...=C2=A0 Er, weird?=C2=A0 Honestly, I don't q=
uite see why
>>>> we would want it like this without x-.
>>>>
>>>> Why use newly generated IDs instead of node names?=C2=A0 Why are tho=
se RAM
>>>> addresses?=C2=A0 That is just so fishy.
>>>>
>>>> Because parents can be non-nodes?=C2=A0 Well, I suppose you better n=
ot
>>>> include them in the graph like this, then.
>>>>
>>>> I don't see why the query command we want would include non-BDSs at
>>>> all.
>>>>
>>>> It may be useful for debugging, so, er, well, with an x-debug- prefi=
x,
>>>> OK.=C2=A0 But the question then is whether it's useful enough to war=
rant
>>>> having a separate query command that isn't precisely the command we
>>>> want
>>>> anyway.
>>>
>>>> The first question we probably have to ask is whether the query comm=
and
>>>> needs to output parent information.=C2=A0 If not, querying would pro=
bably
>>>> start at some named node and then you'd go down from there (either w=
ith
>>>> many queries or through a single one).
>>>>
>>>> If so, well, then we can still output parent information, but I'd sa=
y
>>>> that then is purely informational and we don't need to "generate" ne=
w
>>>> IDs for them.=C2=A0 Just have either a node-name there or a user-rea=
dable
>>>> description (like it was in v1; although it has to be noted that suc=
h a
>>>> user-readable description is useless to a management layer), but the=
se
>>>> new IDs are really not something I like.
>>>>
>>>>> Overall, the command looks quite useful; and the fact that you
>>>>> produced
>>>>> some nice .dot graphs from it for visualization seems like it is wo=
rth
>>>>> considering this as a permanent API addition.=C2=A0 The question, t=
hen,
>>>>> is if
>>>>> the interface is right, or if it needs any tweaks (like using an en=
um
>>>>> instead of open-coded string for the relation between parent and
>>>>> child),
>>>>> as a reason for keeping the x- prefix.
>>>> You can use x-debug- even when you decide to keep a command.
>>>>
>>>> I see no reason why a command should hastily not get an x- prefix ju=
st
>>>> because it may be useful enough.=C2=A0 If it really is and we really=
 see the
>>>> interface is good (which I really don't think it is), then we can
>>>> always
>>>> drop it later.
>>>>
>>>> Max
>>>>
>>>>>> +++ b/block.c
>>>>>> @@ -4003,6 +4003,86 @@ BlockDeviceInfoList
>>>>>> *bdrv_named_nodes_list(Error **errp)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return list;
>>>>>> =C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0 +#define QAPI_LIST_ADD(list, element) do { \
>>>>>> +=C2=A0=C2=A0=C2=A0 typeof(list) _tmp =3D g_new(typeof(*(list)), 1=
); \
>>>>>> +=C2=A0=C2=A0=C2=A0 _tmp->value =3D (element); \
>>>>>> +=C2=A0=C2=A0=C2=A0 _tmp->next =3D (list); \
>>>>>> +=C2=A0=C2=A0=C2=A0 list =3D _tmp; \
>>>>>> +} while (0)
>>>>> Hmm - this seems like a frequently observed pattern - should it be
>>>>> something that we add independently and use throughout the tree as
>>>>> part
>>>>> of QAPI interactions in general?
>>>>>
>>>>>> +
>>>>>> +BlockGraph *bdrv_get_block_graph(Error **errp)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 BlockGraph *graph =3D g_new0(BlockGraph, 1);
>>>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>>>>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>>>>>> +=C2=A0=C2=A0=C2=A0 BlockGraphNode *node;
>>>>>> +=C2=A0=C2=A0=C2=A0 BlockGraphEdge *edge;
>>>>>> +=C2=A0=C2=A0=C2=A0 struct {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int flag;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockPermission num;
>>>>>> +=C2=A0=C2=A0=C2=A0 } permissions[] =3D {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_CONSISTENT_=
READ,
>>>>>> BLOCK_PERMISSION_CONSISTENT_READ },
>>>>> Would it be worth directly reusing a QAPI enum for all such
>>>>> permissions
>>>>> in the existing code base, instead of having to map between an
>>>>> internal
>>>>> and a QAPI enum?
>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_W=
RITE },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE_UNCHA=
NGED,
>>>>>> BLOCK_PERMISSION_WRITE_UNCHANGED },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_RESIZE,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_RESIZE =
},
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_GRAPH_MOD,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_GRAPH_MOD },
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0 }
>>>>>> +=C2=A0=C2=A0=C2=A0 }, *p;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(bs, &graph_bdrv_states, node_li=
st) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &=
bs->parents, next_parent) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (!child->role->parent_is_bds) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BlockGraphNodeList *el;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bool add =3D true;
>>>>> Does your command need/want to expose internal nodes? (I argue that=
 it
>>>>> probably should show internal nodes, even when normal 'query-block'=

>>>>> doesn't, just because knowing about the impact of internal nodes
>>>>> can be
>>>>> important when tracking down permissions issues).
>>>> You could make it a flag, but in theory, implicit nodes should never=
 be
>>>> visible through QMP.=C2=A0 (Though if you explicitly request them, t=
hat's
>>>> probably a different story.)
>>>>
>>>> Max
>>>>
>>> My goal is to get graphviz representation of block graph with all the=

>>> parents for debugging. And I'm absolutely ok to do it with x-debug-.
>>> Then we shouldn't care about enum for role type now. So, it the patch=
 ok
>>> for you with x-debug- prefix?
>> Actually, no, because I'm not sure whether using points for the IDs is=
 a
>> good idea.=C2=A0 That may defeat ASLR, and that would be a problem eve=
n with
>> x-debug-.
>=20
> Hmm ASLR, what about trace points? Do they violate it? We can enable
> trace-points on running vm and they'll show a lot of pointers...

Good question, but at least you can disable it during configure.  If
query-block-graph is disabled by default and needs to be enabled
explicitly, I guess that'd be OK.

Another benefit of using a hash map though would be that you don't need
to loop through the array of existing nodes to find out which you have
added already -- a lookup in the hash map would be enough.

Max

>> So I'd prefer using e.g. a hash map to map pointers to freshly generat=
ed
>> IDs (just incrementing integers).
>>
>> In any case, I'll take a further look at the patch later, but another
>> thing that I've just seen is that using the opaque pointers to identif=
y
>> a parent is something that doesn't look like it's guaranteed to work.
>>
>> I suppose the alternative would be to start from all possible roots an=
d
>> generate the graph from there (all possible roots being all
>> monitor-owned BDSs and all BlockBackends, I think).
>>
>> Max
>>
>=20
>=20



--92BkcfODNsu2MjvXYTUVEBvqMxUb1SmaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9H8AACgkQ9AfbAGHV
z0BdQAgAwQUqcO53IxCmzcuDQY0BM3LJIUXww6YUqbN/OiFoIITnLjRyl0RBEPMH
hjwgUJcizPomaGuaB989zAn1Xob5Y9GL3hKDpR1LpMxhqnUa64gUBL3/tXpW4VKe
RjHaSr/CmBTmYx8Vv/rC4M4oIpoDRWBbD+BKe7DhXLpEa5ENVz4Jjg9bKYun04Or
3EVF32MXmofRa8SiPoN7AhQLBIxkiKhPmWlnJyRNfucDgv/EskyjoUFfOG3bINlr
Z16UfHdd4AhAnO78r0w/vfu4kz4w6qhM+Pp5av+FSQ8E3/v019zBaVLLoPuDMv5H
rmCgdOBfxuUHBhYiLuzghR/d5DqKOQ==
=Norb
-----END PGP SIGNATURE-----

--92BkcfODNsu2MjvXYTUVEBvqMxUb1SmaD--

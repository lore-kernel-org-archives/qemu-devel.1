Received: from eggs.gnu.org ([2001:4830:134:3::10]:35013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frkUD-0002JO-W2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frkUC-0000dN-1s
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:44:49 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
	<8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
Date: Mon, 20 Aug 2018 15:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CpJzyzonNcXANX24cSI3TE8JSijLXK7wO"
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
--CpJzyzonNcXANX24cSI3TE8JSijLXK7wO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
Subject: Re: [PATCH v2 1/3] qapi: add x-query-block-graph
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
 <20180817180440.49687-1-vsementsov@virtuozzo.com>
 <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
 <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
 <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
In-Reply-To: <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 12:20, Vladimir Sementsov-Ogievskiy wrote:
> 18.08.2018 00:03, Max Reitz wrote:
>> On 2018-08-17 22:32, Eric Blake wrote:
>>> On 08/17/2018 01:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add a new command, returning block nodes graph.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>> =C2=A0=C2=A0 qapi/block-core.json=C2=A0 | 116
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>> +##
>>>> +# @BlockGraphEdge:
>>>> +#
>>>> +# Block Graph edge description for x-query-block-graph.
>>>> +#
>>>> +# @parent: parent id
>>>> +#
>>>> +# @child: child id
>>>> +#
>>>> +# @name: name of the relation (examples are 'file' and 'backing')
>>> Can this be made into a QAPI enum? (It would have ripple effects to
>>> existing code, but might be a worthwhile cleanup).
>>>
>>>> +#
>>>> +# @perm: granted permissions for the parent operating on the child
>>>> +#
>>>> +# @shared-perm: permissions that can still be granted to other user=
s
>>>> of the
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 child while it is still attached this parent
>>>> +#
>>>> +# Since: 3.1
>>>> +##
>>>> +{ 'struct': 'BlockGraphEdge',
>>>> +=C2=A0 'data': { 'parent': 'uint64', 'child': 'uint64',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'name': 'str', 'perm': [ 'BlockPermission' ],
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'shared-perm': [ 'BlockPermission' ] } }
>>>> +
>>>> +##
>>>> +# @x-query-block-graph:
>>>> +#
>>>> +# Get the block graph.
>>>> +#
>>>> +# Since: 3.1
>>>> +##
>>>> +{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }
>>> Why is this command given an x- prefix?=C2=A0 What would it take to p=
romote
>>> it from experimental to fully supported?
>> This is just a very bad reasons, but I'll give it anyway: We really wa=
nt
>> such a command but still don't have one.=C2=A0 So I doubt this is exac=
tly
>> what we want. :-)
>>
>> A better reason is that we probably do not want a single command to
>> return the whole block graph.=C2=A0 Do we want the command to just ret=
urn
>> info for a single node, including just the node names of the children?=

>> Do we want the command to include child info on request (but start fro=
m
>> a user-specified root)?
>>
>> Also, the interface is...=C2=A0 Er, weird?=C2=A0 Honestly, I don't qui=
te see why
>> we would want it like this without x-.
>>
>> Why use newly generated IDs instead of node names?=C2=A0 Why are those=
 RAM
>> addresses?=C2=A0 That is just so fishy.
>>
>> Because parents can be non-nodes?=C2=A0 Well, I suppose you better not=

>> include them in the graph like this, then.
>>
>> I don't see why the query command we want would include non-BDSs at al=
l.
>>
>> It may be useful for debugging, so, er, well, with an x-debug- prefix,=

>> OK.=C2=A0 But the question then is whether it's useful enough to warra=
nt
>> having a separate query command that isn't precisely the command we wa=
nt
>> anyway.
>=20
>=20
>>
>> The first question we probably have to ask is whether the query comman=
d
>> needs to output parent information.=C2=A0 If not, querying would proba=
bly
>> start at some named node and then you'd go down from there (either wit=
h
>> many queries or through a single one).
>>
>> If so, well, then we can still output parent information, but I'd say
>> that then is purely informational and we don't need to "generate" new
>> IDs for them.=C2=A0 Just have either a node-name there or a user-reada=
ble
>> description (like it was in v1; although it has to be noted that such =
a
>> user-readable description is useless to a management layer), but these=

>> new IDs are really not something I like.
>>
>>> Overall, the command looks quite useful; and the fact that you produc=
ed
>>> some nice .dot graphs from it for visualization seems like it is wort=
h
>>> considering this as a permanent API addition.=C2=A0 The question, the=
n, is if
>>> the interface is right, or if it needs any tweaks (like using an enum=

>>> instead of open-coded string for the relation between parent and chil=
d),
>>> as a reason for keeping the x- prefix.
>> You can use x-debug- even when you decide to keep a command.
>>
>> I see no reason why a command should hastily not get an x- prefix just=

>> because it may be useful enough.=C2=A0 If it really is and we really s=
ee the
>> interface is good (which I really don't think it is), then we can alwa=
ys
>> drop it later.
>>
>> Max
>>
>>>> +++ b/block.c
>>>> @@ -4003,6 +4003,86 @@ BlockDeviceInfoList
>>>> *bdrv_named_nodes_list(Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return list;
>>>> =C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 +#define QAPI_LIST_ADD(list, element) do { \
>>>> +=C2=A0=C2=A0=C2=A0 typeof(list) _tmp =3D g_new(typeof(*(list)), 1);=
 \
>>>> +=C2=A0=C2=A0=C2=A0 _tmp->value =3D (element); \
>>>> +=C2=A0=C2=A0=C2=A0 _tmp->next =3D (list); \
>>>> +=C2=A0=C2=A0=C2=A0 list =3D _tmp; \
>>>> +} while (0)
>>> Hmm - this seems like a frequently observed pattern - should it be
>>> something that we add independently and use throughout the tree as pa=
rt
>>> of QAPI interactions in general?
>>>
>>>> +
>>>> +BlockGraph *bdrv_get_block_graph(Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 BlockGraph *graph =3D g_new0(BlockGraph, 1);
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>>>> +=C2=A0=C2=A0=C2=A0 BlockGraphNode *node;
>>>> +=C2=A0=C2=A0=C2=A0 BlockGraphEdge *edge;
>>>> +=C2=A0=C2=A0=C2=A0 struct {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int flag;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockPermission num;
>>>> +=C2=A0=C2=A0=C2=A0 } permissions[] =3D {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_CONSISTENT_RE=
AD,
>>>> BLOCK_PERMISSION_CONSISTENT_READ },
>>> Would it be worth directly reusing a QAPI enum for all such permissio=
ns
>>> in the existing code base, instead of having to map between an intern=
al
>>> and a QAPI enum?
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_WRIT=
E },
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE_UNCHANG=
ED,
>>>> BLOCK_PERMISSION_WRITE_UNCHANGED },
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_RESIZE,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_RESIZE =
},
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_GRAPH_MOD,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_GRAPH_MOD },
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0 }
>>>> +=C2=A0=C2=A0=C2=A0 }, *p;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list=
) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &bs=
->parents, next_parent) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!child->role->parent_is_bds) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BlockGraphNodeList *el;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool add =3D true;
>>> Does your command need/want to expose internal nodes? (I argue that i=
t
>>> probably should show internal nodes, even when normal 'query-block'
>>> doesn't, just because knowing about the impact of internal nodes can =
be
>>> important when tracking down permissions issues).
>> You could make it a flag, but in theory, implicit nodes should never b=
e
>> visible through QMP.=C2=A0 (Though if you explicitly request them, tha=
t's
>> probably a different story.)
>>
>> Max
>>
>=20
> My goal is to get graphviz representation of block graph with all the
> parents for debugging. And I'm absolutely ok to do it with x-debug-.
> Then we shouldn't care about enum for role type now. So, it the patch o=
k
> for you with x-debug- prefix?

Actually, no, because I'm not sure whether using points for the IDs is a
good idea.  That may defeat ASLR, and that would be a problem even with
x-debug-.

So I'd prefer using e.g. a hash map to map pointers to freshly generated
IDs (just incrementing integers).

In any case, I'll take a further look at the patch later, but another
thing that I've just seen is that using the opaque pointers to identify
a parent is something that doesn't look like it's guaranteed to work.

I suppose the alternative would be to start from all possible roots and
generate the graph from there (all possible roots being all
monitor-owned BDSs and all BlockBackends, I think).

Max


--CpJzyzonNcXANX24cSI3TE8JSijLXK7wO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt6xbwACgkQ9AfbAGHV
z0CnTwgAqtaH5l1TZuXZPfL8JbjMW6Vs5v5fMDgJnu2qglrC5aSnGu2jlpb0EvNY
EaWQal+AbIoIbTFAA9dtZmc9Ph0NsqJqboeL1FWepkiC8tICgve893elIG93R8eL
CPVEYk+9NWFIlEgcWAtoAils8Yj+pU7iKqs2yUI49QsbzOaTxfCz8Tc6Q9UIc+3R
RdzSKhQVXw4mng7HoFi7YIdxIcwj3Hg7gv7mpCjFdh6QDqnnZJAA6bDHgfoRKm7O
sFbA8IA5j1zfk70zdTexerc4g074v83vtNyMrJ8fBqUNIJ9GITjNFecgHpkTdL0Y
w5yM2FXg+TQtgsD4F6Or4Qwat41sOQ==
=HSyz
-----END PGP SIGNATURE-----

--CpJzyzonNcXANX24cSI3TE8JSijLXK7wO--

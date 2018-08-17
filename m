Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqluc-0003Ui-EQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 17:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqluV-0003iG-F8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 17:04:02 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
Date: Fri, 17 Aug 2018 23:03:05 +0200
MIME-Version: 1.0
In-Reply-To: <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i7pdFupnpzhAU1CECbtg7uyofS20zo8bX"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i7pdFupnpzhAU1CECbtg7uyofS20zo8bX
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
Subject: Re: [PATCH v2 1/3] qapi: add x-query-block-graph
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
 <20180817180440.49687-1-vsementsov@virtuozzo.com>
 <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
In-Reply-To: <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 22:32, Eric Blake wrote:
> On 08/17/2018 01:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Add a new command, returning block nodes graph.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>> =C2=A0 qapi/block-core.json=C2=A0 | 116
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>=20
>> +##
>> +# @BlockGraphEdge:
>> +#
>> +# Block Graph edge description for x-query-block-graph.
>> +#
>> +# @parent: parent id
>> +#
>> +# @child: child id
>> +#
>> +# @name: name of the relation (examples are 'file' and 'backing')
>=20
> Can this be made into a QAPI enum? (It would have ripple effects to
> existing code, but might be a worthwhile cleanup).
>=20
>> +#
>> +# @perm: granted permissions for the parent operating on the child
>> +#
>> +# @shared-perm: permissions that can still be granted to other users
>> of the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 child while it is still attached this parent
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'struct': 'BlockGraphEdge',
>> +=C2=A0 'data': { 'parent': 'uint64', 'child': 'uint64',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'n=
ame': 'str', 'perm': [ 'BlockPermission' ],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 's=
hared-perm': [ 'BlockPermission' ] } }
>> +
>=20
>> +##
>> +# @x-query-block-graph:
>> +#
>> +# Get the block graph.
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }
>=20
> Why is this command given an x- prefix?=C2=A0 What would it take to pro=
mote
> it from experimental to fully supported?

This is just a very bad reasons, but I'll give it anyway: We really want
such a command but still don't have one.  So I doubt this is exactly
what we want. :-)

A better reason is that we probably do not want a single command to
return the whole block graph.  Do we want the command to just return
info for a single node, including just the node names of the children?
Do we want the command to include child info on request (but start from
a user-specified root)?

Also, the interface is...  Er, weird?  Honestly, I don't quite see why
we would want it like this without x-.

Why use newly generated IDs instead of node names?  Why are those RAM
addresses?  That is just so fishy.

Because parents can be non-nodes?  Well, I suppose you better not
include them in the graph like this, then.

I don't see why the query command we want would include non-BDSs at all.

It may be useful for debugging, so, er, well, with an x-debug- prefix,
OK.  But the question then is whether it's useful enough to warrant
having a separate query command that isn't precisely the command we want
anyway.

The first question we probably have to ask is whether the query command
needs to output parent information.  If not, querying would probably
start at some named node and then you'd go down from there (either with
many queries or through a single one).

If so, well, then we can still output parent information, but I'd say
that then is purely informational and we don't need to "generate" new
IDs for them.  Just have either a node-name there or a user-readable
description (like it was in v1; although it has to be noted that such a
user-readable description is useless to a management layer), but these
new IDs are really not something I like.

> Overall, the command looks quite useful; and the fact that you produced=

> some nice .dot graphs from it for visualization seems like it is worth
> considering this as a permanent API addition.=C2=A0 The question, then,=
 is if
> the interface is right, or if it needs any tweaks (like using an enum
> instead of open-coded string for the relation between parent and child)=
,
> as a reason for keeping the x- prefix.

You can use x-debug- even when you decide to keep a command.

I see no reason why a command should hastily not get an x- prefix just
because it may be useful enough.  If it really is and we really see the
interface is good (which I really don't think it is), then we can always
drop it later.

Max

>> +++ b/block.c
>> @@ -4003,6 +4003,86 @@ BlockDeviceInfoList
>> *bdrv_named_nodes_list(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return list;
>> =C2=A0 }
>> =C2=A0 +#define QAPI_LIST_ADD(list, element) do { \
>> +=C2=A0=C2=A0=C2=A0 typeof(list) _tmp =3D g_new(typeof(*(list)), 1); \=

>> +=C2=A0=C2=A0=C2=A0 _tmp->value =3D (element); \
>> +=C2=A0=C2=A0=C2=A0 _tmp->next =3D (list); \
>> +=C2=A0=C2=A0=C2=A0 list =3D _tmp; \
>> +} while (0)
>=20
> Hmm - this seems like a frequently observed pattern - should it be
> something that we add independently and use throughout the tree as part=

> of QAPI interactions in general?
>=20
>> +
>> +BlockGraph *bdrv_get_block_graph(Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BlockGraph *graph =3D g_new0(BlockGraph, 1);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>> +=C2=A0=C2=A0=C2=A0 BlockGraphNode *node;
>> +=C2=A0=C2=A0=C2=A0 BlockGraphEdge *edge;
>> +=C2=A0=C2=A0=C2=A0 struct {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int flag;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockPermission num;
>> +=C2=A0=C2=A0=C2=A0 } permissions[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_CONSISTENT_READ=
, BLOCK_PERMISSION_CONSISTENT_READ },
>=20
> Would it be worth directly reusing a QAPI enum for all such permissions=

> in the existing code base, instead of having to map between an internal=

> and a QAPI enum?
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_WRIT=
E },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE_UNCHANGED=
, BLOCK_PERMISSION_WRITE_UNCHANGED },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_RESIZE,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_RESIZE },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_GRAPH_MOD,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_GRAPH_MOD },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0 }
>> +=C2=A0=C2=A0=C2=A0 }, *p;
>> +
>> +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &bs->=
parents, next_parent) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!child->role->parent_is_bds) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BlockGraphNodeList *el;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool add =3D true;
>=20
> Does your command need/want to expose internal nodes? (I argue that it
> probably should show internal nodes, even when normal 'query-block'
> doesn't, just because knowing about the impact of internal nodes can be=

> important when tracking down permissions issues).

You could make it a flag, but in theory, implicit nodes should never be
visible through QMP.  (Though if you explicitly request them, that's
probably a different story.)

Max


--i7pdFupnpzhAU1CECbtg7uyofS20zo8bX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt3OAkACgkQ9AfbAGHV
z0CY4Af9HgCIFd03C4jKFM9bCyjYWjEzVsQuzRLBCtlkIi4dBLpQcjGqfB1PgrWo
XZeaoKICX0P0RKZPE32CDNPXXIEFjVNQjCvNfkBRqoYfh+kTxQ7wdQPXLmA1sZLE
QIOuBZmoxb32XDXG3YMdD0LFdUBma7vhi0+BFgowHWwI8d+EUS+rkd11jklnEepB
snF8gKjXNorRc1qp8JeVAW+WfjG3sAuVDCABiFZFeE+ffUOn6WbCeAgh61JKnH11
02TrtmJeIAJTR9YmmU1ZuuHgkM+5OH0Z1bvgxMbd8wrxGEb42nHx7LmcZMOnR5lM
OnvnEaeZtidSDryBGzsBlDeI9m5w4A==
=QGzN
-----END PGP SIGNATURE-----

--i7pdFupnpzhAU1CECbtg7uyofS20zo8bX--

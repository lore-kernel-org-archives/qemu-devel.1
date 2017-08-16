Received: from eggs.gnu.org ([2001:4830:134:3::10]:33192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhxBT-0000bo-NP
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhxBS-0005wX-QN
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:12:27 -0400
Date: Wed, 16 Aug 2017 15:11:38 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170816121138.jecvtc7ei3sgqomp@postretch>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<6ebebb61-1f5e-391b-03d7-cae2bee99a2f@redhat.com>
	<20170816094135.beufpqce3v4amhl3@postretch>
	<1d2871d5-e224-6bc7-ebc1-f791357371ce@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzkfbtzcjelpsn4g"
Content-Disposition: inline
In-Reply-To: <1d2871d5-e224-6bc7-ebc1-f791357371ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--lzkfbtzcjelpsn4g
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 06:59:25AM -0500, Eric Blake wrote:
>On 08/16/2017 04:41 AM, Manos Pitsidianakis wrote:
>
>>>> +##
>>>> +# @block-insert-node:
>>>> +#
>>>> +# Insert a filter node between a specific edge in the block driver
>>>> state graph.
>>>> +# @parent:  the name of the parent node or device
>>>> +# @node:    the name of the node to insert under parent
>>>> +# @child:   the name of the child of both node and parent
>>>
>>> Is this always going to be between two existing nodes, or can this
>>> command also be used to insert at the end of the chain (for example, if
>>> parent or child is omitted)?
>>
>> If this is used for filter nodes, I suppose only between would make
>> sense (for now). Is there a use case for the latter?
>
>Perhaps.
>
>Given a qcow2 image backing chain:
>
>base <- active
>
>there are four BDS (2 format, 2 protocol).  Ideally, I could add
>filtering to any one of those four nodes (a filter on the base protocol
>level restricts how much guest data can be used from the backing image,
>but with no limits on the qcow2 metadata; a filter on the base format
>level restricts metadata reads as well; similarly for filters on the
>active protocol and format layers).
>
>But adding a filter on 'active' at the format level has no pre-existing
>parent (I'm adding the filter as the new top-level).  Or am I missing
>something?

The parent in this case is the storage device (disk / cdrom), whose name=20
is specified as the parent. The first example in the=20
qapi/block-core.json is such a case. In code I check blk_by_name(parent)=20
and if that doesn't exist, I try with bdrv_find_node(parent).  Perhaps I=20
should reword the documentation or did I misunderstand what you wrote?

--lzkfbtzcjelpsn4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmUNnkACgkQc2J8L2kN
9xDbEg//buVBaJaXf3jEyOUY4FlrN5/wPoXhWcHTkHgAwScJU4GA28T7tFssb7MT
M4pkDZrZzeX4Xg7yIyu7oBfemaXDCxVAhoVZbEpnSRfTIFDNOuKU65NxbcMXaXss
goR/S4QaxaPLx1ArR9wHu2elhusQfTKmUYkJxQem587FtLvmBlmbGtBzCb5qXBZ0
ArPJt6ZQ8O+UkFpCrn8qUHElC8mTDCon/YaXHcvh1m5jE9xJ3cEx5I810YxQu1wj
05LVs73tBOmG1p/Nq0E4vGZaFws2Tbg8N0dqAW+JKDFocAceREdva42judaYxarP
lqa+pQe3cpcKyXPegc+IajQBGKKDLcnoRBC6smqILG5grtqcAp3bBxvUtNlaDTTw
dCl8BVQSIq/G3jCQe6MKpZQht/A2k9Ut/qkeQw/Q0i+mluaV6oY3FYuuEwAMC46A
ZYLRj2/+iYdV1mm6d6WqfeWwsI/3VkBZ3QHL4J6FzrwPmNndY//8MPrvLByOBCWa
PiPjLJ3AUwdMIJrVn/Q5kk5y1thUefGNpCdBTDg2muWN8BNXZyR7nig4lmiWe/AQ
8puTWNZIwwuNNIoNG5Tuu6zn9xO/6Juqu+fY5PK0RQ5LYTkGP+/ddRuX6htVBuTC
Lzyry1n93Qn7G13poG6vaL3qTelxjXx9Rn4qFkBtT9BgJgTT6Tc=
=3Tag
-----END PGP SIGNATURE-----

--lzkfbtzcjelpsn4g--

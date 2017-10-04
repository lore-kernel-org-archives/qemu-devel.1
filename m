Received: from eggs.gnu.org ([2001:4830:134:3::10]:39532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dzn6s-0004aO-HW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dzn6o-0005vP-NH
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:05:26 -0400
Date: Wed, 4 Oct 2017 20:05:01 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20171004170501.ttj7tayiqx2vvsjn@postretch>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
	<a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kz7btylpp3qbzmv5"
Content-Disposition: inline
In-Reply-To: <a646d860-5f33-19cb-e56a-893b57613533@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] block: add
 block-insert-node QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--kz7btylpp3qbzmv5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 02:49:27PM +0200, Max Reitz wrote:
>On 2017-08-15 09:45, Manos Pitsidianakis wrote:
>> block-insert-node and its pair command block-remove-node provide runtime
>> insertion and removal of filter nodes.
>>
>> block-insert-node takes a (parent, child) and (node, child) pair of
>> edges and unrefs the (parent, child) BdrvChild relationship and=20
>> creates
>> a new (parent, node) child with the same BdrvChildRole.
>>
>> This is a different approach than x-blockdev-change which uses the driver
>> methods bdrv_add_child() and bdrv_del_child(),
>
>Why? :-)
>
>Can't we reuse x-blockdev-change? As far as I'm concerned, this was one
>of its roles, and at least I don't want to have both x-blockdev-change
>and these new commands.
>
>I think it would be a good idea just to change bdrv_add_child() and
>bdrv_del_child(): If the driver has a bdrv_{add,del}_child() callback,
>invoke that.  If it doesn't, then just attach the child.
>
>Of course, it may turn out that x-blockdev-change is lacking something
>(e.g. a way to specify as what kind of child a new node is to be
>attached).  Then we should either extend it so that it covers what it's
>lacking, or replace it completely by these new commands.  In the latter
>case, however, they would need to cover the existing use case which is
>reconfiguring the quorum driver.  (And that would mean it would have to
>invoke bdrv_add_child()/bdrv_del_child() when the driver has them.)
>
>Max
>

I think the two use cases are this:

a) Adding/removing a replication child to an existing quorum node
b) Insert a filter between two existing nodes.

These are not directly compatible semantically, but as you said=20
x-blockdev-change can perform b) if bdrv_add_child()/bdrv_del_child()=20
are not implemented. Wouldn't that be unnecessary overloading?

--kz7btylpp3qbzmv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnVFL0ACgkQc2J8L2kN
9xCXpw/+I6uzdp7sIOdW01raGly9A6u25JZ9jkSE8N076y7ZvJiyhzSjmweXlJDp
E7YYVm+kojdM+ymmnnsWEebu/C4f+T9qd4D4EK12pz7fH7KDyu3ohjT8jkMexmvR
8OFg0dmrxG7m2l/3YbSrA/DD/0RbBprksCsoBPc7zquUD6x65aJAZmxHdwtCMhmk
MWvv5DW4adZ0PpLWeHyqNBcUPyEdV0tmgaie+xJiIOXrdisqfQmeNViherEy2Uj4
S+GJqcf6HPSO7skkzLLl66q7QqS6Qq1GqN/bbAHyIA9Ks5X/vBaDkcMTDtlgKyJ9
0XWEyD/EUkBvT7MLbYoqb3xoJI8TmgXJNVSIzELUuAHQuUrKTae+5XqslqhZmlHj
YwgWfqF0NnLzQMcv1SDHTB1cufkekaSbIv2UxiLkE6K40gCPevq5r4s3VCJfQJw2
STYtH76kVl8Cst0jX2QXONHXeTGR6j72IXmaxJFdiPblRGOQ20ijoRps536zv1hG
uq4XgAiuvPsd0Wa8V7TMRE+qusxssBsb+pIH4W+SkIHL0YQHBkHUINrdXLiIiB3J
LxUK7UW7vEbXuBTEbD6GDLdkTJNMyiNfW1r0C7ZgdOcH9wWhgOOMGoFxCIZWaSQE
9mXAUsM6HK1GDJRGdW7ZLoV8KgRCVIccXxn89crYvx+G9PiBIg0=
=Zkxf
-----END PGP SIGNATURE-----

--kz7btylpp3qbzmv5--

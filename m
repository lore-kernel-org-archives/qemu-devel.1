Received: from eggs.gnu.org ([2001:4830:134:3::10]:48550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7o2b-0003YY-5F
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7o2a-0000jC-Az
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:09:53 -0400
References: <20170508171302.17805-1-eblake@redhat.com>
	<4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
	<a9c93461-8829-3270-5527-3f93fad32a62@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a3a99d1-4d77-da01-9b3c-21cbd4d9b8dc@redhat.com>
Date: Mon, 8 May 2017 21:09:42 +0200
MIME-Version: 1.0
In-Reply-To: <a9c93461-8829-3270-5527-3f93fad32a62@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="96rRLa73xLttr5OriOM1ihoNT46wdR1xd"
Subject: Re: [Qemu-devel] [PATCH] block: Tweak error message related to
 qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--96rRLa73xLttr5OriOM1ihoNT46wdR1xd
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3a3a99d1-4d77-da01-9b3c-21cbd4d9b8dc@redhat.com>
Subject: Re: [PATCH] block: Tweak error message related to qemu-img convert
References: <20170508171302.17805-1-eblake@redhat.com>
 <4d045f6a-15ce-7659-94d2-fb573fa621b1@redhat.com>
 <a9c93461-8829-3270-5527-3f93fad32a62@redhat.com>
In-Reply-To: <a9c93461-8829-3270-5527-3f93fad32a62@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 21:06, Eric Blake wrote:
> On 05/08/2017 01:41 PM, Max Reitz wrote:
>> On 08.05.2017 19:13, Eric Blake wrote:
>>> When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
>>> a contrived failure where allocating a cluster used to replace a
>>> zero cluster reads unaligned data.  Since it is a zero cluster
>>> rather than a data cluster being converted, changing the error
>>> message to match our earlier change in 'qcow2: Make distinction
>>> bewteen zero cluster types obvious' is worthwhile.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> There's one more instance of "Data cluster offset" in qcow2-cluster.c=
,
>>> but that one in handle_copied() is contained inside a
>>> cluster_type =3D=3D QCOW2_CLUSTER_NORMAL conditional.
>>>
>>>  block/qcow2-cluster.c      | 3 ++-
>>>  tests/qemu-iotests/060.out | 2 +-
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> Looks good, except for one thing: This is for qemu-img amend, not
>> qemu-img convert.
>>
>> I can handle that, if you'd like, though. :-)
>=20
> So is fixing my commit message considered a conversion, or an amendment=
?

The git commit parameter is called "--amend", so take your guess. ;-)

Max


--96rRLa73xLttr5OriOM1ihoNT46wdR1xd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQwnYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Axc8H/0ryHLd1GpRkxOcY6RIy6PLYS8Zh8rJ7
2SVfvxrB6Q0yWZ0Wdwrux1XNjUcC6HonArohdb3ouetAn+aiTzW6oRm5H1bYSaly
dxqY4JoNZSJNKAPEYOVCqxIx9JGT45pmYLYt1SgkEwG27tAOak2B5fQ26VAF6Vv+
Qj+ZhZ6neno/RPlgcFgc6jw7Ww6IZYGf+iZWQwnpvOehD65VLun4jhxCJ8I+5vwp
VH7VGrALaTz5BrUqpasw/pt/dXK+OH/r5JOdJvkP5ISIZsF9vxfSwXGemfrtQP9y
17XhRrqcZqxpLqoLwrHUXFwQbRKBw7IrVHYnyCgKUpx5te6AZP8gtOQ=
=53LI
-----END PGP SIGNATURE-----

--96rRLa73xLttr5OriOM1ihoNT46wdR1xd--

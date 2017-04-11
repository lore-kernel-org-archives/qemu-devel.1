Received: from eggs.gnu.org ([2001:4830:134:3::10]:39846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxxog-0001y0-LL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxxof-0005aw-In
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:34:50 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
	<b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
	<1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
	<760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
	<be491b99-9ea4-d1d0-41f4-51945b64f5d4@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <287124b3-7301-38b2-ef86-3f86f5be0221@redhat.com>
Date: Tue, 11 Apr 2017 17:34:37 +0200
MIME-Version: 1.0
In-Reply-To: <be491b99-9ea4-d1d0-41f4-51945b64f5d4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0IQ7lKHSBpXG0qqp4g62cvBsFhiAwHV6X"
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0IQ7lKHSBpXG0qqp4g62cvBsFhiAwHV6X
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <287124b3-7301-38b2-ef86-3f86f5be0221@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <20170411144921.GN4516@noname.str.redhat.com>
 <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
 <1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
 <760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
 <be491b99-9ea4-d1d0-41f4-51945b64f5d4@redhat.com>
In-Reply-To: <be491b99-9ea4-d1d0-41f4-51945b64f5d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 17:30, Eric Blake wrote:
> On 04/11/2017 10:18 AM, Max Reitz wrote:
>=20
>> Hm, yeah, although you have to keep in mind that the padding is almost=

>> pretty much the same as the the data bits we need, effectively doublin=
g
>> the size of the L2 tables:
>>
>> padding =3D 2^{n+2} - 2^{n+1} - 64 (=3D2^6)
>>         =3D 2^{n+1} - 64
>>
>> So that's not so nice, but if it's the only thing we can do...
>=20
> Or we mix-and-match your ideas: since our subclusters are ternary
> encoding, if you want 128 subclusters, instead of asking for 256 bits,
> you ask for ld(3^128) =3D 203 bits, then use 11 padding bits of your
> original 64, and you have something that still fits in 256 bits instead=

> of 512...
>=20
> Okay, just kidding.  Anything larger than 32 subclusters does get
> awkward fast.

If we want to do something a bit complicated that is still kind of
reasonable, though, we could just not use padding except for 512 byte
boundaries. Of course, that makes calculating the index of an L2 table a
bit more complicated (probably involving a division by a value that is
not a power of two), but it would kind of work.

Or we use Malbolge, yes. That would probably be the most sensible choice.=


Max


--0IQ7lKHSBpXG0qqp4g62cvBsFhiAwHV6X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs940SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOg8H/0rQ6OcejqQLXWdQ7kX+w50wxKIqMMBK
L0G9vXngxTERRp3rg0TSalpQchpTctYCfyg1Vv67e6bGpzRnH9LO78BADFsmEMNb
4QFxUq8CeA3RVmKARqVHzcs5Sa6M70GA4OKTWn+yWOUcOLwT+OyEgBye+27UCQ2n
9GgpW670PYtQkJfkzREdxNc87gTpUR5pkMCr/OCC2Er1ZHBQC17miGKRrDjDYs78
MR0o0qAiTpOmjUbMr5uAA8G89MMs5ZhOg2x66ewWlBhqDQupw9+LQvxnWmDH0F2Z
C62EXhKdxF5T6TmvarVW9wlWzimUfNx9NQi7q7NmH6tpeI9CUYxTsZI=
=CfnL
-----END PGP SIGNATURE-----

--0IQ7lKHSBpXG0qqp4g62cvBsFhiAwHV6X--

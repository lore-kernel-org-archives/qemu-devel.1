Received: from eggs.gnu.org ([2001:4830:134:3::10]:60017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxEF-0005ww-9r
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxEE-0004RB-FK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:35:27 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
	<7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
	<2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
	<4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
	<cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7b4ac9d9-1e51-43d4-0d55-488ac5593263@redhat.com>
Date: Wed, 31 Jan 2018 19:35:17 +0100
MIME-Version: 1.0
In-Reply-To: <cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4QetSLjwJ8oZ0YpX2vaU6XpJVJzwqn4AD"
Subject: Re: [Qemu-devel] [PATCH v7 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4QetSLjwJ8oZ0YpX2vaU6XpJVJzwqn4AD
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 berto@igalia.com
Message-ID: <7b4ac9d9-1e51-43d4-0d55-488ac5593263@redhat.com>
Subject: Re: [PATCH v7 8/9] qcow2: skip writing zero buffers to empty COW
 areas
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
 <7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
 <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
 <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
 <cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
In-Reply-To: <cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-31 19:32, Eric Blake wrote:
> On 01/31/2018 11:40 AM, Max Reitz wrote:
>=20
>>> Maybe it's good enough to cover these cases:
>>> =C2=A01. no backing
>>> =C2=A02. beyond bdrv_getlength() in backing
>>> =C2=A03. unallocated in backing qcow2 (covers 'beyond bdrv_getlength(=
)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 in backing->file')
>>>
>>> 1 & 2 are easy to check;
>>
>> Not sure how useful 2 is, though.  (I don't know.  I always hear about=

>> people wanting to optimize for such a case where a backing file is
>> shorter than the overlay, but I can't imagine a real use case for that=
=2E)
>=20
> I can; here's what's happened to me personally.  I created an image, an=
d
> took internal snapshots (yeah, I know those aren't in fashion these
> days, but this was long ago).  Later, I ran out of space.  I wanted to
> resize the image, but am not convinced whether resizing the image will
> play nicely with the internal snapshots (in fact, I don't recall
> off-hand whether this was something we prevented in the past and now
> support, or if it is still unsupported now...) - so the easiest way is
> to create a larger overlay image.

But you were convinced that creating an overlay would play nicely with
the internal snapshots? ;-)

I'm not sure whether that sounds like a use case I'd want to optimize
for, but, well.

>>> 3: if that's not too hacky maybe we can do the bdrv_is_allocated() ch=
eck
>>> for qcow2 exclusively and if there is raw (or any other format) backi=
ng
>>> image - do the COW
>>
>> Yes, well, it seems useful in principle...  But it would require gener=
al
>> block layer work indeed.  Maybe a new flag for bdrv_block_status*() th=
at
>> says only to look into the format layer?
>=20
> Maybe indeed - but first I want my byte-based block_status stuff to lan=
d ;)

It could be done as an optimization in a follow-up to this series
anyway, yes.

Max


--4QetSLjwJ8oZ0YpX2vaU6XpJVJzwqn4AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyDGUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AL0sH/AlVUfA5ktaWUw+gOevuAJ9OisNV5e6w
VXljd7iMIXJAnW17b3L7vUDkidv+vTErvv06VXEOeXW/FkE++s0zpCQYM+h4gbuR
iqPU5+QE86bbosXW9xlGGamcSv843wuHaqQXMW/tYJ6Xhfu1rFMGoCoBorpZhckf
lZBDGKPhlTIFyrFrEBXw9foGEZSGkZRH0iNPL6DLQdbqrguf7dIc0acJxv6PdDod
aNY7hljUXd7rfI9VzbDJzVfRhr5tXFQ4CyC0/fYbzQ+EkBLjbnDEtPiLd64fkyzX
2U90fG9K/lZq0eB+ArxQVEoiyRXU8SBNu79qQ4pCiNyIMlZxe5kd1lA=
=dSI6
-----END PGP SIGNATURE-----

--4QetSLjwJ8oZ0YpX2vaU6XpJVJzwqn4AD--

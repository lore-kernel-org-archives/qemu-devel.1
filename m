Received: from eggs.gnu.org ([2001:4830:134:3::10]:33108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clhu9-0000gf-MT
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clhu8-0001Il-1n
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:09:49 -0500
References: <20170308200216.5931-1-eblake@redhat.com>
	<c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
Date: Wed, 8 Mar 2017 14:09:40 -0600
MIME-Version: 1.0
In-Reply-To: <c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t86VIsaJm15tvPsX4DS9mwWb9Q07fJeFW"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Drop unmaintained
 'archipelago' driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t86VIsaJm15tvPsX4DS9mwWb9Q07fJeFW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org,
 kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <0eac6b1c-2dc0-b0aa-7392-3b7f344cae48@redhat.com>
Subject: Re: [PATCH for-2.9] block: Drop unmaintained 'archipelago' driver
References: <20170308200216.5931-1-eblake@redhat.com>
 <c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
In-Reply-To: <c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2017 02:05 PM, Max Reitz wrote:
> On 08.03.2017 21:02, Eric Blake wrote:
>> The driver has failed to build since commit da34e65, in qemu 2.6,
>> due to a missing include of qapi/error.h for error_setg().
>> Since no one has complained in three releases, it is easier to
>> remove the dead code than to keep it around, especially since it
>> is not being built by default and therefore prone to bitrot.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> My proposed alternative for Max's "block/archipelago: Make it compile"=

>>
>>  qapi/block-core.json             |   33 +-
>>  block/archipelago.c              | 1079 -----------------------------=
---------
>>  MAINTAINERS                      |    8 -
>>  block/Makefile.objs              |    2 -
>>  configure                        |   43 --
>>  tests/qemu-iotests/025           |    2 +-
>>  tests/qemu-iotests/common        |    6 -
>>  tests/qemu-iotests/common.filter |    4 +-
>>  tests/qemu-iotests/common.rc     |    8 -
>>  9 files changed, 4 insertions(+), 1181 deletions(-)
>>  delete mode 100644 block/archipelago.c
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> But I'd like someone to confirm that I'm not the only one who can't
> compile archipelago. ;-)

With my proposed patch not installed, I tried:

=2E/config.status --enable-archipelago

but got the error:

ERROR: User requested feature Archipelago backend support
       configure was not able to find it.
       Install libxseg devel


I don't see libxseg-devel available for Fedora; where does one get it to
even attempt compilation?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--t86VIsaJm15tvPsX4DS9mwWb9Q07fJeFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwGUFAAoJEKeha0olJ0NqXa0H/R3o8I33rlPzEyRlyQ2EGvWJ
iWhzSUUrF6azlUrEaP7iw1bLZ//4bhKLf4ifk537pgNviXpYrizyGF1OpWrnArMm
Im59lbr7WyHtgfS+m0TJqklhozY+nIdnnUTPFrt1Fpu0bmLfiFxHIhnVo2SJ3J8P
N+ddUrgQpVoU96P0clo6Wff7KIhDCZ0lB5dgJyleiWtJL2Bt+iIIc1oXsooDghFM
iTkfBDtCcALtxtXAo9vNa4W9XS55DA/3bjDFwx5NK1nr90Lp+jahnMWt8ow2mPMZ
7hXIyEyHfJvZl2SCgOxBsGJNn7IFcde3aMtq5qqwfG3Al3oy+1tUTpWUrohgFJg=
=yIO+
-----END PGP SIGNATURE-----

--t86VIsaJm15tvPsX4DS9mwWb9Q07fJeFW--

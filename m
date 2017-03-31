Received: from eggs.gnu.org ([2001:4830:134:3::10]:58336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctxHY-0007lw-RZ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctxHX-0007FC-VR
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:12:04 -0400
References: <20170330223645.349-1-eblake@redhat.com>
	<20170330223645.349-4-eblake@redhat.com>
	<7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
	<a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
	<daf677d4-9e1c-a5bb-9e5b-13c77802397e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <402f1924-d3d3-6bab-7ee8-af5f1fab7eba@redhat.com>
Date: Fri, 31 Mar 2017 09:11:53 -0500
MIME-Version: 1.0
In-Reply-To: <daf677d4-9e1c-a5bb-9e5b-13c77802397e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OoQcWttNEkX5qUjLCNDCGjGf9e5qbpqaW"
Subject: Re: [Qemu-devel] [PATCH v7 3/3] qcow2: Discard unaligned tail when
 wiping image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OoQcWttNEkX5qUjLCNDCGjGf9e5qbpqaW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <402f1924-d3d3-6bab-7ee8-af5f1fab7eba@redhat.com>
Subject: Re: [PATCH v7 3/3] qcow2: Discard unaligned tail when wiping image
References: <20170330223645.349-1-eblake@redhat.com>
 <20170330223645.349-4-eblake@redhat.com>
 <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
 <a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
 <daf677d4-9e1c-a5bb-9e5b-13c77802397e@redhat.com>
In-Reply-To: <daf677d4-9e1c-a5bb-9e5b-13c77802397e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 09:01 AM, Max Reitz wrote:

>>                                                            Do I need t=
o
>> respin for that, or is it something a maintainer could tweak, or is th=
e
>> series fine as-is?
>=20
> Of course I can fix the code, but changing the commit messages is a bit=

> more involved...
>=20
>>                     For what it's worth, the policy of single test aft=
er
>> the patch is somewhat opposite of Markus' approach of test first showi=
ng
>> the buggy behavior, then patch that includes the testsuite fix to matc=
h
>> the patch.  But I can live with either order, so I won't respin withou=
t
>> an explicit request to do so.
>=20
> Well, then consider this an explicit request. :-)

Yes sir! v8 coming right up.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OoQcWttNEkX5qUjLCNDCGjGf9e5qbpqaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3mOpAAoJEKeha0olJ0NqoD0IAKgXUyo2BqpFVoZz5zwlG+u5
ajCh88+xdwl1hVmRGnJit7v/aNqw6H3VsPxxKMNgEGudrugZzEoro2j5P3FrE6/p
3Uj4KdG2ggPNNCX/lEKokMqCVl/Uk7UJjdsL6DMJJVGFSXhTnsXuSsPNsMNT2Ot6
2SuN8VAccJDrgv0skWHQrMUThskNVvNwb+h1ITh4Pe0bZSuop0jiEb8c+0Chu2ox
8oW/cY2DsutSYMV4Z/Hqqr9OZUVRTGl5A70DTKrmx8fGdrG/pY6z9oErvlJXCSvJ
EMuLds8mnY4OOW9qUiwtXYk90HBRpRi//FUTV9FRhQcQ1P6RsuCJbY1MkrdkRVs=
=OB18
-----END PGP SIGNATURE-----

--OoQcWttNEkX5qUjLCNDCGjGf9e5qbpqaW--

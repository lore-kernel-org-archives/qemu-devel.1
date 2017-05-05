Received: from eggs.gnu.org ([2001:4830:134:3::10]:32885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6lvL-0008M7-0l
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6lvK-0002zv-3e
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:42:07 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-9-eblake@redhat.com>
	<8e44075e-7edb-16bb-e98f-d24ead5e0063@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc467b26-04a5-c507-da49-da87a50b0097@redhat.com>
Date: Fri, 5 May 2017 17:41:57 -0500
MIME-Version: 1.0
In-Reply-To: <8e44075e-7edb-16bb-e98f-d24ead5e0063@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vsv2UhA0WFcmFTXuvsq4lFNg5J4BEsstp"
Subject: Re: [Qemu-devel] [PATCH v12 08/10] qcow2: Optimize write zero of
 unaligned tail cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vsv2UhA0WFcmFTXuvsq4lFNg5J4BEsstp
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <dc467b26-04a5-c507-da49-da87a50b0097@redhat.com>
Subject: Re: [PATCH v12 08/10] qcow2: Optimize write zero of unaligned tail
 cluster
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-9-eblake@redhat.com>
 <8e44075e-7edb-16bb-e98f-d24ead5e0063@redhat.com>
In-Reply-To: <8e44075e-7edb-16bb-e98f-d24ead5e0063@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 05:06 PM, Max Reitz wrote:
> On 04.05.2017 05:07, Eric Blake wrote:
>> We've already improved discards to operate efficiently on the tail
>> of an unaligned qcow2 image; it's time to make a similar improvement
>> to write zeroes.  The special case is only valid at the tail
>> cluster of a file, where we must recognize that any sectors beyond
>> the image end would implicitly read as zero, and therefore should
>> not penalize our logic for widening a partial cluster into writing
>> the whole cluster as zero.
>>

>>  $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
>>
>> +echo
>> +echo =3D=3D unaligned image tail cluster, no allocation needed =3D=3D=

>=20
> [...]
>=20
>> +# A preallocated cluster maintains its allocation, whether it stays a=
s
>> +# data due to a partial write:
>> +# Convert 128m... | XX XX =3D> ... | XX 00
>> +_make_test_img $((size + 1024))
>> +$QEMU_IO -c "write -P 1 $((size)) 1024" "$TEST_IMG" | _filter_qemu_io=

>> +$QEMU_IO -c "write -z $((size + 512)) 512" "$TEST_IMG.base" | _filter=
_qemu_io
>=20
> s/\.base//, I suppose?

D'oh. Serves me right for renaming which file I was working on.

>=20
> (You should read your reference output. "Pattern verification failed" i=
s
> never good. ;-))

Looks like I get to spin a v13 then.

>=20
> With that (and the reference output) fixed:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vsv2UhA0WFcmFTXuvsq4lFNg5J4BEsstp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDP+1AAoJEKeha0olJ0NqL8IH/06f0Ke9GVyB3lZDBnpWmqcy
0kMjdtnhvRiuxYr72PCh/CGk4ZJbdk/dlAXNLSERW4SBK+dCgecPYCkRXftMbwAQ
0O5HxHAfbO/pLHj++foPNLsz20/z2zYnFXIUI2pBN5LLBzOxC6SvdQkZV/Q524Cl
mE3EvR9zoJjJoTZNi/cuy1UpZSougbdFs2o3YFewhNn0xxVxuhKcpDEtMVQdL5nk
F6xc9c950ArNuVYQa+eWo1BvXiSU1OWJpY/tbb57OvuK5DIyguKpakzrVXqrZFdf
seqK8e6JM/8MnicudbLvKIlAbaCoUBYUS17BsZsqfJYVCOEQ6//B1i18V4iT0I0=
=m4qA
-----END PGP SIGNATURE-----

--vsv2UhA0WFcmFTXuvsq4lFNg5J4BEsstp--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce1az-0006ko-9a
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce1au-0000RO-EB
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:34:17 -0500
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
	<20170215152013.GH24672@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fffca8b-b58a-d085-8f48-0d6c4fb9a774@redhat.com>
Date: Wed, 15 Feb 2017 09:34:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170215152013.GH24672@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F3TBp94xQ9PSutguXDQFqKSuiTmSi34m7"
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, qemu-discuss@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F3TBp94xQ9PSutguXDQFqKSuiTmSi34m7
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 qemu-discuss@nongnu.org
Message-ID: <7fffca8b-b58a-d085-8f48-0d6c4fb9a774@redhat.com>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
 <20170215151419.GD16064@stefanha-x1.localdomain>
 <20170215152013.GH24672@redhat.com>
In-Reply-To: <20170215152013.GH24672@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 09:20 AM, Daniel P. Berrange wrote:
>> Let's try this syntax:
>>
>>   $ qemu-img query-max-size -f raw -O qcow2 input.raw
>>   1234678000
>>
>> As John explained, it is only an estimate.  But it will be a
>> conservative maximum.
>=20
> This forces you to have an input file. It would be nice to be able to
> get the same information by merely giving the desired capacity e.g
>=20
>   $ qemu-img query-max-size -O qcow2 20G

We'd need an option to tell the difference between size and pre-existing
file, if we want to support both ways.  Maybe:

qemu-img query-max-size -O qcow2 --size 20G
qemu-img query-max-size -O qcow2 -f raw input.raw

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--F3TBp94xQ9PSutguXDQFqKSuiTmSi34m7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpHTwAAoJEKeha0olJ0NqUDAIAIkEMXAc6tXBGvJ5YKXWv3Uu
aK7nK1hiraCcZoyeWVs5bXq2eRpfrcMUXR3KwHfyyUGiZO+D4F2qHbE2zSVStNTK
pkKH+HTrQYhh/q5BKzZHwtOOm8wstcgc3SjLnREKePj+Pf60RSSZBiQydbif/3x2
Ele7lL5UHq/qUDIetQXLIx5LQbIXOlATP6GKYAm+ufkeffReLcyfPooD0k6FcPFC
76jBBLZrcs88K1a6u5c7aO27YhlmY98JrVZecgLwzh/UlFYy+qdipieL4Cc2qWmB
Ae7mmHcY4+Duf0YQq7nGQok+0k0VtLxkyXRqQQKR76iVCNYvIfv23NKbMuxwrt0=
=euwF
-----END PGP SIGNATURE-----

--F3TBp94xQ9PSutguXDQFqKSuiTmSi34m7--

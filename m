Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQDXs-0005nR-Js
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQDXp-0004du-98
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQDXp-0004dZ-0k
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:02:13 -0400
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
	<b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
	<20170628125704.GF5378@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4065d2bb-0960-e3fe-c703-692db091aa62@redhat.com>
Date: Wed, 28 Jun 2017 09:02:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170628125704.GF5378@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FwLF0T8pWeWKeaulEAEeobiO1u9g8wKT4"
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FwLF0T8pWeWKeaulEAEeobiO1u9g8wKT4
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <4065d2bb-0960-e3fe-c703-692db091aa62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
References: <20170615163813.7255-1-stefanha@redhat.com>
 <20170615163813.7255-4-stefanha@redhat.com>
 <b1a33e94-b32b-c6ca-c526-6dbb201a25b1@redhat.com>
 <20170628125704.GF5378@noname.redhat.com>
In-Reply-To: <20170628125704.GF5378@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 07:57 AM, Kevin Wolf wrote:
> Am 27.06.2017 um 13:40 hat Eric Blake geschrieben:
>> On 06/15/2017 11:38 AM, Stefan Hajnoczi wrote:
>>> Avoid duplicating the QEMU command-line.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  tests/qemu-iotests/068 | 13 ++++++++-----
>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>
>>> +# Give qemu some time to boot before saving the VM state
>>> +bash -c 'sleep 1; echo -e "savevm 0\nquit"' | _qemu
>>
>> Are we sure that 'bash' on PATH is the same as the /bin/bash running t=
he
>> script?
>=20
> Do we even need to explicitly call bash here? Doesn't this do the same
> as far as this test case is concerned?
>=20
>     ( sleep 1; echo "..." ) | _qemu

Or save a process:

{ sleep 1; echo "..."; } | _qemu

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FwLF0T8pWeWKeaulEAEeobiO1u9g8wKT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU7beAAoJEKeha0olJ0NqEzsH/iwnK+k1wZ4TiKYqsWdu928U
KGl5NJgus/ycXHBW2LdMU0qlyBEU/wyCaXuku3kH4AIy5T+TKZkZ1TM394wiX5e7
AHxgdI5shIohRGD/A16EXlyUJPUBzdKGvUonbVeoyjcKvMamkERnCNcFMy2DU573
6bzGL1vp1GJtvY7mT7quZSwjN0j4O6I0uG7wQgsXshkkNpU/qzsX175bMSHnsFGW
cce0hzoZj0k7e4lB64em+FfrkNUA5fzhAlO92aWs+GXuJt3aXAQvku+g04Z5teGW
PTbpbDcdyDH0ohq+BYzkh8DOW3A1LASRiCYPBB3aLIvlFk3rYlhQClWDh6Nf/dI=
=Dn7h
-----END PGP SIGNATURE-----

--FwLF0T8pWeWKeaulEAEeobiO1u9g8wKT4--

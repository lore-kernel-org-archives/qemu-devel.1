Received: from eggs.gnu.org ([208.118.235.92]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDXOH-0007rD-4p
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDXOG-0005iA-AS
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:40:29 -0400
References: <20180428163442.6238-1-mreitz@redhat.com>
	<20180428163442.6238-3-mreitz@redhat.com>
	<f2529cb3-1ef0-3608-0b91-18026e523a46@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ee0e3380-23ad-5c5c-ef52-8a9cfcddc5c5@redhat.com>
Date: Tue, 1 May 2018 17:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <f2529cb3-1ef0-3608-0b91-18026e523a46@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wAL6qP4by6XOUf8ZyOrkabzHKy9LFEXiH"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Repairing error during
 snapshot deletion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wAL6qP4by6XOUf8ZyOrkabzHKy9LFEXiH
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ee0e3380-23ad-5c5c-ef52-8a9cfcddc5c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Repairing error during snapshot
 deletion
References: <20180428163442.6238-1-mreitz@redhat.com>
 <20180428163442.6238-3-mreitz@redhat.com>
 <f2529cb3-1ef0-3608-0b91-18026e523a46@redhat.com>
In-Reply-To: <f2529cb3-1ef0-3608-0b91-18026e523a46@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-30 18:01, Eric Blake wrote:
> On 04/28/2018 11:34 AM, Max Reitz wrote:
>> This adds a test for an I/O error during snapshot deletion, and maybe
>> more importantly, for how to repair the resulting image.=C2=A0 If the
>> snapshot has been deleted before the error occurs, the only negative
>> result will be leaked clusters -- and those should be repairable with
>> qemu-img check -r leaks.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/217=C2=A0=C2=A0=C2=A0=C2=A0 | 89
>> ++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/217.out | 42 ++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 3 files changed, 132 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/217
>> =C2=A0 create mode 100644 tests/qemu-iotests/217.out
>>
>=20
>> +
>> +# Internal snapshots are (currently) impossible with refcount_bits=3D=
1
>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
>> +
>=20
> And even if they are made possible (by cloning clusters instead of
> incrementing refcounts), you STILL need a refcount > 1 to test the
> particular repair functionality just fixed.

Ah, right...

> Up to you if you want to reword that comment a bit.

Yes, will do.  ("This test needs clusters with at least a refcount of 2
so that OFLAG_COPIED is not set.  refcount_bits=3D1 is therefore
unsupported.")

> Reviewed-by: Eric Blake <eblake@redhat.com>
(As always,) thanks!

Max


--wAL6qP4by6XOUf8ZyOrkabzHKy9LFEXiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlroilUACgkQ9AfbAGHV
z0BzlQgAvqOtOp2jV3W6EmFCnic8XUw+CcZDrzuoDIRSPwhEbYUxZGGYPhSNFcgj
tdX27L0pDLX8GK8WtAdejEckmuzxvkSe35D4bNTMetXp7uEAyLXtXysOBd+U86M2
Ou9Wyl/a37BK5cn0wHr93JLp4mQBzNYVBdDBIJADi2AfubPhvO+xCjNsqLVegfnH
ftTGnTsi4iDQijKdO94yGzK+CCysZrImeAFfy2dClH6wmYcnlP82B14vJ4iS/wTz
rNZaj4rlzpwpaaXZjqi05BBvX+qQ89RIZckL8sujr8ArfpS+JuIHwrDc2c/oA3xF
v5UX9OE8NxxEpRXcxKwtkufKaMT5Tg==
=JTTy
-----END PGP SIGNATURE-----

--wAL6qP4by6XOUf8ZyOrkabzHKy9LFEXiH--

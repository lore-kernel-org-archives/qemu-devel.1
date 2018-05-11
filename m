Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCSD-0001OE-Ut
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCSC-0004sI-VG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:07:41 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-6-mreitz@redhat.com>
	<9bbee72f-4ac6-c564-3537-9d9e37e551be@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ef7ab0d2-cf69-a82e-75bd-0135d6b0f96c@redhat.com>
Date: Fri, 11 May 2018 20:07:31 +0200
MIME-Version: 1.0
In-Reply-To: <9bbee72f-4ac6-c564-3537-9d9e37e551be@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OAnJvl6GZ7pleCIwnh8eZcDeiYikXhy05"
Subject: Re: [Qemu-devel] [PATCH 05/13] qapi: Formalize qcow encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OAnJvl6GZ7pleCIwnh8eZcDeiYikXhy05
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <ef7ab0d2-cf69-a82e-75bd-0135d6b0f96c@redhat.com>
Subject: Re: [PATCH 05/13] qapi: Formalize qcow encryption probing
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-6-mreitz@redhat.com>
 <9bbee72f-4ac6-c564-3537-9d9e37e551be@redhat.com>
In-Reply-To: <9bbee72f-4ac6-c564-3537-9d9e37e551be@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-10 16:24, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> Currently, you can give no encryption format for a qcow file while sti=
ll
>> passing a key-secret.=C2=A0 That does not conform to the schema, so th=
is
>> patch changes the schema to allow it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> =C2=A0 ##
>> =C2=A0 # @BlockdevQcowEncryptionFormat:
>> =C2=A0 #
>> =C2=A0 # @aes: AES-CBC with plain64 initialization vectors
>> =C2=A0 #
>> +# @from-image:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Determine the encryption=
 format from the image
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header.=C2=A0 This only allows th=
e use of the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key-secret option.=C2=A0 (Since: =
2.13)
>> +#
>> =C2=A0 # Since: 2.10
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'BlockdevQcowEncryptionFormat',
>> -=C2=A0 'data': [ 'aes' ] }
>> +=C2=A0 'data': [ 'aes', 'from-image' ] }
>=20
> Overkill.=C2=A0 Why not just:
>=20
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @BlockdevQcowEncryption:
>> @@ -2728,9 +2748,11 @@
>> =C2=A0 # Since: 2.10
>> =C2=A0 ##
>> =C2=A0 { 'union': 'BlockdevQcowEncryption',
>> -=C2=A0 'base': { 'format': 'BlockdevQcowEncryptionFormat' },
>> +=C2=A0 'base': { '*format': 'BlockdevQcowEncryptionFormat' },
>> =C2=A0=C2=A0=C2=A0 'discriminator': 'format',
>> -=C2=A0 'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
>> +=C2=A0 'default-variant': 'from-image',
>=20
> 'default-variant': 'aes'
>=20
>> +=C2=A0 'data': { 'aes': 'QCryptoBlockOptionsQCow',
>=20
> and call it good, because there are no other options to pick from, so
> 'from-image' would always resolve to 'aes' anyway.

Hmmmm.  Yes. :-)

Max


--OAnJvl6GZ7pleCIwnh8eZcDeiYikXhy05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr12+QACgkQ9AfbAGHV
z0DPhAgAqudQV6k9+mAtejJboBF4FcUY9rjPKerE6Z5yRNSKGx2wCI02z05BvF3a
M6hw7AzXqHuz8JCCb5WOT0dWGYpsO2dlhaxcHp2StXuZgD5gA5EfAepppgXKM/qy
5R6qUxij4IJcikGLQun5SlWv0oSufbWXG4BP3ccaTlJxuTMG5zifkE0/S836kX2i
MyAEwu4gIU1kmZF6ObVxl53RYrsi4VCmMWKOQRj5HOt6o0wXX5e4y7TqTe/rNttA
tY9x/m1Nmb+CiCHMbdFleOeMUztmNt2zm93IvKrIqjQNyHZAaSUii6+Dyx/755hW
AxKzGSXES9wmcePlo6qnzFL22HkQsQ==
=6jeL
-----END PGP SIGNATURE-----

--OAnJvl6GZ7pleCIwnh8eZcDeiYikXhy05--

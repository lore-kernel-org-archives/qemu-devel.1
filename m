Received: from eggs.gnu.org ([2001:4830:134:3::10]:46983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csZr7-0002cQ-51
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csZr3-0004Ok-6w
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:59:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:65190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1csZr2-0004Nt-Rh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:59:01 -0400
References: <20170327182137.7006-1-laurent@vivier.eu>
	<20170327182137.7006-2-laurent@vivier.eu>
	<237b2650-da58-c844-d594-390f41e23e65@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3a712e65-045d-3dc2-9c07-a13c8268aa6f@vivier.eu>
Date: Mon, 27 Mar 2017 20:58:50 +0200
MIME-Version: 1.0
In-Reply-To: <237b2650-da58-c844-d594-390f41e23e65@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mWbkJ3b49lPppcq7Vr0LJEE9PrwkhWsrO"
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mWbkJ3b49lPppcq7Vr0LJEE9PrwkhWsrO
From: Laurent Vivier <laurent@vivier.eu>
To: Eric Blake <eblake@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <3a712e65-045d-3dc2-9c07-a13c8268aa6f@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: add SOCKS5 support
References: <20170327182137.7006-1-laurent@vivier.eu>
 <20170327182137.7006-2-laurent@vivier.eu>
 <237b2650-da58-c844-d594-390f41e23e65@redhat.com>
In-Reply-To: <237b2650-da58-c844-d594-390f41e23e65@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 27/03/2017 =C3=A0 20:41, Eric Blake a =C3=A9crit :
> On 03/27/2017 01:21 PM, Laurent Vivier wrote:
>> When the VM is used behind a firewall, This allows
>> to use a SOCKS5 proxy server to connect the VM IP stack
>=20
> "allows to $verb" is not idiomatic English; the correct forms are
> generally "allows $subject to $verb" or "allows ${verb}ing".  In this
> case, I'd lean towards "this allows the use of a SOCKS5 proxy server"

Thank you, and sorry.

>=20
>> directly to the Internet.
>>
>> This implementation doesn't manage UDP packets, so they
>> are simply dropped (as with restrict=3Don), except for
>> the localhost as we need it for DNS.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>=20
>> +++ b/qapi-schema.json
>> @@ -3680,6 +3680,9 @@
>>      '*ipv6-dns':         'str',
>>      '*smb':       'str',
>>      '*smbserver': 'str',
>> +    '*proxy-server': 'str',
>> +    '*proxy-user':   'str',
>> +    '*proxy-passwd': 'str',
>=20
> Why can't we spell this out as password, instead of abbreviating?

because of unix command "passwd" ;) . I will fix.

> Should this hook into the "secrets object" framework so that someone
> does not have to pass the password in plaintext?
>=20
>>      '*hostfwd':   ['String'],
>>      '*guestfwd':  ['String'] } }
>=20
> Missing documentation.

I will fix.

> Do we want all three proxy elements to be in a substruct? The differenc=
e
> is between:
>=20
> { ... "smb": "foo", "proxy-server": "bar", "proxy-user": "noone",
> "proxy-passwd": "hello" }
>=20
> and a substruct:
>=20
> { ... "smb": "foo", "proxy": { "server": "bar", "user", "noone",
> "passwd": "hello" } }

yes, substruct looks better.

>=20
>> =20
>> +@item proxy-server=3D@var{addr}:@var{port}[,proxy-user=3D@var{user},p=
roxy-passwd=3D@var{passwd}]]
>=20
> Yes, you DEFINITELY need to hook into the "secrets object" framework to=

> avoid having to pass a password in plaintext on the command line.  Dan
> Berrange may have more advice on doing that.
>=20

OK

Thank you for the review.

Laurent


--mWbkJ3b49lPppcq7Vr0LJEE9PrwkhWsrO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2WDrAAoJEPMMOL0/L748NYYP/jB824YdvheMSCe1kum81p22
I15qdxme9/g7U/bsk2UI27GVRGUAzUnp7pt59e0HBxE1aJqHm8qdu+9TSjDXcvQA
mletscmsZGJ6dprMYSkSAel6v/z+6YCc1I3hxP4vLkSy5kOSO/KoKit2omzrJMJK
bIumYkn7juB7vQot6F9hF1ZvgvoXNW1z6tXQsMjIMa1Jen/3P8RUa8Q7G5Q3Actn
93VWdm+9coiGXZMOv341oTf3tfjCUPkRhDXsMTyQfE4RB7iikzbuMcH61dnTnBWu
GpwAghStjhLJaIm+TaajMNh7harL4NGVEeN6/wahrcnH3zIZM0aCrQkApDj1Nkqd
F+4r2+v2jgtZZlYAbwELGYTDHuGhLXLsAy9fNwuxhnfl5pG5ylu+iUrOLIzAV60N
jP9/YFY7lEEjb42yfwVGppngpi0n+/zIYGOQUlJRx7jOaQ2MZtj+klE98jguDG7d
a/DFS1b4tQfTQHZ7IX8hIAaluJYo4ntnVGIZgqcJTjxXrdrARk1pLbUobB9WwNGc
PQtT9JKgGS2FDLGVUCNtJ/B2sSl5zm3MPSc3vQQTXX9PYh2E+5BLTqMvE7kWJjiO
GKXYEmdjk/MhVZ1xd6w7eAf3K7bmUwaj9xRK1FeQUnuQ8MvBELv1rr8yApbfTyIC
mrMWSjuc71BEk2jVHrQ9
=Hib2
-----END PGP SIGNATURE-----

--mWbkJ3b49lPppcq7Vr0LJEE9PrwkhWsrO--

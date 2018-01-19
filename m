Received: from eggs.gnu.org ([2001:4830:134:3::10]:45174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecQ4x-000725-UO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecQ4u-00064W-9e
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:23:07 -0500
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:39884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ecQ4u-00064O-3V
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:23:04 -0500
Received: by mail-io0-x22c.google.com with SMTP id b198so1044999iof.6
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 22:23:04 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
Message-ID: <b6587748-a1a5-46e2-e598-2a050acd68b3@ozlabs.ru>
Date: Fri, 19 Jan 2018 17:22:57 +1100
MIME-Version: 1.0
In-Reply-To: <6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sp261IKBwZ7NX4wpaYD9Clo82tiLSPOZk"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sp261IKBwZ7NX4wpaYD9Clo82tiLSPOZk
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>
Message-ID: <b6587748-a1a5-46e2-e598-2a050acd68b3@ozlabs.ru>
Subject: Re: [RFC PATCH qemu] qmp: Add qom-list-properties to list QOM object
 properties
References: <20180119050906.18930-1-aik@ozlabs.ru>
 <20180119051926.GI30352@umbus.fritz.box>
 <6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
In-Reply-To: <6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/01/18 17:15, Alexey Kardashevskiy wrote:
> On 19/01/18 16:19, David Gibson wrote:
>> On Fri, Jan 19, 2018 at 04:09:06PM +1100, Alexey Kardashevskiy wrote:
>>> There is already 'device-list-properties' which does most of the job,=

>>> however it does not handle everything returned by qom-list-types such=

>>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DE=
VICE.
>>>
>>> This adds a new qom-list-properties command which prints properties
>>> of a specific class and its instance. It is pretty much a simplified =
copy
>>> of the device-list-properties handler.
>>>
>>> Since it creates an object instance, device properties should appear
>>> in the output as they are copied to QOM properties at the instance_in=
it
>>> hook.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> I think the existing qom-list interface does this already.
>=20
> Nope, it does not. It takes path, not a type, so running with "-machine=

> none" won't help.
>=20
>> This won't solve the libvirt problem we were discussing, because it
>> needs an existing instance of the object.  libvirt wants to know the
>> machine properties *without* instantiating an instance.
>=20
> My patch works with types, it creates an instance for a short time itse=
lf,
> this is why it does not do a thing for "pseries" as it is not a type an=
d
> prints properties for the "pseries-2.12-machine" type.


This is what I mean by "none":

=2E/qemu-system-ppc64 -machine none -nodefaults -nographic -chardev
 socket,id=3DSOCKET0,server,nowait,host=3Dlocalhost,port=3D40000 -mon
chardev=3DSOCKET0,mode=3Dcontrol


{"arguments": {"typename": "pseries-2.11-machine"}, "execute":
"qom-list-properties"} still returns expected result on the 'none' machin=
e.


--=20
Alexey


--Sp261IKBwZ7NX4wpaYD9Clo82tiLSPOZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlphjsEOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILll8Q/+NwuPqRiStjCGF/B9WqeunuyglBP8gPOqoGt3
KQnY4J3R367As5l/kHCsDv/xiZxvx9urwJgZ5KOJoWA273DqvF/nWxYmmC4jc0lr
kEbMnm2I7+iw90oboEGAlM/80sCnHCB0etf8jpADwtcWnMt61QtZz2bg4K+ehlVx
yuidL5Ki3ZUrTPduUqkeA1wZYYrq+9St2Px/ZweJsJrjYHD7C8tLGnpct3v5zJnF
HN2Oqt4MHGQf/IFfyqT+QddCalNwJ1CLo5ec1k+0Ff3UpVQmndsDJm0e5baZjp7a
cBLCfQ+KKvOjRB2kFuDy6KgEcGiKltcO7JTjMVuCno4sNCZXzeP7bo9gPyhD1run
DQC3QlHPq6s4T4i0AEsw8lQ7UYknviE2QT/9RwEW1s+wd6BLYjKT2lwzt3s9Qm5a
lwOdC4EpGO/TwU/RS7aW7OgrSaabGvYJ6QoGw60cUP0mIskuqBIw2x54Yf1uiGtt
+bVKgZEn8mtuPYXJwOM6690sBpfh53MHtBjk+0900GDhgL3gniXeLib//XszXMyJ
r1y8EqI11tip7DdBI7wa+ZNZlck8M1q533FKz+5z95BSoqW8a1pB2+0HABzxAam+
L06gZzOlc8kiKqH3K0eUXSH7Yu7ezSDcr/mn6wJmdjSE9xYVrLZp0KON8kBdNi8X
s6JH9QY=
=VoXT
-----END PGP SIGNATURE-----

--Sp261IKBwZ7NX4wpaYD9Clo82tiLSPOZk--

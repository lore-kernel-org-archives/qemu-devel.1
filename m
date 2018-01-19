Received: from eggs.gnu.org ([2001:4830:134:3::10]:44214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecPxX-0004po-Hp
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecPxR-0001tp-QJ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:15:27 -0500
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:42763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ecPxR-0001tb-ID
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 01:15:21 -0500
Received: by mail-io0-x230.google.com with SMTP id 25so1026069ioj.9
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 22:15:21 -0800 (PST)
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
Date: Fri, 19 Jan 2018 17:15:15 +1100
MIME-Version: 1.0
In-Reply-To: <20180119051926.GI30352@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ToJr06rSEdJiSjdERk93ILxt348jt5km4"
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
--ToJr06rSEdJiSjdERk93ILxt348jt5km4
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>
Message-ID: <6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
Subject: Re: [RFC PATCH qemu] qmp: Add qom-list-properties to list QOM object
 properties
References: <20180119050906.18930-1-aik@ozlabs.ru>
 <20180119051926.GI30352@umbus.fritz.box>
In-Reply-To: <20180119051926.GI30352@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/01/18 16:19, David Gibson wrote:
> On Fri, Jan 19, 2018 at 04:09:06PM +1100, Alexey Kardashevskiy wrote:
>> There is already 'device-list-properties' which does most of the job,
>> however it does not handle everything returned by qom-list-types such
>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEV=
ICE.
>>
>> This adds a new qom-list-properties command which prints properties
>> of a specific class and its instance. It is pretty much a simplified c=
opy
>> of the device-list-properties handler.
>>
>> Since it creates an object instance, device properties should appear
>> in the output as they are copied to QOM properties at the instance_ini=
t
>> hook.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> I think the existing qom-list interface does this already.

Nope, it does not. It takes path, not a type, so running with "-machine
none" won't help.

> This won't solve the libvirt problem we were discussing, because it
> needs an existing instance of the object.  libvirt wants to know the
> machine properties *without* instantiating an instance.

My patch works with types, it creates an instance for a short time itself=
,
this is why it does not do a thing for "pseries" as it is not a type and
prints properties for the "pseries-2.12-machine" type.



--=20
Alexey


--ToJr06rSEdJiSjdERk93ILxt348jt5km4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlphjPMOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILmnCA/+KH7B4qDastN7MTFG5e0qZbdlnovaRm7TEGMP
9lR5DauARZn7nSD+1I5xrXwyOghF5ksKXZdxwPfrcj+f+BUHV79QICYEEpSh/Dda
QCv/UyspItcQpZE7zwCuz0DU0YWwqZ8mMQcx55JtFtVY+xXFTtqGujGSfFiy6CxN
ELNIjQl2RtRoPzMELYDTQ5oGS/qFTlarKoNevW7A4R10n3P++vbf9aam+hjYX+al
SmK0qbNfWjG1AyFWD1dsRTzVCeJXWKXjJJJdfaYzZejevAPpyxaM1TnISOphbwKE
JfyAY9cGB0Jf8f8Kil/b56dRoWGdXmA4+ALK0d3rLDlsU8z71Hr+ZSYmbLQ15bgN
Pa6sN5qB3XP1XpXZK05bZssrRSGil3gmBCEHIl8TbsDb7m97cSns+C/LseN29kzA
KX6zQX+RCY0++LzYck2YnzE2A6gaYgTeYcoB3n0czo/vN9xY2Banu8y67BsGAR96
W3BgxVfU1G4lx5reyACiBNiYvLWPRgyS9xmoEeO8hX0s77zOBrl8ZRC13s617Fso
vOsZPsMeyYM1fvmQaEA1wrNcZ2w6xc89kTZUxAOdVuHBelLEO7qFoCmEfXW1YpL2
UMmBpoyYE1lZ2+oruo14wj8ZSbakDQJtgq6tJdoyMjO1+LbqY+5WfWstfnLKx50D
duik/1w=
=w4Zq
-----END PGP SIGNATURE-----

--ToJr06rSEdJiSjdERk93ILxt348jt5km4--

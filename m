Received: from eggs.gnu.org ([2001:4830:134:3::10]:41687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGpW-00049T-FD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecGpT-0000Gi-6f
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:30:34 -0500
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
	<20180118052029.GR30352@umbus.fritz.box>
	<0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
	<20180118055348.GU30352@umbus.fritz.box>
	<3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <650522f0-9667-f6c5-1c45-b54619440b69@redhat.com>
Date: Thu, 18 Jan 2018 14:30:27 -0600
MIME-Version: 1.0
In-Reply-To: <3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wXfuEmdzmnKEQC2cMPbtAykC2e5M1jUNh"
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6]
 target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wXfuEmdzmnKEQC2cMPbtAykC2e5M1jUNh
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <650522f0-9667-f6c5-1c45-b54619440b69@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6]
 target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
 <20180115063235.7518-7-sjitindarsingh@gmail.com>
 <20180118052029.GR30352@umbus.fritz.box>
 <0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
 <20180118055348.GU30352@umbus.fritz.box>
 <3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
In-Reply-To: <3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 02:11 AM, Alexey Kardashevskiy wrote:

>>>> I think you just assert() for this.  The only way these could get a
>>>> different value is if there's a bug elsewhere.
>>>
>>>
>>> Why not return H_HARDWARE or other error?
>>
>> Because what's the guest supposed to do with it.=20
>=20
> "oops"
>=20
>> This is an internal
>> qemu problem, so it should be dealt with via an internal qemu
>> mechanism.
>=20
> Do we have assert() enabled in production? If not, then assert =3D=3D n=
oop,
> error_report is just a noise.

See commit 262a69f4.  Yes, assert() is enabled in production, for
security reasons (aka it's easier to do that than to audit that
migration is still safe even with no-op asserts).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wXfuEmdzmnKEQC2cMPbtAykC2e5M1jUNh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlphA+MACgkQp6FrSiUn
Q2qpyAf+JsXKWrp24FajOwK1cppbx0PIfns5sN4a+IqKjdN1+Zed2pQhRXBS1roZ
SIauyuDhuPqLvp1ekwEYguIt+uu2MISw28pjh27h4K+XYLWpaCHc5nWkXF/4zEZg
WseJzL32SEf6pkrgWjlqEqsRfQPiW0g1E0aaK0Fo1PVcKrC0Tm/pIbKgp5rpr74N
f4vMc++z+fvEn8ImVvXgkRu+lQtGBQ8iHuRq15vFs6KsyYa4DpDNgXmbVLMNGuXe
XpsQdCx9G8hIOK7NVTaWCFOrLKGpL0N7VeeHVDNWbYX34perRxtfYSoVLUE8P8Zu
jdoM7KfsmwwhZ58JqjwKg361c7QPTw==
=Ns1L
-----END PGP SIGNATURE-----

--wXfuEmdzmnKEQC2cMPbtAykC2e5M1jUNh--

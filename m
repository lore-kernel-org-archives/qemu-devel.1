Received: from eggs.gnu.org ([2001:4830:134:3::10]:40843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erMi3-00069U-MP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erMi0-0006HP-IM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:49:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46440 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1erMi0-0006H5-CY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:49:12 -0500
References: <20180226082259.40293-1-aik@ozlabs.ru>
	<20180301035910.GC2264@umbus.fritz.box>
	<ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <221842d7-cef8-44a9-7924-f1aece9107c2@redhat.com>
Date: Thu, 1 Mar 2018 12:49:02 +0100
MIME-Version: 1.0
In-Reply-To: <ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fuXlhnlJJE9GZf45LS5dU3aOz4MSjWZdu"
Subject: Re: [Qemu-devel] [PATCH qemu v2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fuXlhnlJJE9GZf45LS5dU3aOz4MSjWZdu
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Message-ID: <221842d7-cef8-44a9-7924-f1aece9107c2@redhat.com>
Subject: Re: [PATCH qemu v2] qmp: Add qom-list-properties to list QOM object
 properties
References: <20180226082259.40293-1-aik@ozlabs.ru>
 <20180301035910.GC2264@umbus.fritz.box>
 <ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
In-Reply-To: <ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 12:47, Alexey Kardashevskiy wrote:
>>> +{ 'struct': 'QOMPropertyInfo',
>>> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
>> So, this has identical contents to DevicePropertyInfo, and is very
>> similar to ObjectPropertyInfo.  Is there any way we could consolidate
>> those types?
> Sure, I can get rid of DevicePropertyInfo in favour of QOMPropertyInfo,=
 I
> am just not sure if this typename is visible anywhere in the QMP protoc=
ol.
> I'll post v3 in minutes.

You can just extend ObjectPropertyInfo with the optional description.
It's the one with the best documentation.

The type names are (intentionally) hidden from the schema and are only
visible in the documentation.

Paolo



--fuXlhnlJJE9GZf45LS5dU3aOz4MSjWZdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlqX6LIACgkQv/vSX3jH
roNQmwf/eDvtFQ+WZCJQqXueDE/ygblb6tzFdw20zR1si3ALqfPj0M8zBY6XYaDn
PqaOuGiZBiZkDmTPwed7JzxLA132dPzIbn53Iw3zI0z+y2Uc3F0ZccCtBW9ipbo7
UlumzQ0pbL8KNkwuXcJuhZFzD+Qa+ZT5nsLpOpqQucRnT6+YH4QZIARNousDGJ3b
oHuSzO70MGGgnNWIBe7+q+Mif8tkqvW8bNIXploveH8OqreBPpQ4ZV5gGC8GQcXY
fgFIa1x3l6OPNaWvrYp8x27y73OQ5Jg2qwNQrSoV6BcspA5PAUGnkjVU5ZYk+zkU
NSqqmc7pm1u9zbb8QNbupQVgcRvPgg==
=86Bp
-----END PGP SIGNATURE-----

--fuXlhnlJJE9GZf45LS5dU3aOz4MSjWZdu--

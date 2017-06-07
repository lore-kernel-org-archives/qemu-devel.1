Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIifC-0005kJ-6N
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIif9-0003r4-3G
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIif8-0003ql-QL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:38:47 -0400
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
	<b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
	<20170607160628.mqhecliq7ka4t3gf@postretch>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1940573-6a33-9566-9057-16180f94b948@redhat.com>
Date: Wed, 7 Jun 2017 16:38:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170607160628.mqhecliq7ka4t3gf@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RVP2QMoAerAFS6wJtIC0mfUtg0jkexu2h"
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RVP2QMoAerAFS6wJtIC0mfUtg0jkexu2h
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org,
 kwolf@redhat.com, stefanha@gmail.com, berto@igalia.com
Message-ID: <f1940573-6a33-9566-9057-16180f94b948@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
 <b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
 <20170607160628.mqhecliq7ka4t3gf@postretch>
In-Reply-To: <20170607160628.mqhecliq7ka4t3gf@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 11:06 AM, Manos Pitsidianakis wrote:
> On Wed, Jun 07, 2017 at 10:40:08AM -0500, Eric Blake wrote:
>> On 06/07/2017 08:06 AM, Manos Pitsidianakis wrote:
>>> This is part of my work for my GSOC project this summer.
>>>
>>> I am not sure if the count parameter in  bdrv_co_pwrite_zeros and
>>> bdrv_co_pdiscard refers to sectors or bytes.
>>
>> Both refer to byte counts.  (We're trying to get rid of as many
>> sector-based interfaces as possible, but it's slow going to make sure
>> the conversions are still accurate).
>=20
> I see. Would changing the names in the BlockDriverState function
> signatures to reflect that be okay?

What names need changing?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RVP2QMoAerAFS6wJtIC0mfUtg0jkexu2h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHJjAAoJEKeha0olJ0NqFw8H/0m+OsyGZmb5eP7N+oB4Izec
nAzbg4GCe3bDT0etFMDmw9w466ipucm+m+whd6iSV4aISI33p8+GyFFNjyNJv2cA
+Pne6GREbdJfdh35DexcoLsJdmcD4+NT5ImaaCuThWpGmHnqjG1ewsYwa+6EC28u
qly2EOasEGc6xZoRXrCo0Sysw+545wImcLe8knqVs/9Iaa1YDrPIXgnvKFoCtg5P
BqDksgZ6jDQKViBBkLX/RKnbJI97JW3YAHhzzf2qjgMmlVFYTiIJZ6sAcZtRqr+B
h0fXk0jmHZ848JDWHj3+tbiuIV+OS5AsKcPKFHEyPJ07nhpAcJaEP3g88fxRICM=
=ekQN
-----END PGP SIGNATURE-----

--RVP2QMoAerAFS6wJtIC0mfUtg0jkexu2h--

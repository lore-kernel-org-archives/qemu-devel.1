Received: from eggs.gnu.org ([2001:4830:134:3::10]:56375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIjAP-0007UK-EK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIjAK-0004sr-F2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:11:05 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:63887)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIjAJ-0004q0-TD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:11:00 -0400
Date: Thu, 8 Jun 2017 01:08:56 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170607220856.wjp2hnzwvf33pbws@postretch>
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
	<b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
	<20170607160628.mqhecliq7ka4t3gf@postretch>
	<f1940573-6a33-9566-9057-16180f94b948@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y5ipwwnqwhtb3gyj"
Content-Disposition: inline
In-Reply-To: <f1940573-6a33-9566-9057-16180f94b948@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, berto@igalia.com


--y5ipwwnqwhtb3gyj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 04:38:43PM -0500, Eric Blake wrote:
>On 06/07/2017 11:06 AM, Manos Pitsidianakis wrote:
>> On Wed, Jun 07, 2017 at 10:40:08AM -0500, Eric Blake wrote:
>>> On 06/07/2017 08:06 AM, Manos Pitsidianakis wrote:
>>>> This is part of my work for my GSOC project this summer.
>>>>
>>>> I am not sure if the count parameter in  bdrv_co_pwrite_zeros and
>>>> bdrv_co_pdiscard refers to sectors or bytes.
>>>
>>> Both refer to byte counts.  (We're trying to get rid of as many
>>> sector-based interfaces as possible, but it's slow going to make sure
>>> the conversions are still accurate).
>>
>> I see. Would changing the names in the BlockDriverState function
>> signatures to reflect that be okay?
>
>What names need changing?

I meant, change "int count" to "int bytes" in the bdrv_co_pwrite_zeros=20
and bdrv_co_pdiscard signatures inside struct BlockDriverState.=20
>--=20
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3266
>Virtualization:  qemu.org | libvirt.org
>



--y5ipwwnqwhtb3gyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk4eXgACgkQc2J8L2kN
9xBerBAAsV/AJX6hn1tgEJ1w0lIerSEKx1mvSHv8igD2AyY03S3kO44DD5VKbTBQ
tN9luZ1LIuaUj3krqzfeEnl6YMYLRY2TCTZ4cV/aqhX/V9tLoAPu0iiOMwSPeqku
HPoBMGWf/6hpZw7IRqju5v72ByEnvC0jTnVP9mlRAYPuh0KQJZG0005IdR96F8My
ERfe5CDOTwNGmgyfPS7HtiYlrJRSE7OR6w6jV49GWi8Bp7wBiO0dzK5hOuV0Qn7L
Cx7oEkAvAxals1tttUVVlMBU8T8/NhHUzdEH98O9O2C4b+YBTXDBHdZOBT4t0Toy
Tz0A8m4kYTBwtHM00+G5gUoL2cpneGRW+NDoG8io0CrfF6R1rgEQ3vwIGnGSXG6w
PQvVwpDgbKO6mNgXClBvWrT2x18D1fHl5RrqH3oM3Jpa1fdwucau80jEqIaQNuOC
nC+uv6CGJFMoDwkKhc4xTcoO6TDXAw/yOksKYtHapwneBiCpZfN5hRA/YRf5kRFs
wkvVioEVDMQer1e/QEAW1rXxzZCCJiwjUL0EM9BLPiU+t1eY8GGgiKXKMys3HD42
qU5z823g8R5LL+J1UBxegYI2hbFrRdQPBEX5CdRMQNx3CZ1BBJEK623OcHfJzWUL
mAZGgbCKqyLrwqB30OMcP+fFA51s/VxdFjTmWfwE3OEobi9wuKg=
=TA5I
-----END PGP SIGNATURE-----

--y5ipwwnqwhtb3gyj--

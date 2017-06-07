Received: from eggs.gnu.org ([2001:4830:134:3::10]:57903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIjJ4-00023y-PQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIjJ0-0007iO-70
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIjIz-0007i3-UJ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:19:58 -0400
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
	<b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
	<20170607160628.mqhecliq7ka4t3gf@postretch>
	<f1940573-6a33-9566-9057-16180f94b948@redhat.com>
	<20170607220856.wjp2hnzwvf33pbws@postretch>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40598aba-b670-9a4a-03bc-90b4d1c72790@redhat.com>
Date: Wed, 7 Jun 2017 17:19:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170607220856.wjp2hnzwvf33pbws@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RowtOLSw3gbI9FoVscD1GG41pPDPThkgS"
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
--RowtOLSw3gbI9FoVscD1GG41pPDPThkgS
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org,
 kwolf@redhat.com, stefanha@gmail.com, berto@igalia.com
Message-ID: <40598aba-b670-9a4a-03bc-90b4d1c72790@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
 <b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
 <20170607160628.mqhecliq7ka4t3gf@postretch>
 <f1940573-6a33-9566-9057-16180f94b948@redhat.com>
 <20170607220856.wjp2hnzwvf33pbws@postretch>
In-Reply-To: <20170607220856.wjp2hnzwvf33pbws@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 05:08 PM, Manos Pitsidianakis wrote:
> On Wed, Jun 07, 2017 at 04:38:43PM -0500, Eric Blake wrote:
>> On 06/07/2017 11:06 AM, Manos Pitsidianakis wrote:
>>> On Wed, Jun 07, 2017 at 10:40:08AM -0500, Eric Blake wrote:
>>>> On 06/07/2017 08:06 AM, Manos Pitsidianakis wrote:
>>>>> This is part of my work for my GSOC project this summer.
>>>>>
>>>>> I am not sure if the count parameter in  bdrv_co_pwrite_zeros and
>>>>> bdrv_co_pdiscard refers to sectors or bytes.
>>>>
>>>> Both refer to byte counts.  (We're trying to get rid of as many
>>>> sector-based interfaces as possible, but it's slow going to make sur=
e
>>>> the conversions are still accurate).
>>>
>>> I see. Would changing the names in the BlockDriverState function
>>> signatures to reflect that be okay?
>>
>> What names need changing?
>=20
> I meant, change "int count" to "int bytes" in the bdrv_co_pwrite_zeros
> and bdrv_co_pdiscard signatures inside struct BlockDriverState.

Sure, a patch to change parameter names to something that aids
legibility would be welcome.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RowtOLSw3gbI9FoVscD1GG41pPDPThkgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHwKAAoJEKeha0olJ0NqyoYH/RwXklmt1uE24vSDj6aQd/z6
SKruhZEJOBNATmecWamKuS9QF3GM3Ispx07CY7faQIo5vqWMRNaqzanhpAFYUNFv
F8aKg0u14FtmK2PB3/EUXxr1l5Xk00eiVs6AJ3FaLaQJD9bDAiid940TyxwSXxmQ
hVqCgOnpyRgXgxQbmPnv33Fx0cChPQ/jXWh+OW0b6jL8Oq2iZrFLaoapGH3gb1fA
0Qs0D8DiqVRqUFEWZTodoB4uRK58CTLrNyDvBIdeVIM2fn0Q43k6WFwlxciO5LsS
FEVRKh+1dvRYSZxhdYWGOIdz9fnKgxof4fS82s22Ul0cL/4tz6yGDZxmzNj8Dp8=
=McnO
-----END PGP SIGNATURE-----

--RowtOLSw3gbI9FoVscD1GG41pPDPThkgS--

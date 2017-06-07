Received: from eggs.gnu.org ([2001:4830:134:3::10]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIdUF-0003Bc-Lc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIdUC-0001i1-HO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:07:11 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:45267)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIdUC-0001hN-3Y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:07:08 -0400
Date: Wed, 7 Jun 2017 19:06:28 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170607160628.mqhecliq7ka4t3gf@postretch>
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
	<b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ppzi6rafsehxnk4q"
Content-Disposition: inline
In-Reply-To: <b1464fa9-84fe-780c-ea32-bbaa631b1d8f@redhat.com>
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


--ppzi6rafsehxnk4q
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 10:40:08AM -0500, Eric Blake wrote:
>On 06/07/2017 08:06 AM, Manos Pitsidianakis wrote:
>> This is part of my work for my GSOC project this summer.
>>
>> I am not sure if the count parameter in  bdrv_co_pwrite_zeros and
>> bdrv_co_pdiscard refers to sectors or bytes.
>
>Both refer to byte counts.  (We're trying to get rid of as many
>sector-based interfaces as possible, but it's slow going to make sure
>the conversions are still accurate).

I see. Would changing the names in the BlockDriverState function=20
signatures to reflect that be okay?

--ppzi6rafsehxnk4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk4JIQACgkQc2J8L2kN
9xDKnQ//ephbePN4cLHSPQDZPq0DC1dy6JrM/YP9s8BRVlUJGQ/P9cpRQXqQlDHI
thPTuzsMuXYHzrGpXZ6rlfdSAtAfoXN2HzDLBssbEyaZ2umXR2Kd7YfYv4MFBSuU
qndb52DcYzFb/r4To5z1Rp4a+LYdfhcmkBYhP3M+7B7A8HVzLGcC+WMcdeBt9OzH
vzHUV1CoqeVc/ygbGfz2aD8Jeuooz4nG9ltoBAPla8AcoT4Xuqo1Y89hAMesKYPY
ilrbxHN4GGGIZ902uEsRz6VwFyhWCRC/gz4hCe3A7wqS+JciarXxCCFS+BHibL0/
RQ+z7xA33k/KYgtJ3hHE8hEVNPI1tzCBzQhMiYXHr6zJ2g1kWtg9hCUk6IRiamJ3
CfFoFArzw9UvbF/sv7RmFwgz+gA41s54ha+bQoFKUgCMHnqfxwfvUsnkjMFfZAmB
QzOnhIr5Qn2xgIX5hfgaIWeDAg+Lg5tePoqa6eDXzDDmJ1bhdW/dFX0Lz5BYBwlJ
vQ/tntQ9pu3FgEDbUYCXTJrp8ptWVOzH476Q2ODA5Ch9TVbb/oiPpAbcTKeat6rP
8PVxPvTiqx8Cu617kD7ybZRpOeQqxH56DtdWPjcTLTEup6Al5JuhoCdkhBMu245f
0Rc8ZJD54kNNa4idM5RLfDc8ImEdyq/uRU2NmitQMa4w4rUOaq8=
=pRB8
-----END PGP SIGNATURE-----

--ppzi6rafsehxnk4q--

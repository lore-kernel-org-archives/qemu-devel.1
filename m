Received: from eggs.gnu.org ([2001:4830:134:3::10]:52542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctez5-0006XD-KS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctez4-0003e4-LG
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:39:47 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-3-eblake@redhat.com>
	<f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
	<4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b120de9-55fe-0527-8ed3-753dceea3b3e@redhat.com>
Date: Thu, 30 Mar 2017 13:39:39 -0500
MIME-Version: 1.0
In-Reply-To: <4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Psm9aqxFNIWQniLIpIVdNvPKHqch8SDju"
Subject: Re: [Qemu-devel] [PATCH v6 02/10] iotests: Improve image-clear
 tests on non-aligned image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Psm9aqxFNIWQniLIpIVdNvPKHqch8SDju
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <4b120de9-55fe-0527-8ed3-753dceea3b3e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/10] iotests: Improve image-clear tests
 on non-aligned image
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-3-eblake@redhat.com>
 <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
 <4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
In-Reply-To: <4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/29/2017 09:13 PM, Eric Blake wrote:
> On 03/13/2017 05:00 PM, Max Reitz wrote:
>> On 08.03.2017 03:54, Eric Blake wrote:
>>> Tweak 097 and 176 to operate on an image that is not cluster-aligned,=

>>> to give further coverage of clearing out an entire image.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>> ---
>>> v6: new patch
>>> ---
>>>  tests/qemu-iotests/097     |  7 ++++---
>>>  tests/qemu-iotests/097.out | 24 ++++++++++++------------
>>>  tests/qemu-iotests/176     |  7 ++++---
>>>  tests/qemu-iotests/176.out | 24 ++++++++++++------------
>>>  4 files changed, 32 insertions(+), 30 deletions(-)
>>
>> I don't have anything against this patch, but maybe it would be even
>> more useful if it wrote some data to the final partial cluster (just a=
n
>> idea).
>=20
> And not a bad one.  Kevin said patch 1 and 2 are okay for freeze (if
> wanted; but not essential if they miss it), so I'll post v7 soon.

Urrgh. Doing this uncovered the fact that we have a latent bug: we STILL
leave the unaligned tail cluster allocated, when using the slow path; or
put another way, commit a3e1505 is an incomplete fix.

Do I say "thanks" for your suggestion being the cause for me to find the
problem, or "no thanks" for it turning into more work? ;)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Psm9aqxFNIWQniLIpIVdNvPKHqch8SDju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3VDrAAoJEKeha0olJ0NqQJoH/jUiJJFUVVY0CdWstwfr+KLI
gcU5CaC6NW4A86ffseUoRgY90cIjauzvik2TwejEKZM0n3zPdBPgFSlHB4orpjrr
oKDTai+vY8HDSw++uVMSZFjGtfzoFfKEIQaRlaXbi0m4dGmuoNQp5r/Skt9zKY87
jIFZJi13hOxTQAnB0Ozgd9qfwuPrLYTrtX4hws7KxMiiG7dJ1KlcLX0ZkFuzArBr
N3UA8ELksYBmXq1mysshojOwVnCQo+T+GzxF6b+PE2Sx2w0ZCDLqAE8efTJyyENy
uftuf1RNGexK4LaaFwRRGwdoEML2aUKQvsXn+HxfgAu/bzHJwUsZZBUKYTPIHy4=
=9zib
-----END PGP SIGNATURE-----

--Psm9aqxFNIWQniLIpIVdNvPKHqch8SDju--

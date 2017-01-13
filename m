Received: from eggs.gnu.org ([2001:4830:134:3::10]:33061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cS39r-0004KK-BX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cS39m-0001Gb-H4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:48:47 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:33612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cardoe@cardoe.com>) id 1cS39m-0001DK-By
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:48:42 -0500
Received: by mail-io0-x242.google.com with SMTP id 101so5777342iom.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 06:48:40 -0800 (PST)
References: <20170112114612.14520-1-stefanha@redhat.com>
	<fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
	<20170112220500-mutt-send-email-mst@kernel.org>
From: Doug Goldstein <cardoe@cardoe.com>
Message-ID: <508c0b4c-2b53-db77-61ae-09ece0e6498d@cardoe.com>
Date: Fri, 13 Jan 2017 08:48:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170112220500-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="pD6mNiatHLrfS5ajQ4DfCPgAoJb63pJlf"
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pD6mNiatHLrfS5ajQ4DfCPgAoJb63pJlf
From: Doug Goldstein <cardoe@cardoe.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <508c0b4c-2b53-db77-61ae-09ece0e6498d@cardoe.com>
Subject: Re: [PATCH 0/2] virtio: revert virtio_queue_set_notification()
 nesting
References: <20170112114612.14520-1-stefanha@redhat.com>
 <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
 <20170112220500-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170112220500-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/12/17 2:05 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 12, 2017 at 10:57:53AM -0600, Doug Goldstein wrote:
>> On 1/12/17 5:46 AM, Stefan Hajnoczi wrote:
>>> The virtio_queue_set_notification() nesting introduced for AioContext=
 polling
>>> raised an assertion with virtio-net (even in non-polling mode).  Conv=
erting
>>> virtio-net and virtio-crypto to use virtio_queue_set_notification() i=
n a
>>> nesting fashion would be invasive and isn't worth it.
>>>
>>> Patch 1 contains the revert to resolve the bug that Doug noticed.
>>>
>>> Patch 2 is a less efficient but safe alternative.
>>>
>>> Stefan Hajnoczi (2):
>>>   Revert "virtio: turn vq->notification into a nested counter"
>>>   virtio: disable notifications again after poll succeeded
>>>
>>>  hw/virtio/virtio.c | 21 +++++++++------------
>>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>>
>>
>> So I just gave this series a whirl and it fixes the assert but causes
>> another issue for me. While iPXE is getting a DHCP address the screen
>> immediately flashes over to the UEFI shell. Its like a timeout is
>> getting hit and just dropping me to the shell.
>>
>> --=20
>> Doug Goldstein
>>
>=20
> Is this just with UEFI or with seabios as well?
>=20

Sorry for the delay on responding. I've now tested seabios and UEFI
(using OVMF). The issue is only happening via UEFI and it works fine
with seabios.

--=20
Doug Goldstein


--pD6mNiatHLrfS5ajQ4DfCPgAoJb63pJlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0

iQJ8BAEBCgBmBQJYeOjFXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBNTM5MEQ2RTNFMTkyNzlCNzVDMzIwOTVB
MkJDMDNEQzg3RUQxQkQ0AAoJEKK8A9yH7RvUvYMP/0PTJK1pQRYQCgZA1QmFboJ6
uKrppfJ6ryFVmY0oemgRAurcuInEy2xkRrVU7PVqvBzRmZvuml62BcqauBEES1hp
71e2Z0jzLOhg6h6x4fULCkX3bsjNX5MNAhnfTSn410swwzVMEGZDmHaUPCqaus9o
ZfEzuff73BhnSiSgQGsRoSjfo5weoTy8Uf+6dFMIrGESpdUeoZzrl7kHHuQQ+510
36O5qyc3fC+83pdlloMW86ctPpn5OLLU5zUuY8JMV6+kU7r/kYG9sc/T09mxOIrV
OfWucFPHuWZ8xVyOBnAlFwKahmxUSVr9n8jgODILJaX2J8KVQuU21nbJE4yxWYQc
qjLX5WHeNGbJ3wVeg5sFsQIr3XSK7A6kNdw33mkipLHXA4zU2QWFOm+Z1pzp1rIw
/mqgZXsxgwEkZUXELb71Od0HN6gm1FWy/ZgM1el1DI3UoEnqWpA6ioDE0z9oE/t1
ycCDLLx80SG/KpsjFKLeq6c8c5GEBbp4aJorMH9aC0adAVti1Catt9OjbJWwUooV
g4sleHuekvKvCYDcTSRhy3et4ysSfTGzt0kiJAcYTesoB9dux2teMbiej3TOteQb
xH4d4Ov8DsZTb2XQvcrjRSuruIsJy/dZe9ZwTZvQEp+3s9tR0YdBjNzVvbM7nNhm
gGVJl1IVUPaiCpEiNznA
=3XbG
-----END PGP SIGNATURE-----

--pD6mNiatHLrfS5ajQ4DfCPgAoJb63pJlf--

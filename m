Received: from eggs.gnu.org ([2001:4830:134:3::10]:54382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cRihl-0004WF-RP
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cRihh-0000T2-92
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:58:25 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cardoe@cardoe.com>) id 1cRihh-0000Sr-2j
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:58:21 -0500
Received: by mail-it0-x242.google.com with SMTP id o185so2433423itb.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:58:20 -0800 (PST)
References: <20170112114612.14520-1-stefanha@redhat.com>
From: Doug Goldstein <cardoe@cardoe.com>
Message-ID: <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
Date: Thu, 12 Jan 2017 10:57:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170112114612.14520-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="tsFq6KAVOMDhAa9Ge5w2sL8Ea0PjLNqwk"
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tsFq6KAVOMDhAa9Ge5w2sL8Ea0PjLNqwk
From: Doug Goldstein <cardoe@cardoe.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
Subject: Re: [PATCH 0/2] virtio: revert virtio_queue_set_notification()
 nesting
References: <20170112114612.14520-1-stefanha@redhat.com>
In-Reply-To: <20170112114612.14520-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/12/17 5:46 AM, Stefan Hajnoczi wrote:
> The virtio_queue_set_notification() nesting introduced for AioContext p=
olling
> raised an assertion with virtio-net (even in non-polling mode).  Conver=
ting
> virtio-net and virtio-crypto to use virtio_queue_set_notification() in =
a
> nesting fashion would be invasive and isn't worth it.
>=20
> Patch 1 contains the revert to resolve the bug that Doug noticed.
>=20
> Patch 2 is a less efficient but safe alternative.
>=20
> Stefan Hajnoczi (2):
>   Revert "virtio: turn vq->notification into a nested counter"
>   virtio: disable notifications again after poll succeeded
>=20
>  hw/virtio/virtio.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20

So I just gave this series a whirl and it fixes the assert but causes
another issue for me. While iPXE is getting a DHCP address the screen
immediately flashes over to the UEFI shell. Its like a timeout is
getting hit and just dropping me to the shell.

--=20
Doug Goldstein


--tsFq6KAVOMDhAa9Ge5w2sL8Ea0PjLNqwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0

iQJ8BAEBCgBmBQJYd7WqXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBNTM5MEQ2RTNFMTkyNzlCNzVDMzIwOTVB
MkJDMDNEQzg3RUQxQkQ0AAoJEKK8A9yH7RvU0egP/iaehvaDWXbttNB7Et9qkYKZ
JmggCGSCW8D6ZufQnOpAnAcWoVLfuOOzMnShpNfCeQVWvTCLisyipYqRbC+jzU0S
gJwLEoJx1mj8raB6BSIkbjPmxhvqrHfjhf1rpNc+TMp0mJgpNCsR0v66vzMUwdEV
2xyKcCG+396k2c5w08/OzUlaGkYVAqZXpH7U7vhDNPfTc8AeoGZEZcF4hByFjHLR
7wV/iVWBvXrX6gursBktdzmWXcjuF+KHyvsAMvEsxGQ0e2cgzN15Gq1GdhjWqoie
xHIxWJjPDR+qEgw7uXQHBCO/13w+TfP2wD3X37deweSJMX/Na9V9RmQ88jY9MzR9
PkuiZh+kFDvAAltbSSZ7GTxxkovFPDc+NzUXMjbnNfPL1DXKnVTmkG7AHKRNMJ5/
NAyk/69nufs2oHqNsQ/cvdM/BSYO7pmnkvDpk3/iBi7hHywpSShVa6xo6zinqAHd
mxVL13ieFv9OZr/BggeObyBsCNlYmzA7UweHWfp9cMo+o0a3Q8EC9sek6LjKTUzv
rgX/8EnYOzB5qAxSZIeLI7SwNlTlc52Qp7gBH4eSf2pjpuAB9aZ6HVL+s3A9+uUo
KSnoMV/m2SCsAi53QTBPO17UlzzcTeT0zffw0bSF0aVevNxmSelu3a7FdhdfjpFJ
ma1pWtPs2oMbnqI2AaN8
=kQo6
-----END PGP SIGNATURE-----

--tsFq6KAVOMDhAa9Ge5w2sL8Ea0PjLNqwk--

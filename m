Received: from eggs.gnu.org ([2001:4830:134:3::10]:40625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cS3aA-0003Zu-ON
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cS3a7-0002ct-Hh
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:15:58 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cardoe@cardoe.com>) id 1cS3a7-0002cG-DW
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:15:55 -0500
Received: by mail-io0-x241.google.com with SMTP id c80so5859441iod.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 07:15:55 -0800 (PST)
References: <20170112114612.14520-1-stefanha@redhat.com>
	<fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
	<20170113120240.GB9142@stefanha-x1.localdomain>
From: Doug Goldstein <cardoe@cardoe.com>
Message-ID: <75cb767b-2850-4a87-50fc-d957e3a793ac@cardoe.com>
Date: Fri, 13 Jan 2017 09:15:49 -0600
MIME-Version: 1.0
In-Reply-To: <20170113120240.GB9142@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="FhIwJuh8H9BVhvvWHwpnxHkNun68DTGfA"
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FhIwJuh8H9BVhvvWHwpnxHkNun68DTGfA
From: Doug Goldstein <cardoe@cardoe.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <75cb767b-2850-4a87-50fc-d957e3a793ac@cardoe.com>
Subject: Re: [PATCH 0/2] virtio: revert virtio_queue_set_notification()
 nesting
References: <20170112114612.14520-1-stefanha@redhat.com>
 <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
 <20170113120240.GB9142@stefanha-x1.localdomain>
In-Reply-To: <20170113120240.GB9142@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/13/17 6:02 AM, Stefan Hajnoczi wrote:
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
>=20
> Sounds like an separate problem.
>=20
> Stefan
>=20

Is there any debug output that I can provide to help troubleshoot it?
I've built 23425cc and UEFI via OVMF is able to get an IP address via
DHCP inside of iPXE. I've also taken master and only applied the first
patch in this series (the revert) and it too works. Its only when I add
the 2nd patch into the mix or don't revert out the "virtio: turn
vq->notification into a nested counter" patch that it fails.

--=20
Doug Goldstein


--FhIwJuh8H9BVhvvWHwpnxHkNun68DTGfA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0

iQJ8BAEBCgBmBQJYeO8oXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBNTM5MEQ2RTNFMTkyNzlCNzVDMzIwOTVB
MkJDMDNEQzg3RUQxQkQ0AAoJEKK8A9yH7RvUDgMP+wSCXYrUePTvXApn9cYH72dl
1TEKY6WZ9XIggvhXEY5Bs8vVuUC8UzZMYooQASwKtGJuS/UG2eSvsBy906G5/I35
wxF7dKyT7u1JeDSu0xpnqV/w+4Tp2Zu9leez12XYvu1Wi3ZQfnregKl0fnEBOgDI
2x4HZtIiiI+3jmGSWchU/qEXNiX25NoHvizD9jFwcedG/Ymbi0NkKPi2V+GPhgI4
Xv4OeaaGwuDU7W8JjnkXEJ11MM/aU5JzT9qVj8scSeyiputf4pJfkp2lP7ybvIi2
Og9M3CvPSGL08wX3o8sZrmyEQZj5VVdRtSHZnYGyJCPW8mr4i01UJo4Ldd5dfbPS
0nAw92xY6+Cjn1udvPPmJUoIE94EeryHxUdV9VLQ23ohEyAc1Lvcq7tL9ulpZKoU
1vlF81/V0rxIbfaiplw4ZeMacj7MFkBeFirzB/yDKiCvOa80D5fOQ38QdVLLIddb
0kl0EmB3rGTeVWMwyFdnjW+TmMGZ3pVQGWzM1sVZIQcg6vrTWOteh9aHaFXmQ5d3
hBxSBgynftsOoDQxQHL72SGvmw9aWBbb+1r38GIeKoCCKXw785polLc8Y6aCbdUB
9F21b0H2rTS7He7mmTkNuBE6nlqKSv4hf1wzFAkd5o0ohILD9fQrjXHJlI+gDjlT
MdZy4gm6M9q/AwogV+8d
=FhkZ
-----END PGP SIGNATURE-----

--FhIwJuh8H9BVhvvWHwpnxHkNun68DTGfA--

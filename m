Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS0ZU-0000Tg-0f
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cS0ZQ-0001jM-Vm
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:03:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cS0ZQ-0001in-Pz
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:03:00 -0500
Date: Fri, 13 Jan 2017 12:02:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170113120240.GB9142@stefanha-x1.localdomain>
References: <20170112114612.14520-1-stefanha@redhat.com>
	<fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
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
To: Doug Goldstein <cardoe@cardoe.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 10:57:53AM -0600, Doug Goldstein wrote:
> On 1/12/17 5:46 AM, Stefan Hajnoczi wrote:
> > The virtio_queue_set_notification() nesting introduced for AioContext p=
olling
> > raised an assertion with virtio-net (even in non-polling mode).  Conver=
ting
> > virtio-net and virtio-crypto to use virtio_queue_set_notification() in a
> > nesting fashion would be invasive and isn't worth it.
> >=20
> > Patch 1 contains the revert to resolve the bug that Doug noticed.
> >=20
> > Patch 2 is a less efficient but safe alternative.
> >=20
> > Stefan Hajnoczi (2):
> >   Revert "virtio: turn vq->notification into a nested counter"
> >   virtio: disable notifications again after poll succeeded
> >=20
> >  hw/virtio/virtio.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> >=20
>=20
> So I just gave this series a whirl and it fixes the assert but causes
> another issue for me. While iPXE is getting a DHCP address the screen
> immediately flashes over to the UEFI shell. Its like a timeout is
> getting hit and just dropping me to the shell.

Sounds like an separate problem.

Stefan

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYeMHgAAoJEJykq7OBq3PI3UAH/RyqDPDFvPdlFnufsfZIOjUi
XiGmooeDhDp/hMUSFLUYjHoLeq0Ps3Yv9+UCuKWhRTg1DsSemlKeqlJAqMZC6ezU
vD3CNhtKEtVRDheotR7XRDHv3oNrdO5j+F1rEHP5J/gaWoKCcLIT31UgIcrmPbJx
+G7tiT5gtuJXG5X8hP1dxWnOUQDGAvUamziTyMZGS1si8FCVi17xxOepl0jlpoLV
E91pvLI8YhaU1iVo5+OAj347SPVEmpKYZRVnYHazxrSbB+g3lN77SENS/15xUJtp
CHt5r+5M/JIvBisbAdAbk62AAMY/9lgZ0Pc/fcnnUHA7DzNjKs4eNOId+yGu63g=
=FgoN
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

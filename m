Received: from eggs.gnu.org ([2001:4830:134:3::10]:44030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEYn-0003FF-Hl
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEYj-0006pH-KA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:49:33 -0400
Date: Wed, 11 Jul 2018 13:49:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711124926.GE31228@stefanha-x1.localdomain>
References: <CA++5wji+jjiTcBT+Uhd4VL2U70vmRFnvacbRqhnxWX3M=f7svA@mail.gmail.com>
	<edee4a56-e75e-f3cb-8423-2f891be1ff3f@oracle.com>
	<CA++5wjjCMY0Si0HWw4Y5DEswOsQ5MnaoE_6y2xUXcG=y-9FwBQ@mail.gmail.com>
	<298d7750-3dca-f741-abe2-4efef0b2d200@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <298d7750-3dca-f741-abe2-4efef0b2d200@oracle.com>
Subject: Re: [Qemu-devel] [Qemu-discuss] IRQ per CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Probir Roy <roy@probir.info>, qemu-devel@nongnu.org, qemu-discuss@nongnu.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 03:16:44PM +0800, Dongli Zhang wrote:
>=20
>=20
> On 07/05/2018 12:12 PM, Probir Roy wrote:
> >> Does 'per CPU basis' indicates irq per cpu, or irq per device queue?
> >=20
> > IRQ per CPU core, meaning that IRQ will be raised at and served by
> > that CPU. Does IRQ per queue mean the same thing?
> >=20
>=20
> About 'IRQ per queue', the device may create multiple queue in the OS dri=
ver.
> The number of queues are always proportional to the number of CPU core/th=
read
> (although this is also always configurable by OS driver).
>=20
> Usually the per-queue irq/vector is bound to each CPU. As the number of
> queue/irq is always the same as the number of CPU, it is sort of 'per CPU
> basis', as each CPU will be serving irq for its own queue.

Some more background on devices with multiple irqs:

It's the guest kernel that configures interrupt routing on modern
systems where the interrupt controller hardware supports that.

With a PCI device you would need multiple Message-Signalled Interrupt
vectors.  Then the guest driver can set the irq affinity so that the
vcpu of your choice receives each of these interrupts.

Interrupts are a limited resource, even when using Message-Signalled
Interrupts, so you'll have to choose a maximum number of interrupts that
the device supports.

https://en.wikipedia.org/wiki/Message_Signaled_Interrupts#MSI-X

Stefan

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRfzWAAoJEJykq7OBq3PIaPcIAIdOqWYWpMUEMi+i/fLo51g1
ihHrldy9tGyugF24ZCQ7x68U7V4Qo4l1YABhoVolEfae9TGMHDuUIkCpmMV0Fmka
R9Nk/OYxMCg16qW377PbtAwW1GfJyaHAJPVanIDmLP9w6Z/amXvPZw0sFuRj8J/0
ZO1WsYF6/skVeXJUnZMlZ0QOOzzG8vwEs2MrWEf6NmlFSE5dOTJGsVxNYIJIKZWa
GZ83amv77jC0WGrAsQYhvrzG7EC8gPLL7w7ix6SVypu0nwYmsopNZ/VEwz0fge5x
a7FAFZfa5eH0KGmJTM3fY2tC+J049vgxpKt48leZPZdaDp3WeUjR/JvnnrAwXd8=
=2RoM
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

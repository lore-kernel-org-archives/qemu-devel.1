Received: from eggs.gnu.org ([2001:4830:134:3::10]:48085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQz0h-0008Ip-TB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQz0e-00077F-Ou
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:10:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQz0e-000772-JH
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:10:52 -0500
Date: Tue, 10 Jan 2017 16:01:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170110160154.GD17540@stefanha-x1.localdomain>
References: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
	<20170109130852.GE2541@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20170109130852.GE2541@work-vm>
Subject: Re: [Qemu-devel] assert hit on master with q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Doug Goldstein <cardoe@cardoe.com>, qemu-devel@nongnu.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 01:08:53PM +0000, Dr. David Alan Gilbert wrote:
> copying in Stefan since it's his commit.
>=20
> * Doug Goldstein (cardoe@cardoe.com) wrote:
> > I'm currently hitting an assert on master. I've bisected the change down
> > to aff8fd18f1786fc5af259a9bc0077727222f51ca but obviously that's a false
> > positive because that adds the assert for the condition. So obviously
> > the issue was introduced prior to this. As another data point the issue
> > only occurs with q35 machines and will only happen with pc-q35-2.7 and
> > pc-q35-2.8 (and obviously the aliased q35). If I use pc-q35-2.6 it does
> > not hit.
> >=20
> > The message is: qemu-system-x86_64:
> > /home/doug/work/qemu/hw/virtio/virtio.c:214:
> > virtio_queue_set_notification: Assertion `vq->notification_disabled > 0'
> > failed.
> >=20
> > But that clearly just shows its the assert that was added in that
> > commit. To create the machine I use the following command line:
> >=20
> > ./work/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -M pc-q35-2.8
> > -device intel-iommu -cpu host -m 2048 -smp 2 -drive
> > if=3Dpflash,format=3Draw,file=3D/tmp/tmp.Sno2BP3saP -global
> > isa-debugcon.iobase=3D0x402 -debugcon file:/tmp/tmp.KCrwM98Mus -monitor
> > stdio -chardev socket,host=3D127.0.0.1,port=3D4455,id=3DS0,server,nowait
> > -device isa-serial,chardev=3DS0 -device piix3-usb-uhci -device usb-tabl=
et
> > -netdev id=3Dnet0,type=3Dtap -device virtio-net-pci,netdev=3Dnet0 -boot
> > order=3Dn -device qxl-vga -gdb tcp::1234
> >=20
> > It happens almost right away. Let me know how I can help track this down
> > further.

I can't reproduce the assertion failure.

Are you able to provide a backtrace (e.g. launch QEMU under gdb and then
use the 'bt' command after the assertion failure is raised)?

Thanks,
Stefan

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdQVyAAoJEJykq7OBq3PI8MoH/3sYMejq/csqEM2LBu7fxUjl
5D5fRhMvP9gYLxzcOfgRNdIy4tQRuCnXycOMxvP0rML6zYMUP7YBpyk4xH3NaJlm
HA3wJJY8R1XUkhVIuUjb8sJTVRTJgvZFQq5T1XTlE25beJ3IeSiw10zfTPyhofYS
x1Yl3rDjp5GnCSCuMDG7LvABqv6G4gplrus8NWdvXtblDQeB2fzXeMoL6zQ2uskS
EeiUjgNxTWw06VMVVKSpkIYHdEygVqIC7jqBtBJ2LefgO/kE18R8h/axf/JOel8U
bLeTlkpgrzIs8MHZ808rSkSPvMRBATpAzHs1pCvWeTvHR15Kz58YZJj2nDuHa+g=
=+D45
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

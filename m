Received: from eggs.gnu.org ([2001:4830:134:3::10]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gOjGr-0007JA-AA
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gOjGn-0000kk-DC
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:07:21 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gOjGn-0000kZ-6Z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:07:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id w7-v6so5252312wmc.1
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 05:07:17 -0800 (PST)
Date: Mon, 19 Nov 2018 13:07:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181119130713.GB6443@stefanha-x1.localdomain>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kraxel@redhat.com, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 11:42:28AM +0100, Stefano Garzarella wrote:
> On Mon, Nov 19, 2018 at 9:49 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> >   Hi,
> >
> > > I'm investigating the SeaBIOS booting time, to understand if we can
> > > reduce the boot time in some cases (e.g. legacy hardware is not
> > > needed). I think this can be interesting also for NEMU developers.
> >
> > > The goal is to have only one image of SeaBIOS configurable at runtime
> > > to reduce the boot time, avoiding unnecessary initialization.
> >
> > Why at runtime?  What is bad with two images?  With a runtime option
> > you probably need some way to enable the "fastboot" hint for seabios,
> > because some optimizations (like skipping ps/2 initialization) breaks
> > functionality.  So it must be opt-in so you can enable it if you know
> > your use case is fine with that.  But "qemu -boot fast=3Don" isn't much
> > different from "qemu -bios seabios-fastboot.bin" after all ...
> >
>=20
> You are right, but maybe having a single image can be simpler to distribu=
te,
> and we can implement something (eg. using fw_cfg) to selectively enable
> features needed.
> Anyway, as the first step, I'll try to build a separate image of SeaBIOS.

Gerd, you may be right that explicit an command-line option like -boot
fast=3Don is required.  I was hoping SeaBIOS improvements could
automatically detect cases where no functionality is lost and would not
require new command-line options for users or management tools (e.g.
libvirt).

For example, if SeaBIOS sees -kernel, is it necessary to follow the full
BIOS boot process including loading option ROMs?  This way we could
avoid scanning PCI devices.

Admittedly I don't know the answer to how transparent we can make this,
but I hope Stefano will identify how far we can go.

Stefan

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb8rWBAAoJEJykq7OBq3PIrV4IAK2kmIjVFy8eJ+11FUxKFGQS
Dhk0tbG8SgEzn5hJXGJvn/quDhMnhHBzn+6J6LpEbjCDfXDFUi2tS5D4rRZV64J0
pSGWI2R4nRzLhqOLpvLWKtkJwsrno8/lCP/4hP8HeNV1X4OVJLIG5cXoLcq9RtqZ
fzLxXKWwctdOS5y6JsHA6a7rSpHtQ0WHZbvzQVxYZum4W+ApXEt33DbLrwYZFdlS
xFnk/w9hCa8O3ySSuyBjLwkBDOTOn0cYySRuzyYWMsurTO9KSjODH+RXLkgBnlRB
QrC5sPzEcz+HiUuRDPSpM7TaqLXwxrabY0H/kBKp172MahJg2VnDPjWbqvqvr6k=
=PmHL
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

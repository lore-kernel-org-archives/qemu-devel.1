Received: from eggs.gnu.org ([209.51.188.92]:57435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guaZI-0001Gc-UD
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guaZH-000412-SN
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:18:04 -0500
Date: Fri, 15 Feb 2019 16:21:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215052059.GL4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
	<f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
	<20190215032436.GG4573@umbus.fritz.box>
	<d6f2f973-f57a-f5f0-c20b-9a574e05bd7b@ozlabs.ru>
	<20190215035447.GI4573@umbus.fritz.box>
	<36b41743-e218-3b2e-7f96-6feee7849a66@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
Content-Disposition: inline
In-Reply-To: <36b41743-e218-3b2e-7f96-6feee7849a66@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2 0/4] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 03:34:52PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 15/02/2019 14:54, David Gibson wrote:
> > On Fri, Feb 15, 2019 at 02:32:14PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 15/02/2019 14:24, David Gibson wrote:
> >>> On Fri, Feb 15, 2019 at 11:35:02AM +1100, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 15/02/2019 10:37, Alex Williamson wrote:
> >>>>> On Thu, 14 Feb 2019 16:21:40 +1100
> >>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>
> >>>>>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
> >>>>>>
> >>>>>> This implements a subdriver for NVIDIA V100 GPU with coherent memo=
ry and
> >>>>>> NPU/ATS support available in the POWER9 CPU.
> >>>>>>
> >>>>>> 1/4 is a preparation for bigger DMA windows.
> >>>>>> 2/4 is a small cleanup.
> >>>>>>
> >>>>>> Here is the kernel driver:
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/drivers/vfio/pci?h=3Dv5.0-rc6&id=3D7f92891778dff62303c070ac81de7b7d=
80de331a
> >>>>>>
> >>>>>> SLOF changes already went in.
> >>>>>>
> >>>>>> This depends on "pci: Move NVIDIA vendor id to the rest of ids" (p=
osted separately).
> >>>>>
> >>>>> TBH, I'm not sure it was the best idea to let it live or die on it's
> >>>>> own when it now creates a build dependency for this series.
> >>>> I am sure that patch is disgustingly primitive and can make it to
> >>>> upstream in just one click and the rest of the series will take more
> >>>> time anyway (always does :) ).
> >>>>
> >>>>>> This is based on sha1
> >>>>>> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sung=
em for mac99 machine".
> >>>>>
> >>>>> Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
> >>>>> there dependencies we need to wait for in the ppc tree as well?
> >>>>
> >>>> There are few changes in spapr_pci so conflicts are possible, every =
time
> >>>> when David updates his tree and I rebase I get some minor ones.
> >>>>
> >>>>>> Please comment. Thanks.
> >>>>>
> >>>>> Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get th=
is:
> >>>>>
> >>>>> .../qemu.git/hw/vfio/spapr.c: In function =E2=80=98vfio_spapr_creat=
e_window=E2=80=99:
> >>>>> .../qemu.git/hw/vfio/spapr.c:212:9: error: =E2=80=98ret=E2=80=99 ma=
y be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>>>>          error_report("Failed to create a window, ret =3D %d (%m)",=
 ret);
> >>>>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >>>>> cc1: all warnings being treated as errors
> >>>>
> >>>> Agrh. How exactly do you make them errors, not warnings? I get no
> >>>> warning/error with --disable-werror but not having  --disable-werror
> >>>> prints warnings, not errors so it does not fail the build and easy t=
o miss.
> >>>
> >>> Are you sure it's printing warnings with --enable-werror?  Otherwise
> >>> it sounds like you just have a compiler version that's not picking
> >>> this up.
> >>
> >> Ah, here is my mistake - I thought not having --disable-werror means
> >> that it is enabled as ./configure does not advertise  "--enable-werror=
":
> >>
> >> [fstn1-p1 qemu]$ ./configure --help | grep werror
> >>   --disable-werror         disable compilation abort on warning
> >>
> >>
> >> Apparently it is a tri-state flag :)
> >=20
> > Um.. no.. I believe it should be on by default as well, I was just
> > saying --enable-werror because I thought it was clearer than the
> > double negative in "without --disable-werror".
>=20
> The default value of werror is "":
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dconfigure;h=3Da61682c3c72=
7f467ce2710c7469a33b261da8ff6;hb=3DHEAD#l935

Which turns into a "yes" on Linux - see line 1835-1844.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmTDkACgkQbDjKyiDZ
s5I2xw/+I5hwzOrYr3OIYZLIcDBb5GccKcMNyCr0nTRWJt+01GlJAY6Ur/IBa5I2
xJM6APGl5xBQQ647ZFUuoHQwkRRwXs8M+anlSX5SOQqAqGNjXCwOsWQi/5lHDqYZ
WyvcB10yvueJkRyPDuCr5xFZDVXXgVOtwZow4hlDZsi5llnHiZZUMs1oHTMXQFYF
aGYNYgdID4R+5SAEdmq4OdYc0Xg7YwUnFY+lfmTdPVQEnpez+P4xnIlshasI29Is
YOOm/HufBBnrSoKv99pLiZF/sbEtcnrjOniAEUEaqZaKQzh98F44jh5a1bVFueG/
7Tq3PupLP2e9KCBwkieisRVD9OfqOxho3e3TfyJfJoFQMijlIS9YV8fLKY1OASiR
ngzOpnMofGogboT5saVmF/P54+0DH5EdBl72g+ll5raE8n0zUH3s+hzr35Co1V1B
Yp3uqeMV2tNWSNXNuS+KI4mjKtRabmzqGAbtWqQ0Co+xnBzEopIUQNfdg2pxJNEk
VfEbIufbATJX/qaS1gXPzyDkuLiQ3DgPi7NtLX14+6gxeIXdI+ot4al7hHUncW+S
aQOPtGHZMwO5/GbdZDtydJlgZGbrPhW7JJcnYxhxyRjw2xf+eQtPC1f3C0Cy3jZU
QGC1IcfMiCsx3KHeBOb96hklFVscQt0p3pwhi4ZlkFnxVALhlEI=
=Di3m
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--

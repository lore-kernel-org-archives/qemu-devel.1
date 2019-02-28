Received: from eggs.gnu.org ([209.51.188.92]:46511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnh-0003wf-Tx
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnT-0005DS-HZ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:55:50 -0500
Date: Thu, 28 Feb 2019 13:21:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228022113.GA5894@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
	<f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
	<20190215032436.GG4573@umbus.fritz.box>
	<d6f2f973-f57a-f5f0-c20b-9a574e05bd7b@ozlabs.ru>
	<20190215035447.GI4573@umbus.fritz.box>
	<36b41743-e218-3b2e-7f96-6feee7849a66@ozlabs.ru>
	<20190215052059.GL4573@umbus.fritz.box>
	<dbf77c76-2398-572d-a59e-0ee0a4c5935d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <dbf77c76-2398-572d-a59e-0ee0a4c5935d@ozlabs.ru>
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


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 05:39:06PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 15/02/2019 16:21, David Gibson wrote:
> > On Fri, Feb 15, 2019 at 03:34:52PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 15/02/2019 14:54, David Gibson wrote:
> >>> On Fri, Feb 15, 2019 at 02:32:14PM +1100, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 15/02/2019 14:24, David Gibson wrote:
> >>>>> On Fri, Feb 15, 2019 at 11:35:02AM +1100, Alexey Kardashevskiy wrot=
e:
> >>>>>>
> >>>>>>
> >>>>>> On 15/02/2019 10:37, Alex Williamson wrote:
> >>>>>>> On Thu, 14 Feb 2019 16:21:40 +1100
> >>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>>
> >>>>>>>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
> >>>>>>>>
> >>>>>>>> This implements a subdriver for NVIDIA V100 GPU with coherent me=
mory and
> >>>>>>>> NPU/ATS support available in the POWER9 CPU.
> >>>>>>>>
> >>>>>>>> 1/4 is a preparation for bigger DMA windows.
> >>>>>>>> 2/4 is a small cleanup.
> >>>>>>>>
> >>>>>>>> Here is the kernel driver:
> >>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/drivers/vfio/pci?h=3Dv5.0-rc6&id=3D7f92891778dff62303c070ac81de7b=
7d80de331a
> >>>>>>>>
> >>>>>>>> SLOF changes already went in.
> >>>>>>>>
> >>>>>>>> This depends on "pci: Move NVIDIA vendor id to the rest of ids" =
(posted separately).
> >>>>>>>
> >>>>>>> TBH, I'm not sure it was the best idea to let it live or die on i=
t's
> >>>>>>> own when it now creates a build dependency for this series.
> >>>>>> I am sure that patch is disgustingly primitive and can make it to
> >>>>>> upstream in just one click and the rest of the series will take mo=
re
> >>>>>> time anyway (always does :) ).
> >>>>>>
> >>>>>>>> This is based on sha1
> >>>>>>>> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to su=
ngem for mac99 machine".
> >>>>>>>
> >>>>>>> Perhaps this is why it doesn't apply cleanly against qemu.git.  A=
re
> >>>>>>> there dependencies we need to wait for in the ppc tree as well?
> >>>>>>
> >>>>>> There are few changes in spapr_pci so conflicts are possible, ever=
y time
> >>>>>> when David updates his tree and I rebase I get some minor ones.
> >>>>>>
> >>>>>>>> Please comment. Thanks.
> >>>>>>>
> >>>>>>> Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get =
this:
> >>>>>>>
> >>>>>>> .../qemu.git/hw/vfio/spapr.c: In function =E2=80=98vfio_spapr_cre=
ate_window=E2=80=99:
> >>>>>>> .../qemu.git/hw/vfio/spapr.c:212:9: error: =E2=80=98ret=E2=80=99 =
may be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>>>>>>          error_report("Failed to create a window, ret =3D %d (%m)=
", ret);
> >>>>>>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> >>>>>>> cc1: all warnings being treated as errors
> >>>>>>
> >>>>>> Agrh. How exactly do you make them errors, not warnings? I get no
> >>>>>> warning/error with --disable-werror but not having  --disable-werr=
or
> >>>>>> prints warnings, not errors so it does not fail the build and easy=
 to miss.
> >>>>>
> >>>>> Are you sure it's printing warnings with --enable-werror?  Otherwise
> >>>>> it sounds like you just have a compiler version that's not picking
> >>>>> this up.
> >>>>
> >>>> Ah, here is my mistake - I thought not having --disable-werror means
> >>>> that it is enabled as ./configure does not advertise  "--enable-werr=
or":
> >>>>
> >>>> [fstn1-p1 qemu]$ ./configure --help | grep werror
> >>>>   --disable-werror         disable compilation abort on warning
> >>>>
> >>>>
> >>>> Apparently it is a tri-state flag :)
> >>>
> >>> Um.. no.. I believe it should be on by default as well, I was just
> >>> saying --enable-werror because I thought it was clearer than the
> >>> double negative in "without --disable-werror".
> >>
> >> The default value of werror is "":
> >>
> >> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dconfigure;h=3Da61682c3=
c727f467ce2710c7469a33b261da8ff6;hb=3DHEAD#l935
> >=20
> > Which turns into a "yes" on Linux - see line 1835-1844.
>=20
>=20
> No it does not - the 'test -d "$source_path/.git"' fails as "git
> worktree" makes .git a file, not a folder.

Oh, right.  Turns into a "yes" for people who don't have weird git
setups :-p.  Care to submit a patch to make it do the right thing in
your setup?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3RZYACgkQbDjKyiDZ
s5JVDg/+PmhTpM+9z1HMCaNBviST3MT2Zb08AwjxyjdS15n3xxr7dPx2OTh9KOVL
7AyHsEBbj6mp6zc3E1DVXdJV+jKXVyOy//A9eG6kFnQbs8XiwRYk+fI5CM80wcWp
ZXgo7WNsD4E9wxJIa9m9+4yTuxqLuYGCxL12M/llLT5HG6V7YQeBxgLhn60nCwTG
roI47nRPTmk9edbjZyP0g0HYbxYz8FihqeVmYj/vRFqj8tKanA2m0Xt0hjoEvfKh
ya3gHQkgbJqsrihd1VR5wyrpXL43vxiXdBkD/67PI2fL4aKQob+m67p3IH9JnmDj
a88Vq8qkyMFWs+TNw4WP/DguzskcrKQnhDomJCAWngyeHwd1cd2hL8N+p0bqiY44
Agp7nrz52bCZbUPsUJA0PGhhKfInPmlZhdLBA5nxIiqlzoweP0e3ZJ5pIMFgIDbu
u80fanx/46gpQDwT6QvLFeKy5coyKewSQlmJyygRcJnZB1MqD+2QX+fPbymSGbsG
o1UcYPfDmaU+y/mP2K2DTkqnFBmVfYi9lvoYgV4Zp2Vw1Pw6m5wsm8kOJvLX1jf3
wbO9UkbgUHxAnEEddbFK8uk1PRTb5KXgoImwKNCJKUh4AJ26jjssXk0rWXolspTi
nk75jjh1MgA1QtQFOIEv4je+m9V6qUiCYhvURFd16UKnM40A4QM=
=YQT1
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

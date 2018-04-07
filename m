Received: from eggs.gnu.org ([2001:4830:134:3::10]:37762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4cAL-0000om-E5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4cAK-00080Q-3T
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:57:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f4cAJ-0007sp-0C
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:57:12 -0400
Date: Sat, 7 Apr 2018 10:54:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180407005432.GE3212@umbus.fritz.box>
References: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
	<alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
	<95d8655f-9956-6d7b-1419-efae9893784f@msgid.tls.msk.ru>
	<alpine.BSF.2.21.1804061352030.50304@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1804061352030.50304@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] some ROMs questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 01:59:03PM +0200, BALATON Zoltan wrote:
> On Fri, 6 Apr 2018, Michael Tokarev wrote:
> > 02.04.2018 17:30, BALATON Zoltan wrote:
> > > On Mon, 2 Apr 2018, Michael Tokarev wrote:
> > > > roms/u-boot-sam460ex/tools/updater/stubs.c -
> > > > it is some strange symlink pointing to a strange place, probably sh=
ould be removed?
> > >=20
> > > This does not seem to matter for building the rom image but this can =
be fixed by converting it to a relative path. I've done that and will send =
a patch to update the submodule as well to use the QEMU repo now that we ha=
ve a mirror there. Thanks for finding this.
> >=20
> > Hmm, I've no idea how to pull a submodule change.. :)
>=20
> git submodule update? But it's not in master yet only in David's
> ppc-for-2.12 branch I think.
>=20
> > But I've one more question about this rom.  When I'm trying to build it,
> > the build fails:
> >=20
> > roms/u-boot-sam460ex$ make Sam460ex_config CROSS_COMPILE=3Dpowerpc64-li=
nux-gnu-
> > Generating include/autoconf.mk
> > cc1: error: -mcall not supported in this configuration
> > cc1: error: -mrelocatable not supported in this configuration
> > cc1: error: -meabi not supported in this configuration
> > cc1: error: -m64 requires a PowerPC64 cpu
> > Generating include/autoconf.mk.dep
> > cc1: error: -mcall not supported in this configuration
> > cc1: error: -mrelocatable not supported in this configuration
> > cc1: error: -meabi not supported in this configuration
> > cc1: error: -m64 requires a PowerPC64 cpu
> > Configuring for Sam460ex board...
> >=20
> > roms/u-boot-sam460ex$ make CROSS_COMPILE=3Dpowerpc64-linux-gnu-
> > ...
> > make -C arch/powerpc/cpu/ppc4xx start.o
> > make[1]: Entering directory '/build/qemu/debian-qemu/roms/u-boot-sam460=
ex/arch/powerpc/cpu/ppc4xx'
> > powerpc64-linux-gnu-gcc   -D__ASSEMBLY__ -g  -Os   -mrelocatable -fPIC =
-meabi -ffunction-sections -fdata-sections -D__KERNEL__ -DTEXT_BASE=3D0xFFF=
80000 -I/build/qemu/debian-qemu/roms/u-boot-sam460ex/include -fno-builtin -=
ffreestanding -nostdinc -isystem /usr/lib/gcc-cross/powerpc64-linux-gnu/6/i=
nclude -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2 -mstring -=
msoft-float -Wa,-m440 -mcpu=3D440 -DCONFIG_440=3D1 -I../bios_emulator/scite=
ch/include -I../bios_emulator/scitech/src/x86emu -Dprintk=3Dprintf   \
> >        -o start.o start.S -c
> > start.S:1:0: error: -mcall not supported in this configuration
> > /*
> >=20
> > start.S:1:0: error: -mrelocatable not supported in this configuration
> > start.S:1:0: error: -meabi not supported in this configuration
> > start.S:1:0: error: -m64 requires a PowerPC64 cpu
> > /build/qemu/debian-qemu/roms/u-boot-sam460ex/config.mk:249: recipe for =
target 'start.o' failed
> > make[1]: *** [start.o] Error 1
> > make[1]: Leaving directory '/build/qemu/debian-qemu/roms/u-boot-sam460e=
x/arch/powerpc/cpu/ppc4xx'
> > Makefile:353: recipe for target 'arch/powerpc/cpu/ppc4xx/start.o' failed
> > make: *** [arch/powerpc/cpu/ppc4xx/start.o] Error 2
> >=20
> > What I'm doing wrong?
> >=20
> > $ powerpc64-linux-gnu-gcc --version
> > powerpc64-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
>=20
> Note sure, maybe building it with ppc64 compiler or a too new one? This
> board is 32bit and the source is from 2011 so I'm not sure what it does w=
ith
> recent compilers. I have powerpc-elf-gcc 4.9.3 which works.

Yeah, if it's a 32-bit board, I'm pretty sure you'll need a 32-bit
compiler.  Or at least add -m32 if it's a biarch compiler.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrIFsUACgkQbDjKyiDZ
s5JqAw/+O2ycoj6+E+bO+NxREnlC/VxEcZOq4Ai4OxDZnJQiLZzfGXuw2U7Ok3CT
9h9pFreZgsGrYHmQCfqS2hS2pGFaVFfbdDpiGX612IUMoNUhDWKVWhi7/FAND9zx
1G9RKfp3Z3xacMlpkSwufVGM50Bco6Oqxm654Gd3FUDUStAyDa2rZm9bTfv7fWMu
ZLn+tw2YlVAoVDWctaa6e7tKZYp2ScTq8QM7eha4JyQGopuNuMhgR0NLbYYtZqsl
bktJhsWIFRq44dOGSLLG32lApoHiM0IQAqJwt47onfQgplfCFKUW6RDswWk3u0or
JosG0sMm5/nKqVXq+8Z4HsYvl4VySAYHVMpkarwnUAmxJnusOIquRB0SGwl8aVvQ
wO+As1KvR2V9e0qn/CBCPFW50iR4Kh98ovfY6CLr2eYcMkX04tGbQIcATnSSWjAX
FuN7IH08GulpBUzBlo1Nx8fBEbTgzANk4iJjwn0UmVeILyIP8c1SkF2GabGMZmOn
vTnLQdCGj4CqqvjjUdcOT9b/QmJDpaCfTPRJAGCBwS4y0XHFzJM03ZIbyC40Q9WW
Yu7p0in7xvWsTWaohLhOn5y5+yHMMcAc3vT+KBOzyohEseJiEn7DJQ1stf6Vc6aq
ME6u2X+/WWokC6zl7LkCg21kKFDBxgwik8ycs0/meHh4fK8oy/Y=
=WV15
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--

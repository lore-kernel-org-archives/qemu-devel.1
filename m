Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBJ4d-0007w5-TL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBJ4c-0004gT-Jl
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:54:27 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBJ4c-0004g0-AM
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:54:26 -0400
Date: Thu, 18 May 2017 12:54:13 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518105413.35nurpeltmtj7l3q@aurel32.net>
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
	<f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
	<8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
	<6f73123b-d235-3680-89cc-8ed5b02a7040@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="itwoywv4z72add5h"
Content-Disposition: inline
In-Reply-To: <6f73123b-d235-3680-89cc-8ed5b02a7040@gmx.com>
Subject: Re: [Qemu-devel] [Bug 1691379] [NEW] NetBSD evbmips64el port
 installation doesn't work with qemu-system-mips64el.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Thomas Huth <thuth@redhat.com>, Bug 1691379 <1691379@bugs.launchpad.net>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>


--itwoywv4z72add5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-05-18 04:29, Kamil Rytarowski wrote:
> On 17.05.2017 19:58, Kamil Rytarowski wrote:
> > On 17.05.2017 10:10, Thomas Huth wrote:
> >> On 17.05.2017 09:52, Utkarsh Anand wrote:
> >>> Public bug reported:
> >>>
> >>> I successfully installed the NetBSD evbmips64el port on gxemul but was
> >>> unable to install it on qemu. Trying to boot it on qemu takes me to t=
he
> >>> 'db>' prompt. Here's the output and backtrace:
> >>>
> >>> panic: pcib_isa_intr_string: bogus isa irq 0x0
> >>> kernel: breakpoint trap
> >>> Stopped in pid 0.1 (system) at  netbsd:cpu_Debugger+0x4:        jr   =
   ra
> >>>                 bdslot: nop
> >>> db> bt
> >>> 0xffffffff805977f0: cpu_Debugger+4 (63061,90000000180003f8,6,ffffffff=
804c2290) ra ffffffff8030acd0 sz 0
> >>> 0xffffffff805977f0: vpanic+158 (63061,90000000180003f8,6,ffffffff804c=
2290) ra ffffffff8030ad7c sz 64
> >>> 0xffffffff80597830: panic+34 (63061,ffffffff803d65b0,0,40) ra fffffff=
f80109784 sz 96
> >>> 0xffffffff80597890: pcib_isa_intr_string+6c (63061,ffffffff803d65b0,0=
,40) ra ffffffff80149bfc sz 16
> >>> 0xffffffff805978a0: uhci_pci_attach+16c (63061,ffffffff803d65b0,0,40)=
 ra ffffffff802f0400 sz 176
> >>> 0xffffffff80597950: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,4=
0) ra ffffffff802f053c sz 64
> >>> 0xffffffff80597990: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,=
40) ra ffffffff80121354 sz 64
> >>> 0xffffffff805979d0: pci_probe_device+524 (63061,ffffffff803d65b0,0,0)=
 ra ffffffff80121548 sz 288
> >>> 0xffffffff80597af0: pci_enumerate_bus+1d0 (63061,ffffffff803d65b0,0,0=
) ra ffffffff8012167c sz 160
> >>> 0xffffffff80597b90: pcirescan+5c (63061,ffffffff803d65b0,0,0) ra ffff=
ffff801218c4 sz 32
> >>> 0xffffffff80597bb0: pciattach+19c (63061,ffffffff803d65b0,0,0) ra fff=
fffff802f0400 sz 80
> >>> 0xffffffff80597c00: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0=
) ra ffffffff802f053c sz 64
> >>> 0xffffffff80597c40: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,=
0) ra ffffffff80108934 sz 64
> >>> 0xffffffff80597c80: gt_attach+7c (63061,ffffffff803d65b0,0,0) ra ffff=
ffff802f0400 sz 112  =20
> >>> 0xffffffff80597cf0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0=
) ra ffffffff802f053c sz 64
> >>> 0xffffffff80597d30: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,=
0) ra ffffffff801086ac sz 64
> >>> 0xffffffff80597d70: mainbus_attach+dc (63061,ffffffff803d65b0,0,0) ra=
 ffffffff802f0400 sz 96
> >>> 0xffffffff80597dd0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0=
) ra ffffffff80104bf8 sz 64
> >>> 0xffffffff80597e10: cpu_configure+28 (63061,ffffffff803d65b0,0,0) ra =
ffffffff803d5f30 sz 16
> >>> 0xffffffff80597e20: main+3a0 (63061,ffffffff803d65b0,0,0) ra ffffffff=
801000dc sz 128      =20
> >>> 0xffffffff80597ea0: kernel_text+dc (63061,ffffffff803d65b0,0,0) ra 0 =
sz 0
> >>> User-level: pid 0.1
> >>>
> >>> Here's the command that I used:
> >>>
> >>> Build evbmips64el from source and then launch it from qemu (replace t=
he
> >>> paths relative to your system):
> >>>
> >>> qemu-system-mips64el -cdrom
> >>> /extra/evbmips64/distrib/evbmips/cdroms/installcd/NetBSD-7.99.71
> >>> -evbmips-mips64el.iso -hda /extra/evbmips64.img -kernel
> >>> /extra/evbmips64/releasedir/evbmips/installation/netbsd-INSTALL_MALTA=
64
> >>> -nographic -M malta
> >>>
> >>> (I've decompressed the kernel)
> >>>
> >>> Here's the output for qemu-system-mips64el --version :
> >>>
> >>> QEMU emulator version 2.7.1(qemu-2.7.1-6.fc25), Copyright (c) 2003-20=
16
> >>> Fabrice Bellard and the QEMU Project developers
> >>>
> >>> This doesn't look like a NetBSD bug. I've attached a screenshot of the
> >>> working installation using gxemul in the attachments.
> >>
> >> When reporting such issues, please always use the latest release of QE=
MU
> >> first, so could you please try again with the latest upstream release =
of
> >> QEMU (currently v2.9.0)? Thanks!
> >>
> >>  Thomas
> >>
> >=20
> > 7.99.71 is the most recent kernel ABI version (NetBSD-current).
> >=20
> > Release engineering builds of NetBSD-current are hosted on nyftp.netbsd=
=2Eorg.
> >=20
> > kernel:
> >=20
> > http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/evbmips-mip=
s64el/installation/
> >=20
> > installation medium:
> >=20
> > http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/images/
> >=20
> > [In future there will be need to switch 201705170540Z to a newer
> > snapshot, as this one will be removed.]
> >=20
> > I will have to a look tonight and try to reproduce locally (and take
> > MIPS 64-bit crash course).
> >=20
>=20
> I've reproduced it locally with qemu/NetBSD-7.99.71 ver. 2.9 git HEAD
> (rev. cdece0467c00007cf8e3).
>=20
>     464 const char *
>     465 pcib_isa_intr_string(void *v, int irq, char *buf, size_t len)
>     466 {
>     467 	if (irq =3D=3D 0 || irq >=3D ICU_LEN || irq =3D=3D 2)
>     468 		panic("%s: bogus isa irq 0x%x", __func__, irq);
>     469
>     470 	snprintf(buf, len, "isa irq %d", irq);
>     471 	return buf;
>     472 }
>=20
> Generates: "panic: pcib_isa_intr_string: bogus isa irq 0x0".

I haven't look in details, but it looks like that the PCI initialization
hasn't been done. This should be the responsibility of the firmware, but
the Malta emulation doesn't use any firmware when booting with -kernel. It
works with the Linux kernel because there is some fixup code which does
the work if it hasn't been done in the firmware. See:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/mips/pci/fixup-malta.c

One option would be to implement the same on the NetBSD side. The other
option is to use YAMON or U-Boot to load the NetBSD kernel.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--itwoywv4z72add5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEd0YmQqnvlP0Pdxltupx4Bh3djJsFAlkdfVUACgkQupx4Bh3d
jJtqAg/9EmCzrvcZ4OFvfi6Eb01paEKd537vSKP3SX923yfl6cEZg/iooJGqudt7
GoEeUkFIs3eR5IAhIkUdfaWwnQjPFzXr6z8QPLnx+VtF8Jo6RP8iyXGUkTpd1u6A
/E1ysFtgixNDN7yr8toeWtIe2EFNVg2s/wNEfQeG3RxUc0Lpvas48EdWECBa1wHO
0JzibYypwBD0b7ruJcVR/jPW2Ad4EQ0W8BAIxTDjn4pjL3WiMDSXvv6G9b/6zcDQ
HqS3SsYT93ZHSsLCPZ5TvevGgaY/jni/kTKoqKIQfC/Txuee7FRkyt3wkHsEp6M4
2Kd13A53Me9LiWPnO4kZbA7SpT3DtJFXgkK0iCktmoApiV+Jdy9zDI524lNoI+rk
GqP+M105DdCjmAH0jLR/Gha4CTEXCRFlE7pc+BKuZ6GPCKYq/RQTqZxtrMP9TMGc
NxVgvHQgKNtcMR+63IbM8EwE/h8Y4yOEcztRz3y3p0SVBPVYo/RadyZgyAfHQvUg
3rLiaaPKjrApZX1L8V6Zs+j08wSmHFCBwqheHInnB4PyMI7ozaPaPYqWA3saQh9R
juvw9DXEmNJYSWonKzEeajRHFiJItgGIbrVAfM2WEU/7WvqjvPc7eSUlGcT0VWu1
BP6FN/lg9hQUnSdvjfUWb5zspPJbALbZK80pGhdkD0O7TkV8c/M=
=MscB
-----END PGP SIGNATURE-----

--itwoywv4z72add5h--

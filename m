Received: from eggs.gnu.org ([2001:4830:134:3::10]:38838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8OGW-0000oY-Jo
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8OGS-0000Ov-Si
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:50:40 -0400
Date: Wed, 10 May 2017 19:45:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510094542.GA14408@umbus.fritz.box>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
	<149440262829.285.3407353522530465007@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <149440262829.285.3407353522530465007@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PULL 00/22] ppc-for-2.10 queue 20170510
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru, mark.cave-ayland@ilande.co.uk, agraf@suse.de, qemu-ppc@nongnu.org, clg@kaod.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 12:50:29AM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 20170510070115.13063-1-david@gibson.dropbear.id.au
> Type: series
> Subject: [Qemu-devel] [PULL 00/22] ppc-for-2.10 queue 20170510
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailbac=
k -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 1b70f29 pnv: Fix build failures on some host platforms
> 86671f8 target/ppc: Allow workarounds for POWER9 DD1
> 6cedee8 spapr: Don't accidentally advertise HTM support on POWER9
> 6977773 ppc: xics: fix compilation with CentOS 6
> eafc8f5 target/ppc: Enable RADIX mmu mode for pseries TCG guest
> 0695293 target/ppc: Implement ISA V3.00 radix page fault handler
> 44c9403 target/ppc: Change tlbie invalid fields for POWER9 support
> 9b09287 target/ppc: Update tlbie to check privilege level based on GTSE
> d1a36ba target/ppc: Set UPRT and GTSE on all cpus in H_REGISTER_PROCESS_T=
ABLE
> 7cf9c6f ppc: add qemu_vga.ndrv ROM to fw_cfg interface for NewWorld Macs
> dd211ca ppc: add qemu_vga.ndrv ROM to fw_cfg interface for OldWorld Macs
> 757323f Add QemuMacDrivers qemu_vga.ndrv revision d4e7d7a built as submod=
ule
> 636240c Add QemuMacDrivers as submodule
> bd86886 ppc/xics: preserve P and Q bits for KVM IRQs
> c769966 ppc/xics: Fix stale irq->status bits after get
> fe7ce46 target/ppc: do not reset reserve_addr in exec_enter
> 48eb3bf tcg: enable MTTCG by default for PPC64 on x86
> 46bdb83 cpus: Fix CPU unplug for MTTCG
> 64d1b41 target/ppc: Generate fence operations
> 688eb24 cputlb: handle first atomic write to the page
> 625734c target/ppc: Emulate LL/SC using cmpxchg helpers
> d736912 ppc/pnv: restrict BMC object to the BMC simulator
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/22: ppc/pnv: restrict BMC object to the BMC simulator...
> Checking PATCH 2/22: target/ppc: Emulate LL/SC using cmpxchg helpers...
> Checking PATCH 3/22: cputlb: handle first atomic write to the page...
> Checking PATCH 4/22: target/ppc: Generate fence operations...
> Checking PATCH 5/22: cpus: Fix CPU unplug for MTTCG...
> Checking PATCH 6/22: tcg: enable MTTCG by default for PPC64 on x86...
> Checking PATCH 7/22: target/ppc: do not reset reserve_addr in exec_enter.=
=2E.
> Checking PATCH 8/22: ppc/xics: Fix stale irq->status bits after get...
> Checking PATCH 9/22: ppc/xics: preserve P and Q bits for KVM IRQs...
> Checking PATCH 10/22: Add QemuMacDrivers as submodule...
> Checking PATCH 11/22: Add QemuMacDrivers qemu_vga.ndrv revision d4e7d7a b=
uilt as submodule...
> Checking PATCH 12/22: ppc: add qemu_vga.ndrv ROM to fw_cfg interface for =
OldWorld Macs...
> Checking PATCH 13/22: ppc: add qemu_vga.ndrv ROM to fw_cfg interface for =
NewWorld Macs...
> Checking PATCH 14/22: target/ppc: Set UPRT and GTSE on all cpus in H_REGI=
STER_PROCESS_TABLE...
> Checking PATCH 15/22: target/ppc: Update tlbie to check privilege level b=
ased on GTSE...
> Checking PATCH 16/22: target/ppc: Change tlbie invalid fields for POWER9 =
support...
> Checking PATCH 17/22: target/ppc: Implement ISA V3.00 radix page fault ha=
ndler...
> ERROR: Macros with complex values should be enclosed in parenthesis
> #413: FILE: target/ppc/mmu-radix64.h:19:
> +#define PRTBE_R_GET_RTS(rts)    (((rts >> 58) & 0x18) | ((rts >> 5) & 0x=
7)) + 31

Crud.  that's actually an important one, I should have caught it.

> total: 1 errors, 0 warnings, 373 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 18/22: target/ppc: Enable RADIX mmu mode for pseries TCG g=
uest...
> Checking PATCH 19/22: ppc: xics: fix compilation with CentOS 6...
> Checking PATCH 20/22: spapr: Don't accidentally advertise HTM support on =
POWER9...
> Checking PATCH 21/22: target/ppc: Allow workarounds for POWER9 DD1...
> Checking PATCH 22/22: pnv: Fix build failures on some host platforms...
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEuFDAAoJEGw4ysog2bOSh6YQAOcltjo4qWcV7U/pHw1/Rpaj
4MYvZBR1rV/O/7WDS5YjscaGw6Rya7Gf7tAr7CllnY4EXqJ5LAplMSYSOcXU9D3o
MTenApAQQdLmXQhPyibJfw9B3WeCr2u4PGZ7kcO44ewgSfmGWFLk5ZxgkxTpByo/
kFEQxWXcs2r7f7UG2UORXfjlH9fOAgr/nY+/UvcHMPxJLTr4Pq7Y1w3auz0pFzCO
Hge1V3pLtYeHXrP4zp+2K/eZxwRpQ58CDnkXM/SDEonaEH8ZXjJuv0GGy/BNF7QG
8NZeoAleZno4dTBY7gOCVauu+lyEOxYEqBgdr27Rmfs1A8Ebrj4KR+J5tho4RZjo
MrEH+uY+huSBhnJPXrdCMHSx6/kL/IWfrCMG2hG1KJrhqFacNvqiqfPWYDdgjOmp
8e4lXV9aDDUL9IRCAr/odibn333gy227oqaphYOzvuyEuOHoOPJZr+abVUM9hZ/F
ymG8XzDlLvrSCnoP0SMoEWxLMB5XLHg9ngPisnayfgRryPAqtU6KEEWCJ/XDdLqI
321lC5+ZbcNHYAVnA8YJNAtCpU8pYQSnGXp53qlHaPHnEeaEQlRs23yt0Gq2mv5s
Fib3RYwJvx5QCVkYCm0AhEo8jd4SWB9r2lggjsY5t/Q+yzlzlpvRaR3YZp1K0O0c
NXrgjuH6SboWB6cdSODe
=jCf9
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

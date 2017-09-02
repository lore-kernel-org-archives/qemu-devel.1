Received: from eggs.gnu.org ([2001:4830:134:3::10]:54694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1do0BK-0004sI-Dn
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 00:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1do0BE-0007Mt-Ff
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 00:37:18 -0400
Date: Sat, 2 Sep 2017 12:45:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170902024503.GP3386@umbus.fritz.box>
References: <1504251492-7819-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Content-Disposition: inline
In-Reply-To: <1504251492-7819-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Remove old STATUS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2017 at 09:38:12AM +0200, Thomas Huth wrote:
> The target/ppc/STATUS file has seen its last real update 10 years
> ago - so the information in there is not up to date anymore. Since
> nobody seems to care about this file, let's simply remove it.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.11.

> ---
>  target/ppc/STATUS | 550 ------------------------------------------------=
------
>  1 file changed, 550 deletions(-)
>  delete mode 100644 target/ppc/STATUS
>=20
> diff --git a/target/ppc/STATUS b/target/ppc/STATUS
> deleted file mode 100644
> index a4d48a7..0000000
> --- a/target/ppc/STATUS
> +++ /dev/null
> @@ -1,550 +0,0 @@
> -PowerPC emulation status.
> -The goal of this file is to provide a reference status to avoid regressi=
ons.
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -PowerPC core emulation status
> -
> -INSN: instruction set.
> -      OK =3D> all instructions are emulated
> -      KO =3D> some insns are missing or some should be removed
> -      ?  =3D> unchecked
> -SPR:  special purpose registers set
> -      OK =3D> all SPR registered (but some may be fake)
> -      KO =3D> some SPR are missing or should be removed
> -      ?  =3D> unchecked
> -MSR:  MSR bits definitions
> -      OK =3D> all MSR bits properly defined
> -      KO =3D> MSR definition is incorrect
> -      ?  =3D> unchecked
> -IRQ:  input signals definitions (mostly interrupts)
> -      OK =3D> input signals are properly defined
> -      KO =3D> input signals are not implemented (system emulation does n=
ot work)
> -      ?  =3D> input signals definitions may be incorrect
> -MMU:  MMU model implementation
> -      OK =3D> MMU model is implemented and Linux is able to boot
> -      KO =3D> MMU model not implemented or bugged
> -      ?  =3D> MMU model not tested
> -EXCP: exceptions model implementation
> -      OK =3D> exception model is implemented and Linux is able to boot
> -      KO =3D> exception model not implemented or known to be buggy
> -      ?  =3D> exception model may be incorrect or is untested
> -
> -Embedded PowerPC cores
> -***
> -PowerPC 401:
> -INSN  OK
> -SPR   OK 401A1
> -MSR   OK
> -IRQ   KO partially implemented
> -MMU   OK
> -EXCP  ?
> -
> -PowerPC 401x2:
> -INSN  OK
> -SPR   OK 401B2 401C2 401D2 401E2 401F2
> -MSR   OK
> -IRQ   KO partially implemented
> -MMU   OK
> -EXCP  ?
> -
> -PowerPC IOP480:
> -INSN  OK
> -SPR   OK IOP480
> -MSR   OK
> -IRQ   KO partially implemented
> -MMU   OK
> -EXCP  ?
> -
> -To be checked: 401G2 401B3 Cobra
> -
> -***
> -PowerPC 403:
> -INSN  OK
> -SPR   OK 403GA 403GB
> -MMU   OK
> -MSR   OK
> -IRQ   KO not implemented
> -EXCP  ?
> -
> -PowerPC 403GCX:
> -INSN  OK
> -SPR   OK 403GCX
> -MMU   OK
> -MSR   OK
> -IRQ   KO not implemented
> -EXCP  ?
> -
> -To be checked: 403GC
> -
> -***
> -PowerPC 405:
> -Checked: 405CRa 405CRb 405CRc 405EP 405GPa 405GPb 405GPc 405GPd 405GPe 4=
05GPR
> -         Npe405H Npe405H2 Npe405L
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots (at least 1 proprietary firmware).
> -         uboot seems to freeze at boot time.
> -To be checked: 405D2 405D4 405EZ 405LP Npe4GS3 STB03 STB04 STB25
> -               x2vp4 x2vp7 x2vp20 x2vp50
> -
> -XXX: find what is IBM e407b4
> -
> -***
> -PowerPC 440:
> -Checked: 440EPa 440EPb 440GXa 440GXb 440GXc 440GXf 440SP 440SP2
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   KO not implemented
> -MMU   ?
> -EXCP  ?
> -
> -PowerPC 440GP:
> -Checked: 440GPb 440GPc
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   KO not implemented
> -MMU   ?
> -EXCP  ?
> -
> -PowerPC 440x4:
> -Checked: 440A4 440B4 440G4 440H4
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   KO not implemented
> -MMU   ?
> -EXCP  ?
> -
> -PowerPC 440x5:
> -Checked: 440A5 440F5 440G5 440H6 440GRa
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   KO not implemented
> -MMU   ?
> -EXCP  ?
> -
> -To be checked: 440EPx 440GRx 440SPE
> -
> -***
> -PowerPC 460: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -PowerPC 460F: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -***
> -PowerPC e200: (not implemented)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -***
> -PowerPC e300: (not implemented)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -***
> -PowerPC e500: (not implemented)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -***
> -PowerPC e600: (not implemented)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -***
> -32 bits PowerPC
> -PowerPC 601: (601 601v2)
> -INSN  OK
> -SPR   OK is HID15 only on 601v2 ?
> -MSR   OK
> -IRQ   KO not implemented
> -MMU   ?
> -EXCP  ?
> -Remarks: some instructions should have a specific behavior (not implemen=
ted)
> -
> -PowerPC 602: 602
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   ?
> -EXCP  ? at least timer and external interrupt are OK
> -Remarks: Linux 2.4 crashes when entering user-mode.
> -         Linux 2.6.22 boots on this CPU but does not recognize it.
> -
> -PowerPC 603: (603)
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots and properly recognizes the CPU
> -         Linux 2.6.22 idem.
> -
> -PowerPC 603e: (603e11)
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots and properly recognizes the CPU
> -         Linux 2.6.22 idem.
> -
> -PowerPC G2:
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots, recognizes the CPU as a 82xx.
> -         Linux 2.6.22 idem.
> -
> -PowerPC G2le:
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 does not boots. Same symptoms as 602.
> -         Linux 2.6.22 boots and properly recognizes the CPU.
> -
> -PowerPC 604:
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots and properly recognizes the CPU.
> -         Linux 2.6.22 idem.
> -
> -PowerPC 7x0:
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots and properly recognizes the CPU.
> -         Linux 2.6.22 idem.
> -
> -PowerPC 750fx:
> -INSN  OK
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  OK
> -Remarks: Linux 2.4 boots but does not properly recognizes the CPU.
> -         Linux 2.6.22 boots and properly recognizes the CPU.
> -
> -PowerPC 7x5:
> -INSN  ?
> -SPR   ?
> -MSR   ?
> -IRQ   OK
> -MMU   ?
> -EXCP  OK
> -Remarks: Linux 2.4 does not boot.
> -         Linux 2.6.22 idem.
> -
> -PowerPC 7400:
> -INSN  KO Altivec missing
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  ?  Altivec, ...
> -Remarks: Linux 2.4 boots and properly recognize the CPU.
> -         Linux 2.6.22 idem.
> -
> -PowerPC 7410:
> -INSN  KO Altivec missing
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  ?  Altivec, ...
> -Remarks: Linux 2.4 boots and properly recognize the CPU.
> -         Linux 2.6.22 idem.
> -   Note that UM says tlbld & tlbli are implemented but this may be a mis=
take
> -   as TLB loads are managed by the hardware and the CPU does not impleme=
nt the
> -   needed registers.
> -
> -PowerPC 7441:
> -INSN  KO Altivec missing
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  ?  Altivec, ...
> -Remarks: Linux does not have the code to handle TLB miss on this CPU
> -         Linux 2.6.22 idem.
> -
> -PowerPC 7450/7451:
> -INSN  KO Altivec missing
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  ?  Altivec, ...
> -Remarks: Linux does not have the code to handle TLB miss on this CPU
> -         Linux 2.6.22 idem.
> -
> -PowerPC 7445/7447:
> -INSN  KO Altivec missing
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  ?  Altivec, ...
> -Remarks: Linux does not have the code to handle TLB miss on this CPU
> -         Linux 2.6.22 idem.
> -
> -PowerPC 7455/7457:
> -INSN  KO Altivec missing
> -SPR   OK
> -MSR   OK
> -IRQ   OK
> -MMU   OK
> -EXCP  ?  Altivec, ...
> -Remarks: Linux does not have the code to handle TLB miss on this CPU
> -         Linux 2.6.22 idem.
> -
> -64 bits PowerPC
> -PowerPC 620: (disabled)
> -INSN  KO
> -SPR   KO
> -MSR   ?
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -Remarks: not much documentation for this implementation...
> -
> -PowerPC 970:
> -INSN  KO Altivec missing and more
> -SPR   KO
> -MSR   ?
> -IRQ   OK
> -MMU   OK
> -EXCP  KO partially implemented
> -Remarks: Should be able to boot but there is no hw platform currently em=
ulated.
> -
> -PowerPC 970FX:
> -INSN  KO Altivec missing and more
> -SPR   KO
> -MSR   ?
> -IRQ   OK
> -MMU   OK
> -EXCP  KO partially implemented
> -Remarks: Should be able to boot but there is no hw platform currently em=
ulated.
> -
> -PowerPC Cell:
> -INSN  KO Altivec missing and more
> -SPR   KO
> -MSR   ?
> -IRQ   ?
> -MMU   ?
> -EXCP  ? partially implemented
> -Remarks: As the core is mostly a 970, should be able to boot.
> -         SPE are not implemented.
> -
> -PowerPC 630: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -PowerPC 631: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -POWER4: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -POWER4+: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -POWER5: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -POWER5+: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -POWER6: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -RS64: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -RS64-II: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -RS64-III: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -RS64-IV: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -Original POWER
> -POWER: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -POWER2: (disabled: lack of detailed specifications)
> -INSN  KO
> -SPR   KO
> -MSR   KO
> -IRQ   KO
> -MMU   KO
> -EXCP  KO
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -PowerPC microcontrollers emulation status
> -
> -Implemementation should be sufficient to boot Linux:
> -(there seem to be problems with uboot freezing at some point)
> -- PowerPC 405CR
> -- PowerPC 405EP
> -
> -TODO:
> -- PowerPC 401 microcontrollers emulation
> -- PowerPC 403 microcontrollers emulation
> -- more PowerPC 405 microcontrollers emulation
> -- Fixes / more features for implemented PowerPC 405 microcontrollers emu=
lation
> -- PowerPC 440 microcontrollers emulation
> -- e200 microcontrollers emulation
> -- e300 microcontrollers emulation
> -- e500 microcontrollers emulation
> -- e600 microcontrollers emulation
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -PowerPC based platforms emulation status
> -
> -* PREP platform (RS/6000 7043...) - TO BE CHECKED (broken)
> -- Gentoo Linux live CDROM 1.4
> -- Debian Linux 3.0
> -- Mandrake Linux 9
> -
> -* heathrow PowerMac platform (beige PowerMac) - TO BE CHECKED (broken)
> -- Gentoo Linux live CDROM 1.4
> -- Debian Linux 3.0
> -- Mandrake Linux 9
> -
> -* mac99 platform (white and blue PowerMac, ...)
> -- Gentoo Linux live CDROM 1.4 - boots, compiles linux kernel
> -- Debian Linux woody - boots from CDROM and HDD
> -- Mandrake Linux 9 - boots from CDROM, freezes during install
> -- Knoppix 2003-07-13_4 boots from CDROM, pb with X configuration
> -  distribution bug: X runs with a properly hand-coded configuration.
> -- rock Linux 2.0 runs from CDROM
> -
> -* Linux 2.6 support seems deadly broken (used to boot...).
> -
> -* PowerPC 405EP reference boards:
> -- can boot Linux 2.4 & 2.6.
> -  Need to provide a flash image ready to boot for reproductible tests.
> -
> -TODO:
> -- URGENT: fix PreP and heathrow platforms
> -- PowerPC 64 reference platform
> -- MCA based RS/6000 emulation
> -- CHRP emulation (not PowerMac)
> -- PPAR emulation
> -- ePPAR emulation
> -- misc PowerPC reference boards emulation
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmqGysACgkQbDjKyiDZ
s5IiyA/+LSRT0xTOTmovqb4qKP8RXlZnZy0LPXv1ARqkllHRpRCcA8Dcf0IqE4b4
07LIw5j9Qup092aeEhrzs/epR8aCNH5rTyAHBVDVCNepTyj6ilk5IsHKOo7zQHf0
J7Y2Pv8ZqFvQ+1qc4euG193M0ZHHEWXlm8JXeeFMXdoz29GU1n888K4PGSpt+rro
g8Sv/fauY2TJ9xaY9CQJLC9W1Sdp3KRm5GLw9fMQ8y4DK9sl63WYn8EuZi1ms+BJ
y6LS2jNKZStmDdvdw+cQ7wVgzI5+n6H0Pybx7z+fNVhwkfbll3TDSSZ7phNWnghS
lYiSAa0UNZ/ZaGxwUnFTOFIVpwDe1We4+HqCN7kH9f/RkH3UGZbnZ9U6DcC9JVro
iR8gnXDUNEwDEzuZ8UtsfJoIgk36OXg/XavTuedMBHIyJvkOLdKMGJsXF1a5Kpfi
RqSHrpf4nf9kTYA+q/suqNfnF6PN2dtlkJb7y+b4MBgmqOVCVTiO5JBaSHsDWOUp
qHLpeeWEGt32X88hPccxbEc2jo25CdAOBAXTyuFaRglrrYqrHfFtbylgWpmeRSzi
pLyywjyqMgCGAzhtDfMMx9w51Pg07MxAQLCymd8sCXP/82N7PgBH4EddJnCp8/nP
G3AldMWR7fuhzzDJgIsGP6MTw7sLK/ddA2x1+2y9aCvYfeliMK8=
=UkCf
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--

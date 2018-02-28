Received: from eggs.gnu.org ([2001:4830:134:3::10]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eqrgK-0005eZ-3t
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 21:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eqrgG-0004iZ-8a
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 21:41:24 -0500
Date: Wed, 28 Feb 2018 13:24:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180228022401.GF11706@umbus.fritz.box>
References: <151938789136.813.13235892014976491889@bdbb90650ae5>
	<b2c5ed9a-4946-83a2-3788-2762cc73dc80@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <b2c5ed9a-4946-83a2-3788-2762cc73dc80@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 00/11] macio: remove legacy macio_init()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-ppc@nongnu.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:51:48PM +0000, Mark Cave-Ayland wrote:
> On 23/02/18 12:11, no-reply@patchew.org wrote:
>=20
> > Hi,
> >=20
> > This series failed build test on s390x host. Please find the details be=
low.
> >=20
> > Type: series
> > Message-id: 20180219181922.21586-1-mark.cave-ayland@ilande.co.uk
> > Subject: [Qemu-devel] [PATCH 00/11] macio: remove legacy
> > macio_init() function

[snip]
> >    CC      ppc-linux-user/accel/stubs/whpx-stub.o
> >    CC      ppc-linux-user/accel/stubs/kvm-stub.o
> >    CC      ppc-linux-user/accel/tcg/tcg-runtime.o
> >    CC      ppc-linux-user/accel/tcg/tcg-runtime-gvec.o
> >    CC      ppc-linux-user/accel/tcg/cpu-exec.o
> >    CC      ppc-linux-user/accel/tcg/cpu-exec-common.o
> >    CC      ppc-linux-user/accel/tcg/translate-all.o
> >    CC      ppc-linux-user/accel/tcg/translator.o
> >    CC      ppc-linux-user/accel/tcg/user-exec.o
> >    CC      ppc-linux-user/accel/tcg/user-exec-stub.o
> >    CC      ppc-linux-user/linux-user/main.o
> >    CC      ppc-linux-user/linux-user/syscall.o
> >    CC      ppc-linux-user/linux-user/strace.o
> >    CC      ppc-linux-user/linux-user/mmap.o
> >    CC      ppc-linux-user/linux-user/signal.o
> >    CC      ppc-linux-user/linux-user/elfload.o
> >    CC      ppc-linux-user/linux-user/linuxload.o
> >    CC      ppc-linux-user/linux-user/uaccess.o
> >    CC      ppc-linux-user/linux-user/uname.o
> >    CCAS    ppc-linux-user/linux-user/safe-syscall.o
> >    CC      ppc-linux-user/target/ppc/cpu-models.o
> >    CC      ppc-linux-user/target/ppc/cpu.o
> >    CC      ppc-linux-user/target/ppc/translate.o
> >    CC      ppc-linux-user/target/ppc/kvm-stub.o
> >    CC      ppc-linux-user/target/ppc/dfp_helper.o
> > In file included from /var/tmp/patchew-tester-tmp-ob5ouqpf/src/include/=
hw/qdev.h:4:0,
> >                   from /var/tmp/patchew-tester-tmp-ob5ouqpf/src/include=
/hw/sysbus.h:6,
> >                   from /var/tmp/patchew-tester-tmp-ob5ouqpf/src/include=
/hw/ppc/openpic.h:5,
> >                   from /var/tmp/patchew-tester-tmp-ob5ouqpf/src/target/=
ppc/kvm-stub.c:15:
> > /var/tmp/patchew-tester-tmp-ob5ouqpf/src/include/hw/hw.h:6:2: error: #e=
rror Cannot include hw/hw.h from user emulation
> >   #error Cannot include hw/hw.h from user emulation
> >    ^~~~~
> > In file included from /var/tmp/patchew-tester-tmp-ob5ouqpf/src/target/p=
pc/kvm-stub.c:15:0:
> > /var/tmp/patchew-tester-tmp-ob5ouqpf/src/include/hw/ppc/openpic.h:146:1=
8: error: field =E2=80=98mem=E2=80=99 has incomplete type
> >       MemoryRegion mem;
> >                    ^~~
> > /var/tmp/patchew-tester-tmp-ob5ouqpf/src/include/hw/ppc/openpic.h:163:1=
8: error: array type has incomplete element type =E2=80=98MemoryRegion {aka=
 struct MemoryRegion}=E2=80=99
> >       MemoryRegion sub_io_mem[6];
> >                    ^~~~~~~~~~
> > make[1]: *** [/var/tmp/patchew-tester-tmp-ob5ouqpf/src/rules.mak:66: ta=
rget/ppc/kvm-stub.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:404: subdir-ppc64-linux-user] Error 2
> > make: *** [Makefile:404: subdir-ppc-linux-user] Error 2
> > =3D=3D=3D OUTPUT END =3D=3D=3D
> >=20
> > Test command exited with code: 2
>=20
> Oh that's fun - it seems that kvm-stub.c includes hw/ppc/openpic.h in ord=
er
> to make use of kvm_openpic_connect_vcpu() which is why this is tripping u=
p.
>=20
> David, any idea what the right solution is here?

Not off the top of my head.

> I could perhaps split the
> KVM-specific parts of openpic.h into a separate hw/ppc/openpic_kvm.h file.
> Then again it feels a bit like kvm_openpic_connect_vcpu() doesn't live in
> the right place.

Both of those seem like plausible solutions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqWEr4ACgkQbDjKyiDZ
s5JFoBAA2P3YNzU6Rr/FVa7LUD3Yq2WSNo9Ugcii/ixZj0KKCgZPQ7Tee6b7GgXE
tPJZ0ENues1CuCwiYgZ9lVk6EPD1Oj2Jl0FqzN9nJhV3pAuKFpNMMejSiszjznUs
W7gi6zfgLIzy9pWxuex1sJuuZYHNenNupeogilw/LjAQlVVwaXUArfHwqqqGu9wg
h1H1wOGDL4DKN+hTdco09gEXHopkqbIsaznsAGTeE0up7oMIykBYDxGhw0c1QSUL
kUpMCiDk4i+Bi4swzwJNcgHYfK8MnEtyn/SsiGiYG58JWDV0CUYG/WWyWzDx+36T
6uxevJaduY5LJy7WQmHKmRGHIyUcUcuMxQiw2d2sD8p0EwlLHGnxnuAhvuBmZV1d
FNNDGFIeQ9+G4fMepzhynyuFwxoVHswQjOBRFdeZI76mHTiOGh81HGMJlKbxX6JR
nG9EkHSYBWF7UdFSF+iS84Ip/P6EsFSOik1GKXgBrKdkMnDjRJV+GFA7q8GGvlmo
WAw/KIIX7qCXmu30l1Pa9UN38phXAXUQT5LisODO3YPHCDg8stqdU24gzhtQMyFn
rZ3fHC4PDkCl95mcpHtU7erxOgeltBOEVsRMmksvO9RElIxtBDTgMRvCMGOXI62Z
ByJU629ruBTJfOTpLEHs/rxUS95/qIIVVquxpe2UR9AcQOnNb5c=
=yVpA
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--

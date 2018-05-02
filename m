Received: from eggs.gnu.org ([2001:4830:134:3::10]:38648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDfph-00073l-3m
	for qemu-devel@nongnu.org; Tue, 01 May 2018 20:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDfpd-0006CL-V5
	for qemu-devel@nongnu.org; Tue, 01 May 2018 20:41:21 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:46058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDfpd-0006Bj-MH
	for qemu-devel@nongnu.org; Tue, 01 May 2018 20:41:17 -0400
Received: by mail-qk0-x234.google.com with SMTP id x22so10009930qkb.12
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 17:41:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <04b2ae36-e7ec-3b78-5443-09fe25d2ebb3@amsat.org>
Date: Tue, 1 May 2018 21:41:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="FOX3ahtFrjzhHUu5CPI3hmJcmh13SsewR"
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FOX3ahtFrjzhHUu5CPI3hmJcmh13SsewR
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>,
 Florian Artmeier <florian.artmeier@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>
Message-ID: <04b2ae36-e7ec-3b78-5443-09fe25d2ebb3@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
 <20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bastian,

On 05/01/2018 11:22 AM, Bastian Koppelmann wrote:
> this includes the Makefile and linker script to build all the tests.
>=20
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  tests/tcg/tricore/Makefile | 30 +++++++++++++++++++++++
>  tests/tcg/tricore/link.ld  | 60 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tests/tcg/tricore/Makefile
>  create mode 100644 tests/tcg/tricore/link.ld
>=20
> diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
> new file mode 100644
> index 0000000000..8c168d1062
> --- /dev/null
> +++ b/tests/tcg/tricore/Makefile
> @@ -0,0 +1,30 @@
> +AS :=3D tricore-as
> +LD :=3D tricore-ld
> +HOST_CC =3D gcc
> +
> +LDFLAGS =3D -Tlink.ld
> +ASFLAGS =3D
> +
> +SIM =3D ../../../tricore-softmmu/qemu-system-tricore
> +SIMFLAGS =3D -M tricore_testboard -nographic -kernel

I applied this on upstream QEMU (26bd8d98c4b32).

I suppose you are doing in-tree build, since this doesn't work with
out-of-tree builds (see the $SIM relative path).

I then get:

tricore-softmmu/qemu-system-tricore -M tricore_testboard -nographic
-kests/tcg/tricore/test_muls.tst -d in_asm
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) QEMU 2.12.50 monitor - type 'help' for more information
(qemu) IN:
0x80000000:  qemu-system-tricore: function cpu_get_phys_page_attrs_debug
not implemented, aborting

OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000
OBJD-T: 000000000000000000000000

Having checked the testdevice is here:

tricore-softmmu/qemu-system-tricore -M tricore_testboard -S -monitor stdi=
o
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000080000000-00000000801fffff (prio 0, ram): powerlink_ext_c.ram
    00000000a1000000-00000000a13fffff (prio 0, ram): powerlink_ext_d.ram
    00000000d0000000-00000000d000bfff (prio 0, ram): powerlink_int_d.ram
    00000000d4000000-00000000d400bfff (prio 0, ram): powerlink_int_c.ram
    00000000f0000000-00000000f0000003 (prio 0, i/o): tricore_testdevice
    00000000f0050000-00000000f0053fff (prio 0, ram): powerlink_pcp_data.r=
am
    00000000f0060000-00000000f0067fff (prio 0, ram): powerlink_pcp_text.r=
am

Using the docker image provided here:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg00151.html
(which you can build with 'make docker-image-debian-tricore-cross', I
didn't try to merge your series over Alex's tcg-testing one)

This test seems correctly linked:

$ docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) -u $(id -u) \
    qemu:debian-tricore-cross \
      tricore-readelf -e tests/tcg/tricore/test_muls.tst
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Siemens Tricore
  Version:                           0x1
  Entry point address:               0x80000000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          32812 (bytes into file)
  Flags:                             0x2
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         2
  Size of section headers:           40 (bytes)
  Number of section headers:         7
  Section header string table index: 4

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg
Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00
0   0  0
  [ 1] .text             PROGBITS        80000000 004000 0000a8 00  AX
0   0  2
  [ 2] .data             PROGBITS        d0000000 008000 000000 00  WA
0   0  8
  [ 3] .bss              NOBITS          d0000000 008000 000000 00  WA
0   0  8
  [ 4] .shstrtab         STRTAB          00000000 008000 00002c 00
0   0  1
  [ 5] .symtab           SYMTAB          00000000 008144 0001c0 10
6  14  4
  [ 6] .strtab           STRTAB          00000000 008304 0000b3 00
0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific=
)

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align=

  LOAD           0x004000 0x80000000 0x80000000 0x000a8 0x000a8 R E 0x400=
0
  LOAD           0x008000 0xd0000000 0xd0000000 0x00000 0x00000 RW  0x400=
0

 Section to Segment mapping:
  Segment Sections...
   00     .text
   01

> +
> +all: build
> +
> +%.pS: %.S
> +	$(HOST_CC) -E -o $@ $<
> +
> +%.o: %.pS
> +	$(AS) $(ASFLAGS) -o $@ $<
> +
> +%.tst: %.o link.ld
> +	$(LD) $(LDFLAGS) $< -o $@

Those rules did not work for me:

$ make test_dvstep.tst
cc    -c -o test_dvstep.o test_dvstep.S
test_dvstep.S: Assembler messages:
test_dvstep.S:6: Error: no such instruction: `mov.u %d6,lo:0xfffffe5c'
test_dvstep.S:6: Error: no such instruction: `movh %d10,up:0xfffffe5c'

However called in the same line it did:

$ make test_muls.pS test_muls.o test_muls.tst
gcc -E -o test_muls.pS test_muls.S
tricore-as  -o test_muls.o test_muls.pS
tricore-ld -Tlink.ld test_muls.o -o test_muls.tst

Regards,

Phil.

> +
> +build: $(TESTCASES)
> +
> +check: $(addprefix run-, $(TESTCASES))
> +
> +run-%.tst: %.tst
> +	$(SIM) $(SIMFLAGS) ./$<
> +
> +clean:
> +	$(RM) -fr $(TESTCASES) linker.ld
> diff --git a/tests/tcg/tricore/link.ld b/tests/tcg/tricore/link.ld
> new file mode 100644
> index 0000000000..364bcdc00a
> --- /dev/null
> +++ b/tests/tcg/tricore/link.ld
> @@ -0,0 +1,60 @@
> +/* Default linker script, for normal executables */
> +OUTPUT_FORMAT("elf32-tricore")
> +OUTPUT_ARCH(tricore)
> +ENTRY(_start)
> +
> +/* the internal ram description */
> +MEMORY
> +{
> +  text_ram (rx!p): org =3D 0x80000000, len =3D 15K
> +  data_ram (w!xp): org =3D 0xd0000000, len =3D 130K
> +}
> +/*
> + * Define the sizes of the user and system stacks.
> + */
> +__USTACK_SIZE =3D DEFINED (__USTACK_SIZE) ? __USTACK_SIZE : 1K ;
> +/*
> + * Define the start address and the size of the context save area.
> + */
> +__CSA_BEGIN =3D  0xd0000000 ;
> +__CSA_SIZE =3D  8k ;
> +__CSA_END =3D __CSA_BEGIN + __CSA_SIZE ;
> +
> +SECTIONS
> +{
> +  .text  :
> +  {
> +    *(.text)
> +    . =3D ALIGN(8);
> +  } > text_ram
> +
> +  .rodata :
> +  {
> +    *(.rodata)
> +    *(.rodata1)
> +  } > data_ram
> +
> +  .data :
> +  {
> +    . =3D ALIGN(8) ;
> +    *(.data)
> +    *(.data.*)
> +    . =3D ALIGN(8) ;
> +    __USTACK =3D . + __USTACK_SIZE -768;
> +
> +  } > data_ram
> +  /*
> +   * Allocate space for BSS sections.
> +   */
> +  .bss  :
> +  {
> +    BSS_BASE =3D . ;
> +    *(.bss)
> +    *(COMMON)
> +    . =3D ALIGN(8) ;
> +  } > data_ram
> +  /* Make sure CSA, stack and heap addresses are properly aligned.  */=

> +  _. =3D ASSERT ((__CSA_BEGIN & 0x3f) =3D=3D 0 , "illegal CSA start ad=
dress") ;
> +  _. =3D ASSERT ((__CSA_SIZE & 0x3f) =3D=3D 0 , "illegal CSA size") ;
> +
> +}
>=20


--FOX3ahtFrjzhHUu5CPI3hmJcmh13SsewR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlrpCSQACgkQ4+MsLN6t
wN7RwhAAwZKEAwQPhvAZuFKZKMlA79lYsjjSzLjPq37BrG4lNJps72n0CtPMIlS8
DTqdCcSEK0CNsVV/W2zYmz1g3xlsZcAl4ffqD0ol4Ft0YkbWuRPyFVY5QzD3+DhX
8p/tivsE7hv7EJHE4xtuNaA+vxt/+iHFiOIu8eCHclKl1/C5S9XmxPUq92MuA2fr
mRRqBqqg2p6Oc023WqAOfJ7hYwkIN5SuOw5vDEZMOthjF02txh2P5s92aTX3F+j/
alr+R038s7FB86KfIojqNqj3nafUIH9Ntp12nbiiH7XEchsLumrcd6HW2D7z4yBX
QDGk1vSLZtUk175oZYRazxaNPqwiN0aJIUbGsOdLMG92XDdMvdWYFGzTrcukgGJ9
wVN2vc+jNjb0I9JUnNVMsB62EuGtjiW00T5tDfY5OzfNOignlRY18hWMNAxYq3B7
+Sb3+ly8IKH1Qdamixqha1UFg8lOf4M5sIvzZveCdZ4rg0x/nGxaLKzQU4ve9AA4
5+QH3qxyRouzUVzqe+W1pdCJWpo+XF21wWUYdFznxi5Uoar9cRO0wz3qjb08veA9
eLux/91IkJujhZ0sgixjpBzql5llB9SHJNhPFi2wWdW0vtTcK3S6iG7kY62kYkgD
hUS3+kwkNUz5XLwOgjSINfUeNPY56KgMRXmk2WDaR6pbz0VM4/o=
=UN4G
-----END PGP SIGNATURE-----

--FOX3ahtFrjzhHUu5CPI3hmJcmh13SsewR--

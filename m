Received: from eggs.gnu.org ([2001:4830:134:3::10]:41278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eywxD-0006Wv-5p
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eywxA-0001uB-0n
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:56:15 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:46050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eywx9-0001u4-PZ
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:56:11 -0400
Received: by mail-qk0-x229.google.com with SMTP id s9so8491595qke.12
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 02:56:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ced1950-9cbb-9230-578a-162741713ff7@amsat.org>
Date: Thu, 22 Mar 2018 06:56:03 -0300
MIME-Version: 1.0
In-Reply-To: <1521584722-39133-1-git-send-email-mjc@sifive.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="G28nwBwEKbgGpnz6ko5RaHcgiQxRYC7Ho"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G28nwBwEKbgGpnz6ko5RaHcgiQxRYC7Ho
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Message-ID: <2ced1950-9cbb-9230-578a-162741713ff7@amsat.org>
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance and
 cleanup
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
In-Reply-To: <1521584722-39133-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 03/20/2018 07:25 PM, Michael Clark wrote:
> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4=
f135:
>=20
>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>=20
> are available in the git repository at:
>=20
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
>=20
> for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679=
:
>=20
>   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:1=
3 -0700)
>=20
> ----------------------------------------------------------------
> This is a series of spec conformance bug fixes and code cleanups
> that we would like to get in before the QEMU 2.12 release.
>=20
> * Implements WARL behavior for CSRs that don't support writes
> * Improves specification conformance of the page table walker
>   * Change access checks from ternary operator to if statements
>   * Checks for misaligned PPNs
>   * Disallow M-mode or S-mode from fetching from User pages
>   * Adds reserved PTE flag check: W or W|X
>   * Set READ flag for PTE X flag if mstatus.mxr is in effect
>   * Improves page walker comments and general readability
> * Several trivial code cleanups to hw/riscv
>   * Replacing hard coded constants with reference to enums
>     or the machine memory maps.
>   * Remove unnecessary class initialization boilerplate
> * Adds bounds checks when writing device-tree to ROM
> * Updates the cpu model to use a more modern interface
> * Sets mtval/stval to zero on exceptions without addresses
> * Fixes memory allocation bug in riscv_isa_string
>=20
> v4
>=20
> * added fix for memory allocation bug in riscv_isa_string
>=20
> v3
>=20
> * refactor rcu_read_lock in PTE update to use single unlock
> * mstatus.mxr is in effect regardless of privilege mode
> * remove unnecessary class init from riscv_hart
> * set mtval/stval to zero on exceptions without addresses
>=20
> v2
>=20
> * remove unused class boilerplate retains qom parent_obj
> * convert cpu definition towards future model
> * honor mstatus.mxr flag in page table walker
>=20
> v1
>=20
> * initial post merge cleanup patch series
>=20
> ----------------------------------------------------------------
> Michael Clark (25):
>       RISC-V: Make virt create_fdt interface consistent
>       RISC-V: Replace hardcoded constants with enum values
>       RISC-V: Make virt board description match spike
>       RISC-V: Use ROM base address and size from memmap
>       RISC-V: Remove identity_translate from load_elf
>       RISC-V: Mark ROM read-only after copying in code
>       RISC-V: Remove unused class definitions
>       RISC-V: Make sure rom has space for fdt
>       RISC-V: Include intruction hex in disassembly
>       RISC-V: Hold rcu_read_lock when accessing memory
>       RISC-V: Improve page table walker spec compliance
>       RISC-V: Update E order and I extension order
>       RISC-V: Make some header guards more specific
>       RISC-V: Make virt header comment title consistent
>       RISC-V: Use memory_region_is_ram in pte update
>       RISC-V: Remove EM_RISCV ELF_MACHINE indirection
>       RISC-V: Hardwire satp to 0 for no-mmu case
>       RISC-V: Remove braces from satp case statement
>       RISC-V: riscv-qemu port supports sv39 and sv48
>       RISC-V: vectored traps are optional
>       RISC-V: No traps on writes to misa,minstret,mcycle
>       RISC-V: Remove support for adhoc X_COP interrupt
>       RISC-V: Convert cpu definition towards future model
>       RISC-V: Clear mtval/stval on exceptions without info
>       RISC-V: Remove erroneous comment from translate.c


I'm not a maintainer, so I'll just give my reviewer point of view, since
I'm willing to review the RISC-V patches.

=46rom https://wiki.qemu.org/Contribute/FAQ:

  "In order for your patch to be merged, it must either
  (1) receive a Reviewed-by by a trusted reviewer on qemu-devel or
  (2) be reviewed by a maintainer and accepted into their tree."

As I understand the review process, reviewers can:
- directly agree with your patches and add their R-b tag so you can pull
your patches,
- ask changes.
If the change is easy/obvious they can:
- give you the option to add their R-b tag if you agree and do their chan=
ge,
- wait you respin another version, and review again.
(Normally when a reviewer commented on a patch, he will track your
respin, but it is safer to Cc: him due to the mass amount of traffic).

There are sometime misunderstanding and if the updated patch is not what
the reviewer suggested, he can still notify you in time.


In your 25 matches, only 12 have R-b tag.

You could have sent a PR of the reviewed patches, and respin the
unreviewed patches separately.

I also see you addressed some of my comments, so I'd have liked be able
to take time to review and eventually test your series.


That was my two reviewer's cents.

Regards,

Phil.

>=20
>  disas/riscv.c                   |  39 +++++++------
>  hw/riscv/riscv_hart.c           |   6 --
>  hw/riscv/sifive_clint.c         |   9 +--
>  hw/riscv/sifive_e.c             |  34 +----------
>  hw/riscv/sifive_u.c             |  65 +++++++--------------
>  hw/riscv/spike.c                |  65 ++++++++-------------
>  hw/riscv/virt.c                 |  77 +++++++++----------------
>  include/hw/riscv/sifive_clint.h |   4 ++
>  include/hw/riscv/sifive_e.h     |   5 --
>  include/hw/riscv/sifive_u.h     |   9 ++-
>  include/hw/riscv/spike.h        |  15 ++---
>  include/hw/riscv/virt.h         |  17 +++---
>  target/riscv/cpu.c              | 125 ++++++++++++++++++++++----------=
--------
>  target/riscv/cpu.h              |   6 +-
>  target/riscv/cpu_bits.h         |   3 -
>  target/riscv/helper.c           |  84 ++++++++++++++++++++-------
>  target/riscv/op_helper.c        |  52 ++++++++---------
>  target/riscv/translate.c        |   1 -
>  18 files changed, 281 insertions(+), 335 deletions(-)
>=20


--G28nwBwEKbgGpnz6ko5RaHcgiQxRYC7Ho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqzfbMACgkQ4+MsLN6t
wN7vZg/+IKBa0/tr8WH7r0UdA/TYw9pqWbhzMrpjD7o9GbLiGZtMIVU8sm978Hv7
PGPuKT+KBR3L3H2CebcioNbQ+FwuxMuVdHPpBvLv9hUsNn2+zl7GlCw8wzWjc1dI
TXHDZH0Bm6i8gDH/iMKRtP09oB9jj5h1Nx8ZCZ1ylNVwV7TMHNX2yzBi1a6Q/mrT
CnK0WhWGOvSLD78GBn7cwqb6aLU7t5tcqJd8m4aafXwqpTxFMYmATrRaayD5S619
OP+0rQ+oNIO84O0dHf/GqS2dk/9xnF3z3LccnJAH7TyOvY/cZ94uDFnfyx45m65M
BqSnQfQrGBIuQzYaPbXXS2fswYc9LbrqQUM2tXOJf2nK8J+d/DtDnrol3QIs1xDX
3YO3RGB16VzMx5M2ZBBQPNBgzHDhTV91wqHK7Nvn6f9xCw1CBANEeC6NyfRX/EKF
1iQ6NnRUl8HY8B+NUPgpxtB9PAxDTVrYTZoc4CRisQlMsXKiOVSlncB4JlV9xypS
7Eie+hLAzh0I/Hy1PTSSaZqTL1a8jm2s9ZjstWgfioh8CuZ75taVF6obG4zTxfzl
kXv7RU9W+4rG/i9g//hwxJmF8uY9Jd6FBoQbNyYSDOwrqQgyo9zaP+O/u9XcpaPa
k8yV2ka0MyV/GwcfeVXKWn+ceCT6Bl8fKCQE7+c3KH9svgNmNP4=
=zhXB
-----END PGP SIGNATURE-----

--G28nwBwEKbgGpnz6ko5RaHcgiQxRYC7Ho--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG5ZX-0001O8-1l
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 13:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gG5ZS-0006S4-4O
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 13:06:55 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
	([40.107.71.132]:42336
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gG5ZR-0006Pn-Pz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 13:06:50 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 17:06:43 +0000
Message-ID: <BN6PR2201MB1251F5DC1274AE343D1C1649C6F00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/6] target/mips: Add support for prctl()
 PR_GET_FP_MODE and PR_SET_FP_MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>

> Subject: [PATCH 0/6] target/mips: Add support for prctl() PR_GET_FP_MODE =
and PR_SET_FP_MODE
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> This series includes support for prctl() PR_GET_FP_MODE and PR_SET_FP_MOD=
E.
> This requires extracting MIPS.abiflags section from ELF file and fp_abi v=
alue handling.
>=20
> Stefan Markovic (6):
>   Define MIPS_ABI_FP_UNKNOWN macro
>   Extend image_info struct with MIPS specific fp_abi and interp_fp_abi fi=
elds
>   Extract MIPS abiflags from ELF file
>   Read and set FP ABI value from MIPS abiflags
>   Determine the desired FPU mode
>   Add prctl() PR_SET_FP_MODE and PR_GET_FP_MODE implementations
>=20
>  include/elf.h                      |  2 +
>  linux-user/elfload.c               | 37 +++++++++++++++++++
>  linux-user/mips/cpu_loop.c         | 75 ++++++++++++++++++++++++++++++++=
++++++
>  linux-user/mips/target_syscall.h   |  2 +
>  linux-user/mips64/target_syscall.h |  2 +
>  linux-user/qemu.h                  |  4 ++
>  linux-user/syscall.c               | 62 +++++++++++++++++++++++++++++--
>  7 files changed, 180 insertions(+), 4 deletions(-)
>=20
> --
> 1.9.1
>=20


Hi, Laurent,

Here is a mini-series about a MIPS-specific linux-user feature. Its code is=
 almost entirely either in MIPS-specific files or under "#ifdef MIPS" direc=
tives. I think it makes sense that I should be able to integrate them via M=
IPS queue. Please let me know if you object to this.

You probably wonder why so much code for such obscure feature. The answer i=
s that the solution needs to follow and mimic corresponding solution in MIP=
S-specific parts of the kernel, and its complexity is determined by that.

Thanks,
Aleksandar

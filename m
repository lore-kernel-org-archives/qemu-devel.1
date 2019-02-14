Received: from eggs.gnu.org ([209.51.188.92]:54440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1guGye-0006yn-Vz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1guGsw-0002sS-02
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:17:03 -0500
Received: from mail-eopbgr730114.outbound.protection.outlook.com
	([40.107.73.114]:28312
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1guGsv-0002gx-Ic
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:17:01 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Thu, 14 Feb 2019 13:16:54 +0000
Message-ID: <DM5PR22MB1658387A88B7A312ED1D4A55D2670@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1550143103-20133-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550143103-20133-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/9] target/mips: Add MSA ASE tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Thursday, February 14, 2019 12:18 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo; alex.be=
nnee@linaro.org
> Subject: [PATCH v3 0/9] target/mips: Add MSA ASE tests
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> v2->v3:
>
>   - minor cosmetic changes
>   - added wrappers and tests for MSA logic instructions
>
> v1->v2:
>
>   - added refference to the original commit in patch #1
>   - corrected copy-and-paste error in comments in 12 new source files
>   - renamed "bit_counting" subdirectory to "bit-counting"
>   - added wrappers and tests for MSA interleave instructions
>
> This series begins to add unit tests (aka tcg tests) for MIPS'
> MSA ASE. More tests and related test infrastructure will be added
> in subsequent version of this series.
>
> There are several checkpatch warnings that are all false positives
> for given circumstances.
>
> Aleksandar Markovic (9):
>   tests/tcg: target/mips: Remove an unnecessary file
>   tests/tcg: target/mips: Add a header with test inputs
>   tests/tcg: target/mips: Add a header with test utilities
>   tests/tcg: target/mips: Add wrappers for MSA bit counting instructions
>   tests/tcg: target/mips: Add tests for MSA bit counting instructions
>   tests/tcg: target/mips: Add wrappers for MSA interleave instructions
>   tests/tcg: target/mips: Add tests for MSA interleave instructions
>   tests/tcg: target/mips: Add wrappers for MSA logic instructions
>   tests/tcg: target/mips: Add tests for MSA logic instructions
>
>  tests/tcg/mips/include/test_inputs.h               | 122 +++++++++++++++=
+
>  tests/tcg/mips/include/test_utils.h                |  84 +++++++++++
>  tests/tcg/mips/include/wrappers_msa.h              | 101 ++++++++++++++
>  tests/tcg/mips/mips64-dspr2/.directory             |   2 -
>  .../user/ase/msa/bit-counting/test_msa_nloc_b.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nloc_d.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nloc_h.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nloc_w.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nlzc_b.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nlzc_d.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nlzc_h.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_nlzc_w.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_pcnt_b.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_pcnt_d.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_pcnt_h.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/bit-counting/test_msa_pcnt_w.c    | 144 +++++++++++++++=
++++
>  .../user/ase/msa/interleave/test_msa_ilvev_b.c     | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvev_d.c     | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvev_h.c     | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvev_w.c     | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_b.c | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_d.c | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_h.c | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvl_w.c | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvod_b.c     | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvod_d.c     | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvod_h.c     | 153 +++++++++++++++=
++++++
>  .../user/ase/msa/interleave/test_msa_ilvod_w.c     | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_b.c | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_d.c | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_h.c | 153 +++++++++++++++=
++++++
>  .../mips/user/ase/msa/interleave/test_msa_ilvr_w.c | 153 +++++++++++++++=
++++++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c | 153 +++++++++++++++=
++++++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c | 153 +++++++++++++++=
++++++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c  | 153 +++++++++++++++=
++++++
>  tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c | 153 +++++++++++++++=
++++++
>  36 files changed, 5095 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/mips/include/test_inputs.h
>  create mode 100644 tests/tcg/mips/include/test_utils.h
>  create mode 100644 tests/tcg/mips/include/wrappers_msa.h
>  delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlo=
c_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlo=
c_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlo=
c_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlo=
c_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlz=
c_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlz=
c_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlz=
c_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlz=
c_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcn=
t_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcn=
t_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcn=
t_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcn=
t_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev=
_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev=
_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev=
_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev=
_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_=
b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_=
d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_=
h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_=
w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod=
_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod=
_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod=
_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod=
_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_=
b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_=
d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_=
h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_=
w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
>
> --
> 2.7.4

For all patches in this series:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

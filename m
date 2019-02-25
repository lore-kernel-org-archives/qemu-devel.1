Received: from eggs.gnu.org ([209.51.188.92]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gyJKI-0007jH-8A
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gyJK5-0003Ci-AH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:41:51 -0500
Received: from mail-eopbgr820097.outbound.protection.outlook.com
	([40.107.82.97]:18145
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gyJK4-00033s-D4
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:41:45 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Mon, 25 Feb 2019 16:41:31 +0000
Message-ID: <DM5PR22MB1658393CD63D8FE03885D896D27A0@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Misc target/mips fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Friday, February 22, 2019 8:26 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v3 0/8] Misc target/mips fixes and improvements
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> A collection of misc target/mips fixes and improvements for
> February 2019.
>

Patches in this series are all fairly straightforward, and all
of them have my:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

except the patch on DSP-related comments, which I think should
be completed to handle comments on all DSP instructions.

Aleksandar Rikalo

>
> v2->v3:
>
>   - added a patches on documenting Boston board
>   - added two patches on testing integer max/min MSA instructions
>   - removed four patches that had been accepted
>   - amended patch on DSP-related comments
>
> v1->v2:
>
>   - added two patches on updating end user documentation
>   - minor updates to commit messages
>
> Aleksandar Markovic (8):
>   tests/tcg: target/mips: Add tests for MSA integer compare instructions
>   disas: nanoMIPS: Correct comments to handlers of some DSP instructions
>   disas: nanoMIPS: Fix a function misnomer
>   qemu-doc: Move section on MIPS' mipssim pseudo board
>   qemu-doc: Add section on MIPS' Fulong 2E board
>   qemu-doc: Add section on MIPS' Boston board
>   tests/tcg: target/mips: Add wrappers for MSA integer max/min
>     instructions
>   tests/tcg: target/mips: Add tests for MSA integer max/min instructions
>
>  disas/nanomips.cpp                                 | 381 +++++++++++----=
------
>  disas/nanomips.h                                   |   2 +-
>  qemu-doc.texi                                      |  46 ++-
>  tests/tcg/mips/include/wrappers_msa.h              |  30 ++
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c | 153 +++++++++
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c | 153 +++++++++
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c | 153 +++++++++
>  .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_s_b.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_s_d.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_s_h.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_s_w.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_u_b.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_u_d.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_u_h.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_cle_u_w.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_s_b.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_s_d.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_s_h.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_s_w.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_u_b.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_u_d.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_u_h.c    | 153 +++++++++
>  .../user/ase/msa/int-compare/test_msa_clt_u_w.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_a_b.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_a_d.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_a_h.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_a_w.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_s_b.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_s_d.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_s_h.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_s_w.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_u_b.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_u_d.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_u_h.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_max_u_w.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_a_b.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_a_d.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_a_h.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_a_w.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_s_b.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_s_d.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_s_h.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_s_w.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_u_b.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_u_d.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_u_h.c    | 153 +++++++++
>  .../user/ase/msa/int-max-min/test_msa_min_u_w.c    | 153 +++++++++
>  48 files changed, 6995 insertions(+), 196 deletions(-)
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_=
b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_=
d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_=
h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_=
w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
s_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
u_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_=
u_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
s_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
u_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_=
u_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
a_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
a_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
a_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
a_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
s_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
u_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_=
u_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
a_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
a_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
a_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
a_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
s_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
s_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
s_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
s_w.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
u_b.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
u_d.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
u_h.c
>  create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_=
u_w.c
>
> --
> 2.7.4
>

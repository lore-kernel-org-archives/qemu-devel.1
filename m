Received: from eggs.gnu.org ([2001:4830:134:3::10]:45530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQeKw-0000FM-H3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQeKv-0002lv-B2
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:43:14 -0400
References: <20180606152128.449-1-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <b4903491-f450-1a54-2a70-a084c30cd8c6@redhat.com>
Date: Wed, 6 Jun 2018 15:43:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] misc: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 06/06/2018 11:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Nothing very exciting here.
> I sometimes miss to notice some trace events, running with -d unimp,tra=
ce...
> then using 'grep ^...'. This is only due to a missing '\n' :)
>=20

so error_setg must be used WITHOUT \n and logging must happen with \n?

If we're sure that's the way we want to have things laid out, we really
ought to augment checkpatch to catch this -- because there's 0% chance
that we'll keep it straight on our own otherwise.

--js

> Philippe Mathieu-Daud=C3=A9 (11):
>   hw/sd/milkymist-memcard: Add trailing '\n' to qemu_log() call
>   hw/digic: Add trailing '\n' to qemu_log() calls
>   xilinx-dp: Add trailing '\n' to qemu_log() call
>   ppc/pnv: Add trailing '\n' to qemu_log() calls
>   hw/core/register: Add trailing '\n' to qemu_log() call
>   hw/mips/boston: Add trailing '\n' to qemu_log() calls
>   stellaris: Add trailing '\n' to qemu_log() calls
>   target/arm: Add trailing '\n' to qemu_log() calls
>   target/m68k: Add trailing '\n' to qemu_log() call
>   RISC-V: Add trailing '\n' to qemu_log() calls
>   RFC target/xtensa: Add trailing '\n' to qemu_log() calls
>=20
>  hw/arm/stellaris.c        | 11 ++++++-----
>  hw/char/digic-uart.c      |  4 ++--
>  hw/core/register.c        |  2 +-
>  hw/display/xlnx_dp.c      |  4 +++-
>  hw/mips/boston.c          |  8 ++++----
>  hw/ppc/pnv_core.c         |  4 ++--
>  hw/sd/milkymist-memcard.c |  2 +-
>  hw/timer/digic-timer.c    |  4 ++--
>  target/arm/helper.c       |  4 ++--
>  target/m68k/translate.c   |  2 +-
>  target/riscv/op_helper.c  |  6 ++++--
>  target/xtensa/translate.c |  6 +++---
>  12 files changed, 31 insertions(+), 26 deletions(-)
>=20

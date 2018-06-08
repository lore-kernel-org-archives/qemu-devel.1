Received: from eggs.gnu.org ([2001:4830:134:3::10]:36389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRFyu-0004lH-0x
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRFyt-0000AE-49
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:55:00 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRFys-00009a-N3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:54:59 -0400
Received: by mail-ot0-x244.google.com with SMTP id l15-v6so14321277oth.6
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 04:54:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 12:54:37 +0100
Message-ID: <CAFEAcA-9=j8_VmMmAuUbk37uvWKkFEs77NFT3jv4TbWDk4=ZYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 6 June 2018 at 16:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Nothing very exciting here.
> I sometimes miss to notice some trace events, running with -d unimp,trace=
...
> then using 'grep ^...'. This is only due to a missing '\n' :)
>
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
>
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


Applied to target-arm.next, since about half of these are arm
and the rest are trivial and have got ack/review by the relevant
maintainers.

thanks
-- PMM

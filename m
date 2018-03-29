Received: from eggs.gnu.org ([2001:4830:134:3::10]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f1Ugl-0004bV-4f
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f1Ugk-0001ds-8i
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:21:47 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f1Ugk-0001dn-3A
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 06:21:46 -0400
Received: by mail-ot0-x243.google.com with SMTP id m7-v6so5914611otd.1
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 03:21:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522269619-48636-1-git-send-email-mjc@sifive.com>
References: <1522269619-48636-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Mar 2018 11:21:24 +0100
Message-ID: <CAFEAcA9VVr-2DBDBUK6gq8+2B6xtruqqGA=d6WqfwC6jxwV5dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] RISC-V: Important fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On 28 March 2018 at 21:40, Michael Clark <mjc@sifive.com> wrote:
> The following changes since commit 043289bef4d9c0d277c45695c676a6cc9fca48a0:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180328' into staging (2018-03-28 13:30:10 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-important-fixes
>
> for you to fetch changes up to 33b4f859f1e1ea6722d10c3e9c0e3d85afb44ff4:
>
>   RISC-V: Fix incorrect disassembly for addiw (2018-03-28 11:12:02 -0700)
>
> ----------------------------------------------------------------
> RISC-V: Important fixes for QEMU 2.12
>
> This series includes changes that are considered important.
> i.e. correct user-visible bugs that are exercised by common
> operations such as -cpu list (CPU model changes) or -d in_asm
> (fix for disassembly of addiw)
>
> ----------------------------------------------------------------
> Michael Clark (2):
>       RISC-V: Convert cpu definition to future model
>       RISC-V: Fix incorrect disassembly for addiw
>
>  disas/riscv.c      |   2 +-
>  target/riscv/cpu.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
>  2 files changed, 70 insertions(+), 55 deletions(-)


Applied, thanks.

-- PMM

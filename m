Received: from eggs.gnu.org ([2001:4830:134:3::10]:40107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFkT3-0004wO-VP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFkT3-0000WW-3u
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:34:49 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFkT2-0000Vv-I7
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 14:34:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id e3-v6so1544793oiy.6
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 11:34:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181017215422.3973-1-palmer@sifive.com>
References: <20181017215422.3973-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Oct 2018 19:34:27 +0100
Message-ID: <CAFEAcA95ku+cSakGZDMh1jXdz0srGuHU0Uo3isoEF6cgnXsa9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] First RISC-V Patch Set for the 3.1 Soft
 Freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 October 2018 at 22:54, Palmer Dabbelt <palmer@sifive.com> wrote:
> The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf0
>
> for you to fetch changes up to 7c28f4da20e5585dce7d575691dac5392b7c6f78:
>
>   RISC-V: Don't add NULL bootargs to device-tree (2018-10-17 13:02:30 -0700)
>
> ----------------------------------------------------------------
> First RISC-V Patch Set for the 3.1 Soft Freeze
>
> This pull request contains a handful of patches that have been floating
> around various trees for a while but haven't made it upstream.  These
> patches all appear quite safe.  They're all somewhat independent from
> each other:
>
> * One refactors our IRQ management function to allow multiple interrupts
>   to be raised an once.  This patch has no functional difference.
> * Cleaning up the op_helper/cpu_helper split.  This patch has no
>   functional difference.
> * Updates to various constants to keep them in sync with the latest ISA
>   specification and to remove some non-standard bits that snuck in.
> * A fix for a memory leak in the PLIC driver.
> * A fix to our device tree handling to avoid provinging a NULL string.
>
> I've given this my standard test: building the port, booting a Fedora
> root filesytem on the latest Linux tag, and then shutting down that
> image.  Essentially I'm just following the QEMU RISC-V wiki page's
> instructions.  Everything looks fine here.
>
> We have a lot more outstanding patches so I'll definately be submitting
> another PR for the soft freeze.
>
> ----------------------------------------------------------------

Applied to master, thanks (following some off-list discussions
of what we are doing wrt who is submitting riscv upstream pullreqs).

-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG57l-0000iR-Nf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG57k-0002bb-IU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:05:57 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG57k-0002Y4-E7
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:05:56 -0400
Received: by mail-ot0-x243.google.com with SMTP id n1-v6so36691107otf.7
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 09:05:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525734893-10299-1-git-send-email-mjc@sifive.com>
References: <1525734893-10299-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 17:05:35 +0100
Message-ID: <CAFEAcA8U5nkAKfCVSRVdHZ0CUEj20S3EyobfDvTnyNJ259A40w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] RISC-V: QEMU 2.13 Minor Fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair.francis@xilinx.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-stable <qemu-stable@nongnu.org>

On 8 May 2018 at 00:14, Michael Clark <mjc@sifive.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-fixes-1
>
> for you to fetch changes up to d4a63373c0e6349c6f36f56a6290ad639bfa20cb:
>
>   riscv: requires libfdt (2018-05-08 10:57:21 +1200)
>
> ----------------------------------------------------------------
> RISC-V: QEMU 2.13 Minor Fixes
>
> * Require libfdt when configuring for 'riscv*-softmmu'
> * Increase HTIF priority and allow zero address
>
> ----------------------------------------------------------------
> KONRAD Frederic (3):
>       riscv: spike: allow base == 0
>       riscv: htif: increase the priority of the htif subregion
>       riscv: requires libfdt

Hi Michael -- these patches from Fred need your Signed-off-by:
line in the commit messages as well as his. (This indicates that
they've passed through your hands to get to master; see item 3
in https://wiki.qemu.org/Contribute/SubmitAPullRequest )

I did a build test and they passed that fine, so if you can just
respin this pullreq with the signoff lines added to each commit
message I should be able to apply it.

thanks
-- PMM

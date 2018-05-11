Received: from eggs.gnu.org ([2001:4830:134:3::10]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH4zM-0000Lh-F5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH4zL-0002TC-GT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:09:24 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH4zL-0002T2-BD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:09:23 -0400
Received: by mail-ot0-x242.google.com with SMTP id 15-v6so5607196otn.12
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 03:09:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525861240-4130-1-git-send-email-mjc@sifive.com>
References: <1525861240-4130-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 11:09:02 +0100
Message-ID: <CAFEAcA_vVF00Q4ot8mTqrv76=VCe+F-iCynx_m=1oUOESkmjNA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 9 May 2018 at 11:20, Michael Clark <mjc@sifive.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-fixes-3
>
> for you to fetch changes up to a666409f0df5dce113a5bd2c4c144a0792f2a4a3:
>
>   riscv: requires libfdt (2018-05-09 22:14:28 +1200)
>
> ----------------------------------------------------------------
> RISC-V: QEMU 2.13 Minor Fixes
>
> * Require libfdt when configuring for 'riscv*-softmmu'
> * Increase HTIF priority and allow zero base address
>
> ----------------------------------------------------------------
> KONRAD Frederic (3):
>       riscv: spike: allow base == 0
>       riscv: htif: increase the priority of the htif subregion
>       riscv: requires libfdt
>
>  configure             |  2 +-
>  hw/riscv/riscv_htif.c | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
Applied, thanks.

-- PMM

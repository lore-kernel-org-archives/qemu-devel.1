Received: from eggs.gnu.org ([2001:4830:134:3::10]:46559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fG8jW-0006t9-9L
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fG8jV-0000i9-6y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:57:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fG8jU-0000hq-Vb
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:57:09 -0400
Received: by mail-oi0-x243.google.com with SMTP id n65-v6so29473148oig.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 12:57:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8U5nkAKfCVSRVdHZ0CUEj20S3EyobfDvTnyNJ259A40w@mail.gmail.com>
References: <1525734893-10299-1-git-send-email-mjc@sifive.com>
	<CAFEAcA8U5nkAKfCVSRVdHZ0CUEj20S3EyobfDvTnyNJ259A40w@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 9 May 2018 07:57:07 +1200
Message-ID: <CAHNT7Ns5B0ex5b5v6P_Xhd569Nxf_92x-c_HwRx1Xny0B_E6Dg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair.francis@xilinx.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-stable <qemu-stable@nongnu.org>

On Wed, May 9, 2018 at 4:05 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 8 May 2018 at 00:14, Michael Clark <mjc@sifive.com> wrote:
> > The following changes since commit c8b7e627b4269a3bc3ae41d9f42054
> 7a47e6d9b9:
> >
> >   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04'
> into staging (2018-05-04 14:42:46 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-
> fixes-1
> >
> > for you to fetch changes up to d4a63373c0e6349c6f36f56a6290ad639bfa20cb:
> >
> >   riscv: requires libfdt (2018-05-08 10:57:21 +1200)
> >
> > ----------------------------------------------------------------
> > RISC-V: QEMU 2.13 Minor Fixes
> >
> > * Require libfdt when configuring for 'riscv*-softmmu'
> > * Increase HTIF priority and allow zero address
> >
> > ----------------------------------------------------------------
> > KONRAD Frederic (3):
> >       riscv: spike: allow base == 0
> >       riscv: htif: increase the priority of the htif subregion
> >       riscv: requires libfdt
>
> Hi Michael -- these patches from Fred need your Signed-off-by:
> line in the commit messages as well as his. (This indicates that
> they've passed through your hands to get to master; see item 3
> in https://wiki.qemu.org/Contribute/SubmitAPullRequest )
>

I was thinking about that but was not sure. This is my first pull with
changes that originated outside the riscv tree.


> I did a build test and they passed that fine, so if you can just
> respin this pullreq with the signoff lines added to each commit
> message I should be able to apply it.
>

Okay, thanks. I've boot tested Linux kernel in the 'spike' machines. These
changes are very low risk. I'll respin with my "Signed-off-by" added.

The configure libfdt patch is the main one to cherry-pick for 2.12.1,
however, the other changes are innocuous enough if you want to merge the
whole PR to stable, as there are 3 commits. BTW I still need to test 'sifive_u'
in stable 2.12.0 to figure out the changes that need to be cherry-picked or
I can backport changes if necessary.

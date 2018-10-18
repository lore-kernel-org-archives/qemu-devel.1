Received: from eggs.gnu.org ([2001:4830:134:3::10]:35130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1gD7ol-0003IX-SS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1gD7of-0008F2-VZ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:54:21 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1gD7oc-00089d-P8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:54:15 -0400
Received: by mail-oi1-x22f.google.com with SMTP id j68-v6so23899612oib.7
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 05:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <fc39293f-9d79-a3d3-9e39-9e4680e6bbb4@redhat.com>
	<mhng-6c4401ed-995c-48e1-a3ba-21692c2efcb1@palmer-si-x1c4>
In-Reply-To: <mhng-6c4401ed-995c-48e1-a3ba-21692c2efcb1@palmer-si-x1c4>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 19 Oct 2018 01:54:01 +1300
Message-ID: <CAHNT7Nux+jD0o8QPuk971tHO=+pCSk0e9e5Bxu_093XGeO2aJQ@mail.gmail.com>
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
Cc: eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

Any patches intended for the RISC-V port should go through the maintainer
tree. I have been pretty clear that I would like to run regression tests. I
do not wish to pull surprises in via master. I also do not agree with this
random patch approach. It's all well and good for inactive maintainers to
pop up now, but we were not getting our patches reviewed. The riscv-qemu
tree is actively managed and we rebase and test at release time. I don't
like the idea of busted stuff getting into the tree with patch churn
correcting it. In any case we disagree regards process. Please don't break
any of the branches in the riscv-qemu repository. I have scripts to tag our
stable branches there (we got positive feedback from Karsten on the
"series"). You are adding risk to the process. Fine. You are in charge.
Don't break stuff.

On Thu, Oct 18, 2018 at 1:01 PM Palmer Dabbelt <palmer@sifive.com> wrote:

> On Wed, 17 Oct 2018 16:32:10 PDT (-0700), eblake@redhat.com wrote:
> > On 10/17/18 4:54 PM, Palmer Dabbelt wrote:
> >> The following changes since commit
> 09558375a634e17cea6cfbfec883ac2376d2dc7f:
> >>
> >>    Merge remote-tracking branch
> 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16
> 17:42:56 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>    git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf0
> >>
> >> for you to fetch changes up to 7c28f4da20e5585dce7d575691dac5392b7c6f78:
> >>
> >>    RISC-V: Don't add NULL bootargs to device-tree (2018-10-17 13:02:30
> -0700)
> >>
> >> ----------------------------------------------------------------
> >> First RISC-V Patch Set for the 3.1 Soft Freeze
> >>
> >
> >> ----------------------------------------------------------------
> >> Michael Clark (5):
> >>        RISC-V: Allow setting and clearing multiple irqs
> >>        RISC-V: Move non-ops from op_helper to cpu_helper
> >>        RISC-V: Update CSR and interrupt definitions
> >>        RISC-V: Add missing free for plic_hart_config
> >>        RISC-V: Don't add NULL bootargs to device-tree
> >>
> >
> > Isn't this just a subset of Alistair's pull request?
> > https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02342.html
>
> Yes, but there's still on-going discussion about the PCIe patches so
> they're
> not really fully reviewed.  I think part of the trouble here is that there
> wasn't someone submitting regular QEMU pull requests so there was always a
> rush
> to get things in.  I've volunteered to wrangle the branches and submit
> weekly
> pull requests (just like I do for Linux), so now there won't be any more
> big
> cliffs.
>
> We've got a lot of patches to filter through because things have been
> backed up
> for a bit, so I thought it'd be best to just go with something simple for
> this
> first week.  Assuming everything gets sorted out for the PCIe patches
> they'll
> just go up next week -- I'm super excited for them as well :)
>
> > which included:
> >> ----------------------------------------------------------------
> >> Alistair Francis (5):
> >>       hw/riscv/virt: Increase the number of interrupts
> >>       hw/riscv/virt: Connect the gpex PCIe
> >>       riscv: Enable VGA and PCIE_VGA
> >>       hw/riscv/sifive_u: Connect the Xilinx PCIe
> >>       hw/riscv/virt: Connect a VirtIO net PCIe device
> >>
> >> Michael Clark (5):
> >>       RISC-V: Allow setting and clearing multiple irqs
> >>       RISC-V: Move non-ops from op_helper to cpu_helper
> >>       RISC-V: Update CSR and interrupt definitions
> >>       RISC-V: Add missing free for plic_hart_config
> >>       RISC-V: Don't add NULL bootargs to device-tree
>

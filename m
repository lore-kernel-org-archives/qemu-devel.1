Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG9Yb-0001Eq-Fx
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG9Ya-00031R-3i
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:49:57 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG9YZ-000316-Ue
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:49:56 -0400
Received: by mail-ot0-x244.google.com with SMTP id l12-v6so37712039oth.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 13:49:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525810060-36690-1-git-send-email-mjc@sifive.com>
References: <1525810060-36690-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 21:49:34 +0100
Message-ID: <CAFEAcA_iD-ub8obNp-7B27oFE_12T6iDDiAMuXcKX_TqHesofQ@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Alistair Francis <alistair.francis@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 8 May 2018 at 21:07, Michael Clark <mjc@sifive.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-minor-fixes-2
>
> for you to fetch changes up to fc28db142ea9331d24d08a6418efa93e258a6876:
>
>   riscv: requires libfdt (2018-05-09 07:57:57 +1200)
>
> ----------------------------------------------------------------
> RISC-V: QEMU 2.13 Minor Fixes
>
> * Require libfdt when configuring for 'riscv*-softmmu'
> * Increase HTIF priority and allow zero base address
>
> Consider backporting to stable branch for 2.12.1

Ah, if you want something flagged to be backported to
the stable branch, the way to do that is to include
the line "Cc: qemu-stable@nongnu.org" in the commit
message. We use the same approach for flagging things
for stable as the Linux kernel. (Individual submaintainers
are generally in the best position to decide whether
something should go into stable, and this system leaves
that choice up to them. A patch submitter can also suggest
something for stable when you submit the initial patch for
review by adding the Cc: line and cc'ing qemu-stable on the
patchmail.)

thanks
-- PMM

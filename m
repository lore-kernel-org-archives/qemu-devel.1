Received: from eggs.gnu.org ([2001:4830:134:3::10]:59289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0tpN-0003iH-8B
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0tpM-00023J-6S
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:00:13 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:38968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0tpL-00022a-VU
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:00:12 -0400
Received: by mail-oi0-x22a.google.com with SMTP id q71-v6so20136864oic.6
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 12:00:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nux9v-iDZbm6bXs8LG3WF4fF+5b_5E+z-QHmG=FiB7N1g@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
	<CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
	<CAFEAcA9k2e76o+DXEu0NN770o5ZDwY4g2UKnSxA2VhwRBq6F=Q@mail.gmail.com>
	<CAHNT7Nux9v-iDZbm6bXs8LG3WF4fF+5b_5E+z-QHmG=FiB7N1g@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 12:00:10 -0700
Message-ID: <CAHNT7NshRrGsm9g9T7jCXZJmS+ZzPC2ZHw31r-6_+zZnTmSWEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PATCH v6 00/26] RISC-V: Fixes and
 cleanups for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: RISC-V Patches <patches@groups.riscv.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Tue, Mar 27, 2018 at 11:39 AM, Michael Clark <mjc@sifive.com> wrote:

>
> I will divide the series up into 3 branches, and move through them in
> order of priority, with correctness ahead of tidyness:
>
> 1). riscv-qemu-2.12-critical-fixes
> 2). riscv-qemu-2.13-bug-fixes
> 3). riscv-qemu-2.13-tidy-ups
>

I think we need 4 categories:

1). riscv-qemu-2.12-critical-fixes
- floating point register file corruption mstatus.FS

2). riscv-qemu-2.12-important-fixes
- user visible bugs, e.g. Igor's -cpu list bug, wrong dissassembly for
sext.w/addiw bug

3). riscv-qemu-2.13-bug-fixes
- spec bugs and other innocuous bug fixes that are not /yet/ user visible.
i.e. not exercised by RISC-V Linux

4). riscv-qemu-2.13-tidy-ups
- code cleanups

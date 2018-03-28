Received: from eggs.gnu.org ([2001:4830:134:3::10]:40952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f136O-0000MN-VE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f136O-0008Nw-0L
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:54:25 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f136N-0008Nj-Nx
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:54:23 -0400
Received: by mail-oi0-x243.google.com with SMTP id 126-v6so1064977oig.0
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:54:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180328022233.13400-1-richard.henderson@linaro.org>
References: <20180328022233.13400-1-richard.henderson@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 21:54:22 -0700
Message-ID: <CAHNT7NvG=QGdTM-056K20t9pRA3haoSFKvjMtt2QQtTgHH1tDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/2] RISC-V: Mark FP status dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

Hi Richard,

Thanks! I'll test this tomorrow morning and we can choose whether to
include your proper fix or the workaround.

I think we have time assuming we send out PRs tomorrow.

Given our important fixes have review including either this fix by tomorrow
or the workaround, and Philippe has reviewed our other important bugs
fixes, then we should be fine.

Then after getting the critical and important fixes out of the way, then I
perhaps make a PR for the other reviewed changes, although these might best
wait until QEMU 2.13 opens.

Thanks again,
Michael.


On Tue, Mar 27, 2018 at 7:22 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> Since it was my patch that broke FP state tracking in the
> first place, I feel obligated to fix it again.
>
> Mark mstatus[fs] as dirty whenever we write to the file.
> This can be optimized by only doing so once within a TB
> which initially began with a clean file.
>
> I have not yet put together an environment that can test
> this, so I'll need someone else to give it a go.
>
>
> r~
>
>
> Richard Henderson (2):
>   target/riscv: Split out mstatus_fs from tb_flags during translation
>   target/riscv: Mark MSTATUS_FS dirty
>
>  target/riscv/cpu.h       |  6 +++---
>  target/riscv/op_helper.c | 25 ++++++++++++++++--------
>  target/riscv/translate.c | 50 ++++++++++++++++++++++++++++++
> ++++++++++++------
>  3 files changed, 64 insertions(+), 17 deletions(-)
>
> --
> 2.14.3
>
>

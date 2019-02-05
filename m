Received: from eggs.gnu.org ([209.51.188.92]:42991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqySE-0000ER-Bd
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqySD-0007Kd-Du
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:59:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqySA-0007DT-AX
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:59:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so4888881otr.10
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 02:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20190204190314.25373-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190204190314.25373-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 10:59:20 +0000
Message-ID: <CAFEAcA-q7Y5zoOr0fSoRPEF9G401qqhta7x=fgd4POSKGmsdCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/11] target/xtensa: SMP updates and
 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Feb 2019 at 19:03, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following series that enables SMP linux support for
> xtensa-softmmu.
>
> The following changes since commit 8b7a3e1e5434b55d7710071b00af97c7086cab7a:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-24 15:04:47 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20190204-xtensa
>
> for you to fetch changes up to 174e09b73ab1c47408dd29fb36c4dd9fbda54f97:
>
>   hw/xtensa: xtfpga: raise CPU number limit (2019-01-28 11:55:20 -0800)
>
> ----------------------------------------------------------------
> target/xtensa: SMP updates and various fixes
>
> - fix CPU wakeup on runstall changes; expose runstall as an IRQ line;
> - place mini-bootloader at the BSP reset vector;
> - expose CPU core frequency in XTFPGA board FPGA register;
> - rearrange access to external interrupts of xtensa cores;
> - add MX interrupt distributor and use it on SMP XTFPGA boards;
> - add test_mmuhifi_c3 xtensa core variant;
> - raise number of CPUs that can be instantiated on XTFPGA boards.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

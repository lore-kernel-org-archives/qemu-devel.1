Received: from eggs.gnu.org ([209.51.188.92]:53285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gla5z-0001hw-Ru
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gla5x-0001Px-0C
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:58:35 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:40954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gla5v-0001K5-3P
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:58:31 -0500
Received: by mail-ot1-x331.google.com with SMTP id s5so20577510oth.7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 05:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20190121104346.30821-1-peter.maydell@linaro.org>
In-Reply-To: <20190121104346.30821-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 13:58:10 +0000
Message-ID: <CAFEAcA9pWGYFY3DFcCim2rUvCEhVh_QQX8qhUDZgPL=vTHtJoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/48] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 21 Jan 2019 at 10:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v1->v2 changes: fix a clang warning about bitfields;
> drop a patch from Julia that I accidentally included
> (it will likely be in a future series).
>
> The following changes since commit a8d2b0685681e2f291faaa501efbbd76875f8ec8:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190118' into staging (2019-01-18 16:56:15 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190121
>
> for you to fetch changes up to 0d4bfd7df809863b1f45fad35229fb9419527d06:
>
>   target/arm: Implement PMSWINC (2019-01-21 10:38:56 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/char/stm32f2xx_usart: Do not update data register when device is disabled
>  * hw/arm/virt-acpi-build: Set COHACC override flag in IORT SMMUv3 node
>  * target/arm: Allow Aarch32 exception return to switch from Mon->Hyp
>  * ftgmac100: implement the new MDIO interface on Aspeed SoC
>  * implement the ARMv8.3-PAuth extension
>  * improve emulation of the ARM PMU
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

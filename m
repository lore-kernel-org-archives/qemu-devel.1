Received: from eggs.gnu.org ([2001:4830:134:3::10]:50432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbNkQ-0003rp-2a
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbNkO-0007EM-Vq
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:13:54 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbNkO-0007Ay-HF
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:13:52 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so22450348oib.10
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 03:13:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706012215.21714-1-alistair.francis@wdc.com>
References: <20180706012215.21714-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 11:13:31 +0100
Message-ID: <CAFEAcA-47XAknVgachzZPM2_9hj22sP9koC5hJ-GVAaQ-eHtYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>

On 6 July 2018 at 02:22, Alistair Francis <alistair.francis@wdc.com> wrote:
> The following changes since commit cee35138b59c6d6b0808c5fa644e3f063832860f:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-code-coverage-and-build-tweaks-050718-3' into staging (2018-07-05 18:24:28 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180705
>
> for you to fetch changes up to 5a7f76a3d47a75290868968682c0585d380764a4:
>
>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-07-05 15:24:25 -0700)
>
> ----------------------------------------------------------------
> RISC-V: SoCify SiFive boards and connect GEM
>
> This series has three tasks:
>  1. To convert the SiFive U and E machines into SoCs and boards
>  2. To connect the Cadence GEM device to the SiFive U board
>  3. Fix some device tree problems with the SiFive U board
>
> After this series the SiFive E and U boards have their SoCs split into
> seperate QEMU objects, which can be used on future boards if desired.
>
> The RISC-V Virt and Spike boards have not been converted. They haven't
> been converted as they aren't physical boards, so it doesn't make a
> whole lot of sense to split them into an SoC and board. The only
> disadvantage with this is that they now differ to the SiFive boards.
>
> This series also connect the Cadence GEM device to the SiFive U board.
> There are some interrupt line changes requried before this is possible.

Applied, thanks.

-- PMM

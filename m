Received: from eggs.gnu.org ([2001:4830:134:3::10]:52862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYxlp-0000mR-Ku
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYxll-0000z8-3f
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:05:21 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYxlk-0000xM-Tb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 14:05:17 -0400
Received: by mail-qk0-x241.google.com with SMTP id u21-v6so5406006qku.2
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 11:05:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629172215.29475-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1c0d57b-3e63-643a-9b65-ce9945902ea5@amsat.org>
Date: Fri, 29 Jun 2018 15:05:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180629172215.29475-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, mjc@sifive.com
Cc: alistair23@gmail.com

On 06/29/2018 02:22 PM, Alistair Francis wrote:
> The following changes since commit 75507f1aba6feb73ae43329922d51571550b9128:
> 
>   Merge remote-tracking branch 'remotes/berrange/tags/min-glib-pull-request' into staging (2018-06-29 15:04:20 +0100)
> 
> are available in the Git repository at:
> 
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180629
> 
> for you to fetch changes up to e4847c96685e210649e6ec90fecd732a744dad75:
> 
>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-29 09:51:05 -0700)
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
> 
> ----------------------------------------------------------------
> Alistair Francis (7):
>       hw/riscv/sifive_u: Create a SiFive U SoC object
>       hw/riscv/sifive_e: Create a SiFive E SoC object
>       hw/riscv/sifive_plic: Use gpios instead of irqs
>       hw/riscv/sifive_u: Set the soc device tree node as a simple-bus
>       hw/riscv/sifive_u: Set the interrupt controler number of interrupts
>       hw/riscv/sifive_u: Move the uart device tree node under /soc/
>       hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device
> 
>  default-configs/riscv32-softmmu.mak |   3 +-
>  default-configs/riscv64-softmmu.mak |   3 +-
>  hw/riscv/sifive_e.c                 | 102 +++++++++++++++++-------
>  hw/riscv/sifive_plic.c              |   6 +-
>  hw/riscv/sifive_u.c                 | 151 +++++++++++++++++++++++++++++-------
>  hw/riscv/virt.c                     |   4 +-
>  include/hw/riscv/sifive_e.h         |  16 +++-
>  include/hw/riscv/sifive_plic.h      |   1 -
>  include/hw/riscv/sifive_u.h         |  25 +++++-
>  9 files changed, 241 insertions(+), 70 deletions(-)
> 

Again, many servers replied "gpg: keyserver receive failed: No data" but
this one worked:

hkps.pool.sks-keyservers.net has address 18.9.60.141

FWIW:

$ gpg --export -a 21E10D29DF977054
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
1HhH/pzsdFWqN02zQRDg0IA=
=Vf6y
-----END PGP PUBLIC KEY BLOCK-----

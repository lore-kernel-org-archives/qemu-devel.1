Received: from eggs.gnu.org ([2001:4830:134:3::10]:44425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fce5g-0005Dg-Qh
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fce5g-0004Mu-1M
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:53:04 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fce5f-0004Lz-Pr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:53:03 -0400
Received: by mail-lj1-x241.google.com with SMTP id p10-v6so9793958ljg.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 14:53:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mvm36ws7mq7.fsf@suse.de>
References: <20180706012215.21714-1-alistair.francis@wdc.com>
	<mvm36ws7mq7.fsf@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jul 2018 14:52:31 -0700
Message-ID: <CAKmqyKNx9M6rLGcrv-ZuCtf5q5QyjrdpNr5d+q=tAdqZSXvJRQ@mail.gmail.com>
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
To: Andreas Schwab <schwab@suse.de>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Jul 9, 2018 at 3:00 AM, Andreas Schwab <schwab@suse.de> wrote:
> What is the state of the sifive_u emulation?  When I tried to boot a bbl
> with an included kernel I get these errors:
>
> qemu-system-riscv64: plic: invalid register write: 00002090
> qemu-system-riscv64: plic: invalid register write: 00002094
> qemu-system-riscv64: plic: invalid register write: 00002098
> qemu-system-riscv64: plic: invalid register write: 0000209c
> qemu-system-riscv64: plic: invalid register write: 000020a0
> qemu-system-riscv64: plic: invalid register write: 000020a4
> qemu-system-riscv64: plic: invalid register write: 000020a8
> qemu-system-riscv64: plic: invalid register write: 000020ac
> qemu-system-riscv64: plic: invalid register write: 000020b0
> qemu-system-riscv64: plic: invalid register write: 000020b4

I see those as well. I haven't investigated but I assume we are just
not completely modelling the PLIC. In saying that it should still
boot. Do you not see the kernel booting?

Alistair

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

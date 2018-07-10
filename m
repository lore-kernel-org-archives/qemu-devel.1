Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fcn1Q-0005LI-ES
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fcn1M-0006LO-EW
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35492 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1fcn1M-0006Ki-8T
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:25:12 -0400
From: Andreas Schwab <schwab@suse.de>
References: <20180706012215.21714-1-alistair.francis@wdc.com>
	<mvm36ws7mq7.fsf@suse.de>
	<CAKmqyKNx9M6rLGcrv-ZuCtf5q5QyjrdpNr5d+q=tAdqZSXvJRQ@mail.gmail.com>
Date: Tue, 10 Jul 2018 09:25:09 +0200
In-Reply-To: <CAKmqyKNx9M6rLGcrv-ZuCtf5q5QyjrdpNr5d+q=tAdqZSXvJRQ@mail.gmail.com>
	(Alistair Francis's message of "Mon, 9 Jul 2018 14:52:31 -0700")
Message-ID: <mvmr2kb5z8q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v4 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Clark <mjc@sifive.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Jul 09 2018, Alistair Francis <alistair23@gmail.com> wrote:

> On Mon, Jul 9, 2018 at 3:00 AM, Andreas Schwab <schwab@suse.de> wrote:
>> What is the state of the sifive_u emulation?  When I tried to boot a bbl
>> with an included kernel I get these errors:
>>
>> qemu-system-riscv64: plic: invalid register write: 00002090
>> qemu-system-riscv64: plic: invalid register write: 00002094
>> qemu-system-riscv64: plic: invalid register write: 00002098
>> qemu-system-riscv64: plic: invalid register write: 0000209c
>> qemu-system-riscv64: plic: invalid register write: 000020a0
>> qemu-system-riscv64: plic: invalid register write: 000020a4
>> qemu-system-riscv64: plic: invalid register write: 000020a8
>> qemu-system-riscv64: plic: invalid register write: 000020ac
>> qemu-system-riscv64: plic: invalid register write: 000020b0
>> qemu-system-riscv64: plic: invalid register write: 000020b4
>
> I see those as well. I haven't investigated but I assume we are just
> not completely modelling the PLIC. In saying that it should still
> boot. Do you not see the kernel booting?

I don't see those errors when using the qemu from github:riscv/riscv-qemu.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fd2hW-0000n8-1l
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fd2hU-00072h-Vx
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:09:46 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fd2hU-00072I-Ob
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 20:09:44 -0400
Received: by mail-lf0-x244.google.com with SMTP id n96-v6so19786327lfi.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 17:09:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mvmr2kb5z8q.fsf@suse.de>
References: <20180706012215.21714-1-alistair.francis@wdc.com>
	<mvm36ws7mq7.fsf@suse.de>
	<CAKmqyKNx9M6rLGcrv-ZuCtf5q5QyjrdpNr5d+q=tAdqZSXvJRQ@mail.gmail.com>
	<mvmr2kb5z8q.fsf@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jul 2018 17:09:12 -0700
Message-ID: <CAKmqyKPd9h6X-YM8J08EOcS-jCK_YjRgmw6b9mELZYbNj3eVOw@mail.gmail.com>
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

On Tue, Jul 10, 2018 at 12:25 AM, Andreas Schwab <schwab@suse.de> wrote:
> On Jul 09 2018, Alistair Francis <alistair23@gmail.com> wrote:
>
>> On Mon, Jul 9, 2018 at 3:00 AM, Andreas Schwab <schwab@suse.de> wrote:
>>> What is the state of the sifive_u emulation?  When I tried to boot a bbl
>>> with an included kernel I get these errors:
>>>
>>> qemu-system-riscv64: plic: invalid register write: 00002090
>>> qemu-system-riscv64: plic: invalid register write: 00002094
>>> qemu-system-riscv64: plic: invalid register write: 00002098
>>> qemu-system-riscv64: plic: invalid register write: 0000209c
>>> qemu-system-riscv64: plic: invalid register write: 000020a0
>>> qemu-system-riscv64: plic: invalid register write: 000020a4
>>> qemu-system-riscv64: plic: invalid register write: 000020a8
>>> qemu-system-riscv64: plic: invalid register write: 000020ac
>>> qemu-system-riscv64: plic: invalid register write: 000020b0
>>> qemu-system-riscv64: plic: invalid register write: 000020b4
>>
>> I see those as well. I haven't investigated but I assume we are just
>> not completely modelling the PLIC. In saying that it should still
>> boot. Do you not see the kernel booting?
>
> I don't see those errors when using the qemu from github:riscv/riscv-qemu.

There are extra patches in that fork. One of them must fix the
messages for the PLIC.

I think a fair few of them have been reviewed on list, they just need
a PR to be merged.

Alistair

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

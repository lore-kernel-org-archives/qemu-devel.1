Received: from eggs.gnu.org ([2001:4830:134:3::10]:35923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1flPMO-0002Wz-5r
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 21:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1flPML-0006hH-3w
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 21:58:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1flPMK-0006gR-TJ
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 21:58:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id f14-v6so1551558pgv.13
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 18:58:28 -0700 (PDT)
Date: Thu, 02 Aug 2018 18:58:26 -0700 (PDT)
In-Reply-To: <CAHNT7Nt4m-6wAtHNtArGFV0PP0f5se5R9U=KCHHv65kw7oqHcw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-aedff193-4b11-4e25-9b37-220712cf5e24@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v4 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: alistair23@gmail.com, schwab@suse.de, f4bug@amsat.org, alistair.francis@wdc.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Mon, 09 Jul 2018 16:04:48 PDT (-0700), Michael Clark wrote:
> On Tue, Jul 10, 2018 at 9:52 AM, Alistair Francis <alistair23@gmail.com>
> wrote:
>
>> On Mon, Jul 9, 2018 at 3:00 AM, Andreas Schwab <schwab@suse.de> wrote:
>> > What is the state of the sifive_u emulation?  When I tried to boot a bbl
>> > with an included kernel I get these errors:
>> >
>> > qemu-system-riscv64: plic: invalid register write: 00002090
>> > qemu-system-riscv64: plic: invalid register write: 00002094
>> > qemu-system-riscv64: plic: invalid register write: 00002098
>> > qemu-system-riscv64: plic: invalid register write: 0000209c
>> > qemu-system-riscv64: plic: invalid register write: 000020a0
>> > qemu-system-riscv64: plic: invalid register write: 000020a4
>> > qemu-system-riscv64: plic: invalid register write: 000020a8
>> > qemu-system-riscv64: plic: invalid register write: 000020ac
>> > qemu-system-riscv64: plic: invalid register write: 000020b0
>> > qemu-system-riscv64: plic: invalid register write: 000020b4
>>
>> I see those as well. I haven't investigated but I assume we are just
>> not completely modelling the PLIC. In saying that it should still
>> boot. Do you not see the kernel booting?

FWIW, I see similar looking messages on QEMU master but get a booting kernel.  
Thanks to some of the WD guys our Linux port is rapidly approaching "bootable 
on master", so we should start pushing on the QEMU patch queue a bit as well.

Is there anything in particular I can do to help get patches reviewed?  Michael 
has taken most of the burden here, but I'm trying to schedule much more time 
for code review on my end (which I say while replying to a thread that's been 
dead for a month... :)).

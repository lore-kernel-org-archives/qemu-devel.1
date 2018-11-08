Received: from eggs.gnu.org ([2001:4830:134:3::10]:34415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpQe-0006Zp-Gl
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpQT-0001Wg-9u
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:53:14 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKpQS-0000zc-Vg
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:53:09 -0500
Received: by mail-pl1-x643.google.com with SMTP id p4-v6so7567895plo.5
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:52:19 -0800 (PST)
Date: Thu, 08 Nov 2018 10:52:17 -0800 (PST)
In-Reply-To: <CAKmqyKPHDx7iTQRaY7+5v13oE-ARzpqFDOo4e98Y4bHGH7s+Ww@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-10e50b53-fc97-4315-9a4d-6934d7acd223@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL] A Single RISC-V Patch for 3.1-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Thu, 08 Nov 2018 10:38:51 PST (-0800), alistair23@gmail.com wrote:
> On Thu, Nov 8, 2018 at 10:35 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> The following changes since commit a7ce790a029bd94eb320d8c69f38900f5233997e:
>>
>>   tcg/tcg-op.h: Add multiple include guard (2018-11-08 15:15:32 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-rc1
>>
>> for you to fetch changes up to 00a014ac01feac875468d38c376f7e06f050f992:
>>
>>   riscv: spike: Fix memory leak in the board init (2018-11-08 08:41:06 -0800)
>>
>> ----------------------------------------------------------------
>> A Single RISC-V Patch for 3.1-rc1
>>
>> This tag contains a single patch that I'd like to target for rc1: a fix
>> for a memory leak that was detected by static code analysis.
>>
>> There are still three patch sets that I'd like to try to get up for 3.1:
>>
>> * The patch set Basian just published that contains fixes for a pair of
>>   issues he found when converting our port to decodetree.
>> * An as-of-yet-unwritten fix to the third issue that Basian pointed out.
>> * A fix to our fflags bug, which is currently coupled to some CSR
>>   refactoring that I don't think is OK for 3.1.
>
> There is one more patch fixing a memory leak in the virt board as well.

Oh, sorry about that -- I thought they were the same patch!

Peter: let me know if you want me to submit a new copy of this PR with both 
patches or a follow-on PR.  Sorry for the noise!

>> I'm at Plumbers next week (and I think Alistair is there too?), but I'll
>> try to find a way to squeeze in as much as possible.
>
> Yep! I'll be there.
>
> Alistair
>
>>
>> ----------------------------------------------------------------
>> Alistair Francis (1):
>>       riscv: spike: Fix memory leak in the board init
>>
>>  hw/riscv/spike.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>

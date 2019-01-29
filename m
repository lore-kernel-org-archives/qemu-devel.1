Received: from eggs.gnu.org ([209.51.188.92]:47323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gochS-0002sY-Dp
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 18:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gochR-0003Wl-EN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 18:21:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gochR-0003WT-1H
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 18:21:49 -0500
Received: by mail-pg1-x541.google.com with SMTP id t13so9432789pgr.11
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 15:21:48 -0800 (PST)
Date: Tue, 29 Jan 2019 15:21:46 -0800 (PST)
In-Reply-To: <CAFyWVaYACGYvUe2ehYiT0hjJR4bUc44ZG5niEdT7mJOMXxGVpg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-742f375b-47d4-4554-b13a-270e098799e7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5 v2] RISC-V: Add hooks to use the gdb
 xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>
Cc: alistair23@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Mon, 28 Jan 2019 19:11:58 PST (-0800), Jim Wilson wrote:
> On Tue, Jan 22, 2019 at 1:52 PM Alistair Francis <alistair23@gmail.com> wrote:
>> You can get env and then check for floating point support:
>>
>> CPURISCVState *env = &cs->env;
>> if (env->misa_mask & RVF) {
>> ...
>
> I needed this which wasn't hard to figure out.
>     RISCVCPU *cpu = RISCV_CPU(cs);
>     CPURISCVState *env = &cpu->env;
>     if (env->misa & RVF) {
>
> The tricky bit was figuring out how to test it, because I wasn't sure
> if making registers conditional would actually work.  I figured out
> that using -machine sifive_e gives me a target with no fpu, and
> playing with that a bit I get the expected result, which is that the
> FP regs don't print anymore.  The FP related CSRs still do, but that
> would require gdb fixes I think, because gdb knows that they are both
> FP regs and CSR, and tries to print them both ways.  That leads to a
> more general problem of figuring out exactly which CSRs a particular
> target implements, which is a bigger problem than I have time to fix
> at the moment, and should be handled as a separate problem.
>
> Since my patch set is now a month old, I'll rebase onto current master
> and post a version 3 patch set.

Thanks!

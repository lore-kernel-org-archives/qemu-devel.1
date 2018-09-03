Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fwjtW-0003Ui-T7
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fwjtV-00088g-Vf
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:07:34 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:38091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fwjtV-00088S-Jt
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:07:33 -0400
Received: by mail-oi0-x230.google.com with SMTP id x197-v6so32177554oix.5
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 01:07:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCCUzMvQbbcfa8GboH1wpCogFSr1vgf==1EjAz8L+yxo6w@mail.gmail.com>
References: <CAJhHMCDR3FVHxO7hfUNbYTM2zsx6Q1CeKfeMjkW0b-En-1Z0Xw@mail.gmail.com>
	<CAJhHMCCUzMvQbbcfa8GboH1wpCogFSr1vgf==1EjAz8L+yxo6w@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 3 Sep 2018 20:07:32 +1200
Message-ID: <CAHNT7NvuwMw71jn4aQP2DWiekMEe0veSNrnL0tao3pPR+uGROg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu-riscv64 seg fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Thanks. I was just about to log an issue in the riscv-qemu issue tracker on
GitHub.

I reproduced it on my side. The fact that it is causes QEMU user to crash
in translate.c is interesting.

I ran your program with -d in_asm and it appears to crash in thread::join

On Mon, Sep 3, 2018 at 7:58 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:

> On second looks, running the benchmark on a RISCV processor is also
> giving a seg fault. So may be there is something wrong with the
> benchmark... OTOH, x86 version runs fine... hmm
>
> Please ignore this report, I will try to investigate further.
>
> Thanks,
> On Mon, Sep 3, 2018 at 12:45 AM Pranith Kumar <bobby.prani@gmail.com>
> wrote:
> >
> > Hi Michael,
> >
> > qemu-riscv64 seg faults for me on a static binary. You can build the
> > binary from here: https://github.com/pranith/quickht
> >
> > $ STATIC=1 RISCV=1 make
> >
> > $ qemu-riscv64 ./bench -t 1 -u 1
> > <seg fault>
> >
> > Thanks,
> > --
> > Pranith
>
>
>
> --
> Pranith
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1fwjl8-0007Yv-KG
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1fwjl7-0003Du-A6
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:58:54 -0400
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:38030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1fwjl7-0003Cm-4j
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:58:53 -0400
Received: by mail-it0-x22b.google.com with SMTP id p129-v6so117581ite.3
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 00:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJhHMCDR3FVHxO7hfUNbYTM2zsx6Q1CeKfeMjkW0b-En-1Z0Xw@mail.gmail.com>
In-Reply-To: <CAJhHMCDR3FVHxO7hfUNbYTM2zsx6Q1CeKfeMjkW0b-En-1Z0Xw@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 3 Sep 2018 00:58:25 -0700
Message-ID: <CAJhHMCCUzMvQbbcfa8GboH1wpCogFSr1vgf==1EjAz8L+yxo6w@mail.gmail.com>
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
To: mjc@sifive.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On second looks, running the benchmark on a RISCV processor is also
giving a seg fault. So may be there is something wrong with the
benchmark... OTOH, x86 version runs fine... hmm

Please ignore this report, I will try to investigate further.

Thanks,
On Mon, Sep 3, 2018 at 12:45 AM Pranith Kumar <bobby.prani@gmail.com> wrote:
>
> Hi Michael,
>
> qemu-riscv64 seg faults for me on a static binary. You can build the
> binary from here: https://github.com/pranith/quickht
>
> $ STATIC=1 RISCV=1 make
>
> $ qemu-riscv64 ./bench -t 1 -u 1
> <seg fault>
>
> Thanks,
> --
> Pranith



-- 
Pranith

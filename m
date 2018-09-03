Received: from eggs.gnu.org ([2001:4830:134:3::10]:49176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1fwk2Z-0001my-RN
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1fwk2Z-00037q-7f
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:16:55 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:39745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1fwk2Z-00037c-21
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 04:16:55 -0400
Received: by mail-io0-x22f.google.com with SMTP id l7-v6so15248538iok.6
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 01:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJhHMCDR3FVHxO7hfUNbYTM2zsx6Q1CeKfeMjkW0b-En-1Z0Xw@mail.gmail.com>
	<CAJhHMCCUzMvQbbcfa8GboH1wpCogFSr1vgf==1EjAz8L+yxo6w@mail.gmail.com>
	<CAHNT7NvuwMw71jn4aQP2DWiekMEe0veSNrnL0tao3pPR+uGROg@mail.gmail.com>
In-Reply-To: <CAHNT7NvuwMw71jn4aQP2DWiekMEe0veSNrnL0tao3pPR+uGROg@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 3 Sep 2018 01:16:27 -0700
Message-ID: <CAJhHMCBKpf2F5NqEvZOugzd0TgK802TxCWfYL1Y2ELiGH-vmJg@mail.gmail.com>
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

On Mon, Sep 3, 2018 at 1:07 AM Michael Clark <mjc@sifive.com> wrote:
>
> Thanks. I was just about to log an issue in the riscv-qemu issue tracker on GitHub.
>
> I reproduced it on my side. The fact that it is causes QEMU user to crash in translate.c is interesting.
>
> I ran your program with -d in_asm and it appears to crash in thread::join

Interestingly, qemu-x86_64 crashes too. But running natively on x86
works fine. There is something off somewhere...

~/quickht$ qemu-x86_64 ./bench -t 2 -u 2
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault

~/quickht$ ./bench -t 2 -u 2
Comparisons: 23922
Buckets touched: 4933
Operations: 2000

--
Pranith

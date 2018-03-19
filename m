Received: from eggs.gnu.org ([2001:4830:134:3::10]:46704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2zQ-0000cM-SH
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2zP-00054g-Ip
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:10:48 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:40935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2zP-00053n-Ct
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:10:47 -0400
Received: by mail-oi0-x235.google.com with SMTP id c12so15657225oic.7
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 15:10:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mvm1sggjazj.fsf@suse.de>
References: <mvm1sggjazj.fsf@suse.de>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 15:10:46 -0700
Message-ID: <CAHNT7NuOLVGyodcJ98ruM5t+m1s=in07dXfNp_77=vTOb=1yhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu:handle_cpu_signal received signal outside
 vCPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Mar 19, 2018 at 9:17 AM, Andreas Schwab <schwab@suse.de> wrote:

> I'm seeing this error while building gedit for riscv64 with linux-user
> emulation:
>
> $ LD_LIBRARY_PATH=gedit/.libs qemu-riscv64 gedit/.libs/gedit
> --introspect-dump=/tmp/tmp-introspectnj0xla07/functions.txt,
> /tmp/tmp-introspectnj0xla07/dump.xml
> qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x6003d7d5
> qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x60106a16
>

Thanks. I can see this code in accel/tcg/user-exec.c

It would be nice if that log message included the signal number. I wonder
if we are getting a SIGSEGV. I also wonder what thread is actually
running...


> This is qemu as of today with the patches from
> git://github.com/riscv/riscv-qemu / riscv-all on top.


Okay. We don't have any linux-user specific patches in our patch series so
it likely the same in the master branch.

I wonder what is the best way for me to reproduce on my side... a tarball
with binaries that I can use to trigger the fault?

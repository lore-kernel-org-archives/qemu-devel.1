Received: from eggs.gnu.org ([209.51.188.92]:35428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasha.tatashin@soleen.com>) id 1ggZT2-0002P4-CV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasha.tatashin@soleen.com>) id 1ggZT0-00037s-2n
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:17:40 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pasha.tatashin@soleen.com>)
	id 1ggZSz-0002t6-OM
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:17:37 -0500
Received: by mail-ed1-x544.google.com with SMTP id a20so1788428edc.8
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 10:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
In-Reply-To: <20190103234339.GA17457@nautica>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 7 Jan 2019 13:17:16 -0500
Message-ID: <CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Steven Sistare <steven.sistare@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Thu, Jan 3, 2019 at 6:43 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Pavel Tatashin wrote on Thu, Jan 03, 2019:
> > Could you please send the config file and qemu arguments that were
> > used to reproduce this problem.
>
> Running qemu by hand, nothing fancy e.g. this works:
>
> # qemu-system-x86_64 -m 1G -smp 4 -drive file=/root/kvm-wrapper/disks/f2.img,if=virtio -serial mon:stdio --enable-kvm -cpu Haswell -device virtio-rng-pci -nographic
>
> (used a specific cpu just in case but normally runnning with cpu host on
> a skylake machine; can probably go older)
>
>
> qemu is fedora 29 blend as is:
> $ qemu-system-x86_64 --version
> QEMU emulator version 3.0.0 (qemu-3.0.0-3.fc29)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
>
> compressed .config attached to the mail, this can likely be trimmed down
> some as well but that takes more time for me..
> I didn't rebuild the kernel so not 100% sure (comes from
> /proc/config.gz) but it should work on a 4.20-rc2 kernel as written in
> the first few lines; 857baa87b64 I referred to in another mail was
> merged in 4.19-rc1 so anything past that is probably OK to reproduce...
>
>
> Re-checked today with these exact options (fresh VM start; then suspend
> laptop for a bit, then reboot VM):
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [ 2477.907447] kvm-clock: cpu 0, msr 153a4001, primary cpu clock
> [ 2477.907448] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [ 2477.907450] tsc: Detected 2592.000 MHz processor

I could not reproduce the problem. Did you suspend to memory between
wake ups? Does this time jump happen every time, even if your laptop
sleeps for a minute?

I have tried with qemu 2.6 and 3.1 on Ubuntu, testing 4.20rc2.

Pasha

Received: from eggs.gnu.org ([209.51.188.92]:58231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasha.tatashin@soleen.com>) id 1gnQYa-0007LG-JL
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 11:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasha.tatashin@soleen.com>) id 1gnQYZ-0003Tc-SK
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 11:11:44 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pasha.tatashin@soleen.com>)
	id 1gnQYZ-0003S5-IF
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 11:11:43 -0500
Received: by mail-qk1-x742.google.com with SMTP id 189so7160748qkj.8
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 08:11:40 -0800 (PST)
Date: Sat, 26 Jan 2019 16:11:37 +0000
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Message-ID: <20190126161137.gme4vsrz3xmncbkx@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
	<CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
	<20190107234839.GA15269@nautica>
	<CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
	<20190126020410.GB3796@feynman.vault24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126020410.GB3796@feynman.vault24.org>
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominique Martinet <asmadeus@codewreck.org>, Salvatore Bonaccorso <carnil@debian.org>, Steven Sistare <steven.sistare@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 19-01-25 21:04:10, Jon DeVree wrote:
> 
> * KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is always set by the hypervisor
>   starting with Linux v2.6.35 - 371bcf646d17 ("KVM: x86: Tell the guest
>   we'll warn it about tsc stability")
> * PVCLOCK_TSC_STABLE_BIT is set starting in Linux v3.8 but only if the
>   clocksource is the TSC - d828199e8444 ("KVM: x86: implement
>   PVCLOCK_TSC_STABLE_BIT pvclock flag")
> 
> I changed the clocksource of a hypervisor that wasn't having issues from
> TSC to HPET and when I started up a guest VM the bug suddenly appeared.
> I shut down the guest, set the hypervisor's clocksource back to TSC,
> started up the guest and the bug went away again.
> 
> You don't actually have to reboot the guest before the bug is visible
> either, just letting the guest sit at the GRUB menu for a minute or two
> before loading Linux is enough to make the bug plainly visible in the
> printk timestamps.
> 
> I don't know enough to actually fix the bug, but hopefully this is
> enough to allow everyone else to reproduce it and come up with a fix.

Thank you very much for your analysis, I am now able to reproduce the
problem by setting clocksource on my machine to hpet. I will soon submit a
patch with a fix.

Pasha

> 
> -- 
> Jon
> X(7): A program for managing terminal windows. See also screen(1) and tmux(1).

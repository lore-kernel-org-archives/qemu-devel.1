Received: from eggs.gnu.org ([2001:4830:134:3::10]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1fayVE-0004lO-8m
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1fayVD-0002MW-FU
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:16:32 -0400
References: <CA++5wji+jjiTcBT+Uhd4VL2U70vmRFnvacbRqhnxWX3M=f7svA@mail.gmail.com>
	<edee4a56-e75e-f3cb-8423-2f891be1ff3f@oracle.com>
	<CA++5wjjCMY0Si0HWw4Y5DEswOsQ5MnaoE_6y2xUXcG=y-9FwBQ@mail.gmail.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <298d7750-3dca-f741-abe2-4efef0b2d200@oracle.com>
Date: Thu, 5 Jul 2018 15:16:44 +0800
MIME-Version: 1.0
In-Reply-To: <CA++5wjjCMY0Si0HWw4Y5DEswOsQ5MnaoE_6y2xUXcG=y-9FwBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-discuss] IRQ per CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Probir Roy <roy@probir.info>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org



On 07/05/2018 12:12 PM, Probir Roy wrote:
>> Does 'per CPU basis' indicates irq per cpu, or irq per device queue?
> 
> IRQ per CPU core, meaning that IRQ will be raised at and served by
> that CPU. Does IRQ per queue mean the same thing?
> 

About 'IRQ per queue', the device may create multiple queue in the OS driver.
The number of queues are always proportional to the number of CPU core/thread
(although this is also always configurable by OS driver).

Usually the per-queue irq/vector is bound to each CPU. As the number of
queue/irq is always the same as the number of CPU, it is sort of 'per CPU
basis', as each CPU will be serving irq for its own queue.

Dongli Zhang

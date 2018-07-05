Received: from eggs.gnu.org ([2001:4830:134:3::10]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1favHx-00053k-9L
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1favHw-000423-9u
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:50:37 -0400
References: <CA++5wji+jjiTcBT+Uhd4VL2U70vmRFnvacbRqhnxWX3M=f7svA@mail.gmail.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <edee4a56-e75e-f3cb-8423-2f891be1ff3f@oracle.com>
Date: Thu, 5 Jul 2018 11:50:50 +0800
MIME-Version: 1.0
In-Reply-To: <CA++5wji+jjiTcBT+Uhd4VL2U70vmRFnvacbRqhnxWX3M=f7svA@mail.gmail.com>
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



On 07/04/2018 10:32 PM, Probir Roy wrote:
> I am writing a virtual device that would generate IRQ per CPU basis. I

Does 'per CPU basis' indicates irq per cpu, or irq per device queue?

AFAIK, the device may create multiple queues in the driver (in OS) and we would
have one irq (vector) per queue?

If you are talking about irq (vector) per queue, I would suggest read about
following on nvme which involves per-queue vector.

https://github.com/qemu/qemu/blob/master/hw/block/nvme.c

Although I am not expert on qemu, in my opinion the qemu nvme code is very
helpful for understanding per-queue vector.

> have written a PCI device from the template which does not generate
> IRQ per CPU. How can write such device in Qemu?
> 
> The code of current device is here:
> https://gist.github.com/proywm/6ca98d3e8ca001965e2c8792fcf97911
> 
> Regards,
> Probir
> 

Dongli Zhang

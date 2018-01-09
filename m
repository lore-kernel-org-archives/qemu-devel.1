Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hikarupsp@gmail.com>) id 1eYhvr-0005Bs-E4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hikarupsp@gmail.com>) id 1eYhvq-0003Gf-C8
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:38:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180108152844.GH8052@localhost.localdomain>
References: <1513573243-29022-1-git-send-email-hikarupsp@gmail.com>
	<20180108152844.GH8052@localhost.localdomain>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Tue, 9 Jan 2018 09:38:04 +0900
Message-ID: <CAD-w0GDbEGNDJhwmbazLoMWPQKbMh08YRA1tF8BKvChkLNfQBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/block: Fix pin-based interrupt
 behaviour of NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

Thank you for applying my patch.

> I had to resolve conflicts with the tracing patches and chose to keep
> the trace points from pci_irq_pulse() for pci_irq_assert(), but didn't
> add them to pci_irq_deassert(). Please check if this makes sense to you.

It makes sense for now.
I will send another patch shortly to improve some points of the
tracing functions.

Hikaru Nishida

2018-01-09 0:28 GMT+09:00 Kevin Wolf <kwolf@redhat.com>:
> Am 18.12.2017 um 06:00 hat Hikaru Nishida geschrieben:
>> Pin-based interrupt of NVMe controller did not work properly
>> because using an obsolated function pci_irq_pulse().
>> To fix this, change to use pci_irq_assert() / pci_irq_deassert()
>> instead of pci_irq_pulse().
>>
>> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
>
> Thanks, applied to the block branch.
>
> I had to resolve conflicts with the tracing patches and chose to keep
> the trace points from pci_irq_pulse() for pci_irq_assert(), but didn't
> add them to pci_irq_deassert(). Please check if this makes sense to you.
> Here is the commit after my conflict resolution:
>
> http://repo.or.cz/qemu/kevin.git/commitdiff/44c55a9159f2048a26c07e50dbc21c934917b82c
>
> Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQVrs-0007tQ-2g
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQVro-0004ad-Vo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:03:52 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cQVro-0004aQ-PB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:03:48 -0500
Received: by mail-wm0-x244.google.com with SMTP id l2so20484504wml.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 01:03:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1483952153-7221-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a93b912d-7b2c-39f9-6335-3335fef3191f@redhat.com>
Date: Mon, 9 Jan 2017 10:04:06 +0100
MIME-Version: 1.0
In-Reply-To: <1483952153-7221-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] x86: ioapic: fix fail migrate when
 irqchip=split
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org



On 09/01/2017 09:55, Peter Xu wrote:
> Split irqchip works based on the fact that we kept the first 24 gsi
> routing entries inside KVM for userspace ioapic's use. When system
> boot, we'll reserve these MSI routing entries before hand. However,
> after migration, we forgot to re-configure it up in the destination
> side. The result is, we'll get invalid gsi routing entries after
> migration (all empty), and we get interrupts with vector=0, then
> strange things happen, like keyboard hang.
> 
> The solution is simple - we update them after migration, which is a
> one line fix in patch 3.
> 
> The first two patches are things I used for debugging this issue.
> Though it might not be directly related, I still think it's something
> good to have in case we encounter similar interrupt issues in the
> future.
> 
> Please review, thanks,
> 
> Peter Xu (3):
>   x86: ioapic: add traces for ioapic
>   x86: ioapic: dump version for "info ioapic"
>   x86: ioapic: fix fail migration when irqchip=split
> 
>  hw/intc/ioapic.c        | 22 ++++++++++++++++++++--
>  hw/intc/ioapic_common.c |  3 ++-
>  hw/intc/trace-events    |  7 +++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 

Thanks, queued.

Paolo

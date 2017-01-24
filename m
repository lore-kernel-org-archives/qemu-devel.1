Received: from eggs.gnu.org ([2001:4830:134:3::10]:36941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVxLk-0002Co-DR
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVxLj-0005Br-KV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:25:12 -0500
References: <1485132904-17632-1-git-send-email-zhaoshenglong@huawei.com>
	<20170123180247-mutt-send-email-mst@kernel.org>
	<49fcc1e0-f439-9212-25f1-9b8dce6462cc@redhat.com>
	<20170123190257-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5760ee8c-f567-0dfd-456f-65f8957b22e2@redhat.com>
Date: Tue, 24 Jan 2017 10:25:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170123190257-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] virtio: Fix no interrupt when not
 creating msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org



On 23/01/2017 18:04, Michael S. Tsirkin wrote:
>> For virtio-blk, my patch moved the setting of ISR from
>> virtio_queue_guest_notifier_read to virtio_notify_irqfd.  This is
>> because the irqfd emulation only needs to trigger the interrupt.
>> Setting the ISR should have been done elsewhere.
>>
>> Can vhost set ISR (I thought it couldn't)?  If so, it seems like ARM was
>> relying on QEMU's irqfd emulation, as a work around for vhost not
>> setting ISR.  But this only works if irqfd is directed to QEMU and not
>> to KVM.  So if vhost cannot set ISR, I think vhost should be disabled
>> unless MSI is active.
>>
>> Am I missing something?
>
> vhost doesn't set ISR ATM.  Without MSI we are always bouncing
> interrupts through QEMU in particular in order to set ISR.

Where is the code that disables KVM irqfd?

Paolo

> Disabling vhost when user requested it was what we did
> at some point but this just confused people.
> 
> 

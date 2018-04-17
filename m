Received: from eggs.gnu.org ([2001:4830:134:3::10]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=63820fd2d=igor.druzhinin@citrix.com>)
	id 1f8RcD-0006LW-6k
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=63820fd2d=igor.druzhinin@citrix.com>)
	id 1f8RcA-0007WV-GM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:29:49 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:12677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=63820fd2d=igor.druzhinin@citrix.com>)
	id 1f8RcA-0007UM-7h
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:29:46 -0400
References: <1523049683-11782-1-git-send-email-igor.druzhinin@citrix.com>
	<20180417141518.GM2208@perard>
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <c7d408cb-454c-2322-3812-a7cacecdbe5f@citrix.com>
Date: Tue, 17 Apr 2018 15:29:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180417141518.GM2208@perard>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] xen/pt: use address_space_memory object
 for memory region hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, sstabellini@kernel.org, ross.lagerwall@citrix.com

On 17/04/18 15:15, Anthony PERARD wrote:
> On Fri, Apr 06, 2018 at 10:21:23PM +0100, Igor Druzhinin wrote:
>> Commit 99605175c (xen-pt: Fix PCI devices re-attach failed) introduced
>> a subtle bug. As soon as the guest switches off Bus Mastering on the
>> device it immediately causes all the BARs be unmapped due to the DMA
>> address space of the device being changed. This is undesired behavior
>> because the guest may try to communicate with the device after that
>> which triggers the following errors in the logs:
>>
>> [00:05.0] xen_pt_bar_read: Error: Should not read BAR through QEMU. @0x0000000000000200
>> [00:05.0] xen_pt_bar_write: Error: Should not write BAR through QEMU. @0x0000000000000200
>>
>> The issue that the original patch tried to workaround (uneven number of
>> region_add/del calls on device attach/detach) was fixed in later QEMU
>> versions.
> 
> Do you know when the issue was fixed?
> 

I think it's this commit:

commit d25836cafd7508090d211e97acfc0abc5ae88daa
Author: Peter Xu <peterx@redhat.com>
Date:   Mon Jan 22 14:02:44 2018 +0800

    memory: do explicit cleanup when remove listeners

Igor

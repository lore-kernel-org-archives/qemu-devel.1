Received: from eggs.gnu.org ([2001:4830:134:3::10]:41032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1elIhw-0000lm-FJ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1elIhr-0008P9-Lf
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:20:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1elIhr-0008Ns-Da
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:19:59 -0500
References: <20180201205511.19198-1-marcel@redhat.com>
	<20180201205511.19198-2-marcel@redhat.com>
	<20180208210035.GK13301@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f4d83081-7d69-5023-63e2-696e6c4a7365@redhat.com>
Date: Mon, 12 Feb 2018 20:19:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180208210035.GK13301@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 1/4] mem: add share parameter to
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, cohuck@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, dotanb75@yahoo.com

Hi Eduardo,

[This is a re-send, I didn't see the response
 on the mailing list, sorry for the spam]

On 08/02/2018 23:00, Eduardo Habkost wrote:
> On Thu, Feb 01, 2018 at 10:55:08PM +0200, Marcel Apfelbaum wrote:
>> Currently only file backed memory backend can
>> be created with a "share" flag in order to allow
>> sharing guest RAM with other processes in the host.
>>
>> Add the "share" flag also to RAM Memory Backend
>> in order to allow remapping parts of the guest RAM
>> to different host virtual addresses. This is needed
>> by the RDMA devices in order to remap non-contiguous
>> QEMU virtual addresses to a contiguous virtual address range.
>>
>> Moved the "share" flag to the Host Memory base class,
>> modified phys_mem_alloc to include the new parameter
>> and a new interface memory_region_init_ram_shared_nomigrate.
>>
>> There are no functional changes if the new flag is not used.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> Code looks correct, so:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 

Appreciated!

> But later can we please stop the explosion of memory_init_ram*()
> functions and replace them with a single function with a flags
> parameter?
> 

Sounds reasonable.


Thanks,
Marcel

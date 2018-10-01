Received: from eggs.gnu.org ([2001:4830:134:3::10]:52920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tSR-0001KE-2O
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g6tSP-0001wL-BY
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:21:34 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-17-david@redhat.com>
	<2c164355-1592-a785-b761-463f00dee259@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c7c561ea-7b14-b943-68cd-5392ecda40e0@redhat.com>
Date: Mon, 1 Oct 2018 10:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <2c164355-1592-a785-b761-463f00dee259@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 16/24] memory-device: trace when
 pre_assigning/assigning/unassigning addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


>>  # hw/mem/pc-dimm.c
>>  mhp_pc_dimm_assigned_slot(int slot) "%d"
>> -mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
>> +# hw/mem/memory-device.c
>> +memory_device_pre_assign_address(uint64_t addr) "0x%"PRIx64
>> +memory_device_assign_address(uint64_t addr) "0x%"PRIx64
>> +memory_device_unassign_address(uint64_t addr) "0x%"PRIx64
> In case we use several memory devices, wouldn't it make sense to pass
> the mr name or id as well to uniquely identify the device?
> 
> nit: For debugging purpose it would look simpler to me to use the
> original function name for the associated trace (all the more so there
> is a single trace within) than the "assign_address" naming.
> 

Both points make sense. I guess I'll move this patch behind
"memory-device: add class function get_device_id()", so I can directly
use get_device_id().

Thanks!

> Thanks
> 
> Eric
>>


-- 

Thanks,

David / dhildenb

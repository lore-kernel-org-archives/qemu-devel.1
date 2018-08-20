Received: from eggs.gnu.org ([2001:4830:134:3::10]:59423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1frdMo-0001QJ-OI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 02:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1frdEy-0001oz-5X
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 02:00:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:2733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1frdEx-0001oW-Tx
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 02:00:36 -0400
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
	<1534411696-6454-2-git-send-email-jing2.liu@linux.intel.com>
	<515049f3-e53f-8091-e71a-c15f630e4b6a@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <3b3b6e4a-0ed8-ce08-21bd-c5151c02d174@linux.intel.com>
Date: Mon, 20 Aug 2018 14:00:05 +0800
MIME-Version: 1.0
In-Reply-To: <515049f3-e53f-8091-e71a-c15f630e4b6a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/pci: factor PCI reserve
 resources to a separate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, lersek@redhat.com, pbonzini@redhat.com

Hi Marcel,

On 8/17/2018 11:49 PM, Marcel Apfelbaum wrote:
> Hi Jing,
> 
[...]
>> +/*
>> + * additional resources to reserve on firmware init
>> + */
>> +typedef struct PCIResReserve {
>> +    uint32_t bus_reserve;
>> +    uint64_t io_reserve;
>> +    uint64_t mem_reserve;
> 
> The patch looks good to me, I noticed you renamed
> 'mem_no_pref_reserve' to 'mem reserve'.
> I remember we had a lot of discussions about the  naming, so they would
> be clear and consistent with the firmware counterpart.
> 
OK, will change 'mem_no_pref_reserve' to 'mem_no_pref' and also for
others.
> Please add a least a comment in the PCIResReserve.
Will add a comment to the structure definition, and where it's called.

> Also, since you encapsulated the fields into a new struct,
> you could remove the  "_reserve" suffix so we
> remain with clear "bus", "io", "mem" ...
> 
Got it.

Thanks,
Jing

> Thanks,
> Marcel
> 
>> +    uint64_t pref32_reserve;
>> +    uint64_t pref64_reserve;
>> +} PCIResReserve;
>> +
>>   int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
>> -                              uint32_t bus_reserve, uint64_t io_reserve,
>> -                              uint64_t mem_non_pref_reserve,
>> -                              uint64_t mem_pref_32_reserve,
>> -                              uint64_t mem_pref_64_reserve,
>> -                              Error **errp);
>> +                               PCIResReserve res_reserve, Error **errp);
>>   #endif /* QEMU_PCI_BRIDGE_H */
> 

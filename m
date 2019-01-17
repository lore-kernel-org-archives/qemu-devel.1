Received: from eggs.gnu.org ([209.51.188.92]:39393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gk6dM-0005lX-Sd
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gk6dM-00078j-1d
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:18:56 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-5-david@redhat.com>
	<7c7cfe1c-16c6-fe1b-0e9f-796502e75652@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <61f73087-0de9-fb38-fa5d-237a1640ff79@redhat.com>
Date: Thu, 17 Jan 2019 13:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <7c7cfe1c-16c6-fe1b-0e9f-796502e75652@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 04/10] virtio-pmem: Prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On 16.01.19 15:46, Eric Blake wrote:
> On 1/16/19 5:35 AM, David Hildenbrand wrote:
>> From: Pankaj Gupta <pagupta@redhat.com>
>>
>> This is the current protoype of virtio-pmem. Support will require
>> machine changes for the architectures that will support it, so it will
>> not yet be compiled.
>>
>> TODO:
>> - Use separate struct for tracking requests internally
>> - Move request/response structs to linux headers
>> - Factor out linux header sync
>> - Drop debug printfs
>>
>> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
>>   split up patches, unplug handler ]
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
>> +++ b/qapi/misc.json
>> @@ -2949,6 +2949,29 @@
>>            }
>>  }
>>  
>> +##
>> +# @VirtioPMEMDeviceInfo:
>> +#
>> +# VirtioPMEM state information
>> +#
>> +# @id: device's ID
>> +#
>> +# @memaddr: physical address in memory, where device is mapped
>> +#
>> +# @size: size of memory that the device provides
>> +#
>> +# @memdev: memory backend linked with device
>> +#
>> +# Since: 3.1
> 
> Now 4.0

Indeed. (if we'll get it into 4.0 of course ;) )
> 
>> +##
>> +{ 'struct': 'VirtioPMEMDeviceInfo',
>> +  'data': { '*id': 'str',
>> +            'memaddr': 'size',
>> +            'size': 'size',
>> +            'memdev': 'str'
>> +          }
>> +}
>> +
>>  ##
>>  # @MemoryDeviceInfo:
>>  #
>> @@ -2958,7 +2981,8 @@
>>  ##
>>  { 'union': 'MemoryDeviceInfo',
> 
> Does this union need a documentation update that virtio-pmem was added
> in 4.0?

We can add that, makes sense!

Thanks!

> 
>>    'data': { 'dimm': 'PCDIMMDeviceInfo',
>> -            'nvdimm': 'PCDIMMDeviceInfo'
>> +            'nvdimm': 'PCDIMMDeviceInfo',
>> +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
>>            }
>>  }
>>  
>>
> 


-- 

Thanks,

David / dhildenb

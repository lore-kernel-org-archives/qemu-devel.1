Received: from eggs.gnu.org ([2001:4830:134:3::10]:37660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fToBa-0001FK-4Y
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fToBZ-0006tG-Ab
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:50:38 -0400
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-9-david@redhat.com>
	<20180615144604.2adc6850@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d0167968-583f-7332-70cd-fc4ab28577d7@redhat.com>
Date: Fri, 15 Jun 2018 14:50:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180615144604.2adc6850@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/12] nvdimm: no need to overwrite
 get_vmstate_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 15.06.2018 14:46, Igor Mammedov wrote:
> On Fri, 15 Jun 2018 13:24:56 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Our parent class (PC_DIMM) provides exactly the same function.
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/nvdimm.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
>> index 37e19044d6..df9716231f 100644
>> --- a/hw/mem/nvdimm.c
>> +++ b/hw/mem/nvdimm.c
>> @@ -166,11 +166,6 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
>>      memory_region_set_dirty(mr, backend_offset, size);
>>  }
>>  
>> -static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
>> -{
>> -    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
>> -}
>> -
>>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>>  {
>>      PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
>> @@ -178,7 +173,6 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
>>  
>>      ddc->realize = nvdimm_realize;
>>      ddc->get_memory_region = nvdimm_get_memory_region;
>> -    ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
>>  
>>      nvc->read_label_data = nvdimm_read_label_data;
>>      nvc->write_label_data = nvdimm_write_label_data;
> 
> maybe put this patch before 7/12 ?
> 

Yes, that's how it was before moving all nvdimm patches into one chunk.

-- 

Thanks,

David / dhildenb

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Matt.Redfearn@imgtec.com>) id 1dx7gk-0001VT-A1
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Matt.Redfearn@imgtec.com>) id 1dx7gg-0001Zl-Bo
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:27:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:10118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Matt.Redfearn@imgtec.com>) id 1dx7gg-0001XR-5W
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:27:22 -0400
References: <1502808257-17395-1-git-send-email-matt.redfearn@imgtec.com>
	<8f87ef69-f93e-d05e-00db-0a68dba85356@redhat.com>
From: Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <eda76580-a54a-868d-5b70-d9c6ba75adac@imgtec.com>
Date: Wed, 27 Sep 2017 09:27:16 +0100
MIME-Version: 1.0
In-Reply-To: <8f87ef69-f93e-d05e-00db-0a68dba85356@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] PCI: PCIe access should always be little
 endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Yongbok Kim <Yongbok.Kim@imgtec.com>

ping?


On 16/08/17 11:25, Marcel Apfelbaum wrote:
> On 15/08/2017 17:44, Matt Redfearn wrote:
>> PCIe busses are always little endian, so set the endianness of the
>> memory region to little endian rather than native such that operations
>> work as expected on big endian targets.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>
>
> Hi Matt,
> Thanks for the patch.
>
>> ---
>>
>>   hw/pci/pcie_host.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
>> index dcebf57ed45e..553db56778b6 100644
>> --- a/hw/pci/pcie_host.c
>> +++ b/hw/pci/pcie_host.c
>> @@ -81,7 +81,7 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
>>   static const MemoryRegionOps pcie_mmcfg_ops = {
>>       .read = pcie_mmcfg_data_read,
>>       .write = pcie_mmcfg_data_write,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>     static void pcie_host_init(Object *obj)
>>
>
>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>
> Thanks,
> Marcel

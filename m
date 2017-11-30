Received: from eggs.gnu.org ([2001:4830:134:3::10]:37475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eKE5M-0002BG-7F
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 20:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eKE5I-0004x7-5X
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 20:56:20 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eKE5H-0004wn-V5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 20:56:16 -0500
Received: by mail-pg0-x244.google.com with SMTP id q20so2353665pgv.2
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 17:56:15 -0800 (PST)
References: <20171122073947.19325-1-aik@ozlabs.ru>
	<20171129083624.134d46ce@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f41f2faa-25f2-1c1d-a6e4-ba646fe6fb14@ozlabs.ru>
Date: Thu, 30 Nov 2017 12:56:09 +1100
MIME-Version: 1.0
In-Reply-To: <20171129083624.134d46ce@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio-pci: Remove unused fields from
 VFIOMSIXInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

On 30/11/17 02:36, Alex Williamson wrote:
> On Wed, 22 Nov 2017 18:39:47 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> Missing reference to commit that made these fields unused.  A Fixes tag
> to that commit also seems appropriate.  An empty commit log is pretty
> much never justified.

Ah. Right, sorry. I could not find when it was used, looks like never.


> This also looks like 2.12 material.  Thanks,

Indeed 2.12.


> 
> Alex
> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/vfio/pci.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c5e168e..06dcf99 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -93,8 +93,6 @@ typedef struct VFIOMSIXInfo {
>>      uint16_t entries;
>>      uint32_t table_offset;
>>      uint32_t pba_offset;
>> -    MemoryRegion mmap_mem;
>> -    void *mmap;
>>      unsigned long *pending;
>>  } VFIOMSIXInfo;
>>  
> 


-- 
Alexey

Received: from eggs.gnu.org ([209.51.188.92]:48593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjcgk-0006l6-LI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjcge-0005BS-P0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:20:21 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gjcgd-00056R-Mb
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:20:20 -0500
Received: by mail-pf1-x443.google.com with SMTP id g62so2372040pfd.12
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 20:20:19 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-4-aik@ozlabs.ru>
	<CAKmqyKOOp0Nv7wqL_=s6f_1hep==bicXKofnhYo_puResrjNRg@mail.gmail.com>
	<25ef3ad6-90b6-a255-7f65-f3a88625b622@ozlabs.ru>
Message-ID: <937f3d53-5ed1-85fe-c8de-623b69c870e4@ozlabs.ru>
Date: Wed, 16 Jan 2019 15:20:11 +1100
MIME-Version: 1.0
In-Reply-To: <25ef3ad6-90b6-a255-7f65-f3a88625b622@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/7] pci: Move NVIDIA vendor id to
 the rest of ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, joserz@linux.ibm.com, Alistair Popple <alistair@popple.id.au>, alex.williamson@redhat.com, sbobroff@linux.ibm.com, pjaroszynski@nvidia.com, "open list:New World" <qemu-ppc@nongnu.org>, lagarcia@br.ibm.com, oohall@gmail.com, arbab@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

Ping, anyone?

On 14/12/2018 14:36, Alexey Kardashevskiy wrote:
> 
> 
> On 21/11/2018 05:27, Alistair Francis wrote:
>> On Tue, Nov 13, 2018 at 12:42 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>> sPAPR code will use it too so move it from VFIO to the common code.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> 
> 
> Aaaaaand who is taking this? I am going to repost the patchset, posting
> this one over and over again seems redundant. Thanks,
> 
> 
> 
>>
>> Alistair
>>
>>> ---
>>>  include/hw/pci/pci_ids.h | 2 ++
>>>  hw/vfio/pci-quirks.c     | 2 --
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
>>> index 63acc72..3ed7d10 100644
>>> --- a/include/hw/pci/pci_ids.h
>>> +++ b/include/hw/pci/pci_ids.h
>>> @@ -271,4 +271,6 @@
>>>
>>>  #define PCI_VENDOR_ID_SYNOPSYS           0x16C3
>>>
>>> +#define PCI_VENDOR_ID_NVIDIA             0x10de
>>> +
>>>  #endif
>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>> index eae31c7..40a1200 100644
>>> --- a/hw/vfio/pci-quirks.c
>>> +++ b/hw/vfio/pci-quirks.c
>>> @@ -526,8 +526,6 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>>>   * note it for future reference.
>>>   */
>>>
>>> -#define PCI_VENDOR_ID_NVIDIA                    0x10de
>>> -
>>>  /*
>>>   * Nvidia has several different methods to get to config space, the
>>>   * nouveu project has several of these documented here:
>>> --
>>> 2.17.1
>>>
>>>
> 

-- 
Alexey

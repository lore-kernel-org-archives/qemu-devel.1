Received: from eggs.gnu.org ([2001:4830:134:3::10]:50926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFmjw-0006Lp-SM
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFmju-00015V-Tg
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:55:52 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:33926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFmju-00013c-OP
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:55:50 -0500
Received: by mail-io0-x241.google.com with SMTP id q101so9911908ioi.1
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 11:55:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f81553b7-a7c7-bd8e-22ab-bf3d1b1945b5@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8DBV72n4Vp0eUc-Hg6df37QYAXjLTnSQn3r71TTtaWGdg@mail.gmail.com>
	<f81553b7-a7c7-bd8e-22ab-bf3d1b1945b5@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 20:55:28 +0100
Message-ID: <CACXAS8AnSA91gT=x6y4eWncK9HAL65LjOvyN7UQ_P6eJzaHxQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/15] apb: move QOM macros and typedefs
 from apb.c to apb.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Nov 17, 2017 at 4:40 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 17/11/17 14:24, Artyom Tarasenko wrote:
>
>> Hi Mark,
>>
>> On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>> This also includes the related IOMMUState typedef and defines.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/pci-host/apb.c         |   85 --------------------------------------------
>>>  include/hw/pci-host/apb.h |   86 +++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 86 insertions(+), 85 deletions(-)
>>>
>>> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
>>> index 64025cd..f743a4e 100644
>>> --- a/hw/pci-host/apb.c
>>> +++ b/hw/pci-host/apb.c
>>> @@ -82,91 +82,6 @@ do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while (0)
>>>  #define MAX_IVEC 0x40
>>>  #define NO_IRQ_REQUEST (MAX_IVEC + 1)
>>>
>>> -#define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
>>> -#define IOMMU_PAGE_MASK_8K      (~(IOMMU_PAGE_SIZE_8K - 1))
>>> -#define IOMMU_PAGE_SIZE_64K     (1ULL << 16)
>>> -#define IOMMU_PAGE_MASK_64K     (~(IOMMU_PAGE_SIZE_64K - 1))
>>> -
>>> -#define IOMMU_NREGS             3
>>> -
>>> -#define IOMMU_CTRL              0x0
>>> -#define IOMMU_CTRL_TBW_SIZE     (1ULL << 2)
>>> -#define IOMMU_CTRL_MMU_EN       (1ULL)
>>> -
>>> -#define IOMMU_CTRL_TSB_SHIFT    16
>>> -
>>> -#define IOMMU_BASE              0x8
>>> -#define IOMMU_FLUSH             0x10
>>> -
>>> -#define IOMMU_TTE_DATA_V        (1ULL << 63)
>>> -#define IOMMU_TTE_DATA_SIZE     (1ULL << 61)
>>> -#define IOMMU_TTE_DATA_W        (1ULL << 1)
>>> -
>>> -#define IOMMU_TTE_PHYS_MASK_8K  0x1ffffffe000ULL
>>> -#define IOMMU_TTE_PHYS_MASK_64K 0x1ffffff8000ULL
>>> -
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_8M    0x00000000007fe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_16M   0x0000000000ffe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_32M   0x0000000001ffe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_64M   0x0000000003ffe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_128M  0x0000000007ffe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_256M  0x000000000fffe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_512M  0x000000001fffe000ULL
>>> -#define IOMMU_TSB_8K_OFFSET_MASK_1G    0x000000003fffe000ULL
>>> -
>>> -#define IOMMU_TSB_64K_OFFSET_MASK_64M  0x0000000003ff0000ULL
>>> -#define IOMMU_TSB_64K_OFFSET_MASK_128M 0x0000000007ff0000ULL
>>> -#define IOMMU_TSB_64K_OFFSET_MASK_256M 0x000000000fff0000ULL
>>> -#define IOMMU_TSB_64K_OFFSET_MASK_512M 0x000000001fff0000ULL
>>> -#define IOMMU_TSB_64K_OFFSET_MASK_1G   0x000000003fff0000ULL
>>> -#define IOMMU_TSB_64K_OFFSET_MASK_2G   0x000000007fff0000ULL
>>> -
>>> -typedef struct IOMMUState {
>>> -    AddressSpace iommu_as;
>>> -    IOMMUMemoryRegion iommu;
>>> -
>>> -    uint64_t regs[IOMMU_NREGS];
>>> -} IOMMUState;
>>> -
>>> -#define TYPE_APB "pbm"
>>> -
>>> -#define APB_DEVICE(obj) \
>>> -    OBJECT_CHECK(APBState, (obj), TYPE_APB)
>>> -
>>> -#define TYPE_APB_IOMMU_MEMORY_REGION "pbm-iommu-memory-region"
>>> -
>>> -typedef struct APBState {
>>> -    PCIHostState parent_obj;
>>> -
>>> -    MemoryRegion apb_config;
>>> -    MemoryRegion pci_config;
>>> -    MemoryRegion pci_mmio;
>>> -    MemoryRegion pci_ioport;
>>> -    uint64_t pci_irq_in;
>>> -    IOMMUState iommu;
>>> -    uint32_t pci_control[16];
>>> -    uint32_t pci_irq_map[8];
>>> -    uint32_t pci_err_irq_map[4];
>>> -    uint32_t obio_irq_map[32];
>>> -    qemu_irq *pbm_irqs;
>>> -    qemu_irq *ivec_irqs;
>>> -    unsigned int irq_request;
>>> -    uint32_t reset_control;
>>> -    unsigned int nr_resets;
>>> -} APBState;
>>> -
>>> -#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
>>> -#define PBM_PCI_BRIDGE(obj) \
>>> -    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
>>> -
>>> -typedef struct PBMPCIBridge {
>>> -    /*< private >*/
>>> -    PCIBridge parent_obj;
>>> -
>>> -    /* Is this busA with in-built devices (ebus)? */
>>> -    bool busA;
>>> -} PBMPCIBridge;
>>> -
>>>  static inline void pbm_set_request(APBState *s, unsigned int irq_num)
>>>  {
>>>      APB_DPRINTF("%s: request irq %d\n", __func__, irq_num);
>>> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
>>> index b19bd55..5d39c03 100644
>>> --- a/include/hw/pci-host/apb.h
>>> +++ b/include/hw/pci-host/apb.h
>>> @@ -2,6 +2,92 @@
>>>  #define PCI_HOST_APB_H
>>>
>>>  #include "qemu-common.h"
>>> +#include "hw/pci/pci_host.h"
>>> +
>>> +#define IOMMU_NREGS             3
>>> +
>>> +#define IOMMU_PAGE_SIZE_8K      (1ULL << 13)
>>> +#define IOMMU_PAGE_MASK_8K      (~(IOMMU_PAGE_SIZE_8K - 1))
>>> +#define IOMMU_PAGE_SIZE_64K     (1ULL << 16)
>>> +#define IOMMU_PAGE_MASK_64K     (~(IOMMU_PAGE_SIZE_64K - 1))
>>> +
>>> +#define IOMMU_CTRL              0x0
>>> +#define IOMMU_CTRL_TBW_SIZE     (1ULL << 2)
>>> +#define IOMMU_CTRL_MMU_EN       (1ULL)
>>
>> While at it, I think the naming for the model-specific constants
>> should be more explicit.
>> How about US2I_IOMMU_ or SABRE_IOMMU_?
>
> I'm actually planning to follow this up with another patchset to split
> out the IOMMU into a separate file (and QOM object) in a similar way to
> sun4m_iommu.c so I can do it there rather than in this patchset if you
> agree?

Sounds good.

>>> +
>>> +#define IOMMU_CTRL_TSB_SHIFT    16
>>> +
>>> +#define IOMMU_BASE              0x8
>>> +#define IOMMU_FLUSH             0x10
>>> +
>>> +#define IOMMU_TTE_DATA_V        (1ULL << 63)
>>> +#define IOMMU_TTE_DATA_SIZE     (1ULL << 61)
>>> +#define IOMMU_TTE_DATA_W        (1ULL << 1)
>>> +
>>> +#define IOMMU_TTE_PHYS_MASK_8K  0x1ffffffe000ULL
>>> +#define IOMMU_TTE_PHYS_MASK_64K 0x1ffffff8000ULL
>>> +
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_8M    0x00000000007fe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_16M   0x0000000000ffe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_32M   0x0000000001ffe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_64M   0x0000000003ffe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_128M  0x0000000007ffe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_256M  0x000000000fffe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_512M  0x000000001fffe000ULL
>>> +#define IOMMU_TSB_8K_OFFSET_MASK_1G    0x000000003fffe000ULL
>>> +
>>> +#define IOMMU_TSB_64K_OFFSET_MASK_64M  0x0000000003ff0000ULL
>>> +#define IOMMU_TSB_64K_OFFSET_MASK_128M 0x0000000007ff0000ULL
>>> +#define IOMMU_TSB_64K_OFFSET_MASK_256M 0x000000000fff0000ULL
>>> +#define IOMMU_TSB_64K_OFFSET_MASK_512M 0x000000001fff0000ULL
>>> +#define IOMMU_TSB_64K_OFFSET_MASK_1G   0x000000003fff0000ULL
>>> +#define IOMMU_TSB_64K_OFFSET_MASK_2G   0x000000007fff0000ULL
>>
>> Maybe it's possible to compute the mask from the bits, similarly to
>> how it's done in the Niagara model?
>> If so, these defines would be not necessary.
>
> Hmmm yes that could be possible as part of the follow-up patchset too (I
> think I wrote this code several years ago). I'll have a look once these
> patches are merged in their final form to see what the result looks like.

ok, no rush.

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

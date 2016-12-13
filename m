Received: from eggs.gnu.org ([2001:4830:134:3::10]:46227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGljQ-0002N3-Pc
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGljL-00042M-WD
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:58:52 -0500
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
	<1481585316-31612-4-git-send-email-lvivier@redhat.com>
	<27f08088-fbfa-848b-ff25-a373918a48e4@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6e847096-4c25-7d45-1075-d8b4a7d09e6c@redhat.com>
Date: Tue, 13 Dec 2016 12:58:44 +0100
MIME-Version: 1.0
In-Reply-To: <27f08088-fbfa-848b-ff25-a373918a48e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] libqos: fix spapr qpci_map()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>



On 13/12/2016 09:46, Thomas Huth wrote:
> A short patch description would be nice here.
> 
> On 13.12.2016 00:28, Laurent Vivier wrote:
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  tests/libqos/pci-spapr.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
>> index 1e5d015..2043f1e 100644
>> --- a/tests/libqos/pci-spapr.c
>> +++ b/tests/libqos/pci-spapr.c
>> @@ -193,8 +193,8 @@ QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
>>      ret->pio.size = SPAPR_PCI_IO_WIN_SIZE;
>>  
>>      /* 32-bit portion of the MMIO window is at PCI address 2..4 GiB */
>> -    ret->mmio32_cpu_base = SPAPR_PCI_BASE + SPAPR_PCI_MMIO32_WIN_SIZE;
>> -    ret->mmio32.pci_base = 0x80000000; /* 2 GiB */
>> +    ret->mmio32_cpu_base = SPAPR_PCI_BASE;
>> +    ret->mmio32.pci_base = SPAPR_PCI_MMIO32_WIN_SIZE;
>>      ret->mmio32.size = SPAPR_PCI_MMIO32_WIN_SIZE;
> 
> Not sure whether it is really right to use SPAPR_PCI_MMIO32_WIN_SIZE for
> the pci_base? I mean, the WIN_SIZE could also be 1G for example, but the
> base could still be at 2G ? IMHO it's better to keep the old value for
> pci_base here.

in hw/ppc/spapr.c, we have:

    *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;

So I think it's logic to have the PCI base at  SPAPR_PCI_MMIO32_WIN_SIZE.

Thanks for your review,
Laurent

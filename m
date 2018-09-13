Received: from eggs.gnu.org ([2001:4830:134:3::10]:43571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0ZzQ-00045q-Qq
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0ZzJ-0002Mj-He
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:21:30 -0400
Received: from mail-by2nam05on0617.outbound.protection.outlook.com
	([2a01:111:f400:fe52::617]:36740
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0ZzI-00029k-Qe
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:21:25 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-5-git-send-email-brijesh.singh@amd.com>
	<20180912183510.1fe2c3b8@redhat.com>
	<88997184-3509-4a6d-4fca-cd3fa64d1858@amd.com>
	<20180913141145-mutt-send-email-mst@kernel.org>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <b93d9448-360a-97de-b814-6f638570d6dc@amd.com>
Date: Thu, 13 Sep 2018 17:20:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180913141145-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: acpi: add IVHD device entry for
 IOAPIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: brijesh.singh@amd.com, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>



On 09/13/2018 01:18 PM, Michael S. Tsirkin wrote:
...>>
>> 0x01 00a0 00 00 0000 48
>>
>> Byte 0: 0x48 (special device)
>> Byte 1 & 2: must be zero
>> Byte 3: 0 (dte setting)
>> Byte 4: 0 (handle)
>> Byte 5 & 6: IOAPIC devfn (14:0.0)
> 
> Do you mean *bus* devfn? devfn is 0.0.
> 

Sorry my bad, I was meaning to write devid and not devfn.

See, 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/amd_iommu_init.c#n2343

/* SB IOAPIC is always on this device in AMD systems */
#define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))


>> Byte 7: 0x1 (IOAPIC) - See Table 97 in spec
> 
> 
> Above should go into code comment, along with
> first (oldest) version of spec that has this table.
> Additionally the number is IMHO more readable as:
> 	(0x1ull << 56) | (PCI_BUILD_BDF(14, 0) << 40) | 0x48
> 
> (assuming I got what it should be).
> 

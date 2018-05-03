Received: from eggs.gnu.org ([2001:4830:134:3::10]:35596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fE2rj-0006zy-1Y
	for qemu-devel@nongnu.org; Wed, 02 May 2018 21:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fE2re-0000jR-Px
	for qemu-devel@nongnu.org; Wed, 02 May 2018 21:16:58 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fE2re-0000it-GD
	for qemu-devel@nongnu.org; Wed, 02 May 2018 21:16:54 -0400
Received: by mail-pg0-x241.google.com with SMTP id z4-v6so11881916pgu.13
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 18:16:54 -0700 (PDT)
References: <20180502044557.21035-1-aik@ozlabs.ru>
	<20180502063706.GD3517@umbus.fritz.box>
	<43ff86df-7368-3857-1443-2cbde839039b@ozlabs.ru>
	<20180503010342.GE13229@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <bfd26c5b-4f1b-fdbd-4962-feb46d5e5ebe@ozlabs.ru>
Date: Thu, 3 May 2018 11:16:49 +1000
MIME-Version: 1.0
In-Reply-To: <20180503010342.GE13229@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow backing bigger
 guest IOMMU pages with smaller physical pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 3/5/18 11:03 am, David Gibson wrote:
> On Wed, May 02, 2018 at 06:59:53PM +1000, Alexey Kardashevskiy wrote:
>> On 2/5/18 4:37 pm, David Gibson wrote:
>>> On Wed, May 02, 2018 at 02:45:57PM +1000, Alexey Kardashevskiy wrote:
>>>> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
>>>> pages and POWER8 CPU supports the exact same set of page size so
>>>> so far things worked fine.
>>>>
>>>> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
>>>> the last two - 2M and 1G - are not even allowed in the paravirt interface
>>>> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
>>>> back guest's 16MB IOMMU pages with 2MB pages on the host.
>>>>
>>>> This stores the supported host IOMMU page sizes in VFIOContainer and uses
>>>> this later when creating a new DMA window.
>>>>
>>>> There should be no behavioral changes on platforms other than pseries.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> What will happen if you try to use this on an older kernel without
>>> your mismatching pagesize changes?
>>
>> I tried 1GB huge pages and "-global spapr-pci-host-bridge.pgsz=0x1011000"
>> or 0x41011000.
> 
> With a hash guest or a radix guest?


The guest was radix but how would it change anything? The guest can only
ask for 4k/64k/16m for IOMMU.


-- 
Alexey

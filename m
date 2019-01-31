Received: from eggs.gnu.org ([209.51.188.92]:41929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJm8-00011w-R9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJm5-0003zK-7n
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:21:30 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<4fec7d60-1d09-ba37-c66a-1d86088a1c0e@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <245401e4-8483-e204-e255-9adc8f2d77d0@redhat.com>
Date: Thu, 31 Jan 2019 22:21:25 +0100
MIME-Version: 1.0
In-Reply-To: <4fec7d60-1d09-ba37-c66a-1d86088a1c0e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/6] s390x/pci: remaining
 hot/un)plug patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 31.01.19 21:43, Collin Walling wrote:
> On 1/30/19 10:57 AM, David Hildenbrand wrote:
>> These are all the patches that are not yet upstream (@Conny you might
>> already picked some, including them for the full picture) and after
>> a good discussion yesterday, including a patch t get rid of the releas=
e
>> timer. I ran a couple of sanity tests on this series.
>>
>> #1 and #2 fix hotplugging of PCI bridges.
>> #3 warns when "zpci=3Doff"
>> #4 refactors unplugging
>> #5 get's rid of the release timer
>> #6 processes all unplug requests on reboot
>>
>> @Colin, can you review/ack? Especially Patch #4 is needed for qdev
>> patches already on the list. ("[PATCH RFCv2 0/9] qdev: Hotplug handler
>> chaining + virtio-pmem")
>=20
> I've given my r-b for 4, 5, and 6. IIRC, the other patches in this
> series looked fine from previous versions, but I'd like to look at them
> more carefully before ack'ing. Please allow me some time to devote to
> them in the near future. Trying my best to balance things :)

Thanks, patch 4 was the most important one for me (needed for the qdev
reworks). All the other stuff was fallout from testing and code review.

>=20
>>
>> David Hildenbrand (6):
>>    s390x/pci: Fix primary bus number for PCI bridges
>>    s390x/pci: Fix hotplugging of PCI bridges
>>    s390x/pci: Warn when adding PCI devices without the 'zpci' feature
>>    s390x/pci: Introduce unplug requests and split unplug handler
>>    s390x/pci: Drop release timer and replace it with a flag
>>    s390x/pci: Unplug remaining requested devices on pcihost reset
>>
>>   hw/s390x/s390-pci-bus.c | 233 ++++++++++++++++++++++++++------------=
--
>>   hw/s390x/s390-pci-bus.h |   4 +-
>>   2 files changed, 152 insertions(+), 85 deletions(-)
>>
>=20


--=20

Thanks,

David / dhildenb

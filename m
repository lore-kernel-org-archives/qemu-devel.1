Received: from eggs.gnu.org ([209.51.188.92]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpJBP-0008PN-9y
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpJBO-0006dl-7x
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:43:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gpJBN-0006aK-RK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:43:34 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VKdKZT038068
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:43:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc60cpmxa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:43:21 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 31 Jan 2019 20:43:20 -0000
References: <20190130155733.32742-1-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 31 Jan 2019 15:43:16 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4fec7d60-1d09-ba37-c66a-1d86088a1c0e@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/30/19 10:57 AM, David Hildenbrand wrote:
> These are all the patches that are not yet upstream (@Conny you might
> already picked some, including them for the full picture) and after
> a good discussion yesterday, including a patch t get rid of the release
> timer. I ran a couple of sanity tests on this series.
> 
> #1 and #2 fix hotplugging of PCI bridges.
> #3 warns when "zpci=off"
> #4 refactors unplugging
> #5 get's rid of the release timer
> #6 processes all unplug requests on reboot
> 
> @Colin, can you review/ack? Especially Patch #4 is needed for qdev
> patches already on the list. ("[PATCH RFCv2 0/9] qdev: Hotplug handler
> chaining + virtio-pmem")

I've given my r-b for 4, 5, and 6. IIRC, the other patches in this
series looked fine from previous versions, but I'd like to look at them
more carefully before ack'ing. Please allow me some time to devote to
them in the near future. Trying my best to balance things :)

> 
> David Hildenbrand (6):
>    s390x/pci: Fix primary bus number for PCI bridges
>    s390x/pci: Fix hotplugging of PCI bridges
>    s390x/pci: Warn when adding PCI devices without the 'zpci' feature
>    s390x/pci: Introduce unplug requests and split unplug handler
>    s390x/pci: Drop release timer and replace it with a flag
>    s390x/pci: Unplug remaining requested devices on pcihost reset
> 
>   hw/s390x/s390-pci-bus.c | 233 ++++++++++++++++++++++++++--------------
>   hw/s390x/s390-pci-bus.h |   4 +-
>   2 files changed, 152 insertions(+), 85 deletions(-)
> 

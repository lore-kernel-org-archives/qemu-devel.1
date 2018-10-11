Received: from eggs.gnu.org ([2001:4830:134:3::10]:54208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAXKY-0002GT-RH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gAXKU-0004bG-MR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:32:30 -0400
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
	<98d6ffa8-97b2-ac01-fe23-22355a04ae56@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <088a3aac-0385-7069-5bfc-8fce7c2624ee@redhat.com>
Date: Thu, 11 Oct 2018 11:32:06 +0200
MIME-Version: 1.0
In-Reply-To: <98d6ffa8-97b2-ac01-fe23-22355a04ae56@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v11 0/6] s390x: vfio-ap: guest
 dedicated crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, berrange@redhat.com, eskultet@redhat.com, qemu-s390x@nongnu.org, heiko.carstens@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, eric.auger@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pbonzini@redhat.com, schwidefsky@de.ibm.com, mimu@linux.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, rth@twiddle.net

On 2018-10-11 10:12, David Hildenbrand wrote:
> On 10/10/2018 20:15, Christian Borntraeger wrote:
>>
>> On 10/10/2018 07:03 PM, Tony Krowiak wrote:
>>> This patch series is the QEMU counterpart to the KVM/kernel support for 
>>> guest dedicated crypto adapters. The KVM/kernel model is built on the 
>>> VFIO mediated device framework and provides the infrastructure for 
>>> granting exclusive guest access to crypto devices installed on the linux 
>>> host. This patch series introduces a new QEMU command line option, QEMU 
>>> object model and CPU model features to exploit the KVM/kernel model.
>>>
>>> See the detailed specifications for AP virtualization provided by this 
>>> patch set in docs/vfio-ap.txt for a more complete discussion of the 
>>> design introduced by this patch series.
>>>
>>> v10 => v11 Change log:
>>
>> Series seems to work fine.
>>
>> Christian
> 
> Had a quick glimpse over all patches, looks good and clean to me.

FWIW, with one additional g_free() in patch 5, the series now also looks
fine to me.

 Thomas

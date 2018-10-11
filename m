Received: from eggs.gnu.org ([2001:4830:134:3::10]:60926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAW58-0005JX-FA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAW55-0000b8-Q3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:12:29 -0400
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <98d6ffa8-97b2-ac01-fe23-22355a04ae56@redhat.com>
Date: Thu, 11 Oct 2018 10:12:14 +0200
MIME-Version: 1.0
In-Reply-To: <ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, akrowiak@linux.vnet.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 10/10/2018 20:15, Christian Borntraeger wrote:
> 
> On 10/10/2018 07:03 PM, Tony Krowiak wrote:
>> This patch series is the QEMU counterpart to the KVM/kernel support for 
>> guest dedicated crypto adapters. The KVM/kernel model is built on the 
>> VFIO mediated device framework and provides the infrastructure for 
>> granting exclusive guest access to crypto devices installed on the linux 
>> host. This patch series introduces a new QEMU command line option, QEMU 
>> object model and CPU model features to exploit the KVM/kernel model.
>>
>> See the detailed specifications for AP virtualization provided by this 
>> patch set in docs/vfio-ap.txt for a more complete discussion of the 
>> design introduced by this patch series.
>>
>> v10 => v11 Change log:
> 
> 
> 
> Series seems to work fine.
> 
> Christian

Had a quick glimpse over all patches, looks good and clean to me.


-- 

Thanks,

David / dhildenb

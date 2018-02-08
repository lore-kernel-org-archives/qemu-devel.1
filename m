Received: from eggs.gnu.org ([2001:4830:134:3::10]:50447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejo5H-0005RK-Ne
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejo5D-0000EV-Mr
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:25:59 -0500
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208111633.0e8a6237.cohuck@redhat.com>
	<ef7d8fbd-42b0-2d28-c3c2-ab96a8e52e5f@de.ibm.com>
	<20180208113748.195f7483.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37aea314-c88b-30af-c744-d4b711b111ac@redhat.com>
Date: Thu, 8 Feb 2018 09:25:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180208113748.195f7483.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>

On 02/08/2018 04:37 AM, Cornelia Huck wrote:

>>>> @@ -373,7 +373,7 @@ static void s390_machine_reset(void)
>>>>   
>>>>       /* all cpus are stopped - configure and start the ipl cpu only */
>>>>       s390_ipl_prepare_cpu(ipl_cpu);
>>>> -    s390_cpu_set_state(CPU_STATE_OPERATING, ipl_cpu);
>>>> +    s390_cpu_set_state(CPU_INFOS390_STATE_OPERATING, ipl_cpu);
>>>
>>> Exposing the state as a QAPI enum has the unfortunate side effect of
>>> that new name. It feels slightly awkward to me, as it is a state for
>>> real decisions and not just for info statements...
>>
>> I asked Viktor to use the qapi enum instead of having two sets of defines that
>> we need to keep in sync. (in fact 3, as the kernel kvm mpstate definition is also
>> there).
> 
> Agreed, using the QAPI enum makes sense.
> 
>>
>> But yes, the INFO in that name is somewhat strange. No good idea though.
> 
> Can we call the enum CpuS390State instead of CpuInfoS390State (while
> keeping the CpuInfoS390 name)? Or does that violate any QAPI rules?

The name of the enum is not important to introspection; and what's more, 
you can set the 'prefix':'...' key in QAPI to pick an enum naming in the 
C code that is saner than what the generator would automatically produce 
from the enum name itself (see qapi/crypto.json for some examples).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

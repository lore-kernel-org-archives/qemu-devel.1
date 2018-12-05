Received: from eggs.gnu.org ([2001:4830:134:3::10]:40521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUVo1-00037D-A0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUVnt-00080M-9J
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:57:27 -0500
References: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
	<a49bf8e8-d5dc-5687-de65-5f4c77edd53d@redhat.com>
	<c5130ab3-a539-fa1b-37cc-3db3904b3053@de.ibm.com>
	<20181205125429.5134adfd.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f4c47bf9-0294-eb8c-e5a6-1c73fa3bff87@redhat.com>
Date: Wed, 5 Dec 2018 12:57:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181205125429.5134adfd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] s390: guest support for
 diagnose 318 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, cornelia.huck@de.ibm.com, cotte@de.ibm.com, mimu@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com

On 05.12.18 12:54, Cornelia Huck wrote:
> On Wed, 5 Dec 2018 09:27:44 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 05.12.2018 09:26, David Hildenbrand wrote:
>>> On 04.12.18 23:18, Collin Walling wrote:  
>>>> Add migration and reset support for diagnose 318. This is a new z14 GA2 
>>>> hardware feature, but we can provide guest support starting with the 
>>>> zEC12-full CPU model.
>>>>
>>>> Because new hardware introduces a new facility-availability byte in 
>>>> the Read SCP Info block, we lose one byte in the CPU entries list 
>>>> and must limit the maximum VCPUs to 247 (down from 248).  
>>>
>>> This could break setups that upgrade/migrate. At least forward migration
>>> can be broken. Do we care about that?  
>>
>> Can we maybe bind this feature and the cpu limit to the 4.0 machine?
> 
> I think that would make sense.

Won't be that easy, as we'll have different sizes of the struct size.
Something that might uglify the code quite a bit.

Also we'll get a dependence between the cpu model features (e.g. probed
via the NULL machine) and the compat machine. Have to think about this.

> 
>>>
>>> Can you split off
>>>
>>> 1. linux-header changes
>>> 2. CPU model changes? (introduction and definition of new feature, but
>>> not when it is used?)
>>>   
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---


-- 

Thanks,

David / dhildenb

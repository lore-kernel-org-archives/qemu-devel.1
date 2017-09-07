Received: from eggs.gnu.org ([2001:4830:134:3::10]:48912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpwU5-0001H4-Tk
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dpwU1-0008Cj-Cb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dpwU1-0008CE-66
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:04:37 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-17-david@redhat.com>
	<87f49e42-13fd-e884-ff73-9516e2c09455@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <08a508ea-b813-49d3-7fe6-dd6dfa271007@redhat.com>
Date: Thu, 7 Sep 2017 15:04:29 +0200
MIME-Version: 1.0
In-Reply-To: <87f49e42-13fd-e884-ff73-9516e2c09455@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/19] s390x: allow cpu hotplug via
 device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On 07.09.2017 05:16, Matthew Rosato wrote:
> On 09/04/2017 11:43 AM, David Hildenbrand wrote:
>> E.g. the following now works:
>>     device_add host-s390-cpu,id=cpu1,core-id=1
>>
>> The system will perform the same checks as when using cpu_add:
>> - If the core_id is already in use
>> - If the next sequential core_id isn't used
>> - If core-id >= max_cpu is specified
>>
>> In addition, mixed CPU models are checked. E.g. if starting with
>> -cpu host and trying to hotplug "qemu-s390-cpu":
>>     "Mixed CPU models are not supported on s390x."
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> As easy as flipping a switch, right?

Yes, luckily all that hotplug handling already was in place, just
core-id vs. id had to be fixed.

> 
> Tested the new device_add path, the old cpu-add path and mixed cases
> where I alternated adding cpus via both methods -- looking good.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> 

Thanks!

-- 

Thanks,

David

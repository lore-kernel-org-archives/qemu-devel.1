Received: from eggs.gnu.org ([209.51.188.92]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hHJ9F-0006c8-27
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hHIzi-0008Oi-UI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:11:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:19645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hHIzf-0008L8-H9
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:11:12 -0400
References: <20190418064602.24558-1-tao3.xu@intel.com>
	<20190418064602.24558-2-tao3.xu@intel.com>
	<20190418142624.GH25134@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a958c064-57d3-6d4a-f02a-3d27e3f33d8e@intel.com>
Date: Fri, 19 Apr 2019 10:11:06 +0800
MIME-Version: 1.0
In-Reply-To: <20190418142624.GH25134@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] numa: move numa global variable
 nb_numa_nodes into MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: imammedo@redhat.com, pbonzini@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org

On 4/18/2019 10:26 PM, Eduardo Habkost wrote:
> On Thu, Apr 18, 2019 at 02:46:00PM +0800, Tao Xu wrote:
>> The aim of this patch is to add struct NumaState in MachineState
>> and move existing numa global nb_numa_nodes into NumaState.
>> And add variable numa_support into MachineClass to decide which
>> submachines support NUMA.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> [...]
>> +    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;
> 
> I see 17 occurrences of this same pattern in the patch, and I had
> to double-check the ones that didn't check if ms->numa_state is
> NULL.
> 
> I think a
>    int machine_num_numa_nodes(MachineState *ms)
> helper would be useful.
> 
> While at it, I suggest naming the nb_numa_nodes field "num_nodes"
> or "nr_nodes", because it's already inside a struct called
> NumaState.
> 
Thank you for your review, I will improve these in the next version of 
patch.

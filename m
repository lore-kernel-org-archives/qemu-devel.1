Received: from eggs.gnu.org ([2001:4830:134:3::10]:34789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9kl-0007eM-Nu
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9kf-0007bs-Rx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:01:59 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9kf-0007bh-NJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:01:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id a77so16955376qkb.2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 07:01:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503387936-3483-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170822152039.5571f243@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc62e1f4-74d4-06fe-10e3-f7a28291e811@amsat.org>
Date: Tue, 22 Aug 2017 11:01:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170822152039.5571f243@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] NUMA: Replace MAX_NODES with nb_numa_nodes
 in for loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

On 08/22/2017 10:20 AM, Igor Mammedov wrote:
> On Tue, 22 Aug 2017 15:45:36 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> 
>> In QEMU, the number of the NUMA nodes is determined by parse_numa_opts().
>> Then, QEMU uses it for iteration, for example:
>>    for (i = 0; i < nb_numa_nodes; i++)
>>
>> However, in memory_region_allocate_system_memory(), it uses MAX_NODES
>> not nb_numa_nodes.
>>
>> So, replace MAX_NODES with nb_numa_nodes to keep code consistency and
>> reduce the loop times.
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>> ---
>>   numa.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/numa.c b/numa.c
>> index e32af04..5f2916d 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -567,7 +567,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>>       }
>>   
>>       memory_region_init(mr, owner, name, ram_size);
>> -    for (i = 0; i < MAX_NODES; i++) {
>> +    for (i = 0; i < nb_numa_nodes; i++) {
>>           uint64_t size = numa_info[i].node_mem;
>>           HostMemoryBackend *backend = numa_info[i].node_memdev;
>>           if (!backend) {
> 
> 

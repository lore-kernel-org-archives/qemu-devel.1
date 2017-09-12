Received: from eggs.gnu.org ([2001:4830:134:3::10]:39010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drl38-0003y3-Mx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drl35-0007pn-H7
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drl35-0007pT-A0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:16:19 -0400
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-15-david@redhat.com>
	<20170912150947.70cf9b71@nial.brq.redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <933e6e9a-aea1-1d8e-210c-e1837e414bdf@redhat.com>
Date: Tue, 12 Sep 2017 15:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170912150947.70cf9b71@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/21] target/s390x: rename next_cpu_id
 to next_core_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On 12.09.2017 15:09, Igor Mammedov wrote:
> On Mon, 11 Sep 2017 17:21:43 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Adapt to the new term "core_id". While at it, fix the type and drop the
>> initialization to 0 (which is superfluous).
>>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu-qom.h |  2 +-
>>  target/s390x/cpu.c     | 11 +++++------
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
>> index 2435cd8390..2e446fab51 100644
>> --- a/target/s390x/cpu-qom.h
>> +++ b/target/s390x/cpu-qom.h
>> @@ -54,7 +54,7 @@ typedef struct S390CPUClass {
>>      bool is_migration_safe;
>>      const char *desc;
>>  
>> -    int64_t next_cpu_id;
>> +    uint32_t next_core_id;
> is it possible to hotplug cpus in out of order in real hw?

Yes, at least under z/VM. See last two patches in this series.


-- 

Thanks,

David

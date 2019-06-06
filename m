Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F6C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 07:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642592083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 07:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642592083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYmW7-00037L-Hm
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 03:08:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hYmV9-0002ib-Qu
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hYmV8-0008CQ-G7
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:07:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50668
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hYmV8-00088l-Bu
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:07:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x566wkiS062855
	for <qemu-devel@nongnu.org>; Thu, 6 Jun 2019 03:07:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sxvtvknjv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 03:07:51 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jun 2019 08:07:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 6 Jun 2019 08:07:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x5677gpr46530718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 6 Jun 2019 07:07:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC177A406F;
	Thu,  6 Jun 2019 07:07:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24D3CA4055;
	Thu,  6 Jun 2019 07:07:42 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.183])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  6 Jun 2019 07:07:42 +0000 (GMT)
To: Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
	<20190518205428.90532-7-like.xu@linux.intel.com>
	<20190606025635.GO22416@habkost.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Thu, 6 Jun 2019 09:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606025635.GO22416@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060607-0008-0000-0000-000002F033A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060607-0009-0000-0000-0000225D1E6B
Message-Id: <fe75222f-3f89-8128-796c-f575a029bdf0@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906060052
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 06/10] hw/s390x: Replace
 global smp variables with machine smp properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06.06.19 04:56, Eduardo Habkost wrote:
> On Sun, May 19, 2019 at 04:54:24AM +0800, Like Xu wrote:
>> The global smp variables in s390x are replaced with smp machine properties.
>>
>> A local variable of the same name would be introduced in the declaration
>> phase if it's used widely in the context OR replace it on the spot if it's
>> only used once. No semantic changes.
>>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> 
> CCing s390 maintainers.
> 
> Any objections to merging this through the Machine Core tree?

Fine with me.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 3 ++-
>>  hw/s390x/sclp.c            | 2 +-
>>  target/s390x/cpu.c         | 3 +++
>>  target/s390x/excp_helper.c | 5 +++++
>>  4 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index ed1fe7a93e..692ad6e372 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -83,7 +83,7 @@ static void s390_init_cpus(MachineState *machine)
>>      /* initialize possible_cpus */
>>      mc->possible_cpu_arch_ids(machine);
>>  
>> -    for (i = 0; i < smp_cpus; i++) {
>> +    for (i = 0; i < machine->smp.cpus; i++) {
>>          s390x_new_cpu(machine->cpu_type, i, &error_fatal);
>>      }
>>  }
>> @@ -410,6 +410,7 @@ static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
>>  static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
>>  {
>>      int i;
>> +    unsigned int max_cpus = ms->smp.max_cpus;
>>  
>>      if (ms->possible_cpus) {
>>          g_assert(ms->possible_cpus && ms->possible_cpus->len == max_cpus);
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 4510a800cb..fac7c3bb6c 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -64,7 +64,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
>>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>>      read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
>> -    read_info->highest_cpu = cpu_to_be16(max_cpus - 1);
>> +    read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
>>  
>>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
>>  
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index b1df63d82c..f1e5c0d9c3 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -37,6 +37,7 @@
>>  #include "hw/qdev-properties.h"
>>  #ifndef CONFIG_USER_ONLY
>>  #include "hw/hw.h"
>> +#include "hw/boards.h"
>>  #include "sysemu/arch_init.h"
>>  #include "sysemu/sysemu.h"
>>  #endif
>> @@ -193,6 +194,8 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>>      }
>>  
>>  #if !defined(CONFIG_USER_ONLY)
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    unsigned int max_cpus = ms->smp.max_cpus;
>>      if (cpu->env.core_id >= max_cpus) {
>>          error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
>>                     ", maximum core-id: %d", cpu->env.core_id,
>> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
>> index 3a467b72c5..1c6938effc 100644
>> --- a/target/s390x/excp_helper.c
>> +++ b/target/s390x/excp_helper.c
>> @@ -31,6 +31,7 @@
>>  #ifndef CONFIG_USER_ONLY
>>  #include "sysemu/sysemu.h"
>>  #include "hw/s390x/s390_flic.h"
>> +#include "hw/boards.h"
>>  #endif
>>  
>>  void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
>> @@ -300,6 +301,10 @@ static void do_ext_interrupt(CPUS390XState *env)
>>          g_assert(cpu_addr < S390_MAX_CPUS);
>>          lowcore->cpu_addr = cpu_to_be16(cpu_addr);
>>          clear_bit(cpu_addr, env->emergency_signals);
>> +#ifndef CONFIG_USER_ONLY
>> +        MachineState *ms = MACHINE(qdev_get_machine());
>> +        unsigned int max_cpus = ms->smp.max_cpus;
>> +#endif
>>          if (bitmap_empty(env->emergency_signals, max_cpus)) {
>>              env->pending_int &= ~INTERRUPT_EMERGENCY_SIGNAL;
>>          }
>> -- 
>> 2.21.0
>>
>>
> 



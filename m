Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA13C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C6D2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C6D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooNc-0001GI-IG
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1ion2C-0002cN-TM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1ion27-0000Mj-3h
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:28:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44100
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1ion26-0000M9-Tk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:28:23 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 007BRRha111507
 for <qemu-devel@nongnu.org>; Tue, 7 Jan 2020 06:28:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xb97cn68m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:28:21 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Tue, 7 Jan 2020 11:28:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 Jan 2020 11:28:17 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 007BSGNv63176856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2020 11:28:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F222A404D;
 Tue,  7 Jan 2020 11:28:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37287A4051;
 Tue,  7 Jan 2020 11:28:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.97])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2020 11:28:15 +0000 (GMT)
Subject: Re: [PATCH v18 6/7] migration: Include migration support for machine
 check handling
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-7-ganeshgr@linux.ibm.com> <20200103022540.GS2098@umbus>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Tue, 7 Jan 2020 16:58:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20200103022540.GS2098@umbus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010711-0016-0000-0000-000002DB243D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010711-0017-0000-0000-0000333D9AB9
Message-Id: <066a1db3-254a-5607-915e-0392fefd72e6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 suspectscore=2 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001070094
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/3/20 7:55 AM, David Gibson wrote:
> On Thu, Jan 02, 2020 at 01:21:10PM +0530, Ganesh Goudar wrote:
>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>
>> This patch includes migration support for machine check
>> handling. Especially this patch blocks VM migration
>> requests until the machine check error handling is
>> complete as these errors are specific to the source
>> hardware and is irrelevant on the target hardware.
>>
>> [Do not set FWNMI cap in post_load, now its done in .apply hook]
>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>> ---
>>   hw/ppc/spapr.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_events.c  | 20 +++++++++++++++++++-
>>   hw/ppc/spapr_rtas.c    |  4 ++++
>>   include/hw/ppc/spapr.h |  1 +
>>   4 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 975d7da734..4acdc30100 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -46,6 +46,7 @@
>>   #include "migration/qemu-file-types.h"
>>   #include "migration/global_state.h"
>>   #include "migration/register.h"
>> +#include "migration/blocker.h"
>>   #include "mmu-hash64.h"
>>   #include "mmu-book3s-v3.h"
>>   #include "cpu-models.h"
>> @@ -1685,6 +1686,8 @@ static void spapr_machine_reset(MachineState *machine)
>>   
>>       /* Signal all vCPUs waiting on this condition */
>>       qemu_cond_broadcast(&spapr->mc_delivery_cond);
>> +
>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>   }
>>   
>>   static void spapr_create_nvram(SpaprMachineState *spapr)
>> @@ -1967,6 +1970,43 @@ static const VMStateDescription vmstate_spapr_dtb = {
>>       },
>>   };
>>   
>> +static bool spapr_fwnmi_needed(void *opaque)
>> +{
>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>> +
>> +    return spapr->fwnmi_calls_registered;
> I think it would be better to base this directly on the cap, rather
> than a variable set later.
Ok, ill revert to older way
>
>> +}
>> +
>> +static int spapr_fwnmi_pre_save(void *opaque)
>> +{
>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>> +
>> +    /*
>> +     * Check if machine check handling is in progress and print a
>> +     * warning message.
>> +     */
>> +    if (spapr->mc_status != -1) {
>> +        warn_report("A machine check is being handled during migration. The"
>> +                "handler may run and log hardware error on the destination");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_machine_check = {
>> +    .name = "spapr_machine_check",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = spapr_fwnmi_needed,
>> +    .pre_save = spapr_fwnmi_pre_save,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
>> +        VMSTATE_INT32(mc_status, SpaprMachineState),
>> +        VMSTATE_BOOL(fwnmi_calls_registered, SpaprMachineState),
> This doesn't make sense to migrate - it will always have its final
> value by the time the guest is running in a migratable state.
Ok, ill remove it.
>
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static const VMStateDescription vmstate_spapr = {
>>       .name = "spapr",
>>       .version_id = 3,
>> @@ -2001,6 +2041,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_cap_large_decr,
>>           &vmstate_spapr_cap_ccf_assist,
>>           &vmstate_spapr_cap_fwnmi,
>> +        &vmstate_spapr_machine_check,
>>           NULL
>>       }
>>   };
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 54eaf28a9e..7092687fa0 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -43,6 +43,7 @@
>>   #include "qemu/main-loop.h"
>>   #include "hw/ppc/spapr_ovec.h"
>>   #include <libfdt.h>
>> +#include "migration/blocker.h"
>>   
>>   #define RTAS_LOG_VERSION_MASK                   0xff000000
>>   #define   RTAS_LOG_VERSION_6                    0x06000000
>> @@ -843,6 +844,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>   {
>>       SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>       CPUState *cs = CPU(cpu);
>> +    int ret;
>> +    Error *local_err = NULL;
>>   
>>       if (spapr->guest_machine_check_addr == -1) {
>>           /*
>> @@ -872,8 +875,23 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>               return;
>>           }
>>       }
>> -    spapr->mc_status = cpu->vcpu_id;
>>   
>> +    error_setg(&spapr->fwnmi_migration_blocker,
>> +               "Live migration not supported during machine check handling");
>> +    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
>> +    if (ret == -EBUSY) {
>> +        /*
>> +         * We don't want to abort so we let the migration to continue.
>> +         * In a rare case, the machine check handler will run on the target.
>> +         * Though this is not preferable, it is better than aborting
>> +         * the migration or killing the VM.
>> +         */
>> +        error_free(spapr->fwnmi_migration_blocker);
>> +        spapr->fwnmi_migration_blocker = NULL;
>> +        warn_report("Received a fwnmi while migration was in progress");
> Didn't we change from initializing the blocker Error at init time
> because there was a case where we could have two migration blockers
> registered at once?  If that's so then we need entirely different
> instances of the blocker Error.  Just dynamiically allocating them
> doesn't help us if there can still only be one at a time.

I agree, but this how we were doing it before.

Are you suggesting to have per cpu blocker Error instance ?

I think initializing the blocker Error at init time and not freeing it, 
is much simpler

and cleaner. And if we receive multiple fwnmi events on different cpus 
almost

at the same time, Though we will be prepending same migration blocker 
instance

multiple times to the migration_blockers list, IIUC we will not be 
unblocking migration

till the migration_blockers list is empty. Please let me know if you are 
ok with initializing

blocker error at init time.

>
>> +    }
>> +
>> +    spapr->mc_status = cpu->vcpu_id;
>>       spapr_mce_dispatch_elog(cpu, recovered);
>>   }
>>   
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 54b142f35b..3409f6b896 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -50,6 +50,7 @@
>>   #include "hw/ppc/fdt.h"
>>   #include "target/ppc/mmu-hash64.h"
>>   #include "target/ppc/mmu-book3s-v3.h"
>> +#include "migration/blocker.h"
>>   
>>   static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                                      uint32_t token, uint32_t nargs,
>> @@ -448,6 +449,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>       spapr->mc_status = -1;
>>       qemu_cond_signal(&spapr->mc_delivery_cond);
>>       rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>> +    error_free(spapr->fwnmi_migration_blocker);
>> +    spapr->fwnmi_migration_blocker = NULL;
>>   }
>>   
>>   static struct rtas_call {
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index a90e677cc3..ac246c8be3 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -220,6 +220,7 @@ struct SpaprMachineState {
>>       SpaprTpmProxy *tpm_proxy;
>>   
>>       bool fwnmi_calls_registered;
>> +    Error *fwnmi_migration_blocker;
>>   };
>>   
>>   #define H_SUCCESS         0



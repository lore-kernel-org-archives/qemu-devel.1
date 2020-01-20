Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99991C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0B421835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0B421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itavb-0008TH-JX
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1itats-0007BA-Og
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1itato-0006Kf-Va
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:31:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1itato-0006Jw-Le
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:31:40 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KHRQGm077000
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:31:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgdk6w68-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:31:39 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Mon, 20 Jan 2020 17:31:36 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 20 Jan 2020 17:31:34 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00KHVXRB45744382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2020 17:31:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B004A4066;
 Mon, 20 Jan 2020 17:31:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F478A405B;
 Mon, 20 Jan 2020 17:31:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.38])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jan 2020 17:31:30 +0000 (GMT)
Subject: Re: [PATCH v20 6/7] migration: Include migration support for machine
 check handling
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
 <20200117093855.19074-7-ganeshgr@linux.ibm.com>
 <20200120004842.GJ54439@umbus>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Mon, 20 Jan 2020 23:01:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20200120004842.GJ54439@umbus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20012017-0016-0000-0000-000002DF23E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012017-0017-0000-0000-00003341C8B4
Message-Id: <217864bc-30f5-88ba-7677-dad963095e80@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_07:2020-01-20,
 2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200147
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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



On 1/20/20 6:18 AM, David Gibson wrote:
> On Fri, Jan 17, 2020 at 03:08:54PM +0530, Ganesh Goudar wrote:
>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>
>> This patch includes migration support for machine check
>> handling. Especially this patch blocks VM migration
>> requests until the machine check error handling is
>> complete as these errors are specific to the source
>> hardware and is irrelevant on the target hardware.
>>
>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>> [Do not set FWNMI cap in post_load, now its done in .apply hook]
>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c         | 47 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_events.c  | 16 +++++++++++++-
>>   hw/ppc/spapr_rtas.c    |  2 ++
>>   include/hw/ppc/spapr.h |  2 ++
>>   4 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 46bac1a83c..c8bc2fa9f3 100644
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
>> @@ -1683,6 +1684,8 @@ static void spapr_machine_reset(MachineState *machine)
>>   
>>       /* Signal all vCPUs waiting on this condition */
>>       qemu_cond_broadcast(&spapr->mc_delivery_cond);
>> +
>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
> Thinking on our discussions about this earlier, there are
> circumstances where we could add the blocker message multiple times.
> IIUC, this will just remove one of them, but at reset, we need to
> remove all of them.
Sorry I did not mention it in our previous conversation, here machine 
check events
are serialized, Aravinda has explained it clear in commit message of 
patch 5/7, So
there will be a single entry in the list.
>
>>   }
>>   
>>   static void spapr_create_nvram(SpaprMachineState *spapr)
>> @@ -1965,6 +1968,42 @@ static const VMStateDescription vmstate_spapr_dtb = {
>>       },
>>   };
>>   
>> +static bool spapr_fwnmi_needed(void *opaque)
>> +{
>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>> +
>> +    return spapr->guest_machine_check_addr != -1;
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
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static const VMStateDescription vmstate_spapr = {
>>       .name = "spapr",
>>       .version_id = 3,
>> @@ -1999,6 +2038,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_cap_large_decr,
>>           &vmstate_spapr_cap_ccf_assist,
>>           &vmstate_spapr_cap_fwnmi,
>> +        &vmstate_spapr_machine_check,
>>           NULL
>>       }
>>   };
>> @@ -2814,6 +2854,13 @@ static void spapr_machine_init(MachineState *machine)
>>           spapr_create_lmb_dr_connectors(spapr);
>>       }
>>   
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
>> +        /* Create the error string for live migration blocker */
>> +        error_setg(&spapr->fwnmi_migration_blocker,
>> +            "A machine check is being handled during migration. The handler"
>> +            "may run and log hardware error on the destination");
>> +    }
>> +
>>       /* Set up RTAS event infrastructure */
>>       spapr_events_init(spapr);
>>   
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 54eaf28a9e..884e455f02 100644
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
>> @@ -872,8 +875,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>               return;
>>           }
>>       }
>> -    spapr->mc_status = cpu->vcpu_id;
>>   
>> +    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
>> +    if (ret == -EBUSY) {
>> +        /*
>> +         * We don't want to abort so we let the migration to continue.
>> +         * In a rare case, the machine check handler will run on the target.
>> +         * Though this is not preferable, it is better than aborting
>> +         * the migration or killing the VM.
>> +         */
>> +        warn_report("Received a fwnmi while migration was in progress");
>> +    }
>> +
>> +    spapr->mc_status = cpu->vcpu_id;
>>       spapr_mce_dispatch_elog(cpu, recovered);
>>   }
>>   
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 3f162d82f5..4ce8e48d2a 100644
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
>> @@ -453,6 +454,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>       spapr->mc_status = -1;
>>       qemu_cond_signal(&spapr->mc_delivery_cond);
>>       rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>   }
>>   
>>   static struct rtas_call {
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index f6f82d88aa..a1fba95c82 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -218,6 +218,8 @@ struct SpaprMachineState {
>>   
>>       unsigned gpu_numa_id;
>>       SpaprTpmProxy *tpm_proxy;
>> +
>> +    Error *fwnmi_migration_blocker;
>>   };
>>   
>>   #define H_SUCCESS         0



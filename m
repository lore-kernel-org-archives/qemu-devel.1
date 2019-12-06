Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B95C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056EE2064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056EE2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF8L-000254-Q1
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1idEQg-0003jQ-6y
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1idEQd-0004f6-T1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:17:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1idEQd-0004bj-JM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:17:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB65gcmt078455
 for <qemu-devel@nongnu.org>; Fri, 6 Dec 2019 00:46:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9hkw473-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 00:46:06 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Fri, 6 Dec 2019 05:46:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 6 Dec 2019 05:46:01 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB65k1AL57016428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2019 05:46:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E66A34204C;
 Fri,  6 Dec 2019 05:46:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBBA842047;
 Fri,  6 Dec 2019 05:45:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.49.171])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2019 05:45:58 +0000 (GMT)
Subject: Re: [PATCH v17 6/7] migration: Include migration support for machine
 check handling
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-7-ganeshgr@linux.ibm.com>
 <20191119024514.GM5582@umbus.fritz.box>
 <5348d151-bc01-b704-7587-77e7856f90e5@linux.ibm.com>
 <20191206012217.GJ5031@umbus.fritz.box>
From: Ganesh <ganeshgr@linux.ibm.com>
Date: Fri, 6 Dec 2019 11:15:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20191206012217.GJ5031@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19120605-0016-0000-0000-000002D1F9D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120605-0017-0000-0000-00003334021A
Message-Id: <f79e0391-687d-bda0-76cb-fa995212a0a0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_10:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060050
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/6/19 6:52 AM, David Gibson wrote:
> On Thu, Dec 05, 2019 at 10:39:29AM +0530, Ganesh wrote:
>> On 11/19/19 8:15 AM, David Gibson wrote:
>>> On Thu, Oct 24, 2019 at 01:13:06PM +0530, Ganesh Goudar wrote:
>>>> From: Aravinda Prasad <arawinda.p@gmail.com>
>>>>
>>>> This patch includes migration support for machine check
>>>> handling. Especially this patch blocks VM migration
>>>> requests until the machine check error handling is
>>>> complete as these errors are specific to the source
>>>> hardware and is irrelevant on the target hardware.
>>>>
>>>> [Do not set FWNMI cap in post_load, now its done in .apply hook]
>>>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>>>> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
>>>> ---
>>>>    hw/ppc/spapr.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>>>>    hw/ppc/spapr_events.c  | 16 +++++++++++++++-
>>>>    hw/ppc/spapr_rtas.c    |  2 ++
>>>>    include/hw/ppc/spapr.h |  2 ++
>>>>    4 files changed, 60 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 346ec5ba6c..e0d0f95ec0 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -46,6 +46,7 @@
>>>>    #include "migration/qemu-file-types.h"
>>>>    #include "migration/global_state.h"
>>>>    #include "migration/register.h"
>>>> +#include "migration/blocker.h"
>>>>    #include "mmu-hash64.h"
>>>>    #include "mmu-book3s-v3.h"
>>>>    #include "cpu-models.h"
>>>> @@ -1751,6 +1752,8 @@ static void spapr_machine_reset(MachineState *machine)
>>>>        /* Signal all vCPUs waiting on this condition */
>>>>        qemu_cond_broadcast(&spapr->mc_delivery_cond);
>>>> +
>>>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>>>    }
>>>>    static void spapr_create_nvram(SpaprMachineState *spapr)
>>>> @@ -2041,6 +2044,43 @@ static const VMStateDescription vmstate_spapr_dtb = {
>>>>        },
>>>>    };
>>>> +static bool spapr_fwnmi_needed(void *opaque)
>>>> +{
>>>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>>>> +
>>>> +    return spapr->guest_machine_check_addr != -1;
>>>> +}
>>>> +
>>>> +static int spapr_fwnmi_pre_save(void *opaque)
>>>> +{
>>>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>>>> +
>>>> +    /*
>>>> +     * With -only-migratable QEMU option, we cannot block migration.
>>>> +     * Hence check if machine check handling is in progress and print
>>>> +     * a warning message.
>>>> +     */
>>> IIUC the logic below this could also occur in the case where the fwnmi
>>> event occurs after a migration has started, but before it completes,
>>> not just with -only-migratable.  Is that correct?
>> Yes
> Ok, please update the comment accordingly.
sure
>
>>>> +    if (spapr->mc_status != -1) {
>>>> +        warn_report("A machine check is being handled during migration. The"
>>>> +                "handler may run and log hardware error on the destination");
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_spapr_machine_check = {
>>>> +    .name = "spapr_machine_check",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = spapr_fwnmi_needed,
>>>> +    .pre_save = spapr_fwnmi_pre_save,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
>>>> +        VMSTATE_INT32(mc_status, SpaprMachineState),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    },
>>>> +};
>>>> +
>>>>    static const VMStateDescription vmstate_spapr = {
>>>>        .name = "spapr",
>>>>        .version_id = 3,
>>>> @@ -2075,6 +2115,7 @@ static const VMStateDescription vmstate_spapr = {
>>>>            &vmstate_spapr_cap_large_decr,
>>>>            &vmstate_spapr_cap_ccf_assist,
>>>>            &vmstate_spapr_cap_fwnmi,
>>>> +        &vmstate_spapr_machine_check,
>>>>            NULL
>>>>        }
>>>>    };
>>>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>>>> index db44e09154..30d9371c88 100644
>>>> --- a/hw/ppc/spapr_events.c
>>>> +++ b/hw/ppc/spapr_events.c
>>>> @@ -43,6 +43,7 @@
>>>>    #include "qemu/main-loop.h"
>>>>    #include "hw/ppc/spapr_ovec.h"
>>>>    #include <libfdt.h>
>>>> +#include "migration/blocker.h"
>>>>    #define RTAS_LOG_VERSION_MASK                   0xff000000
>>>>    #define   RTAS_LOG_VERSION_6                    0x06000000
>>>> @@ -842,6 +843,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>>>    {
>>>>        SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>>>        CPUState *cs = CPU(cpu);
>>>> +    int ret;
>>>> +    Error *local_err = NULL;
>>>>        if (spapr->guest_machine_check_addr == -1) {
>>>>            /*
>>>> @@ -871,8 +874,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>>>                return;
>>>>            }
>>>>        }
>>>> -    spapr->mc_status = cpu->vcpu_id;
>>>> +    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
>>>> +    if (ret == -EBUSY) {
>>>> +        /*
>>>> +         * We don't want to abort so we let the migration to continue.
>>>> +         * In a rare case, the machine check handler will run on the target.
>>>> +         * Though this is not preferable, it is better than aborting
>>>> +         * the migration or killing the VM.
>>>> +         */
>>>> +        warn_report_err(local_err);
>>> I suspect the error message in local_err won't be particularly
>>> meaningful on its own.  Perhaps you need to add a prefix to clarify
>>> that the problem is you've received a fwnmi after migration has
>>> commenced?
>> ok
>>>> +    }
>>>> +
>>>> +    spapr->mc_status = cpu->vcpu_id;
>>>>        spapr_mce_dispatch_elog(cpu, recovered);
>>>>    }
>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>> index 0328b1f341..c78d96ee7e 100644
>>>> --- a/hw/ppc/spapr_rtas.c
>>>> +++ b/hw/ppc/spapr_rtas.c
>>>> @@ -50,6 +50,7 @@
>>>>    #include "hw/ppc/fdt.h"
>>>>    #include "target/ppc/mmu-hash64.h"
>>>>    #include "target/ppc/mmu-book3s-v3.h"
>>>> +#include "migration/blocker.h"
>>>>    static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>                                       uint32_t token, uint32_t nargs,
>>>> @@ -446,6 +447,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>>>         */
>>>>        spapr->mc_status = -1;
>>>>        qemu_cond_signal(&spapr->mc_delivery_cond);
>>>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>> Oh... damn.  I suggested using a static fwnmi_migration_blocker
>>> instance, but I just realized there's a problem with it.
>>>
>>> If we do receive multiple fwnmi events on different cpus at roughly
>>> the same time, this will break: I think we'll try to add the same
>>> migration blocker instance multiple times, which won't be good.  Even
>>> if that doesn't do anything *too* bad, then we'll unblock the
>>> migration on the first interlock, rather than waiting for all pending
>>> fwnmi events to complete.
>> Ok, not sure how to handle this, ill look into it.
> Well, you can do it by reverting to the old approach of dynamically
> creating the Error object before adding it as blocker (and freeing it
> when the blocker is removed).  It's a bit ugly, but it will suffice.
Sure, Thanks
>
>>>>        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>>>    }
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 86f0fc8fdd..290abd6328 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -215,6 +215,8 @@ struct SpaprMachineState {
>>>>        unsigned gpu_numa_id;
>>>>        SpaprTpmProxy *tpm_proxy;
>>>> +
>>>> +    Error *fwnmi_migration_blocker;
>>>>    };
>>>>    #define H_SUCCESS         0



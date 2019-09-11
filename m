Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EEDECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7432D20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7432D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xLs-0007Gz-KW
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i7xL6-0006j2-QE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i7xL5-0006UK-8r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:46:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i7xL1-0006Sn-Ir; Wed, 11 Sep 2019 03:46:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8B7gcxO010358; Wed, 11 Sep 2019 03:46:36 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uxc00cvpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2019 03:46:35 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8B7jY1R005628;
 Wed, 11 Sep 2019 07:46:33 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03wdc.us.ibm.com with ESMTP id 2uv4679cke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2019 07:46:33 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8B7kWP247382944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 07:46:32 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9851BC605A;
 Wed, 11 Sep 2019 07:46:32 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74320C6059;
 Wed, 11 Sep 2019 07:46:30 +0000 (GMT)
Received: from [9.102.2.149] (unknown [9.102.2.149])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 11 Sep 2019 07:46:30 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <156801373576.24362.1904051970114447107.stgit@aravinda>
 <156801390267.24362.17017161761742932333.stgit@aravinda>
 <20190910104814.6bd89cec@bahia.lan>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <7760e81b-94c8-b257-f43a-e643425a3229@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2019 13:16:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190910104814.6bd89cec@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-11_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v13 6/6] migration: Include migration
 support for machine check handling
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tuesday 10 September 2019 02:18 PM, Greg Kurz wrote:
> Hi Aravinda,
> 
> Sorry for not being able to review the whole series in one pass,
> and thus forcing you to poste more versions... but I have some
> more remarks about migration.

That's fine. In fact I have to thank you for your time for reviewing my
patches.

> 
> On Mon, 09 Sep 2019 12:55:02 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> This patch includes migration support for machine check
>> handling. Especially this patch blocks VM migration
>> requests until the machine check error handling is
>> complete as (i) these errors are specific to the source
>> hardware and is irrelevant on the target hardware,
>> (ii) these errors cause data corruption and should
>> be handled before migration.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |   44 ++++++++++++++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_events.c  |   14 ++++++++++++++
>>  hw/ppc/spapr_rtas.c    |    2 ++
>>  include/hw/ppc/spapr.h |    2 ++
>>  4 files changed, 62 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 1c0908e..f6262f0 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -46,6 +46,7 @@
>>  #include "migration/qemu-file-types.h"
>>  #include "migration/global_state.h"
>>  #include "migration/register.h"
>> +#include "migration/blocker.h"
>>  #include "mmu-hash64.h"
>>  #include "mmu-book3s-v3.h"
>>  #include "cpu-models.h"
>> @@ -1829,6 +1830,8 @@ static void spapr_machine_reset(MachineState *machine)
>>  
>>      /* Signal all vCPUs waiting on this condition */
>>      qemu_cond_broadcast(&spapr->mc_delivery_cond);
>> +
>> +    migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>  }
>>  
>>  static void spapr_create_nvram(SpaprMachineState *spapr)
>> @@ -2119,6 +2122,42 @@ static const VMStateDescription vmstate_spapr_dtb = {
>>      },
>>  };
>>  
>> +static bool spapr_fwnmi_needed(void *opaque)
>> +{
>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>> +
>> +    return spapr->guest_machine_check_addr != -1;
>> +}
>> +
>> +static int spapr_fwnmi_post_load(void *opaque, int version_id)
>> +{
>> +    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
>> +
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
>> +
>> +        if (kvmppc_has_cap_ppc_fwnmi()) {
>> +            return 0;
>> +        }
>> +
>> +        return kvmppc_set_fwnmi();
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
>> +    .post_load = spapr_fwnmi_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
>> +        VMSTATE_INT32(mc_status, SpaprMachineState),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>  static const VMStateDescription vmstate_spapr = {
>>      .name = "spapr",
>>      .version_id = 3,
>> @@ -2152,6 +2191,7 @@ static const VMStateDescription vmstate_spapr = {
>>          &vmstate_spapr_dtb,
>>          &vmstate_spapr_cap_large_decr,
>>          &vmstate_spapr_cap_ccf_assist,
>> +        &vmstate_spapr_machine_check,
>>          NULL
>>      }
>>  };
>> @@ -2948,6 +2988,10 @@ static void spapr_machine_init(MachineState *machine)
>>              exit(1);
>>          }
>>  
>> +        /* Create the error string for live migration blocker */
>> +        error_setg(&spapr->fwnmi_migration_blocker,
>> +            "Live migration not supported during machine check handling");
>> +
>>          /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
>>          spapr_fwnmi_register();
>>      }
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index ecc3d68..83f0a22 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -43,6 +43,7 @@
>>  #include "qemu/main-loop.h"
>>  #include "hw/ppc/spapr_ovec.h"
>>  #include <libfdt.h>
>> +#include "migration/blocker.h"
>>  
>>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>>  #define   RTAS_LOG_VERSION_6                    0x06000000
>> @@ -844,6 +845,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>  {
>>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>      CPUState *cs = CPU(cpu);
>> +    int ret;
>> +    Error *local_err = NULL;
>>  
>>      if (spapr->guest_machine_check_addr == -1) {
>>          /*
>> @@ -857,6 +860,17 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>          return;
>>      }
>>  
>> +    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
> 
> If an MCE is already being handled, this adds yet another blocker. IIUC only
> the vCPU handling the previous MCE is supposed to call "ibm,nmi-interlock"
> and clear the blocker. This might cause a blocker to be leaked. I think
> migrate_add_blocker() should only be called when we know that the vCPU
> does handle the MCE, ie, after the loop.

I think so.

> 
> Also, please note that migrate_add_blocker() can fail for two reasons:
> (1) migration is already in progress (-EBUSY)
> (2) QEMU was started with -only-migratable (-EACCES)
> 
>> +    if (ret < 0) {
>> +        /*
>> +         * We don't want to abort and let the migration to continue. In a
>> +         * rare case, the machine check handler will run on the target
>> +         * hardware. Though this is not preferable, it is better than aborting
>> +         * the migration or killing the VM.
>> +         */
> 
> This seems correct for case (1).
> 
>> +        warn_report_err(local_err);
> 
> The warning would be:
> 
> disallowing migration blocker (migration in progress) for:
>  Live migration not supported during machine check handling
> 
> This rather looks rather cryptic for the average user. Maybe
> better to ignore the generic message, ie, pass NULL to
> migrate_add_blocker, and output a more meaningul warning
> with warn_report() directly. Something like:
> 
> "A machine check is being handled during migration. This may
> cause data corruption or abusive poisoning of some of the
> guest memory on the destination"

As data could be already corrupt when we get a machine check, I will use
a slightly modified version of the above error msg.

> 
> Case (2) is different. There isn't any migration in progress: the idea
> behind the -only-migratable QEMU option is to avoid configurations that
> can block migration. If migration doesn't happen while the MCE is being
> handled, I don't think we should output a warning at all. But a warning
> (same as above?) should be printed if migration happens before the vCPU
> did call "ibm,nmi-interlock", by checking mc_status in spapr_pre_save()
> for example.

I was not aware of case (2). I agree that we should not print any
warning as there is no migration in progress. Further, as you suggested,
if migration happens before "ibm,nmi-interlock" is called, we can check
mc_status and print the warning in spapr_pre_save().

Regards,
Aravinda

> 
>> +    }
>> +
>>      while (spapr->mc_status != -1) {
>>          /*
>>           * Check whether the same CPU got machine check error
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index d892583..b682cc2 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -50,6 +50,7 @@
>>  #include "hw/ppc/fdt.h"
>>  #include "target/ppc/mmu-hash64.h"
>>  #include "target/ppc/mmu-book3s-v3.h"
>> +#include "migration/blocker.h"
>>  
>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                                     uint32_t token, uint32_t nargs,
>> @@ -438,6 +439,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>           */
>>          spapr->mc_status = -1;
>>          qemu_cond_signal(&spapr->mc_delivery_cond);
>> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>      }
>>  }
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index dada821..ea7625e 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -217,6 +217,8 @@ struct SpaprMachineState {
>>  
>>      unsigned gpu_numa_id;
>>      SpaprTpmProxy *tpm_proxy;
>> +
>> +    Error *fwnmi_migration_blocker;
>>  };
>>  
>>  #define H_SUCCESS         0
>>
> 

-- 
Regards,
Aravinda


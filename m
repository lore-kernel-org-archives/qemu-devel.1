Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CA6217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CA6217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzql-0001on-0I
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:21:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hOzmB-0006ZS-Iw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hOzm9-0002GA-H2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:17:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hOzm8-0002EH-It
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:17:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4A7DH0n031387
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 03:16:58 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sd41c9gsw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 03:16:58 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Fri, 10 May 2019 08:16:56 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
	by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 08:16:53 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
	[9.57.199.109])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4A7Gqgc33357942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 07:16:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F722112061;
	Fri, 10 May 2019 07:16:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68179112062;
	Fri, 10 May 2019 07:16:50 +0000 (GMT)
Received: from [9.199.33.229] (unknown [9.199.33.229])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 07:16:50 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591662496.20338.3862565585716109724.stgit@aravinda>
	<20190510065144.GM20559@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 10 May 2019 12:46:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190510065144.GM20559@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051007-0064-0000-0000-000003DC9C7C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011081; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01201187; UDB=6.00630319;
	IPR=6.00982083; 
	MB=3.00026825; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-10 07:16:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051007-0065-0000-0000-00003D6A2504
Message-Id: <7f54cc6e-7d81-1d08-ea62-0ad8ea95b93d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100050
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v8 6/6] migration: Block migration while
 handling machine check
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Friday 10 May 2019 12:21 PM, David Gibson wrote:
> On Mon, Apr 22, 2019 at 12:33:45PM +0530, Aravinda Prasad wrote:
>> Block VM migration requests until the machine check
>> error handling is complete as (i) these errors are
>> specific to the source hardware and is irrelevant on
>> the target hardware, (ii) these errors cause data
>> corruption and should be handled before migration.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
>>  hw/ppc/spapr_rtas.c    |    4 ++++
>>  include/hw/ppc/spapr.h |    3 +++
>>  3 files changed, 24 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 4032db0..45b990c 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -41,6 +41,7 @@
>>  #include "qemu/bcd.h"
>>  #include "hw/ppc/spapr_ovec.h"
>>  #include <libfdt.h>
>> +#include "migration/blocker.h"
>>  
>>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>>  #define   RTAS_LOG_VERSION_6                    0x06000000
>> @@ -864,6 +865,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>  {
>>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    int ret;
>> +    Error *local_err = NULL;
>> +
>> +    error_setg(&spapr->migration_blocker,
>> +            "Live migration not supported during machine check handling");
>> +    ret = migrate_add_blocker(spapr->migration_blocker, &local_err);
>> +    if (ret < 0) {
>> +        /*
>> +         * We don't want to abort and let the migration to continue. In a
>> +         * rare case, the machine check handler will run on the target
>> +         * hardware. Though this is not preferable, it is better than aborting
>> +         * the migration or killing the VM.
>> +         */
>> +        error_free(spapr->migration_blocker);
>> +        fprintf(stderr, "Warning: Machine check during VM migration\n");
> 
> Use report_err() instead of a raw fprintf().

sure..

> 
>> +    }
>>  
>>      while (spapr->mc_status != -1) {
>>          /*
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 997cf19..1229a0e 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -50,6 +50,7 @@
>>  #include "target/ppc/mmu-hash64.h"
>>  #include "target/ppc/mmu-book3s-v3.h"
>>  #include "kvm_ppc.h"
>> +#include "migration/blocker.h"
>>  
>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                                     uint32_t token, uint32_t nargs,
>> @@ -396,6 +397,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>          spapr->mc_status = -1;
>>          qemu_cond_signal(&spapr->mc_delivery_cond);
>>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +        migrate_del_blocker(spapr->migration_blocker);
>> +        error_free(spapr->migration_blocker);
>> +        spapr->migration_blocker = NULL;
>>      }
>>  }
>>  
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9d16ad1..dda5fd2 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -10,6 +10,7 @@
>>  #include "hw/ppc/spapr_irq.h"
>>  #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>>  #include "hw/ppc/xics.h"        /* For ICSState */
>> +#include "qapi/error.h"
>>  
>>  struct SpaprVioBus;
>>  struct SpaprPhbState;
>> @@ -213,6 +214,8 @@ struct SpaprMachineState {
>>      SpaprCapabilities def, eff, mig;
>>  
>>      unsigned gpu_numa_id;
>> +
>> +    Error *migration_blocker;
> 
> This name doesn't seem good - it's specific to fwnmi, not any other
> migration blockers we might have in future.  It also always contains
> the same string - could you just initialize that in a global and just
> do the migrate_add_blocker() / migrate_del_blocker() instead?

sure..

> 
>>  };
>>  
>>  #define H_SUCCESS         0
>>
> 

-- 
Regards,
Aravinda



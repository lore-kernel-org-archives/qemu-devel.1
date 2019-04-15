Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9703CC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7CC206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7CC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47707 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFycc-0001Et-I5
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:13:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hFybj-0000qO-DY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hFybi-0007C5-4O
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:12:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hFybh-0007BA-C9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:12:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FA9jVg075140
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 06:12:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rvnckr5k1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 06:12:53 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 15 Apr 2019 11:12:52 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
	by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 15 Apr 2019 11:12:49 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x3FACnvn25952392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 15 Apr 2019 10:12:49 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA3C712405B;
	Mon, 15 Apr 2019 10:12:48 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5E0124058;
	Mon, 15 Apr 2019 10:12:47 +0000 (GMT)
Received: from [9.124.31.171] (unknown [9.124.31.171])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2019 10:12:47 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323645659.18748.12592305605497011547.stgit@aravinda>
	<20190325063205.GQ29295@umbus>
	<9da8a51d-106c-410e-fa88-d37dceb0c9e1@linux.vnet.ibm.com>
	<20190325233319.GD9393@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 15 Apr 2019 15:42:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190325233319.GD9393@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041510-0064-0000-0000-000003CB0436
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010931; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01189375; UDB=6.00623167;
	IPR=6.00970162; 
	MB=3.00026447; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 10:12:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041510-0065-0000-0000-00003D1240C3
Message-Id: <93ee6877-b487-1733-a368-3887f105f5a3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904150072
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 5/6] ppc: spapr: Enable FWNMI
 capability
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
Cc: paulus@ozlabs.org, aik@au1.ibm.com, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415101246.AERrKCjdLu2VuB5A22izNdljgxceRbqGai1aoWYjT_w@z>



On Tuesday 26 March 2019 05:03 AM, David Gibson wrote:
> On Mon, Mar 25, 2019 at 02:27:45PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Monday 25 March 2019 12:02 PM, David Gibson wrote:
>>> On Fri, Mar 22, 2019 at 12:04:16PM +0530, Aravinda Prasad wrote:
>>>> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
>>>> the KVM causes guest exit with NMI as exit reason
>>>> when it encounters a machine check exception on the
>>>> address belonging to a guest. Without this capability
>>>> enabled, KVM redirects machine check exceptions to
>>>> guest's 0x200 vector.
>>>>
>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/ppc/spapr_rtas.c  |   15 +++++++++++++++
>>>>  target/ppc/kvm.c     |   14 ++++++++++++++
>>>>  target/ppc/kvm_ppc.h |    6 ++++++
>>>>  3 files changed, 35 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>> index fb594a4..939f428 100644
>>>> --- a/hw/ppc/spapr_rtas.c
>>>> +++ b/hw/ppc/spapr_rtas.c
>>>> @@ -49,6 +49,7 @@
>>>>  #include "hw/ppc/fdt.h"
>>>>  #include "target/ppc/mmu-hash64.h"
>>>>  #include "target/ppc/mmu-book3s-v3.h"
>>>> +#include "kvm_ppc.h"
>>>>  
>>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>                                     uint32_t token, uint32_t nargs,
>>>> @@ -354,6 +355,20 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>>>                                    target_ulong args,
>>>>                                    uint32_t nret, target_ulong rets)
>>>>  {
>>>> +    int ret;
>>>> +
>>>> +    ret = kvmppc_fwnmi_enable(cpu);
>>>> +
>>>> +    if (ret == 1) {
>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>
>>> Urgh, we're here making a guest visible different to the environment
>>> depending on a host (KVM) capability.  What happens if you start a
>>> guest and it registers fwnmi support, then migrate it to a host that
>>> lacks the necessary KVM support?
>>
>> I just checked how such scenarios are handled for other KVM
>> capabilities. Should I need to add an Spapr cap for this?
> 
> Yes, I think that's what we'll need to do.

I was looking into SPAPR Cap, and I am not sure that the following code
will help in handling the migration. I need some help here.

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index edc5ed0..ef96192 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -473,6 +473,15 @@ static void cap_ccf_assist_apply(SpaprMachineState
*spapr, uint8_t val,
     }
 }

+static void cap_machine_check_apply(SpaprMachineState *spapr, uint8_t val,
+                                    Error **errp)
+{
+    if (kvm_enabled()) {
+        if (kvmppc_fwnmi_enable(cpu)) {
+            error_setg(errp, "Unable to enable fwnmi capability");
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -571,6 +580,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_ccf_assist_apply,
     },
+    [SPAPR_CAP_MACHINE_CHECK] = {
+        .name = "machine-check",
+        .description = "Handle machine check exceptions",
+        .index = SPAPR_CAP_MACHINE_CHECK,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_machine_check_apply,
+    },
 };

 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -706,6 +724,7 @@ SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
+SPAPR_CAP_MIG_STATE(mce, SPAPR_CAP_MACHINE_CHECK);

 void spapr_caps_init(SpaprMachineState *spapr)
 {


Or is it that just adding SPAPR_CAP_MIG_STATE(mce,
SPAPR_CAP_MACHINE_CHECK); is enough as it is checking or cap values?

> 

-- 
Regards,
Aravinda



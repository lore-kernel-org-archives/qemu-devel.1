Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF1EC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D50A21852
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D50A21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjMIq-0003Om-SF
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hjMFV-00019a-L7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hjMFU-0000aD-2s
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:19:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hjMFT-0000TG-OO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:19:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x65B9dSk136804
 for <qemu-devel@nongnu.org>; Fri, 5 Jul 2019 07:19:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tj4etan1h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 07:19:25 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 5 Jul 2019 12:19:24 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 5 Jul 2019 12:19:22 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x65BJMXE15860560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jul 2019 11:19:22 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8408AC062;
 Fri,  5 Jul 2019 11:19:21 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78E03AC05B;
 Fri,  5 Jul 2019 11:19:19 +0000 (GMT)
Received: from [9.85.75.69] (unknown [9.85.75.69])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jul 2019 11:19:19 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033126489.26635.3005245220857933178.stgit@aravinda>
 <20190702035105.GG6779@umbus.fritz.box>
 <fa2b5983-7cad-9679-489f-c273bd8216fb@linux.vnet.ibm.com>
 <20190703030334.GF9442@umbus.fritz.box>
 <a43707b0-8059-b2bd-a461-9f6de3285d8f@linux.vnet.ibm.com>
 <20190704010714.GS9442@umbus.fritz.box>
 <d5c75742-4f45-2f26-3837-098e8710ccd9@linux.vnet.ibm.com>
 <20190705010755.GA3266@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 5 Jul 2019 16:49:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190705010755.GA3266@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070511-0052-0000-0000-000003DAC691
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011382; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227755; UDB=6.00646467; IPR=6.01008996; 
 MB=3.00027596; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-05 11:19:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070511-0053-0000-0000-00006193D49E
Message-Id: <c0ab62c0-b170-2c11-221f-b46b1ba4339f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-05_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v10 2/6] ppc: spapr: Introduce FWNMI
 capability
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Friday 05 July 2019 06:37 AM, David Gibson wrote:
> On Thu, Jul 04, 2019 at 10:33:11AM +0530, Aravinda Prasad wrote:
>>
>>
>> On Thursday 04 July 2019 06:37 AM, David Gibson wrote:
>>> On Wed, Jul 03, 2019 at 02:58:24PM +0530, Aravinda Prasad wrote:
>>>>
>>>>
>>>> On Wednesday 03 July 2019 08:33 AM, David Gibson wrote:
>>>>> On Tue, Jul 02, 2019 at 11:54:26AM +0530, Aravinda Prasad wrote:
>>>>>>
>>>>>>
>>>>>> On Tuesday 02 July 2019 09:21 AM, David Gibson wrote:
>>>>>>> On Wed, Jun 12, 2019 at 02:51:04PM +0530, Aravinda Prasad wrote:
>>>>>>>> Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
>>>>>>>> the KVM causes guest exit with NMI as exit reason
>>>>>>>> when it encounters a machine check exception on the
>>>>>>>> address belonging to a guest. Without this capability
>>>>>>>> enabled, KVM redirects machine check exceptions to
>>>>>>>> guest's 0x200 vector.
>>>>>>>>
>>>>>>>> This patch also introduces fwnmi-mce capability to
>>>>>>>> deal with the case when a guest with the
>>>>>>>> KVM_CAP_PPC_FWNMI capability enabled is attempted
>>>>>>>> to migrate to a host that does not support this
>>>>>>>> capability.
>>>>>>>>
>>>>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>>>>>> ---
>>>>>>>>  hw/ppc/spapr.c         |    1 +
>>>>>>>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
>>>>>>>>  include/hw/ppc/spapr.h |    4 +++-
>>>>>>>>  target/ppc/kvm.c       |   19 +++++++++++++++++++
>>>>>>>>  target/ppc/kvm_ppc.h   |   12 ++++++++++++
>>>>>>>>  5 files changed, 61 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>>>>> index 6dd8aaa..2ef86aa 100644
>>>>>>>> --- a/hw/ppc/spapr.c
>>>>>>>> +++ b/hw/ppc/spapr.c
>>>>>>>> @@ -4360,6 +4360,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>>>>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>>>>>>>      spapr_caps_add_properties(smc, &error_abort);
>>>>>>>>      smc->irq = &spapr_irq_dual;
>>>>>>>>      smc->dr_phb_enabled = true;
>>>>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>>>>>>> index 31b4661..2e92eb6 100644
>>>>>>>> --- a/hw/ppc/spapr_caps.c
>>>>>>>> +++ b/hw/ppc/spapr_caps.c
>>>>>>>> @@ -479,6 +479,22 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>>>>>>>>      }
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>>>>>>>> +                                Error **errp)
>>>>>>>> +{
>>>>>>>> +    if (!val) {
>>>>>>>> +        return; /* Disabled by default */
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (tcg_enabled()) {
>>>>>>>> +        error_setg(errp,
>>>>>>>> +"No Firmware Assisted Non-Maskable Interrupts support in TCG, try cap-fwnmi-mce=off");
>>>>>>>
>>>>>>> Not allowing this for TCG creates an awkward incompatibility between
>>>>>>> KVM and TCG guests.  I can't actually see any reason to ban it for TCG
>>>>>>> - with the current code TCG won't ever generate NMIs, but I don't see
>>>>>>> that anything will actually break.
>>>>>>>
>>>>>>> In fact, we do have an nmi monitor command, currently wired to the
>>>>>>> spapr_nmi() function which resets each cpu, but it probably makes
>>>>>>> sense to wire it up to the fwnmi stuff when present.
>>>>>>
>>>>>> Yes, but that nmi support is not enough to inject a synchronous error
>>>>>> into the guest kernel. For example, we should provide the faulty address
>>>>>> along with other information such as the type of error (slb multi-hit,
>>>>>> memory error, TLB multi-hit) and when the error occurred (load/store)
>>>>>> and whether the error was completely recovered or not. Without such
>>>>>> information we cannot build the error log and pass it on to the guest
>>>>>> kernel. Right now nmi monitor command takes cpu number as the only argument.
>>>>>
>>>>> Obviously we can't inject an arbitrary MCE event with that monitor
>>>>> command.  But isn't there some sort of catch-all / unknown type of MCE
>>>>> event which we could inject?
>>>>
>>>> We have "unknown" type of error, but we should also pass an address in
>>>> the MCE event log. Strictly speaking this address should be a valid
>>>> address in the current CPU context as MCEs are synchronous errors
>>>> triggered when we touch a bad address.
>>>
>>> Well, some of them are.  At least historically both synchronous and
>>> asnchronous MCEs were possible.  Are there really no versions where
>>> you can report an MCE with unknown address?
>>
>> I am not aware of any such versions. Will cross check.
>>
>>>
>>>> We can pass a default address with every nmi, but I am not sure whether
>>>> that will be practically helpful.
>>>>
>>>>> It seems very confusing to me to have 2 totally separate "nmi"
>>>>> mechanisms.
>>>>>
>>>>>> So I think TCG support should be a separate patch by itself.
>>>>>
>>>>> Even if we don't wire up the monitor command, I still don't see
>>>>> anything that this patch breaks - we can support the nmi-register and
>>>>> nmi-interlock calls without ever actually creating MCE events.
>>>>
>>>> If we support nmi-register and nmi-interlock calls without the monitor
>>>> command wire-up then we will be falsely claiming the nmi support to the
>>>> guest while it is not actually supported.
>>>
>>> How so?  AFAICT, from the point of view of the guest this is not
>>> observably different from supporting the NMI mechanism but NMIs never
>>> occurring.
>>
>> A guest inserting a duplicate SLB will expect the machine check
>> exception delivered to the handler registered via nmi,register.
>> But we actually don't do that in TCG.
> 
> Ah, true, I was thinking of external hardware fault triggered MCEs
> rather than software error ones like duplicate SLB.
> 
> That said, I strongly suspect TCG is buggy enough at present that
> exact behaviour in rare error conditions like duplicate SLB is not
> really a big problem in the scheme of things.
> 
> I really don't think we can enable this by default until we allow it
> for TCG - we don't want starting a TCG guest to involve manually
> switching other options.
> 
> We could consider allowing it for TCG but just printing a warning that
> the behaviour may not be correct in some conditions - we do something
> similar for some of the Spectre workarounds already.

I think we better not enable this by default until we enhance TCG to
support fwnmi.

> 

-- 
Regards,
Aravinda



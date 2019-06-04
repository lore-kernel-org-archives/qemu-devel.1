Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46932C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E33824A9A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E33824A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY2dq-00051C-4n
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 02:09:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hY2cp-0004eL-F7
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hY2cn-0003C8-Ow
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:08:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hY2cl-00039K-Ge
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:08:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x5467FTw057318
	for <qemu-devel@nongnu.org>; Tue, 4 Jun 2019 02:08:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2swgtrd34q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 02:08:40 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Tue, 4 Jun 2019 07:08:39 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 4 Jun 2019 07:08:36 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
	[9.57.199.106])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x5468ZJL39714974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 4 Jun 2019 06:08:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D0CD2805C;
	Tue,  4 Jun 2019 06:08:35 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB3372805A;
	Tue,  4 Jun 2019 06:08:32 +0000 (GMT)
Received: from [9.199.59.54] (unknown [9.199.59.54])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2019 06:08:32 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910841478.13149.2830700794862210739.stgit@aravinda>
	<20190603121243.687d8d75@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190603131723.261eba99@bahia.lab.toulouse-stg.fr.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Tue, 4 Jun 2019 11:38:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190603131723.261eba99@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060406-0040-0000-0000-000004F8541B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011212; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01212975; UDB=6.00637490;
	IPR=6.00994042; 
	MB=3.00027175; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-04 06:08:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060406-0041-0000-0000-000009047206
Message-Id: <4689dbb8-1ba1-2def-f9a7-b2f5a35bad18@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-04_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906040042
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 1/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Monday 03 June 2019 04:47 PM, Greg Kurz wrote:
> On Mon, 3 Jun 2019 12:12:43 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
>> On Wed, 29 May 2019 11:10:14 +0530
>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>>
>>> This patch adds support in QEMU to handle "ibm,nmi-register"
>>> and "ibm,nmi-interlock" RTAS calls.
>>>
>>> The machine check notification address is saved when the
>>> OS issues "ibm,nmi-register" RTAS call.
>>>
>>> This patch also handles the case when multiple processors
>>> experience machine check at or about the same time by
>>> handling "ibm,nmi-interlock" call. In such cases, as per
>>> PAPR, subsequent processors serialize waiting for the first
>>> processor to issue the "ibm,nmi-interlock" call. The second
>>> processor that also received a machine check error waits
>>> till the first processor is done reading the error log.
>>> The first processor issues "ibm,nmi-interlock" call
>>> when the error log is consumed. This patch implements the
>>> releasing part of the error-log while subsequent patch
>>> (which builds error log) handles the locking part.
>>>
>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---  
>>
>> The code looks okay but it still seems wrong to advertise the RTAS
>> calls to the guest that early in the series. The linux kernel in
>> the guest will assume FWNMI is functional, which isn't true until
>> patch 6 (yes, migration is part of the feature, it should be
>> supported upfront, not fixed afterwards).
>>
>> It doesn't help much to introduce the RTAS calls early and to
>> modify them in the other patches. I'd rather see the rest of
>> the code first and a final patch that introduces the fully
>> functional RTAS calls and calls spapr_rtas_register().
>>
> 
> Thinking again, you should introduce the "fwnmi-mce" spapr capability in
> its own patch first, default to "off" and and have the last patch in the
> series to switch the default to "on" for newer machine types only.
> 
> This patch should then only register the RTAS calls if "fwnmi-mcr" is set
> to "on".
> 
> This should address the fact that we don't want to expose a partially
> implemented FWNMI feature to the guest, and we don't want to support
> FWNMI at all with older machine types for the sake of compatibility.

When you say "expose a partially implemented FWNMI feature to the
guest", do you mean while debugging/bisect we may end up with exposing
the partially implemented FWNMI feature? Otherwise it is expected that
QEMU runs with all the 6 patches.

If that is the case, I will have the rtas nmi register functionality as
the last patch in the series. This way we don't have to have spapr cap
turned off first and later turned on. However, as mentioned earlier
(when David raised the same concern), use of guest_machine_check_addr
may look odd at other patches as it is set only during rtas nmi register.

Or else, as a workaround, I can return RTAS_OUT_NOT_SUPPORTED for rtas
nmi register till the entire functionality is implemented and only in
the last patch in the series I will return RTAS_OUT_SUCCESS. This will
ensure that we have a logical connection between the patches and the
partially implemented fwnmi is not exposed to the guest kernel.

Regards,
Aravinda




> 
>>>  hw/ppc/spapr.c         |    7 +++++
>>>  hw/ppc/spapr_rtas.c    |   65 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  include/hw/ppc/spapr.h |    9 ++++++-
>>>  3 files changed, 80 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index e2b33e5..fae28a9 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -1808,6 +1808,11 @@ static void spapr_machine_reset(void)
>>>      first_ppc_cpu->env.gpr[5] = 0;
>>>  
>>>      spapr->cas_reboot = false;
>>> +
>>> +    spapr->guest_machine_check_addr = -1;
>>> +
>>> +    /* Signal all vCPUs waiting on this condition */
>>> +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
>>>  }
>>>  
>>>  static void spapr_create_nvram(SpaprMachineState *spapr)
>>> @@ -3072,6 +3077,8 @@ static void spapr_machine_init(MachineState *machine)
>>>  
>>>          kvmppc_spapr_enable_inkernel_multitce();
>>>      }
>>> +
>>> +    qemu_cond_init(&spapr->mc_delivery_cond);
>>>  }
>>>  
>>>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>> index 5bc1a93..e7509cf 100644
>>> --- a/hw/ppc/spapr_rtas.c
>>> +++ b/hw/ppc/spapr_rtas.c
>>> @@ -352,6 +352,38 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>      rtas_st(rets, 1, 100);
>>>  }
>>>  
>>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>> +                                  SpaprMachineState *spapr,
>>> +                                  uint32_t token, uint32_t nargs,
>>> +                                  target_ulong args,
>>> +                                  uint32_t nret, target_ulong rets)
>>> +{
>>> +    hwaddr rtas_addr = spapr_get_rtas_addr();
>>> +
>>> +    if (!rtas_addr) {
>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>> +        return;
>>> +    }
>>> +
>>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>> +}
>>> +
>>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>> +                                   SpaprMachineState *spapr,
>>> +                                   uint32_t token, uint32_t nargs,
>>> +                                   target_ulong args,
>>> +                                   uint32_t nret, target_ulong rets)
>>> +{
>>> +    if (spapr->guest_machine_check_addr == -1) {
>>> +        /* NMI register not called */
>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>> +    } else {
>>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>>> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>> +    }
>>> +}
>>> +
>>>  static struct rtas_call {
>>>      const char *name;
>>>      spapr_rtas_fn fn;
>>> @@ -470,6 +502,35 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
>>>      }
>>>  }
>>>  
>>> +hwaddr spapr_get_rtas_addr(void)
>>> +{
>>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>> +    int rtas_node;
>>> +    const struct fdt_property *rtas_addr_prop;
>>> +    void *fdt = spapr->fdt_blob;
>>> +    uint32_t rtas_addr;
>>> +
>>> +    /* fetch rtas addr from fdt */
>>> +    rtas_node = fdt_path_offset(fdt, "/rtas");
>>> +    if (rtas_node == 0) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    rtas_addr_prop = fdt_get_property(fdt, rtas_node, "linux,rtas-base", NULL);
>>> +    if (!rtas_addr_prop) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    /*
>>> +     * We assume that the OS called RTAS instantiate-rtas, but some other
>>> +     * OS might call RTAS instantiate-rtas-64 instead. This fine as of now
>>> +     * as SLOF only supports 32-bit variant.
>>> +     */
>>> +    rtas_addr = fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
>>> +    return (hwaddr)rtas_addr;
>>> +}
>>> +
>>> +
>>>  static void core_rtas_register_types(void)
>>>  {
>>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>>> @@ -493,6 +554,10 @@ static void core_rtas_register_types(void)
>>>                          rtas_set_power_level);
>>>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>>>                          rtas_get_power_level);
>>> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
>>> +                        rtas_ibm_nmi_register);
>>> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>>> +                        rtas_ibm_nmi_interlock);
>>>  }
>>>  
>>>  type_init(core_rtas_register_types)
>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>> index 4f5becf..9dc5e30 100644
>>> --- a/include/hw/ppc/spapr.h
>>> +++ b/include/hw/ppc/spapr.h
>>> @@ -188,6 +188,10 @@ struct SpaprMachineState {
>>>       * occurs during the unplug process. */
>>>      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
>>>  
>>> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>>> +    target_ulong guest_machine_check_addr;
>>> +    QemuCond mc_delivery_cond;
>>> +
>>>      /*< public >*/
>>>      char *kvm_type;
>>>      char *host_model;
>>> @@ -624,8 +628,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>>>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>>>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
>>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
>>>  
>>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
>>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
>>>  
>>>  /* RTAS ibm,get-system-parameter token values */
>>>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>>> @@ -876,4 +882,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>>  
>>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>>> +uint64_t spapr_get_rtas_addr(void);
>>>  #endif /* HW_SPAPR_H */
>>>   
>>
>>
> 

-- 
Regards,
Aravinda



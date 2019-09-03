Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC610C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE9120644
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 07:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE9120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i53Pw-0002Dq-N7
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 03:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i53Or-0001g3-FN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i53Op-0003IF-SS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 03:38:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16052
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i53Om-0003GD-7F; Tue, 03 Sep 2019 03:38:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x837boLu016791; Tue, 3 Sep 2019 03:38:34 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2usk2rssjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Sep 2019 03:38:34 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x837ZnrZ018037;
 Tue, 3 Sep 2019 07:38:33 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01wdc.us.ibm.com with ESMTP id 2uqgh6h2dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Sep 2019 07:38:33 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x837cXao49480006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Sep 2019 07:38:33 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33440124054;
 Tue,  3 Sep 2019 07:38:33 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 696DB124053;
 Tue,  3 Sep 2019 07:38:31 +0000 (GMT)
Received: from [9.85.70.152] (unknown [9.85.70.152])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  3 Sep 2019 07:38:31 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <156715632966.27761.8190459106519248668.stgit@aravinda>
 <156715644777.27761.16844420952499810544.stgit@aravinda>
 <20190830190818.1f46f7b4@bahia.lan>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <534b7850-0245-4f30-69ca-dcdedabd5da0@linux.vnet.ibm.com>
Date: Tue, 3 Sep 2019 13:08:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190830190818.1f46f7b4@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-03_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x837boLu016791
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v12 5/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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



On Friday 30 August 2019 10:38 PM, Greg Kurz wrote:
> On Fri, 30 Aug 2019 14:44:07 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>=20
>> This patch adds support in QEMU to handle "ibm,nmi-register"
>> and "ibm,nmi-interlock" RTAS calls and sets the default
>> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
>> type 4.2.
>>
>> The machine check notification address is saved when the
>> OS issues "ibm,nmi-register" RTAS call.
>>
>> This patch also handles the case when multiple processors
>> experience machine check at or about the same time by
>> handling "ibm,nmi-interlock" call. In such cases, as per
>> PAPR, subsequent processors serialize waiting for the first
>> processor to issue the "ibm,nmi-interlock" call. The second
>> processor that also received a machine check error waits
>> till the first processor is done reading the error log.
>> The first processor issues "ibm,nmi-interlock" call
>> when the error log is consumed.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |   12 +++++++++++-
>>  hw/ppc/spapr_rtas.c    |   50 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/spapr.h |    5 ++++-
>>  3 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 9f2e5d2..1c0908e 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2941,6 +2941,15 @@ static void spapr_machine_init(MachineState *ma=
chine)
>> =20
>>          /* Resize rtas blob to accommodate error log */
>>          spapr->rtas_size =3D RTAS_ERROR_LOG_MAX;
>> +
>> +        /* Set fwnmi capability in KVM */
>> +        if (kvmppc_set_fwnmi() < 0) {
>> +            error_report("Could not enable FWNMI capability");
>> +            exit(1);
>> +        }
>=20
> Hmm... shouldn't this be performed only when the guest
> calls "ibm,nmi-register" ?

The above code is called only when SPAPR_CAP_FWNMI_MCE is set. Please
see my reply to your comments on patch 2 where I have explained why we
don't call it during "ibm,nmi-register".

>=20
>> +
>> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls=
 */
>> +        spapr_fwnmi_register();
>>      }
>> =20
>>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
>> @@ -4508,7 +4517,7 @@ static void spapr_machine_class_init(ObjectClass=
 *oc, void *data)
>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF=
;
>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP=
_ON;
>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
>> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
>>      spapr_caps_add_properties(smc, &error_abort);
>>      smc->irq =3D &spapr_irq_dual;
>>      smc->dr_phb_enabled =3D true;
>> @@ -4582,6 +4591,7 @@ static void spapr_machine_4_1_class_options(Mach=
ineClass *mc)
>>      smc->linux_pci_probe =3D false;
>>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_l=
en);
>>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>>  }
>> =20
>>  DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index d8fb8a8..d892583 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -400,6 +400,48 @@ static void rtas_get_power_level(PowerPCCPU *cpu,=
 SpaprMachineState *spapr,
>>      rtas_st(rets, 1, 100);
>>  }
>> =20
>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>> +                                  SpaprMachineState *spapr,
>> +                                  uint32_t token, uint32_t nargs,
>> +                                  target_ulong args,
>> +                                  uint32_t nret, target_ulong rets)
>> +{
>> +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
>> +
>> +    if (!rtas_addr) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OF=
F) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
>=20
> Doesn't this need some sanity checks ? At least error out on -1
> which has a special meaning in the code and cannot really be used
> as a valid instruction address.
>=20
> Also PAPR+ says:
>=20
> R1=E2=80=937.3.14=E2=80=936. For the FWNMI option: The Real/Logical add=
ress of the
> registered OS Machine Check and System Reset routines must be in the
>  first 32 MB of the OS=E2=80=99s memory address space.

Yes, we can add a sanity check, but I feel it is not required, as a
guest can still provide a wrong address in the first 32MB address space.

>=20
>=20
> And only at this point you may enable the cap in KVM since the
> guest has decided to use FWNMI.
>=20
> My concern is: what happens when the guest reboots ? We set
> guest_machine_check_addr back to -1 during machine reset but
> KVM still assumes the guest has enabled FWNMI... I see that
> enabling FWNMI boils down to setting a kvm->arch.fwnmi_enabled
> to true... what about providing a way to disable FWNMI ?

When the guest reboots, as per my understanding, FWNMI is still set in
KVM. So a machine check will still cause a guest exit. Upon reboot if
the guest does not call "ibm,nmi-register" then we invoke 0x200
interrupt vector of the guest upon a machine check (because
guest_machine_check_addr is set to -1). If the guest calls
"ibm,nmi-register", then the registered handler is invoked.

And, unfortunately disabling a capability is not supported in KVM.

Regards,
Aravinda

>=20
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   uint32_t token, uint32_t nargs,
>> +                                   target_ulong args,
>> +                                   uint32_t nret, target_ulong rets)
>> +{
>> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
>> +        /* NMI register not called */
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +    } else {
>> +        /*
>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling=
,
>> +         * hence unset mc_status.
>> +         */
>> +        spapr->mc_status =3D -1;
>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +    }
>> +}
>> +
>>  static struct rtas_call {
>>      const char *name;
>>      spapr_rtas_fn fn;
>> @@ -544,6 +586,14 @@ hwaddr spapr_get_rtas_addr(void)
>>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>>  }
>> =20
>> +void spapr_fwnmi_register(void)
>> +{
>> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
>> +                        rtas_ibm_nmi_register);
>> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>> +                        rtas_ibm_nmi_interlock);
>> +}
>> +
>>  static void core_rtas_register_types(void)
>>  {
>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index ffefde7..dada821 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -655,8 +655,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, tar=
get_ulong opcode,
>>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x=
28)
>>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x=
29)
>>  #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x=
2A)
>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x=
2B)
>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x=
2C)
>> =20
>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x=
2B)
>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x=
2D)
>> =20
>>  /* RTAS ibm,get-system-parameter token values */
>>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>> @@ -908,4 +910,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr=
, hwaddr pagesize,
>> =20
>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>>  hwaddr spapr_get_rtas_addr(void);
>> +void spapr_fwnmi_register(void);
>>  #endif /* HW_SPAPR_H */
>>
>=20

--=20
Regards,
Aravinda


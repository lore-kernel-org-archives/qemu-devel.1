Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2059DC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17862073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17862073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fr.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH93P-0008Rw-1A
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@fr.ibm.com>) id 1jH92i-0007jW-R8
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@fr.ibm.com>) id 1jH92h-0005Wu-Df
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:38:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10210
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@fr.ibm.com>) id 1jH92h-0005Wl-90
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:38:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PGaXFx065381
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 12:38:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuwyg1u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 12:38:10 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@fr.ibm.com>;
 Wed, 25 Mar 2020 16:38:05 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 25 Mar 2020 16:38:02 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PGc4hQ51576984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 16:38:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 386874C052;
 Wed, 25 Mar 2020 16:38:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7DBD4C04E;
 Wed, 25 Mar 2020 16:38:03 +0000 (GMT)
Received: from [9.145.25.242] (unknown [9.145.25.242])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2020 16:38:03 +0000 (GMT)
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-5-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@fr.ibm.com>
Date: Wed, 25 Mar 2020 17:38:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325144147.221875-5-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20032516-0008-0000-0000-00000363D044
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032516-0009-0000-0000-00004A854132
Message-Id: <f05aebe9-4a80-1568-1687-e916bd462639@fr.ibm.com>
Subject: Re:  [PATCH 4/5] ppc/spapr: Implement mce injection
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_09:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=944
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250128
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 02PGaXFx065381
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:41 PM, Nicholas Piggin wrote:
> This implements mce injection for spapr.
>=20
>   (qemu) mce 0 0x200000 0x80 0xdeadbeef 1
>=20
>     Disabling lock debugging due to kernel taint
>     MCE: CPU0: machine check (Severe) Host SLB Multihit DAR: 00000000de=
adbeef [Recovered]
>     MCE: CPU0: machine check (Severe) Host SLB Multihit [Recovered]
>     MCE: CPU0: PID: 495 Comm: a NIP: [0000000130ee07c8]
>     MCE: CPU0: Initiator CPU
>     MCE: CPU0: Unknown
> [   71.567193] MCE: CPU0: NIP: [c0000000000d7f6c] plpar_hcall_norets+0x=
1c/0x28
> [   71.567249] MCE: CPU0: Initiator CPU
> [   71.567308] MCE: CPU0: Unknown
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr.c         | 54 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  3 +++
>  2 files changed, 57 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 785c41d205..6dbd1858f4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -83,6 +83,7 @@
>  #include "hw/ppc/spapr_nvdimm.h"
>=20
>  #include "monitor/monitor.h"
> +#include "qapi/qmp/qdict.h"
>=20
>  #include <libfdt.h>
>=20
> @@ -3420,6 +3421,56 @@ static void spapr_nmi(NMIState *n, int cpu_index=
, Error **errp)
>      }
>  }
>=20
> +typedef struct MCEInjectionParams {
> +    uint64_t srr1_mask;
> +    uint32_t dsisr;
> +    uint64_t dar;
> +    bool recovered;
> +} MCEInjectionParams;
> +
> +static void spapr_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
> +{
> +    MCEInjectionParams *params =3D data.host_ptr;
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    CPUPPCState *env =3D &cpu->env;
> +    uint64_t srr1_mce_bits =3D PPC_BITMASK(42, 45) | PPC_BIT(36);
> +
> +    cpu_synchronize_state(cs);
> +
> +    env->spr[SPR_SRR0] =3D env->nip;
> +    env->spr[SPR_SRR1] =3D (env->msr & ~srr1_mce_bits) |
> +                         (params->srr1_mask & srr1_mce_bits);
> +    if (params->dsisr) {
> +        env->spr[SPR_DSISR] =3D params->dsisr;
> +        env->spr[SPR_DAR] =3D params->dar;
> +    }
> +
> +    spapr_mce_req_event(cpu, params->recovered);
> +}
> +
> +static void spapr_mce(MCEState *m, const QDict *qdict, Error **errp)
> +{
> +    int cpu_index =3D qdict_get_int(qdict, "cpu_index");
> +    uint64_t srr1_mask =3D qdict_get_int(qdict, "srr1_mask");
> +    uint32_t dsisr =3D qdict_get_int(qdict, "dsisr");
> +    uint64_t dar =3D qdict_get_int(qdict, "dar");
> +    bool recovered =3D qdict_get_int(qdict, "recovered");
> +    CPUState *cs;
> +
> +    cs =3D qemu_get_cpu(cpu_index);
> +
> +    if (cs !=3D NULL) {
> +        MCEInjectionParams params =3D {
> +            .srr1_mask =3D srr1_mask,
> +            .dsisr =3D dsisr,
> +            .dar =3D dar,
> +            .recovered =3D recovered,
> +        };
> +
> +        run_on_cpu(cs, spapr_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&param=
s));
> +    }
> +}
> +
>  int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **er=
rp)
>  {
> @@ -4467,6 +4518,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(oc);
>      FWPathProviderClass *fwc =3D FW_PATH_PROVIDER_CLASS(oc);
>      NMIClass *nc =3D NMI_CLASS(oc);
> +    MCEClass *mcec =3D MCE_CLASS(oc);
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc=
);
>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> @@ -4511,6 +4563,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler =3D spapr_nmi;
> +    mcec->mce_monitor_handler =3D spapr_mce;
>      smc->phb_placement =3D spapr_phb_placement;
>      vhc->hypercall =3D emulate_spapr_hypercall;
>      vhc->hpt_mask =3D spapr_hpt_mask;
> @@ -4566,6 +4619,7 @@ static const TypeInfo spapr_machine_info =3D {
>      .interfaces =3D (InterfaceInfo[]) {
>          { TYPE_FW_PATH_PROVIDER },
>          { TYPE_NMI },
> +        { TYPE_MCE },
>          { TYPE_HOTPLUG_HANDLER },
>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>          { TYPE_XICS_FABRIC },
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 42d64a0368..72f86a2ee8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -929,4 +929,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr,=
 hwaddr pagesize,
>=20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +
> +void spapr_mce_inject(CPUState *cs, uint64_t srr1_mask, uint32_t dsisr=
,
> +                      uint64_t dar, bool recovered);
>  #endif /* HW_SPAPR_H */
>=20



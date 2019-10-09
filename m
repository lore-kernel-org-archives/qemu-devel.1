Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BFC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2B320B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2B320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iII60-0006Ux-DA
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iIF5G-0001FU-CT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iIF5D-0001PI-HZ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43662
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iIF5D-0001Nn-BM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x99GOcav041908
 for <qemu-devel@nongnu.org>; Wed, 9 Oct 2019 12:45:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vhhgummx9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:45:01 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Wed, 9 Oct 2019 17:44:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Oct 2019 17:44:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x99GisV037486686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Oct 2019 16:44:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D1364203F;
 Wed,  9 Oct 2019 16:44:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6301F4204B;
 Wed,  9 Oct 2019 16:44:54 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Oct 2019 16:44:54 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-2-100.uk.ibm.com [9.145.2.100])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 7E4F2220121;
 Wed,  9 Oct 2019 18:44:53 +0200 (CEST)
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Wed, 9 Oct 2019 18:44:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009060818.29719-18-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19100916-4275-0000-0000-000003708CC1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100916-4276-0000-0000-0000388391EE
Message-Id: <e3ee1543-2993-c2c3-7d9a-2eab96113f89@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090146
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x99GOcav041908
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/2019 08:08, David Gibson wrote:
> The only thing remaining in this structure are the flags to allow eithe=
r
> XICS or XIVE to be present.  These actually make more sense as spapr
> capabilities - that way they can take advantage of the existing
> infrastructure to sanity check capability states across migration and s=
o
> forth.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Nice. That is what you had in mind :) Let's make sure we use your
cap framework for the next major change, power10. ic-mode should
be deprecated one day I suppose.


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.


> ---
>  hw/ppc/spapr.c             | 40 ++++++++++--------
>  hw/ppc/spapr_caps.c        | 64 +++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c       |  7 ++--
>  hw/ppc/spapr_irq.c         | 84 ++------------------------------------
>  include/hw/ppc/spapr.h     | 10 +++--
>  include/hw/ppc/spapr_irq.h | 10 -----
>  6 files changed, 103 insertions(+), 112 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e1ff03152e..bf9fdb1693 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1072,12 +1072,13 @@ static void spapr_dt_ov5_platform_support(Spapr=
MachineState *spapr, void *fdt,
>          26, 0x40, /* Radix options: GTSE =3D=3D yes. */
>      };
> =20
> -    if (spapr->irq->xics && spapr->irq->xive) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +        && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          val[1] =3D SPAPR_OV5_XIVE_BOTH;
> -    } else if (spapr->irq->xive) {
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          val[1] =3D SPAPR_OV5_XIVE_EXPLOIT;
>      } else {
> -        assert(spapr->irq->xics);
> +        assert(spapr_get_cap(spapr, SPAPR_CAP_XICS));
>          val[1] =3D SPAPR_OV5_XIVE_LEGACY;
>      }
> =20
> @@ -2075,6 +2076,8 @@ static const VMStateDescription vmstate_spapr =3D=
 {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_cap_xics,
> +        &vmstate_spapr_cap_xive,
>          NULL
>      }
>  };
> @@ -2775,7 +2778,7 @@ static void spapr_machine_init(MachineState *mach=
ine)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> =20
>      /* advertise XIVE on POWER9 machines */
> -    if (spapr->irq->xive) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>      }
> =20
> @@ -3242,14 +3245,18 @@ static void spapr_set_vsmt(Object *obj, Visitor=
 *v, const char *name,
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
> -    if (spapr->irq =3D=3D &spapr_irq_xics_legacy) {
> +    if (smc->legacy_irq_allocation) {
>          return g_strdup("legacy");
> -    } else if (spapr->irq =3D=3D &spapr_irq_xics) {
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +               && !spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          return g_strdup("xics");
> -    } else if (spapr->irq =3D=3D &spapr_irq_xive) {
> +    } else if (!spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +               && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          return g_strdup("xive");
> -    } else if (spapr->irq =3D=3D &spapr_irq_dual) {
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +               && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          return g_strdup("dual");
>      }
>      g_assert_not_reached();
> @@ -3266,11 +3273,14 @@ static void spapr_set_ic_mode(Object *obj, cons=
t char *value, Error **errp)
> =20
>      /* The legacy IRQ backend can not be set */
>      if (strcmp(value, "xics") =3D=3D 0) {
> -        spapr->irq =3D &spapr_irq_xics;
> +        object_property_set_bool(obj, true, "cap-xics", errp);
> +        object_property_set_bool(obj, false, "cap-xive", errp);
>      } else if (strcmp(value, "xive") =3D=3D 0) {
> -        spapr->irq =3D &spapr_irq_xive;
> +        object_property_set_bool(obj, false, "cap-xics", errp);
> +        object_property_set_bool(obj, true, "cap-xive", errp);
>      } else if (strcmp(value, "dual") =3D=3D 0) {
> -        spapr->irq =3D &spapr_irq_dual;
> +        object_property_set_bool(obj, true, "cap-xics", errp);
> +        object_property_set_bool(obj, true, "cap-xive", errp);
>      } else {
>          error_setg(errp, "Bad value for \"ic-mode\" property");
>      }
> @@ -3309,7 +3319,6 @@ static void spapr_set_host_serial(Object *obj, co=
nst char *value, Error **errp)
>  static void spapr_instance_init(Object *obj)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> -    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      spapr->htab_fd =3D -1;
>      spapr->use_hotplug_event_source =3D true;
> @@ -3345,7 +3354,6 @@ static void spapr_instance_init(Object *obj)
>                               spapr_get_msix_emulation, NULL, NULL);
> =20
>      /* The machine class defines the default interrupt controller mode=
 */
> -    spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>                              spapr_set_ic_mode, NULL);
>      object_property_set_description(obj, "ic-mode",
> @@ -4439,8 +4447,9 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_=
ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_XICS] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_XIVE] =3D SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
> -    smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
>      smc->linux_pci_probe =3D true;
>      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> @@ -4539,7 +4548,7 @@ static void spapr_machine_4_0_class_options(Machi=
neClass *mc)
>      spapr_machine_4_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_le=
n);
>      smc->phb_placement =3D phb_placement_4_0;
> -    smc->irq =3D &spapr_irq_xics;
> +    smc->default_caps.caps[SPAPR_CAP_XIVE] =3D SPAPR_CAP_OFF;
>      smc->pre_4_1_migration =3D true;
>  }
> =20
> @@ -4580,7 +4589,6 @@ static void spapr_machine_3_0_class_options(Machi=
neClass *mc)
> =20
>      smc->legacy_irq_allocation =3D true;
>      smc->nr_xirqs =3D 0x400;
> -    smc->irq =3D &spapr_irq_xics_legacy;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2a27..e06fd386f6 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -496,6 +496,42 @@ static void cap_ccf_assist_apply(SpaprMachineState=
 *spapr, uint8_t val,
>      }
>  }
> =20
> +static void cap_xics_apply(SpaprMachineState *spapr, uint8_t val, Erro=
r **errp)
> +{
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    if (!val) {
> +        if (!spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> +            error_setg(errp,
> +"No interrupt controllers enabled, try cap-xics=3Don or cap-xive=3Don"=
);
> +            return;
> +        }
> +
> +        if (smc->legacy_irq_allocation) {
> +            error_setg(errp, "This machine version requires XICS suppo=
rt");
> +            return;
> +        }
> +    }
> +}
> +
> +static void cap_xive_apply(SpaprMachineState *spapr, uint8_t val, Erro=
r **errp)
> +{
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +
> +    if (val) {
> +        if (smc->legacy_irq_allocation) {
> +            error_setg(errp, "This machine version cannot support XIVE=
");
> +            return;
> +        }
> +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
> +            error_setg(errp, "XIVE requires POWER9 CPU");
> +            return;
> +        }
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -595,6 +631,24 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM=
] =3D {
>          .type =3D "bool",
>          .apply =3D cap_ccf_assist_apply,
>      },
> +    [SPAPR_CAP_XICS] =3D {
> +        .name =3D "xics",
> +        .description =3D "Allow XICS interrupt controller",
> +        .index =3D SPAPR_CAP_XICS,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_xics_apply,
> +    },
> +    [SPAPR_CAP_XIVE] =3D {
> +        .name =3D "xive",
> +        .description =3D "Allow XIVE interrupt controller",
> +        .index =3D SPAPR_CAP_XIVE,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_xive_apply,
> +    },
>  };
> =20
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spap=
r,
> @@ -641,6 +695,14 @@ static SpaprCapabilities default_caps_with_cpu(Spa=
prMachineState *spapr,
>          caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
>      }
> =20
> +    /*
> +     * POWER8 machines don't have XIVE
> +     */
> +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
> +                               0, spapr->max_compat_pvr)) {
> +        caps.caps[SPAPR_CAP_XIVE] =3D SPAPR_CAP_OFF;
> +    }
> +
>      return caps;
>  }
> =20
> @@ -734,6 +796,8 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_=
MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(xics, SPAPR_CAP_XICS);
> +SPAPR_CAP_MIG_STATE(xive, SPAPR_CAP_XIVE);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 140f05c1c6..cb4c6edf63 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1784,13 +1784,13 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>       * terminate the boot.
>       */
>      if (guest_xive) {
> -        if (!spapr->irq->xive) {
> +        if (!spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=3D=
xive or ic-mode=3Ddual machine property");
>              exit(EXIT_FAILURE);
>          }
>      } else {
> -        if (!spapr->irq->xics) {
> +        if (!spapr_get_cap(spapr, SPAPR_CAP_XICS)) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XICS), either don't set t=
he ic-mode machine property or try ic-mode=3Dxics or ic-mode=3Ddual");
>              exit(EXIT_FAILURE);
> @@ -1804,7 +1804,8 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>       */
>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EX=
PLOIT)
> -            && spapr->irq->xics && spapr->irq->xive;
> +            && spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +            && spapr_get_cap(spapr, SPAPR_CAP_XIVE);
>      }
> =20
>      spapr_ovec_cleanup(ov5_updates);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2768f9a765..473fc8780a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -101,90 +101,19 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptCo=
ntroller *, Error **),
>      return 0;
>  }
> =20
> -/*
> - * XICS IRQ backend.
> - */
> -
> -SpaprIrq spapr_irq_xics =3D {
> -    .xics        =3D true,
> -    .xive        =3D false,
> -};
> -
> -/*
> - * XIVE IRQ backend.
> - */
> -
> -SpaprIrq spapr_irq_xive =3D {
> -    .xics        =3D false,
> -    .xive        =3D true,
> -};
> -
> -/*
> - * Dual XIVE and XICS IRQ backend.
> - *
> - * Both interrupt mode, XIVE and XICS, objects are created but the
> - * machine starts in legacy interrupt mode (XICS). It can be changed
> - * by the CAS negotiation process and, in that case, the new mode is
> - * activated after an extra machine reset.
> - */
> -
> -/*
> - * Define values in sync with the XIVE and XICS backend
> - */
> -SpaprIrq spapr_irq_dual =3D {
> -    .xics        =3D true,
> -    .xive        =3D true,
> -};
> -
> -
>  static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> =20
> -    /*
> -     * Sanity checks on non-P9 machines. On these, XIVE is not
> -     * advertised, see spapr_dt_ov5_platform_support()
> -     */
> -    if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_=
3_00,
> -                               0, spapr->max_compat_pvr)) {
> -        /*
> -         * If the 'dual' interrupt mode is selected, force XICS as CAS
> -         * negotiation is useless.
> -         */
> -        if (spapr->irq =3D=3D &spapr_irq_dual) {
> -            spapr->irq =3D &spapr_irq_xics;
> -            return 0;
> -        }
> -
> -        /*
> -         * Non-P9 machines using only XIVE is a bogus setup. We have t=
wo
> -         * scenarios to take into account because of the compat mode:
> -         *
> -         * 1. POWER7/8 machines should fail to init later on when crea=
ting
> -         *    the XIVE interrupt presenters because a POWER9 exception
> -         *    model is required.
> -
> -         * 2. POWER9 machines using the POWER8 compat mode won't fail =
and
> -         *    will let the OS boot with a partial XIVE setup : DT
> -         *    properties but no hcalls.
> -         *
> -         * To cover both and not confuse the OS, add an early failure =
in
> -         * QEMU.
> -         */
> -        if (spapr->irq =3D=3D &spapr_irq_xive) {
> -            error_setg(errp, "XIVE-only machines require a POWER9 CPU"=
);
> -            return -1;
> -        }
> -    }
> -
>      /*
>       * On a POWER9 host, some older KVM XICS devices cannot be destroy=
ed and
>       * re-created. Detect that early to avoid QEMU to exit later when =
the
>       * guest reboots.
>       */
>      if (kvm_enabled() &&
> -        spapr->irq =3D=3D &spapr_irq_dual &&
>          machine_kernel_irqchip_required(machine) &&
> +        spapr_get_cap(spapr, SPAPR_CAP_XICS) &&
> +        spapr_get_cap(spapr, SPAPR_CAP_XIVE) &&
>          xics_kvm_has_broken_disconnect(spapr)) {
>          error_setg(errp, "KVM is too old to support ic-mode=3Ddual,ker=
nel-irqchip=3Don");
>          return -1;
> @@ -280,7 +209,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>      /* Initialize the MSI IRQ allocator. */
>      spapr_irq_msi_init(spapr);
> =20
> -    if (spapr->irq->xics) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XICS)) {
>          Error *local_err =3D NULL;
>          Object *obj;
> =20
> @@ -313,7 +242,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>          spapr->ics =3D ICS_SPAPR(obj);
>      }
> =20
> -    if (spapr->irq->xive) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          uint32_t nr_servers =3D spapr_max_server_number(spapr);
>          DeviceState *dev;
>          int i;
> @@ -558,11 +487,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int n=
um, bool align, Error **errp)
>      return first + ics->offset;
>  }
> =20
> -SpaprIrq spapr_irq_xics_legacy =3D {
> -    .xics        =3D true,
> -    .xive        =3D false,
> -};
> -
>  static void spapr_irq_register_types(void)
>  {
>      type_register_static(&spapr_intc_info);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 623e8e3f93..d3b4dd7de3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -79,8 +79,12 @@ typedef enum {
>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Count Cache Flush Assist HW Instruction */
>  #define SPAPR_CAP_CCF_ASSIST            0x09
> +/* XICS interrupt controller */
> +#define SPAPR_CAP_XICS                  0x0a
> +/* XIVE interrupt controller */
> +#define SPAPR_CAP_XIVE                  0x0b
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_XIVE + 1)
> =20
>  /*
>   * Capability Values
> @@ -131,7 +135,6 @@ struct SpaprMachineClass {
>                            hwaddr *nv2atsd, Error **errp);
>      SpaprResizeHpt resize_hpt_default;
>      SpaprCapabilities default_caps;
> -    SpaprIrq *irq;
>  };
> =20
>  /**
> @@ -195,7 +198,6 @@ struct SpaprMachineState {
> =20
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
> -    SpaprIrq *irq;
>      qemu_irq *qirqs;
>      SpaprInterruptController *active_intc;
>      ICSState *ics;
> @@ -870,6 +872,8 @@ extern const VMStateDescription vmstate_spapr_cap_h=
pt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> +extern const VMStateDescription vmstate_spapr_cap_xics;
> +extern const VMStateDescription vmstate_spapr_cap_xive;
> =20
>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>  {
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5e150a6679..71aee13743 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -77,16 +77,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, ui=
nt32_t num, bool align,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> =20
> -typedef struct SpaprIrq {
> -    bool        xics;
> -    bool        xive;
> -} SpaprIrq;
> -
> -extern SpaprIrq spapr_irq_xics;
> -extern SpaprIrq spapr_irq_xics_legacy;
> -extern SpaprIrq spapr_irq_xive;
> -extern SpaprIrq spapr_irq_dual;
> -
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp);
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
>=20



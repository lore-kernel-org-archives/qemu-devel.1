Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB76C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F4924680
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F4924680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1x1F-0003UO-Db
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1j1x0G-0002T4-Lf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1j1x0F-0004UK-DC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:44:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1j1x0F-0004Q6-87; Wed, 12 Feb 2020 13:44:51 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01CIdWeQ178346; Wed, 12 Feb 2020 13:44:35 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucmse6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2020 13:44:35 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01CIdfXZ178772;
 Wed, 12 Feb 2020 13:44:34 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucmse6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2020 13:44:34 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01CIiBxe003088;
 Wed, 12 Feb 2020 18:44:33 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01wdc.us.ibm.com with ESMTP id 2y1mm76tb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2020 18:44:33 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01CIiXLw59834688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2020 18:44:33 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CC9FC6057;
 Wed, 12 Feb 2020 18:44:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E5E4C6055;
 Wed, 12 Feb 2020 18:44:32 +0000 (GMT)
Received: from localhost (unknown [9.86.26.115])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Feb 2020 18:44:31 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Subject: Re: [PATCH qemu v6 2/6] ppc/spapr: Move GPRs setup to one place
In-Reply-To: <20200203032943.121178-3-aik@ozlabs.ru>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-3-aik@ozlabs.ru>
Date: Wed, 12 Feb 2020 15:44:30 -0300
Message-ID: <87ftffk5m9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-12_08:2020-02-12,
 2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=22 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120133
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> At the moment "pseries" starts in SLOF which only expects the FDT blob
> pointer in r3. As we are going to introduce a OpenFirmware support in
> QEMU, we will be booting OF clients directly and these expect a stack
> pointer in r1, the OF entry point in r5 and in addition to this, Linux
> looks at r3/r4 for the initramdisk location (although vmlinux can find
> this from the device tree but zImage from distro kernels cannot).
>
> This extends spapr_cpu_set_entry_state() to take more registers. This
> should cause no behavioral change.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

> ---
>  include/hw/ppc/spapr_cpu_core.h | 4 +++-
>  hw/ppc/spapr.c                  | 4 ++--
>  hw/ppc/spapr_cpu_core.c         | 7 ++++++-
>  hw/ppc/spapr_rtas.c             | 2 +-
>  4 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 1c4cc6559c52..edd7214fafcf 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
>  } SpaprCpuCoreClass;
>  
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
> -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3);
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> +                               target_ulong r1, target_ulong r3,
> +                               target_ulong r4, target_ulong r5);
>  
>  typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c9b2e0a5e060..660a4b60e072 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1674,8 +1674,8 @@ static void spapr_machine_reset(MachineState *machine)
>      spapr->fdt_blob = fdt;
>  
>      /* Set up the entry state */
> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
> -    first_ppc_cpu->env.gpr[5] = 0;
> +    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
> +                              0, fdt_addr, 0, 0);
>  
>      spapr->cas_reboot = false;
>  
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d09125d9afd4..696b76598dd7 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -84,13 +84,18 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>      spapr_irq_cpu_intc_reset(spapr, cpu);
>  }
>  
> -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> +                               target_ulong r1, target_ulong r3,
> +                               target_ulong r4, target_ulong r5)
>  {
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
>  
>      env->nip = nip;
> +    env->gpr[1] = r1;
>      env->gpr[3] = r3;
> +    env->gpr[4] = r4;
> +    env->gpr[5] = r5;
>      kvmppc_set_reg_ppc_online(cpu, 1);
>      CPU(cpu)->halted = 0;
>      /* Enable Power-saving mode Exit Cause exceptions */
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 656fdd221665..9e3cbd70bbd9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr,
>       */
>      newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
>  
> -    spapr_cpu_set_entry_state(newcpu, start, r3);
> +    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0, 0);
>  
>      qemu_cpu_kick(CPU(newcpu));


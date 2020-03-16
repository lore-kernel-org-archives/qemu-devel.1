Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4023BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FE420719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FE420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu9e-00073E-8u
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mahesh@linux.vnet.ibm.com>) id 1jDte1-0006YE-AR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mahesh@linux.vnet.ibm.com>) id 1jDtdz-0002uh-Gb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:35:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mahesh@linux.vnet.ibm.com>)
 id 1jDtdz-0002nR-2o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:35:15 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02GHWjk1084719
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:35:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrue238ex-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:35:11 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Mar 2020 17:35:09 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Mar 2020 17:35:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02GHY3CT49021232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2020 17:34:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65C714C052;
 Mon, 16 Mar 2020 17:35:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC9584C046;
 Mon, 16 Mar 2020 17:35:02 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.45.53])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 16 Mar 2020 17:35:02 +0000 (GMT)
Date: Mon, 16 Mar 2020 23:05:00 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 7/8] ppc/spapr: Implement FWNMI System Reset delivery
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316142613.121089-8-npiggin@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20031617-0008-0000-0000-0000035E3F42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031617-0009-0000-0000-00004A7F9342
Message-Id: <20200316173500.576hdvush3fzvvef@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-16_07:2020-03-12,
 2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=835 suspectscore=1 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Mon, 16 Mar 2020 13:49:15 -0400
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
Reply-To: mahesh@linux.vnet.ibm.com
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-03-17 00:26:12 Tue, Nicholas Piggin wrote:
> PAPR requires that if "ibm,nmi-register" succeeds, then the hypervisor
> delivers all system reset and machine check exceptions to the registered
> addresses.
> 
> System Resets are delivered with registers set to the architected state,
> and with no interlock.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 25221d843c..78e649f47d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -967,7 +967,29 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
> 
> -    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
> +    /*
> +     * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error log,
> +     * and 16 bytes per CPU for system reset error log plus an extra 8 bytes.
> +     *
> +     * The system reset requirements are driven by existing Linux and PowerVM
> +     * implementation which (contrary to PAPR) saves r3 in the error log
> +     * structure like machine check, so Linux expects to find the saved r3
> +     * value at the address in r3 upon FWNMI-enabled sreset interrupt (and
> +     * does not look at the error value).
> +     *
> +     * System reset interrupts are not subject to interlock like machine
> +     * check, so this memory area could be corrupted if the sreset is
> +     * interrupted by a machine check (or vice versa) if it was shared. To
> +     * prevent this, system reset uses per-CPU areas for the sreset save
> +     * area. A system reset that interrupts a system reset handler could
> +     * still overwrite this area, but Linux doesn't try to recover in that
> +     * case anyway.
> +     *
> +     * The extra 8 bytes is required because Linux's FWNMI error log check
> +     * is off-by-one.
> +     */
> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_ERROR_LOG_MAX +
> +			  ms->smp.max_cpus * sizeof(uint64_t)*2 + sizeof(uint64_t)));

Currently the rtas region is only of size 2048 (i.e RTAS_ERROR_LOG_MAX).
Do we need SLOF change to increase rtas area as well ? Otherwise QEMU
may corrupt guest memory area OR Am I wrong ?

Thanks,
-Mahesh/

>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>                            RTAS_ERROR_LOG_MAX));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
> @@ -3399,8 +3421,28 @@ static void spapr_machine_finalizefn(Object *obj)
> 
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
>  {
> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +
>      cpu_synchronize_state(cs);
> -    ppc_cpu_do_system_reset(cs, -1);
> +    /* If FWNMI is inactive, addr will be -1, which will deliver to 0x100 */
> +    if (spapr->fwnmi_system_reset_addr != -1) {
> +        uint64_t rtas_addr, addr;
> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> +        CPUPPCState *env = &cpu->env;
> +
> +        /* get rtas addr from fdt */
> +        rtas_addr = spapr_get_rtas_addr();
> +        if (!rtas_addr) {
> +            qemu_system_guest_panicked(NULL);
> +            return;
> +        }
> +
> +        addr = rtas_addr + RTAS_ERROR_LOG_MAX + cs->cpu_index * sizeof(uint64_t)*2;
> +        stq_be_phys(&address_space_memory, addr, env->gpr[3]);
> +        stq_be_phys(&address_space_memory, addr + sizeof(uint64_t), 0);
> +        env->gpr[3] = addr;
> +    }
> +    ppc_cpu_do_system_reset(cs, spapr->fwnmi_system_reset_addr);
>  }
> 
>  static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
> -- 
> 2.23.0
> 
> 

-- 
Mahesh J Salgaonkar



Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3811CC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112E32073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112E32073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1xBf-00024x-9K
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1j1xAA-0000K8-WC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1j1xA9-0001iz-MS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:55:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1j1xA9-0001ip-Hr; Wed, 12 Feb 2020 13:55:05 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01CInnmA049314; Wed, 12 Feb 2020 13:55:02 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucmsqvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2020 13:55:01 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01CInrH3049802;
 Wed, 12 Feb 2020 13:55:01 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucmsquv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2020 13:55:01 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01CIsb5p029456;
 Wed, 12 Feb 2020 18:55:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 2y1mm868fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Feb 2020 18:55:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01CIsxkB41943454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2020 18:54:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 706B2112061;
 Wed, 12 Feb 2020 18:54:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAEF6112063;
 Wed, 12 Feb 2020 18:54:58 +0000 (GMT)
Received: from localhost (unknown [9.86.26.115])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Feb 2020 18:54:58 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Subject: Re: [PATCH qemu v6 5/6] spapr: Allow changing offset for -kernel image
In-Reply-To: <20200203032943.121178-6-aik@ozlabs.ru>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-6-aik@ozlabs.ru>
Date: Wed, 12 Feb 2020 15:54:57 -0300
Message-ID: <87d0ajk54u.fsf@linux.ibm.com>
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
 engine=8.12.0-2001150001 definitions=main-2002120134
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

> This allows moving the kernel in the guest memory. The option is useful
> for step debugging (as Linux is linked at 0x0); it also allows loading
> grub which is normally linked to run at 0x20000.
>

+1, as this fixes half of the '-S' debugging issue.

> This uses the existing kernel address by default.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

> ---
>  include/hw/ppc/spapr.h |  1 +
>  hw/ppc/spapr.c         | 38 +++++++++++++++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3b50f36c338a..32e831a395ae 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -164,6 +164,7 @@ struct SpaprMachineState {
>      void *fdt_blob;
>      long kernel_size;
>      bool kernel_le;
> +    uint64_t kernel_addr;
>      uint32_t initrd_base;
>      long initrd_size;
>      uint64_t rtc_offset; /* Now used only during incoming migration */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 60153bf0b771..b59e9dc360fe 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1054,7 +1054,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>      }
>  
>      if (spapr->kernel_size) {
> -        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
> +        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
>                                cpu_to_be64(spapr->kernel_size) };
>  
>          _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
> @@ -1242,7 +1242,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>      /* Build memory reserve map */
>      if (reset) {
>          if (spapr->kernel_size) {
> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
> +                                  spapr->kernel_size)));
>          }
>          if (spapr->initrd_size) {
>              _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
> @@ -1270,7 +1271,9 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>  
>  static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>  {
> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
> +    SpaprMachineState *spapr = opaque;
> +
> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>  }
>  
>  static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
> @@ -2947,14 +2950,15 @@ static void spapr_machine_init(MachineState *machine)
>          uint64_t lowaddr = 0;
>  
>          spapr->kernel_size = load_elf(kernel_filename, NULL,
> -                                      translate_kernel_address, NULL,
> +                                      translate_kernel_address, spapr,
>                                        NULL, &lowaddr, NULL, NULL, 1,
>                                        PPC_ELF_MACHINE, 0, 0);
>          if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
>              spapr->kernel_size = load_elf(kernel_filename, NULL,
> -                                          translate_kernel_address, NULL, NULL,
> +                                          translate_kernel_address, spapr, NULL,
>                                            &lowaddr, NULL, NULL, 0,
> -                                          PPC_ELF_MACHINE, 0, 0);
> +                                          PPC_ELF_MACHINE,
> +                                          0, 0);
>              spapr->kernel_le = spapr->kernel_size > 0;
>          }
>          if (spapr->kernel_size < 0) {
> @@ -2968,7 +2972,7 @@ static void spapr_machine_init(MachineState *machine)
>              /* Try to locate the initrd in the gap between the kernel
>               * and the firmware. Add a bit of space just in case
>               */
> -            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
> +            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
>                                    + 0x1ffff) & ~0xffff;
>              spapr->initrd_size = load_image_targphys(initrd_filename,
>                                                       spapr->initrd_base,
> @@ -3214,6 +3218,18 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
>  
> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> +}
> +
> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> +}
> +
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(obj);
> @@ -3319,6 +3335,14 @@ static void spapr_instance_init(Object *obj)
>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>                               spapr_get_msix_emulation, NULL, NULL);
>  
> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_addr,
> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
> +                        &error_abort);
> +    object_property_set_description(obj, "kernel-addr",
> +                                    stringify(KERNEL_LOAD_ADDR)
> +                                    " for -kernel is the default",
> +                                    NULL);
> +    spapr->kernel_addr = KERNEL_LOAD_ADDR;
>      /* The machine class defines the default interrupt controller mode */
>      spapr->irq = smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,


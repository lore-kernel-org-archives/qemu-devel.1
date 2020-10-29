Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB2C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF3020759
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnZz9Bmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF3020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBQG-0005Ju-S2
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kYBPY-0004ll-Vm
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kYBPW-0002Bf-4X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603991303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+zVOemFiHVTDcIVUt1Y4hBbU2kugiOlwPQQVEZxo/o=;
 b=RnZz9BmfUJAFse8WtYS6SFdoz8WgCsHvcHw02EZlowXmKcoInCl0euC+5GRsydcFB9tbWc
 IRZgQ+gJv6ioNk8TlXNvdHndTJ81lSg9PaTA5AVFbMYl4sZInOo54QBuLGJHZj6y7Iw8E6
 gCQLxiSpWF43uzXuwBnqEo6vywPuANI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Mf_lySZxNdmvUJFN3HCKhA-1; Thu, 29 Oct 2020 13:08:21 -0400
X-MC-Unique: Mf_lySZxNdmvUJFN3HCKhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7580A809DC9;
 Thu, 29 Oct 2020 17:08:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71B5D5C26A;
 Thu, 29 Oct 2020 17:08:16 +0000 (UTC)
Date: Thu, 29 Oct 2020 18:08:13 +0100
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH v2 05/13] hw: add compat machines for 5.3
Message-ID: <20201029170813.n7kst474zrh24m2t@kamzik.brq.redhat.com>
References: <20201020131440.1090-1-fangying1@huawei.com>
 <20201020131440.1090-6-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20201020131440.1090-6-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 09:14:32PM +0800, Ying Fang wrote:
> Add 5.2 machine types for arm/i440fx/q35/s390x/spapr.
      ^ 5.3

Thanks,
drew

> 
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---
>  hw/arm/virt.c              |  9 ++++++++-
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 15 ++++++++++++++-
>  hw/i386/pc_q35.c           | 14 +++++++++++++-
>  hw/ppc/spapr.c             | 15 +++++++++++++--
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  9 files changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ba902b53ba..ff8a14439e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2665,10 +2665,17 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> +static void virt_machine_5_3_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(5, 3)
> +
>  static void virt_machine_5_2_options(MachineClass *mc)
>  {
> +    virt_machine_5_3_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
> +DEFINE_VIRT_MACHINE(5, 2)
>  
>  static void virt_machine_5_1_options(MachineClass *mc)
>  {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 7e2f4ec08e..6dc77699a9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,9 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
>  
> +GlobalProperty hw_compat_5_2[] = { };
> +const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
> +
>  GlobalProperty hw_compat_5_1[] = {
>      { "vhost-scsi", "num_queues", "1"},
>      { "vhost-user-blk", "num-queues", "1"},
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e87be5d29a..eaa046ff5d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -97,6 +97,9 @@
>  #include "trace.h"
>  #include CONFIG_DEVICES
>  
> +GlobalProperty pc_compat_5_2[] = { };
> +const size_t pc_compat_5_2_len = G_N_ELEMENTS(pc_compat_5_2);
> +
>  GlobalProperty pc_compat_5_1[] = {
>      { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
>  };
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3c2ae0612b..01254090ce 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -426,7 +426,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>  }
>  
> -static void pc_i440fx_5_2_machine_options(MachineClass *m)
> +static void pc_i440fx_5_3_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_machine_options(m);
> @@ -435,6 +435,19 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
>      pcmc->default_cpu_version = 1;
>  }
>  
> +DEFINE_I440FX_MACHINE(v5_3, "pc-i440fx-5.3", NULL,
> +                      pc_i440fx_5_3_machine_options);
> +
> +static void pc_i440fx_5_2_machine_options(MachineClass *m)
> +{
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +    pc_i440fx_machine_options(m);
> +    m->alias = NULL;
> +    m->is_default = false;
> +    compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
> +    compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
> +}
> +
>  DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
>                        pc_i440fx_5_2_machine_options);
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index a3f4959c43..dd14803edb 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -344,7 +344,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus = 288;
>  }
>  
> -static void pc_q35_5_2_machine_options(MachineClass *m)
> +static void pc_q35_5_3_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_machine_options(m);
> @@ -352,6 +352,18 @@ static void pc_q35_5_2_machine_options(MachineClass *m)
>      pcmc->default_cpu_version = 1;
>  }
>  
> +DEFINE_Q35_MACHINE(v5_3, "pc-q35-5.3", NULL,
> +                   pc_q35_5_3_machine_options);
> +
> +static void pc_q35_5_2_machine_options(MachineClass *m)
> +{
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +    pc_q35_machine_options(m);
> +    m->alias = NULL;
> +    compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
> +    compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
> +}
> +
>  DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
>                     pc_q35_5_2_machine_options);
>  
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2db810f73a..c292a3edd9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4511,15 +4511,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
>  
> +/*
> + * pseries-5.3
> + */
> +static void spapr_machine_5_3_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(5_3, "5.3", true);
> +
>  /*
>   * pseries-5.2
>   */
>  static void spapr_machine_5_2_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_5_3_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>  }
>  
> -DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
> +DEFINE_SPAPR_MACHINE(5_2, "5.2", false);
>  
>  /*
>   * pseries-5.1
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 28266a3a35..bde084e13d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -789,14 +789,26 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
>  
> +static void ccw_machine_5_3_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_5_3_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(5_3, "5.3", true);
> +
>  static void ccw_machine_5_2_instance_options(MachineState *machine)
>  {
> +    ccw_machine_5_3_instance_options(machine);
>  }
>  
>  static void ccw_machine_5_2_class_options(MachineClass *mc)
>  {
> +    ccw_machine_5_3_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>  }
> -DEFINE_CCW_MACHINE(5_2, "5.2", true);
> +DEFINE_CCW_MACHINE(5_2, "5.2", false);
>  
>  static void ccw_machine_5_1_instance_options(MachineState *machine)
>  {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index bf53e8a16e..f631c1799d 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -311,6 +311,9 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +extern GlobalProperty hw_compat_5_2[];
> +extern const size_t hw_compat_5_2_len;
> +
>  extern GlobalProperty hw_compat_5_1[];
>  extern const size_t hw_compat_5_1_len;
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 84639d0ebc..6f1531ed14 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -190,6 +190,9 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
>  
> +extern GlobalProperty pc_compat_5_2[];
> +extern const size_t pc_compat_5_2_len;
> +
>  extern GlobalProperty pc_compat_5_1[];
>  extern const size_t pc_compat_5_1_len;
>  
> -- 
> 2.23.0
> 
> 



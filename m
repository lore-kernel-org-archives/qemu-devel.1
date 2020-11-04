Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B418C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A200C20759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 19:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpRXB5Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaOw4-00057x-FO
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 14:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaOs4-0002Ls-Iq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 14:55:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kaOs0-0002uJ-95
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 14:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604519698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WVDR+qrn1uPl/IdSrIDhgYC4CSsvJpvEsrOQcI7fxM=;
 b=GpRXB5LplM64eqBkmWH7K2mjQRwr7yTtptCSUlU3knQebN4Jr6LD4pXqQqnR/CGdSPexvA
 XMJV+13auEy/heCm9d8NPsRNvPduEMqvdyvakhDgtnWpmMsp9EXWjoIY1t8QH6Sf/pV9eg
 ztzMnQstA97c53YUSdrRkygJ/Luzxi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-jCtQtYRAP2q8Z_13bOxjhQ-1; Wed, 04 Nov 2020 14:54:54 -0500
X-MC-Unique: jCtQtYRAP2q8Z_13bOxjhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 917F28C88FA;
 Wed,  4 Nov 2020 19:54:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-163.ams2.redhat.com
 [10.36.112.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7887E19C4F;
 Wed,  4 Nov 2020 19:54:46 +0000 (UTC)
Subject: Re: [PATCH v9 2/8] fw_cfg: Write the extra roots into the fw_cfg
To: Jiahui Cen <cenjiahui@huawei.com>, qemu-devel@nongnu.org
References: <20201103120157.2286-1-cenjiahui@huawei.com>
 <20201103120157.2286-3-cenjiahui@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dadc89f2-bff2-358a-b15d-1302018286a5@redhat.com>
Date: Wed, 4 Nov 2020 20:54:45 +0100
MIME-Version: 1.0
In-Reply-To: <20201103120157.2286-3-cenjiahui@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Marcel

On 11/03/20 13:01, Jiahui Cen wrote:
> From: Yubo Miao <miaoyubo@huawei.com>
> 
> Write the extra roots into the fw_cfg, therefore the uefi could
> get the extra roots. Only if the uefi knows there are extra roots,
> the config space of devices behind the root could be obtained.
> 
> Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
> ---
>  hw/arm/virt.c              |  8 ++++++++
>  hw/i386/pc.c               | 18 ++----------------
>  hw/nvram/fw_cfg.c          | 20 ++++++++++++++++++++
>  include/hw/nvram/fw_cfg.h  |  2 ++
>  include/hw/pci/pcie_host.h |  4 ++++
>  5 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 27dbeb549e..58c3695290 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -78,6 +78,8 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/char/pl011.h"
>  #include "qemu/guest-random.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pcie_host.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1463,6 +1465,10 @@ void virt_machine_done(Notifier *notifier, void *data)
>      ARMCPU *cpu = ARM_CPU(first_cpu);
>      struct arm_boot_info *info = &vms->bootinfo;
>      AddressSpace *as = arm_boot_address_space(cpu, info);
> +    PCIHostState *s = PCI_GET_PCIE_HOST_STATE;

(1) Not too happy about this new macro.

For pc/q35, see commit 81ed6482a347 ("hw/i386: extend pxb query for all
PC machines", 2015-12-22).

Any reason the same approach cannot work for "virt"? (I.e., saving root
bus 0 in "vms", like we do now in pc_init1().)

> +
> +    PCIBus *bus = s->bus;
> +    FWCfgState *fw_cfg = vms->fw_cfg;

(2) the helper variables "bus" and "fw_cfg" are almost entirely useless
(they don't save any work whatsoever); please just pass "vms->bus" and
"vms->fw_cfg" to the new helper function below.

>  
>      /*
>       * If the user provided a dtb, we assume the dynamic sysbus nodes
> @@ -1481,6 +1487,8 @@ void virt_machine_done(Notifier *notifier, void *data)
>          exit(1);
>      }
>  
> +    fw_cfg_write_extra_pci_roots(bus, fw_cfg);
> +
>      virt_acpi_setup(vms);
>      virt_build_smbios(vms);
>  }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5e6c0023e0..bdd2301d19 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -778,26 +778,12 @@ void pc_machine_done(Notifier *notifier, void *data)
>                                          PCMachineState, machine_done);
>      X86MachineState *x86ms = X86_MACHINE(pcms);
>      PCIBus *bus = pcms->bus;
> +    FWCfgState *fw_cfg = x86ms->fw_cfg;

(3) Same as (2): "fw_cfg" is useless (especially because you leave other
prior uses of "x86ms->fw_cfg" in this function untouched); furthermore,
the existent "bus" shorthand *becomes* useless with the extraction of
fw_cfg_write_extra_pci_roots(), so "bus" should be deleted when the bus
walking is factored out.

>  
>      /* set the number of CPUs */
>      x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
>  
> -    if (bus) {
> -        int extra_hosts = 0;
> -
> -        QLIST_FOREACH(bus, &bus->child, sibling) {
> -            /* look for expander root buses */
> -            if (pci_bus_is_root(bus)) {
> -                extra_hosts++;
> -            }
> -        }
> -        if (extra_hosts && x86ms->fw_cfg) {
> -            uint64_t *val = g_malloc(sizeof(*val));
> -            *val = cpu_to_le64(extra_hosts);
> -            fw_cfg_add_file(x86ms->fw_cfg,
> -                    "etc/extra-pci-roots", val, sizeof(*val));
> -        }
> -    }
> +    fw_cfg_write_extra_pci_roots(bus, fw_cfg);
>  
>      acpi_setup();
>      if (x86ms->fw_cfg) {
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 08539a1aab..33dcbdd31d 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -40,6 +40,7 @@
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/pci/pci_bus.h"
>  
>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
>  
> @@ -742,6 +743,25 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
>      return ptr;
>  }
>  
> +void fw_cfg_write_extra_pci_roots(PCIBus *bus, FWCfgState *s)
> +{
> +    if (bus) {
> +        int extra_hosts = 0;

(4) I don't understand why we need to remove the empty line after this
declaration. It helps understanding if we have an empty line between
declarations and code.

(5) Simpler to return at once if bus is NULL; the extra nesting is
unjustified in this helper function, which has its own top-level scope.

> +        QLIST_FOREACH(bus, &bus->child, sibling) {
> +            /* look for expander root buses */
> +            if (pci_bus_is_root(bus)) {
> +                extra_hosts++;
> +            }
> +        }
> +        if (extra_hosts && s) {
> +            uint64_t *val = g_malloc(sizeof(*val));
> +            *val = cpu_to_le64(extra_hosts);
> +            fw_cfg_add_file(s,
> +                   "etc/extra-pci-roots", val, sizeof(*val));
> +        }
> +    }
> +}
> +
>  void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
>  {
>      trace_fw_cfg_add_bytes(key, trace_key_name(key), len);
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 8a9f5738bf..0dc75ba6ca 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -104,6 +104,8 @@ struct FWCfgMemState {
>      MemoryRegionOps wide_data_ops;
>  };
>  
> +void fw_cfg_write_extra_pci_roots(PCIBus *bus, FWCfgState *s);
> +
>  /**
>   * fw_cfg_add_bytes:
>   * @s: fw_cfg device being modified

(6) Missing documentation (interface contract).

(7) I suggest calling the function fw_cfg_add_extra_pci_roots(), to
conform to the fw_cfg_add_* pattern.

(8) Also, likely not the best place to introduce this function in the
header file. The function contracts tend to grow in complexity towards
the end of the file. (Note that this applies to the "hw/nvram/fw_cfg.c"
file as well.)

> diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
> index 076457b270..12f48ddd59 100644
> --- a/include/hw/pci/pcie_host.h
> +++ b/include/hw/pci/pcie_host.h
> @@ -27,6 +27,10 @@
>  
>  #define TYPE_PCIE_HOST_BRIDGE "pcie-host-bridge"
>  OBJECT_DECLARE_SIMPLE_TYPE(PCIExpressHost, PCIE_HOST_BRIDGE)
> +#define PCI_GET_PCIE_HOST_STATE \
> +    OBJECT_CHECK(PCIHostState, \
> +                 object_resolve_path_type("", "pcie-host-bridge", NULL), \
> +                 TYPE_PCIE_HOST_BRIDGE)
>  
>  #define PCIE_HOST_MCFG_BASE "MCFG"
>  #define PCIE_HOST_MCFG_SIZE "mcfg_size"
> 

(9) According to (1), I suggest dropping this hunk.

(10) Please split this patch into two patches; the first patch should
factor fw_cfg_add_extra_pci_roots() out of pc_machine_done(), while the
second patch should hook it into the "virt" machine.

Thanks
Laszlo



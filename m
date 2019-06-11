Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB9DC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE3A20673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE3A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hag0v-0000cx-9H
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52743)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hafAo-0007Ph-RD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1haf5u-00085L-7l
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:37:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1haf5u-00084T-1W
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:37:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so2578719wmf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 04:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t4hQ37YoEXlmC6jGUgEKBihosiktPvjtKJFuqH1c+c8=;
 b=oABEt7UElfGFdxdr95+NTtsOc6QgSaK1kOqsyhjRGPzomPemJytEC/hqanmqBoD3Fp
 9x9N9dF6NONxC10H744BDDpqwTrI5FB0HgsINEkQF+LpGyvbQpUxjT86c3YPfQS/SavV
 wHah4kJRtjqOneCOiAUsgwymenRMNKQ1KLsJxzqZ/ud5rIKjDxR97myDg/bwGT+4w3Y9
 OrP/ZUscJ0VFWO4Bwe2xfuqo5DkBTP+wLKXJjl/8snP2evaq1Q/IAppqVTJZSTLUO61A
 pIkWydmG6Ty/DixZyi24FqLWrc1W3D9VKfAWtHue4qWcT0kBYfkOnzsbIogoQMRsmzBK
 er5g==
X-Gm-Message-State: APjAAAX28rzl+O/zO7xVLUhj5gPZnnoQS0WV+ioFT2kDFhBUlAuvaTPA
 l4QI4eT9khqdiYk234Ih4rkFrVDLXrhuyw==
X-Google-Smtp-Source: APXvYqzUGr2t/z/h3XjeMv75Q6OvjjPaM/9SyPRAvYroMLgCsERlMfMpfjRWqngcuZdmJKMituY8Rw==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr18418539wmk.127.1560253056551; 
 Tue, 11 Jun 2019 04:37:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8cc3:8abd:4519:2cd6?
 ([2001:b07:6468:f312:8cc3:8abd:4519:2cd6])
 by smtp.gmail.com with ESMTPSA id t140sm167523wmt.0.2019.06.11.04.37.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 04:37:35 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190607073429.3436-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f69e038a-86e0-a01e-da31-8b608a733eb5@redhat.com>
Date: Tue, 11 Jun 2019 13:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607073429.3436-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2] q35: fix mmconfig and PCI0._CRS
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/06/19 09:34, Gerd Hoffmann wrote:
> This patch changes the handling of the mmconfig area.  Thanks to the
> pci(e) expander devices we already have the logic to exclude address
> ranges from PCI0._CRS.  We can simply add the mmconfig address range
> to the list get it excluded as well.
> 
> With that in place we can go with a fixed pci hole which covers the
> whole area from the end of (low) ram to the ioapic.
> 
> This will make the whole logic alot less fragile.  No matter where the
> firmware places the mmconfig xbar, things should work correctly.  The
> guest also gets a bit more PCI address space (seabios boot):
> 
>     # cat /proc/iomem
>     [ ... ]
>     7ffdd000-7fffffff : reserved
>     80000000-afffffff : PCI Bus 0000:00            <<-- this is new
>     b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
>       b0000000-bfffffff : reserved
>     c0000000-febfffff : PCI Bus 0000:00
>       f8000000-fbffffff : 0000:00:01.0
>     [ ... ]
> 
> So this is a guest visible change.
> 
> Cc: László Érsek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test-allowed-diff.h |  8 +++++++
>  hw/i386/acpi-build.c                  | 14 ++++++++++++
>  hw/pci-host/q35.c                     | 31 +++++++--------------------
>  3 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..3bbd22c62a3b 100644
> --- a/tests/bios-tables-test-allowed-diff.h
> +++ b/tests/bios-tables-test-allowed-diff.h
> @@ -1 +1,9 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT",
> +"tests/data/acpi/q35/DSDT.bridge",
> +"tests/data/acpi/q35/DSDT.mmio64",
> +"tests/data/acpi/q35/DSDT.ipmibt",
> +"tests/data/acpi/q35/DSDT.cphp",
> +"tests/data/acpi/q35/DSDT.memhp",
> +"tests/data/acpi/q35/DSDT.numamem",
> +"tests/data/acpi/q35/DSDT.dimmpxm",
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 85dc1640bc67..8e4f26977619 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -122,6 +122,8 @@ typedef struct FwCfgTPMConfig {
>      uint8_t tpmppi_version;
>  } QEMU_PACKED FwCfgTPMConfig;
>  
> +static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
> +
>  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>  {
>      uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> @@ -1807,6 +1809,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      CrsRangeSet crs_range_set;
>      PCMachineState *pcms = PC_MACHINE(machine);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
> +    AcpiMcfgInfo mcfg;
>      uint32_t nr_mem = machine->ram_slots;
>      int root_bus_limit = 0xFF;
>      PCIBus *bus = NULL;
> @@ -1921,6 +1924,17 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          }
>      }
>  
> +    /*
> +     * At this point crs_range_set has all the ranges used by pci
> +     * busses *other* than PCI0.  These ranges will be excluded from
> +     * the PCI0._CRS.  Add mmconfig to the set so it will be excluded
> +     * too.
> +     */
> +    if (acpi_get_mcfg(&mcfg)) {
> +        crs_range_insert(crs_range_set.mem_ranges,
> +                         mcfg.base, mcfg.base + mcfg.size - 1);
> +    }
> +
>      scope = aml_scope("\\_SB.PCI0");
>      /* build PCI0._CRS */
>      crs = aml_resource_template();
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 960939f5ed3e..72093320befe 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -258,15 +258,6 @@ static void q35_host_initfn(Object *obj)
>      object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
>                               (Object **) &s->mch.address_space_io,
>                               qdev_prop_allow_set_link_before_realize, 0, NULL);
> -
> -    /* Leave enough space for the biggest MCFG BAR */
> -    /* TODO: this matches current bios behaviour, but
> -     * it's not a power of two, which means an MTRR
> -     * can't cover it exactly.
> -     */
> -    range_set_bounds(&s->mch.pci_hole,
> -            MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT + MCH_HOST_BRIDGE_PCIEXBAR_MAX,
> -            IO_APIC_DEFAULT_ADDRESS - 1);
>  }
>  
>  static const TypeInfo q35_host_info = {
> @@ -338,20 +329,6 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>      }
>      addr = pciexbar & addr_mask;
>      pcie_host_mmcfg_update(pehb, enable, addr, length);
> -    /* Leave enough space for the MCFG BAR */
> -    /*
> -     * TODO: this matches current bios behaviour, but it's not a power of two,
> -     * which means an MTRR can't cover it exactly.
> -     */
> -    if (enable) {
> -        range_set_bounds(&mch->pci_hole,
> -                         addr + length,
> -                         IO_APIC_DEFAULT_ADDRESS - 1);
> -    } else {
> -        range_set_bounds(&mch->pci_hole,
> -                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT,
> -                         IO_APIC_DEFAULT_ADDRESS - 1);
> -    }
>  }
>  
>  /* PAM */
> @@ -484,6 +461,14 @@ static void mch_update(MCHPCIState *mch)
>      mch_update_pam(mch);
>      mch_update_smram(mch);
>      mch_update_ext_tseg_mbytes(mch);
> +
> +    /*
> +     * pci hole goes from end-of-low-ram to io-apic.
> +     * mmconfig will be excluded by the dsdt builder.
> +     */
> +    range_set_bounds(&mch->pci_hole,
> +                     mch->below_4g_mem_size,
> +                     IO_APIC_DEFAULT_ADDRESS - 1);
>  }
>  
>  static int mch_post_load(void *opaque, int version_id)
> 

Queued, thanks.

Paolo


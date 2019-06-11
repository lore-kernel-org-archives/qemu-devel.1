Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31888C4321B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F992089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F992089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafuS-0005nm-9Y
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hafY2-0006Qw-37
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hafY0-00033O-M9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:06:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hafY0-00033C-Gy
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:06:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so7407269qkb.13
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 05:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QfDronbcLC4WoXIfaFy+9l26dCDW+cc5nCJ4BkyO8GQ=;
 b=quFklgDhmYRDyXv6wKm9P97+M6meTcf24OyWMcIEnrZhE5G2frLnXIEk+ffNFq1Yog
 CC8lF13pBv/ocG4YmIDAhG4sCYXHhSUmYMZ2DNuGVYNVeFHcCUsCOV0kBPfIKNkInRI2
 wOK/5E22v3b7jOfQtliQc1224xT4Ra7LIIvWKi3WItehoRmVGqcQj2qxZvbtVL+ZhXx5
 a0xmYaXKOa0Tv0mZ6UsCqaWaZYyYPPTYo7lWlXpvHr5HE/jcqUnxWtpgI5me1jqaHb+p
 yFUyaZHN6H1RVdJmX1OngWJ4ppI2PC4mmoWYTnFrxJfFg1zk5VjnVInZnEjZbJ1e6Ojk
 EfSQ==
X-Gm-Message-State: APjAAAUGsWdM+PDiJEnSNTwJhVFVHfepDU7+76YZAREsY4uSyxsCKnAs
 Zgu08ftcAEeOfOc65PX4PMVIvQ==
X-Google-Smtp-Source: APXvYqzPzzEo08qCW8QxnX0DxaWm69SJO3GCQZgcs4X5Ag8tz0vWtZgLA/4luRtXB+/15Spp2A+9Nw==
X-Received: by 2002:a05:620a:102d:: with SMTP id
 a13mr39827076qkk.268.1560254799890; 
 Tue, 11 Jun 2019 05:06:39 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id j26sm7705325qtj.70.2019.06.11.05.06.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 05:06:38 -0700 (PDT)
Date: Tue, 11 Jun 2019 08:06:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190611080542-mutt-send-email-mst@kernel.org>
References: <20190607073429.3436-1-kraxel@redhat.com>
 <f69e038a-86e0-a01e-da31-8b608a733eb5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f69e038a-86e0-a01e-da31-8b608a733eb5@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.196
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
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?B?TOFzemzzIMlyc2Vr?= <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 01:37:35PM +0200, Paolo Bonzini wrote:
> On 07/06/19 09:34, Gerd Hoffmann wrote:
> > This patch changes the handling of the mmconfig area.  Thanks to the
> > pci(e) expander devices we already have the logic to exclude address
> > ranges from PCI0._CRS.  We can simply add the mmconfig address range
> > to the list get it excluded as well.
> > 
> > With that in place we can go with a fixed pci hole which covers the
> > whole area from the end of (low) ram to the ioapic.
> > 
> > This will make the whole logic alot less fragile.  No matter where the
> > firmware places the mmconfig xbar, things should work correctly.  The
> > guest also gets a bit more PCI address space (seabios boot):
> > 
> >     # cat /proc/iomem
> >     [ ... ]
> >     7ffdd000-7fffffff : reserved
> >     80000000-afffffff : PCI Bus 0000:00            <<-- this is new
> >     b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
> >       b0000000-bfffffff : reserved
> >     c0000000-febfffff : PCI Bus 0000:00
> >       f8000000-fbffffff : 0000:00:01.0
> >     [ ... ]
> > 
> > So this is a guest visible change.
> > 
> > Cc: László Érsek <lersek@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/bios-tables-test-allowed-diff.h |  8 +++++++
> >  hw/i386/acpi-build.c                  | 14 ++++++++++++
> >  hw/pci-host/q35.c                     | 31 +++++++--------------------
> >  3 files changed, 30 insertions(+), 23 deletions(-)
> > 
> > diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
> > index dfb8523c8bf4..3bbd22c62a3b 100644
> > --- a/tests/bios-tables-test-allowed-diff.h
> > +++ b/tests/bios-tables-test-allowed-diff.h
> > @@ -1 +1,9 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/q35/DSDT",
> > +"tests/data/acpi/q35/DSDT.bridge",
> > +"tests/data/acpi/q35/DSDT.mmio64",
> > +"tests/data/acpi/q35/DSDT.ipmibt",
> > +"tests/data/acpi/q35/DSDT.cphp",
> > +"tests/data/acpi/q35/DSDT.memhp",
> > +"tests/data/acpi/q35/DSDT.numamem",
> > +"tests/data/acpi/q35/DSDT.dimmpxm",
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 85dc1640bc67..8e4f26977619 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -122,6 +122,8 @@ typedef struct FwCfgTPMConfig {
> >      uint8_t tpmppi_version;
> >  } QEMU_PACKED FwCfgTPMConfig;
> >  
> > +static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
> > +
> >  static void init_common_fadt_data(Object *o, AcpiFadtData *data)
> >  {
> >      uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> > @@ -1807,6 +1809,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      CrsRangeSet crs_range_set;
> >      PCMachineState *pcms = PC_MACHINE(machine);
> >      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
> > +    AcpiMcfgInfo mcfg;
> >      uint32_t nr_mem = machine->ram_slots;
> >      int root_bus_limit = 0xFF;
> >      PCIBus *bus = NULL;
> > @@ -1921,6 +1924,17 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          }
> >      }
> >  
> > +    /*
> > +     * At this point crs_range_set has all the ranges used by pci
> > +     * busses *other* than PCI0.  These ranges will be excluded from
> > +     * the PCI0._CRS.  Add mmconfig to the set so it will be excluded
> > +     * too.
> > +     */
> > +    if (acpi_get_mcfg(&mcfg)) {
> > +        crs_range_insert(crs_range_set.mem_ranges,
> > +                         mcfg.base, mcfg.base + mcfg.size - 1);
> > +    }
> > +
> >      scope = aml_scope("\\_SB.PCI0");
> >      /* build PCI0._CRS */
> >      crs = aml_resource_template();
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index 960939f5ed3e..72093320befe 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -258,15 +258,6 @@ static void q35_host_initfn(Object *obj)
> >      object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
> >                               (Object **) &s->mch.address_space_io,
> >                               qdev_prop_allow_set_link_before_realize, 0, NULL);
> > -
> > -    /* Leave enough space for the biggest MCFG BAR */
> > -    /* TODO: this matches current bios behaviour, but
> > -     * it's not a power of two, which means an MTRR
> > -     * can't cover it exactly.
> > -     */
> > -    range_set_bounds(&s->mch.pci_hole,
> > -            MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT + MCH_HOST_BRIDGE_PCIEXBAR_MAX,
> > -            IO_APIC_DEFAULT_ADDRESS - 1);
> >  }
> >  
> >  static const TypeInfo q35_host_info = {
> > @@ -338,20 +329,6 @@ static void mch_update_pciexbar(MCHPCIState *mch)
> >      }
> >      addr = pciexbar & addr_mask;
> >      pcie_host_mmcfg_update(pehb, enable, addr, length);
> > -    /* Leave enough space for the MCFG BAR */
> > -    /*
> > -     * TODO: this matches current bios behaviour, but it's not a power of two,
> > -     * which means an MTRR can't cover it exactly.
> > -     */
> > -    if (enable) {
> > -        range_set_bounds(&mch->pci_hole,
> > -                         addr + length,
> > -                         IO_APIC_DEFAULT_ADDRESS - 1);
> > -    } else {
> > -        range_set_bounds(&mch->pci_hole,
> > -                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT,
> > -                         IO_APIC_DEFAULT_ADDRESS - 1);
> > -    }
> >  }
> >  
> >  /* PAM */
> > @@ -484,6 +461,14 @@ static void mch_update(MCHPCIState *mch)
> >      mch_update_pam(mch);
> >      mch_update_smram(mch);
> >      mch_update_ext_tseg_mbytes(mch);
> > +
> > +    /*
> > +     * pci hole goes from end-of-low-ram to io-apic.
> > +     * mmconfig will be excluded by the dsdt builder.
> > +     */
> > +    range_set_bounds(&mch->pci_hole,
> > +                     mch->below_4g_mem_size,
> > +                     IO_APIC_DEFAULT_ADDRESS - 1);
> >  }
> >  
> >  static int mch_post_load(void *opaque, int version_id)
> > 
> 
> Queued, thanks.
> 
> Paolo

Paolo I would prefer to queue ACPI changes through my tree.
In particular there's a dance with expected tables I am
still working out.

-- 
MST


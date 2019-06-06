Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35596C28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034B7207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034B7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYswL-0006cg-Ag
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 10:00:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYsvc-0006LB-Az
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYsvb-00024Y-0G
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:59:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYsva-00021o-Rl
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:59:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id u12so2751419qth.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 06:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=SDolrGZBsv3NxYHq5o+X8BbY88/1jWmNQpcUHGUDfFI=;
	b=ABSzFmavWKgnCGKdCfpRYhEaNMUyY7/7j36iGQoHdcSiYazXjZ2c1qxeDm5QgN19ge
	DyKxto3oEYu0+hnWq38nz+fO+yRQww9E9+W8bxHnKt7due1KYADqO8rGPLExddkWWaGC
	jKjFtOidPc2XauFUYlAr2jdBvpgsz4Y62bkA0YGYOZM0K5oo5ThN6xIN0t0ZF7bWZlef
	gdNAapuFc3Xk8TlxnwYZ29M9beFw5SwrYRbwPkiwZrpaiRHN3upRU9DLhya1mKH3T90M
	3DAstgvP5b1OHoew6jJL/A8uXTu0WzZAJyjeSLu4r8mJXK+pGtza/cR+2Yv3nDQxZ1VE
	BCGw==
X-Gm-Message-State: APjAAAUvQ0TapLS4kiQ1EhbHCHzgIwAIGJW2oBJtEB6Z0JAcDGW/hhac
	2nsFFx1Z0KM05l3XpMvTki+XpA==
X-Google-Smtp-Source: APXvYqwrfCr7GF/pHG0sooEwyFKsOJMKsy8rnqsoljMl7KrITua1nGNd+eLAkO1UVTBcmFua5Hgodw==
X-Received: by 2002:ac8:31d6:: with SMTP id i22mr41913364qte.338.1559829578151;
	Thu, 06 Jun 2019 06:59:38 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id p13sm907410qkj.4.2019.06.06.06.59.36
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 06 Jun 2019 06:59:37 -0700 (PDT)
Date: Thu, 6 Jun 2019 09:59:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190606095921-mutt-send-email-mst@kernel.org>
References: <20190528204331.5280-1-kraxel@redhat.com>
	<20190529180324-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529180324-mutt-send-email-mst@kernel.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?iso-8859-1?B?TOFzemzzIMlyc2Vr?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 06:05:41PM -0400, Michael S. Tsirkin wrote:
> On Tue, May 28, 2019 at 10:43:31PM +0200, Gerd Hoffmann wrote:
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
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Hi Gerd!
> Please rebase on top of latest pci tree.
> 
> After the rebase this will start failing since we
> are now asserting on any changes to ACPI tables - and the way to
> fix it is to add a comma-separated list of
> changed ACPI tables to tests/bios-tables-test-allowed-diff.h
> 
> As a maintainer I will notice this and update the expected
> files before pushing.

ping.

> > ---
> >  hw/i386/acpi-build.c | 14 ++++++++++++++
> >  hw/pci-host/q35.c    | 31 ++++++++-----------------------
> >  2 files changed, 22 insertions(+), 23 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 0d78d738948c..abb0e0ce9f27 100644
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
> > -- 
> > 2.18.1


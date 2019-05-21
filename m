Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0506C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7840E217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7840E217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5rO-0007hd-Mc
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:35:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT5qD-0007Km-4h
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT5qB-00033u-Si
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:34:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT5qB-00033c-N5
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:34:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id i26so20673618qtr.10
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=SigsA1sP123ej8F2Zg21FNMenhvWldU7U/vGNqkotXI=;
	b=FAAqsdUoxgZe1T8Nny2+DOii1qbwA4oRm83degFVExZCjZnhSdt10foVPG83REgmVU
	Z9KeRn3vTJNRRpDpI68CGa1Spjb2ALuibgo7lrKOsYiOYyKNJRyCBx4F21cCx+sRp/Ej
	xCF5cgt6YT2Tz88vvWMNeddnt4Dd7I6E3COrCt+HgfVpBfhITLYEi0gPbuC+CvVzdjVo
	hj+GqOUUJHcM910E4vWUhn9kvOelatQ51nCT8HXVA+Ec5opifdO/7aaKT+wUy6hRxtU3
	P1mCXs1ppWNsc8mTL40ABkwOr7a++UnwqZ1P0DQcGaVuqdxdBb59hYsAcfTiQlpvMrim
	Cqwg==
X-Gm-Message-State: APjAAAW6sB0QefNoaP8+Lr+V6cAHWZylLj8M7B3338bIUkxzF+7/wAvb
	xTFVbnTxQuWfZaP1upHNEVeGuw==
X-Google-Smtp-Source: APXvYqx19BKRuoOBO12XE8ICBpfYQiORkSUQt16ZG/MzDG9j1gU5yZtgjY0nr6khWDQA4U07NWWg4w==
X-Received: by 2002:a0c:96b9:: with SMTP id a54mr21171889qvd.135.1558449247015;
	Tue, 21 May 2019 07:34:07 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	s17sm12145560qke.60.2019.05.21.07.34.05
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 07:34:06 -0700 (PDT)
Date: Tue, 21 May 2019 10:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190521103215-mutt-send-email-mst@kernel.org>
References: <20190521033249.1960-1-richardw.yang@linux.intel.com>
	<20190521033249.1960-3-richardw.yang@linux.intel.com>
	<20190520233614-mutt-send-email-mst@kernel.org>
	<20190521162958.4415d4ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521162958.4415d4ac@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v5 2/2] acpi: pci: use build_append_foo()
 API to construct MCFG
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 04:29:58PM +0200, Igor Mammedov wrote:
> On Mon, 20 May 2019 23:37:22 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, May 21, 2019 at 11:32:49AM +0800, Wei Yang wrote:
> > > build_append_foo() API doesn't need explicit endianness conversions
> > > which eliminates a source of errors and it makes build_mcfg() look like
> > > declarative definition of MCFG table in ACPI spec, which makes it easy
> > > to review.
> > > 
> > > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > 
> > > ---
> > > v5:
> > >    * miss the reserved[8] of MCFG in last version, add it back
> > >    * drop SOBs and make sure bios-tables-test all OK
> > > ---  
> > 
> > 
> > Please do not add two --- separators. It breaks git am.
> that worked just fine for the last xx years and still works for me.

Because you don't use git am?
It's true I often am forced to edit your patches to apply them.
Pls do not do this it makes no sense.

> > 
> > One --- should come after the commit log. Anything after that and
> > until diff is ignored anyway.
> That's fine if we wish to commit change log into history, but
> Typically we don't want change log to be committed (as it's useless from history pov),
> hence we put it after separator to get it dropped on applying.

Then you should do

build_append_foo() API doesn't need explicit endianness conversions
which eliminates a source of errors and it makes build_mcfg() look like
declarative definition of MCFG table in ACPI spec, which makes it easy
to review.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---
v5:
   * miss the reserved[8] of MCFG in last version, add it back
   * drop SOBs and make sure bios-tables-test all OK

 hw/acpi/pci.c               | 35 +++++++++++++++++++++++------------
 include/hw/acpi/acpi-defs.h | 18 ------------------
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c


Anything between --- and diff is ignored. Second --- is poointless and
harmful.

> > 
> > >  hw/acpi/pci.c               | 35 +++++++++++++++++++++++------------
> > >  include/hw/acpi/acpi-defs.h | 18 ------------------
> > >  2 files changed, 23 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > > index fa0fa30bb9..49df7b7d54 100644
> > > --- a/hw/acpi/pci.c
> > > +++ b/hw/acpi/pci.c
> > > @@ -30,17 +30,28 @@
> > >  
> > >  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> > >  {
> > > -    AcpiTableMcfg *mcfg;
> > > -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> > > -
> > > -    mcfg = acpi_data_push(table_data, len);
> > > -    mcfg->allocation[0].address = cpu_to_le64(info->base);
> > > -
> > > -    /* Only a single allocation so no need to play with segments */
> > > -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> > > -    mcfg->allocation[0].start_bus_number = 0;
> > > -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
> > > -
> > > -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> > > +    int mcfg_start = table_data->len;
> > > +
> > > +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> > > +
> > > +    /*
> > > +     * PCI Firmware Specification, Revision 3.0
> > > +     * 4.1.2 MCFG Table Description.
> > > +     */
> > > +    /* Reserved */
> > > +    build_append_int_noprefix(table_data, 0, 8);
> > > +    /* Base address, processor-relative */
> > > +    build_append_int_noprefix(table_data, info->base, 8);
> > > +    /* PCI segment group number */
> > > +    build_append_int_noprefix(table_data, 0, 2);
> > > +    /* Starting PCI Bus number */
> > > +    build_append_int_noprefix(table_data, 0, 1);
> > > +    /* Final PCI Bus number */
> > > +    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
> > > +    /* Reserved */
> > > +    build_append_int_noprefix(table_data, 0, 4);
> > > +
> > > +    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> > > +                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
> > >  }
> > >  
> > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > > index f9aa4bd398..57a3f58b0c 100644
> > > --- a/include/hw/acpi/acpi-defs.h
> > > +++ b/include/hw/acpi/acpi-defs.h
> > > @@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
> > >  
> > >  typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
> > >  
> > > -/* PCI fw r3.0 MCFG table. */
> > > -/* Subtable */
> > > -struct AcpiMcfgAllocation {
> > > -    uint64_t address;                /* Base address, processor-relative */
> > > -    uint16_t pci_segment;            /* PCI segment group number */
> > > -    uint8_t start_bus_number;       /* Starting PCI Bus number */
> > > -    uint8_t end_bus_number;         /* Final PCI Bus number */
> > > -    uint32_t reserved;
> > > -} QEMU_PACKED;
> > > -typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
> > > -
> > > -struct AcpiTableMcfg {
> > > -    ACPI_TABLE_HEADER_DEF;
> > > -    uint8_t reserved[8];
> > > -    AcpiMcfgAllocation allocation[0];
> > > -} QEMU_PACKED;
> > > -typedef struct AcpiTableMcfg AcpiTableMcfg;
> > > -
> > >  /*
> > >   * TCPA Description Table
> > >   *
> > > -- 
> > > 2.19.1  


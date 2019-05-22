Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767FDC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A4121019
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A4121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTMXu-0008Bo-Cf
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:24:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTMUy-0006hX-CG
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTMUw-0008Fb-D5
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:21:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hTMUq-00087Z-8s; Wed, 22 May 2019 04:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73DA981E0B;
	Wed, 22 May 2019 08:21:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40B21646DF;
	Wed, 22 May 2019 08:20:54 +0000 (UTC)
Date: Wed, 22 May 2019 10:20:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190522102050.66515aa2@redhat.com>
In-Reply-To: <20190521103215-mutt-send-email-mst@kernel.org>
References: <20190521033249.1960-1-richardw.yang@linux.intel.com>
	<20190521033249.1960-3-richardw.yang@linux.intel.com>
	<20190520233614-mutt-send-email-mst@kernel.org>
	<20190521162958.4415d4ac@redhat.com>
	<20190521103215-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 22 May 2019 08:21:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On Tue, 21 May 2019 10:34:03 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 21, 2019 at 04:29:58PM +0200, Igor Mammedov wrote:
> > On Mon, 20 May 2019 23:37:22 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, May 21, 2019 at 11:32:49AM +0800, Wei Yang wrote:  
> > > > build_append_foo() API doesn't need explicit endianness conversions
> > > > which eliminates a source of errors and it makes build_mcfg() look like
> > > > declarative definition of MCFG table in ACPI spec, which makes it easy
> > > > to review.
> > > > 
> > > > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > 
> > > > ---
> > > > v5:
> > > >    * miss the reserved[8] of MCFG in last version, add it back
> > > >    * drop SOBs and make sure bios-tables-test all OK
> > > > ---    
> > > 
> > > 
> > > Please do not add two --- separators. It breaks git am.  
> > that worked just fine for the last xx years and still works for me.  
> 
> Because you don't use git am?
> It's true I often am forced to edit your patches to apply them.
> Pls do not do this it makes no sense.

I do not use it as much as you, but I do use git am to test patches from
list and it works with double separator as expected (the second separator
is ignored).

> > > One --- should come after the commit log. Anything after that and
> > > until diff is ignored anyway.  
> > That's fine if we wish to commit change log into history, but
> > Typically we don't want change log to be committed (as it's useless from history pov),
> > hence we put it after separator to get it dropped on applying.  
> 
> Then you should do

the problem is that the second separator is added by git, so one
would have to edit it out after format-patch (which is error prone in
case of multi-patch series).

I don't know much about git though, so could you suggest how to handle
situation to avoid the second --- (i.e. how do you do it)?

PS:
There is 'git notes' to add/track per patch annotations, but it a bit
tedious to use notes compared to in-lining change log in commit message.

> build_append_foo() API doesn't need explicit endianness conversions
> which eliminates a source of errors and it makes build_mcfg() look like
> declarative definition of MCFG table in ACPI spec, which makes it easy
> to review.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> v5:
>    * miss the reserved[8] of MCFG in last version, add it back
>    * drop SOBs and make sure bios-tables-test all OK



> 
>  hw/acpi/pci.c               | 35 +++++++++++++++++++++++------------
>  include/hw/acpi/acpi-defs.h | 18 ------------------
>  2 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> 
> 
> Anything between --- and diff is ignored. Second --- is poointless and
> harmful.
> 
> > >   
> > > >  hw/acpi/pci.c               | 35 +++++++++++++++++++++++------------
> > > >  include/hw/acpi/acpi-defs.h | 18 ------------------
> > > >  2 files changed, 23 insertions(+), 30 deletions(-)
> > > > 
> > > > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > > > index fa0fa30bb9..49df7b7d54 100644
> > > > --- a/hw/acpi/pci.c
> > > > +++ b/hw/acpi/pci.c
> > > > @@ -30,17 +30,28 @@
> > > >  
> > > >  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> > > >  {
> > > > -    AcpiTableMcfg *mcfg;
> > > > -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> > > > -
> > > > -    mcfg = acpi_data_push(table_data, len);
> > > > -    mcfg->allocation[0].address = cpu_to_le64(info->base);
> > > > -
> > > > -    /* Only a single allocation so no need to play with segments */
> > > > -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> > > > -    mcfg->allocation[0].start_bus_number = 0;
> > > > -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
> > > > -
> > > > -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> > > > +    int mcfg_start = table_data->len;
> > > > +
> > > > +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> > > > +
> > > > +    /*
> > > > +     * PCI Firmware Specification, Revision 3.0
> > > > +     * 4.1.2 MCFG Table Description.
> > > > +     */
> > > > +    /* Reserved */
> > > > +    build_append_int_noprefix(table_data, 0, 8);
> > > > +    /* Base address, processor-relative */
> > > > +    build_append_int_noprefix(table_data, info->base, 8);
> > > > +    /* PCI segment group number */
> > > > +    build_append_int_noprefix(table_data, 0, 2);
> > > > +    /* Starting PCI Bus number */
> > > > +    build_append_int_noprefix(table_data, 0, 1);
> > > > +    /* Final PCI Bus number */
> > > > +    build_append_int_noprefix(table_data, PCIE_MMCFG_BUS(info->size - 1), 1);
> > > > +    /* Reserved */
> > > > +    build_append_int_noprefix(table_data, 0, 4);
> > > > +
> > > > +    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
> > > > +                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
> > > >  }
> > > >  
> > > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > > > index f9aa4bd398..57a3f58b0c 100644
> > > > --- a/include/hw/acpi/acpi-defs.h
> > > > +++ b/include/hw/acpi/acpi-defs.h
> > > > @@ -449,24 +449,6 @@ struct AcpiSratProcessorGiccAffinity {
> > > >  
> > > >  typedef struct AcpiSratProcessorGiccAffinity AcpiSratProcessorGiccAffinity;
> > > >  
> > > > -/* PCI fw r3.0 MCFG table. */
> > > > -/* Subtable */
> > > > -struct AcpiMcfgAllocation {
> > > > -    uint64_t address;                /* Base address, processor-relative */
> > > > -    uint16_t pci_segment;            /* PCI segment group number */
> > > > -    uint8_t start_bus_number;       /* Starting PCI Bus number */
> > > > -    uint8_t end_bus_number;         /* Final PCI Bus number */
> > > > -    uint32_t reserved;
> > > > -} QEMU_PACKED;
> > > > -typedef struct AcpiMcfgAllocation AcpiMcfgAllocation;
> > > > -
> > > > -struct AcpiTableMcfg {
> > > > -    ACPI_TABLE_HEADER_DEF;
> > > > -    uint8_t reserved[8];
> > > > -    AcpiMcfgAllocation allocation[0];
> > > > -} QEMU_PACKED;
> > > > -typedef struct AcpiTableMcfg AcpiTableMcfg;
> > > > -
> > > >  /*
> > > >   * TCPA Description Table
> > > >   *
> > > > -- 
> > > > 2.19.1    



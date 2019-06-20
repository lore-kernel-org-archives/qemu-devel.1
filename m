Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D53DC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5319B20673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5319B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzA5-0000IL-Fh
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hdypq-00061K-9g
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hdycz-0003Ry-M8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hdycx-0002KN-36
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:05:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E8F481F0C;
 Thu, 20 Jun 2019 15:04:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4244F5D9C6;
 Thu, 20 Jun 2019 15:04:34 +0000 (UTC)
Date: Thu, 20 Jun 2019 17:04:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190620170429.7237cfa1@redhat.com>
In-Reply-To: <20190620141842.ijqwozpjrkccy7qx@master>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
 <20190618175956.4373ac7e@redhat.com>
 <20190619062050.GA15665@richard>
 <20190619110440.13a54848@redhat.com>
 <20190620141842.ijqwozpjrkccy7qx@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 20 Jun 2019 15:04:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] hw/acpi: make build_madt arch
 agnostic
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
Cc: yang.zhong@intel.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Jun 2019 14:18:42 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> On Wed, Jun 19, 2019 at 11:04:40AM +0200, Igor Mammedov wrote:
> >On Wed, 19 Jun 2019 14:20:50 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >  
> >> On Tue, Jun 18, 2019 at 05:59:56PM +0200, Igor Mammedov wrote:  
> >> >
> >> >On Mon, 13 May 2019 14:19:04 +0800
> >> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >> >    
> >> >> Now MADT is highly depend in architecture and machine type and leaves
> >> >> duplicated code in different architecture. The series here tries to generalize
> >> >> it.
> >> >> 
> >> >> MADT contains one main table and several sub tables. These sub tables are
> >> >> highly related to architecture. Here we introduce one method to make it
> >> >> architecture agnostic.
> >> >> 
> >> >>   * each architecture define its sub-table implementation function in madt_sub
> >> >>   * introduces struct madt_input to collect sub table information and pass to
> >> >>     build_madt
> >> >> 
> >> >> By doing so, each architecture could prepare its own sub-table implementation
> >> >> and madt_input. And keep build_madt architecture agnostic.    
> >> >
> >> >I've skimmed over patches, and to me it looks mostly as code movement
> >> >without apparent benefits and probably a bit more complex than what we have now
> >> >(it might be ok cost if it simplifies MADT support for other boards).
> >> >
> >> >Before I do line by line review could you demonstrate what effect new way
> >> >to build MADT would have on arm/virt and i386/virt (from NEMU). So it would be
> >> >possible to estimate net benefits from new approach?
> >> >(PS: it doesn't have to be patches ready for merging, just a dirty hack
> >> >that would demonstrate adding MADT for new board using mad_sub[])
> >> >    
> >> 
> >> Per APIC spec 5.2.12, MADT contains a *main* table and several *sub* tables
> >> (Interrupt Controllere), so the idea is give a callback hook in
> >> AcpiDeviceIfClass for each table, including *main* and *sub* table.
> >> 
> >> Current AcpiDeviceIfClass has one callback pc_madt_cpu_entry for some *sub*
> >> tables, after replacing the AcpiDeviceIfClass will look like this:
> >> 
> >> typedef struct AcpiDeviceIfClass {
> >>     /* <private> */
> >>     InterfaceClass parent_class;
> >> 
> >>     /* <public> */
> >>     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
> >>     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
> >> -   void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
> >> -                    const CPUArchIdList *apic_ids, GArray *entry);
> >> +   madt_operation madt_main;
> >> +   madt_operation *madt_sub;
> >> } AcpiDeviceIfClass;
> >> 
> >> By doing so, each arch could have its own implementation for MADT.
> >> 
> >> After this refactoring, build_madt could be simplified to:
> >> 
> >> build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms,
> >>            struct madt_input *input)
> >> {
> >>     ...
> >> 
> >>     if (adevc->madt_main) {
> >>         adevc->madt_main(table_data, madt);
> >>     }
> >> 
> >>     for (i = 0; ; i++) {
> >>         sub_id = input[i].sub_id;
> >>         if (sub_id == ACPI_APIC_RESERVED) {
> >>             break;
> >>         }
> >>         opaque = input[i].opaque;
> >>         adevc->madt_sub[sub_id](table_data, opaque);
> >>     }
> >> 
> >>     ...
> >> }
> >> 
> >> input is a list of data necessary to build *sub* table. Its details is also
> >> arch dependent.  
> >I've got general idea reading patches in this series.
> >As I've mentioned before it's hard to generalize MADT since it
> >mostly contains entries unique for target/board.
> >Goal here isn't generalizing at any cost, but rather find out
> >if there is enough common code to justify generalization
> >and if it allows us to reduce code duplication and simplify.
> >  
> >> For following new arch, what it need to do is prepare the input array and
> >> implement necessary *main*/*sub* table callbacks.  
> >What I'd like to see is the actual patch that does this,
> >to see if it has any merit and to compare to the current
> >approach.  
> 
> I didn't get some idea about your approach. Would you mind sharing more light?
With current approach, 'each board' has its own MADT build routine.
Considering that there is very little to share between different
implementations it might be ok.

This series just add extra data structure for board to populate
and a bunch of callbacks for every record type. Essentially all
the code we have now is still there. It was just moved elsewhere
and made available via callbacks.
This series touches only pc/q35 machines and it's not apparent
to me why it's any better than what we have now.



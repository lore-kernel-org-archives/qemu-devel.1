Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C2C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141042075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he7t8-0005uX-Cr
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 20:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1he7rz-0005B1-6c
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1he7rv-00008t-Ey
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:57:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:1141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1he7rn-0008Iz-An
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:57:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 17:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; d="scan'208";a="171063044"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2019 17:57:07 -0700
Date: Fri, 21 Jun 2019 08:56:44 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190621005644.GA10591@richard>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
 <20190618175956.4373ac7e@redhat.com>
 <20190619062050.GA15665@richard>
 <20190619110440.13a54848@redhat.com>
 <20190620141842.ijqwozpjrkccy7qx@master>
 <20190620170429.7237cfa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620170429.7237cfa1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: yang.zhong@intel.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, Wei Yang <richard.weiyang@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 05:04:29PM +0200, Igor Mammedov wrote:
>On Thu, 20 Jun 2019 14:18:42 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Wed, Jun 19, 2019 at 11:04:40AM +0200, Igor Mammedov wrote:
>> >On Wed, 19 Jun 2019 14:20:50 +0800
>> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >  
>> >> On Tue, Jun 18, 2019 at 05:59:56PM +0200, Igor Mammedov wrote:  
>> >> >
>> >> >On Mon, 13 May 2019 14:19:04 +0800
>> >> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >> >    
>> >> >> Now MADT is highly depend in architecture and machine type and leaves
>> >> >> duplicated code in different architecture. The series here tries to generalize
>> >> >> it.
>> >> >> 
>> >> >> MADT contains one main table and several sub tables. These sub tables are
>> >> >> highly related to architecture. Here we introduce one method to make it
>> >> >> architecture agnostic.
>> >> >> 
>> >> >>   * each architecture define its sub-table implementation function in madt_sub
>> >> >>   * introduces struct madt_input to collect sub table information and pass to
>> >> >>     build_madt
>> >> >> 
>> >> >> By doing so, each architecture could prepare its own sub-table implementation
>> >> >> and madt_input. And keep build_madt architecture agnostic.    
>> >> >
>> >> >I've skimmed over patches, and to me it looks mostly as code movement
>> >> >without apparent benefits and probably a bit more complex than what we have now
>> >> >(it might be ok cost if it simplifies MADT support for other boards).
>> >> >
>> >> >Before I do line by line review could you demonstrate what effect new way
>> >> >to build MADT would have on arm/virt and i386/virt (from NEMU). So it would be
>> >> >possible to estimate net benefits from new approach?
>> >> >(PS: it doesn't have to be patches ready for merging, just a dirty hack
>> >> >that would demonstrate adding MADT for new board using mad_sub[])
>> >> >    
>> >> 
>> >> Per APIC spec 5.2.12, MADT contains a *main* table and several *sub* tables
>> >> (Interrupt Controllere), so the idea is give a callback hook in
>> >> AcpiDeviceIfClass for each table, including *main* and *sub* table.
>> >> 
>> >> Current AcpiDeviceIfClass has one callback pc_madt_cpu_entry for some *sub*
>> >> tables, after replacing the AcpiDeviceIfClass will look like this:
>> >> 
>> >> typedef struct AcpiDeviceIfClass {
>> >>     /* <private> */
>> >>     InterfaceClass parent_class;
>> >> 
>> >>     /* <public> */
>> >>     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
>> >>     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
>> >> -   void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
>> >> -                    const CPUArchIdList *apic_ids, GArray *entry);
>> >> +   madt_operation madt_main;
>> >> +   madt_operation *madt_sub;
>> >> } AcpiDeviceIfClass;
>> >> 
>> >> By doing so, each arch could have its own implementation for MADT.
>> >> 
>> >> After this refactoring, build_madt could be simplified to:
>> >> 
>> >> build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms,
>> >>            struct madt_input *input)
>> >> {
>> >>     ...
>> >> 
>> >>     if (adevc->madt_main) {
>> >>         adevc->madt_main(table_data, madt);
>> >>     }
>> >> 
>> >>     for (i = 0; ; i++) {
>> >>         sub_id = input[i].sub_id;
>> >>         if (sub_id == ACPI_APIC_RESERVED) {
>> >>             break;
>> >>         }
>> >>         opaque = input[i].opaque;
>> >>         adevc->madt_sub[sub_id](table_data, opaque);
>> >>     }
>> >> 
>> >>     ...
>> >> }
>> >> 
>> >> input is a list of data necessary to build *sub* table. Its details is also
>> >> arch dependent.  
>> >I've got general idea reading patches in this series.
>> >As I've mentioned before it's hard to generalize MADT since it
>> >mostly contains entries unique for target/board.
>> >Goal here isn't generalizing at any cost, but rather find out
>> >if there is enough common code to justify generalization
>> >and if it allows us to reduce code duplication and simplify.
>> >  
>> >> For following new arch, what it need to do is prepare the input array and
>> >> implement necessary *main*/*sub* table callbacks.  
>> >What I'd like to see is the actual patch that does this,
>> >to see if it has any merit and to compare to the current
>> >approach.  
>> 
>> I didn't get some idea about your approach. Would you mind sharing more light?
>With current approach, 'each board' has its own MADT build routine.
>Considering that there is very little to share between different
>implementations it might be ok.
>
>This series just add extra data structure for board to populate
>and a bunch of callbacks for every record type. Essentially all
>the code we have now is still there. It was just moved elsewhere
>and made available via callbacks.

Yes, you are right.

>This series touches only pc/q35 machines and it's not apparent
>to me why it's any better than what we have now.

This is the demo for i386. In case you think this approach is reasonable, it
could be applied to arm. And then for new board, we can apply the same
approach.

-- 
Wei Yang
Help you, Help me


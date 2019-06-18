Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A97BC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21270206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21270206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHPT-0001Wf-Bl
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43657)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hdGX0-0005tG-B6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hdGWz-00021G-41
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hdGWy-0001z3-TG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:00:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE5A63092674;
 Tue, 18 Jun 2019 16:00:10 +0000 (UTC)
Received: from localhost (ovpn-204-73.brq.redhat.com [10.40.204.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F8025C221;
 Tue, 18 Jun 2019 16:00:01 +0000 (UTC)
Date: Tue, 18 Jun 2019 17:59:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190618175956.4373ac7e@redhat.com>
In-Reply-To: <20190513061913.9284-1-richardw.yang@linux.intel.com>
References: <20190513061913.9284-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 16:00:11 +0000 (UTC)
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
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On Mon, 13 May 2019 14:19:04 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> Now MADT is highly depend in architecture and machine type and leaves
> duplicated code in different architecture. The series here tries to generalize
> it.
> 
> MADT contains one main table and several sub tables. These sub tables are
> highly related to architecture. Here we introduce one method to make it
> architecture agnostic.
> 
>   * each architecture define its sub-table implementation function in madt_sub
>   * introduces struct madt_input to collect sub table information and pass to
>     build_madt
> 
> By doing so, each architecture could prepare its own sub-table implementation
> and madt_input. And keep build_madt architecture agnostic.

I've skimmed over patches, and to me it looks mostly as code movement
without apparent benefits and probably a bit more complex than what we have now
(it might be ok cost if it simplifies MADT support for other boards).

Before I do line by line review could you demonstrate what effect new way
to build MADT would have on arm/virt and i386/virt (from NEMU). So it would be
possible to estimate net benefits from new approach?
(PS: it doesn't have to be patches ready for merging, just a dirty hack
that would demonstrate adding MADT for new board using mad_sub[])

> 
> Wei Yang (9):
>   hw/acpi: expand pc_madt_cpu_entry in place
>   hw/acpi: implement madt_sub[ACPI_APIC_PROCESSOR]
>   hw/acpi: implement madt_sub[ACPI_APIC_LOCAL_X2APIC]
>   hw/acpi: implement madt_sub[ACPI_APIC_IO]
>   hw/acpi: implement madt_sub[ACPI_APIC_XRUPT_OVERRIDE]
>   hw/acpi: implement madt_sub[ACPI_APIC_LOCAL_X2APIC_NMI]
>   hw/acpi: implement madt_sub[ACPI_APIC_LOCAL_NMI]
>   hw/acpi: factor build_madt with madt_input
>   hw/acpi: implement madt_main to manipulate main madt table
> 
>  hw/acpi/cpu.c                        |  14 +-
>  hw/acpi/piix4.c                      |   3 +-
>  hw/i386/acpi-build.c                 | 265 +++++++++++++++++----------
>  hw/isa/lpc_ich9.c                    |   3 +-
>  include/hw/acpi/acpi_dev_interface.h |  12 +-
>  include/hw/i386/pc.h                 |   2 +
>  6 files changed, 194 insertions(+), 105 deletions(-)
> 



Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D6C48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B106D205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B106D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkPfD-0002zD-S5
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hkPeL-0002Pq-Qx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hkPeK-0001Ih-L9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hkPeK-0001Hq-FJ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:09:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2E7A3086218;
 Mon,  8 Jul 2019 09:09:26 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3403D5D9E5;
 Mon,  8 Jul 2019 09:09:25 +0000 (UTC)
Date: Mon, 8 Jul 2019 11:09:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190708110920.40204b47@redhat.com>
In-Reply-To: <77ae1297-edb1-dcb2-b57e-e9e01b64139a@intel.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
 <20190614155626.27932-7-tao3.xu@intel.com>
 <20190701132532.2699a98a@redhat.com>
 <77ae1297-edb1-dcb2-b57e-e9e01b64139a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 08 Jul 2019 09:09:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 6/8] hmat acpi: Build Memory Subsystem
 Address Range Structure(s) in ACPI HMAT
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 16:50:24 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 7/1/2019 7:25 PM, Igor Mammedov wrote:
> > On Fri, 14 Jun 2019 23:56:24 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >   
> ...
> >> @@ -2710,6 +2711,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> >>               acpi_add_table(table_offsets, tables_blob);
> >>               build_slit(tables_blob, tables->linker, machine);
> >>           }
> >> +        acpi_add_table(table_offsets, tables_blob);
> >> +        build_hmat(tables_blob, tables->linker, machine);  
> > I'm not sure if we should add it unconditionally.
> > Is this table used in any meaningful manner by guest when
> > it's incomplete (i.e. populated only with SPA records)?
> >   
> Hi Igor,
> 
> In ACPI 6.2, the linux kernel use it to show the memory ranges' 
> node-id(Proximity Domain). In ACPI 6.3, the linux kernel use it to show 
> the numa node's closest initiator(Generic Initiator or Processor, directly
> attached). It is useful for a memory only numa node, because with 
> SPA(renamed as "Memory Proximity Domain Attributes Structure" in ACPI 
> 6.3) the user-space can know the topology of hardware heterogeneous 
> memory. I think I should add a doc to describe the use case in QEMU.
Could you point out to me the specific kernel code that parses and uses HMAT?

> 
> Therefore, the numa CLI may be lack of a input which can indicate the 
> Initiator of a memory only numa node. Dan suggested me to add a new 
> parameter for that[1].
> 
> Maybe like:
> -numa node,mem=4G,nodeid=2,initiator=0
> 
> [1] https://patchwork.kernel.org/cover/10934417/
> 
> Thanks
> 
> Tao
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 



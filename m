Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7619C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD0B218D1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD0B218D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWjet-0003zn-QI
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:41:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hWjeB-0003aH-2u
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hWje4-0003Pk-9C
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:40:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hWjdt-0003Cm-8j
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2497E30BBE9F;
	Fri, 31 May 2019 15:40:11 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59FC67C582;
	Fri, 31 May 2019 15:40:05 +0000 (UTC)
Date: Fri, 31 May 2019 09:40:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Message-ID: <20190531094002.29030716@x1.home>
In-Reply-To: <MN2PR02MB620549D68EB53487C6FCF51F8B190@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62053CE40CA6B4A97B32FA048B190@MN2PR02MB6205.namprd02.prod.outlook.com>
	<20190531083732.37ecbb1e@x1.home>
	<MN2PR02MB620549D68EB53487C6FCF51F8B190@MN2PR02MB6205.namprd02.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 31 May 2019 15:40:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QEMU tries to register to VFIO memory that is not
 RAM
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Swapnil Ingle <swapnil.ingle@nutanix.com>,
	Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 15:28:07 +0000
Thanos Makatos <thanos.makatos@nutanix.com> wrote:

> > > When configuring device pass-through via VFIO to a VM, I noticed that
> > > QEMU tries to register (DMA_MAP) all memory regions of a guest (not
>                 > > only RAM). That includes firmware regions like "pc.rom". Would a
> > > physical device ever need access to those?  
> >
> > Probably not, but are those things not in the address space of the
> > device on a physical system?  
> 
> They are. I'm wondering whether it makes sense in a virtualized environment.
> 
> >  
> > > Am I missing something?  
> >
> > Does this cause a problem?  
> 
> It does in my use case. We're experimenting with devices backed by another
> userspace application. We can configure QEMU to allocate shared memory
> (MAP_SHARED) for guest RAM (which we can register in the other process) but not
> for anything else.
> 
> >  It's not always easy to identify regions
> > that should not be mapped to a device, clearly we're not going to
> > create a whitelist based on the name of the region.  Thanks,  
> 
> Indeed. Could we decide whether or not to register an address space with
> VFIO in a more intelligent manner? E.g. the following simplistic patch solves
> our problem:
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4374cc6176..d9d3b1277a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -430,6 +430,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      VFIOHostDMAWindow *hostwin;
>      bool hostwin_found;
> 
> +    if (!section->mr->ram_device)
> +        return;
> +

Nope, this would prevent IOMMU mapping of assigned device MMIO regions
which would prevent peer-to-peer DMA between assigned devices.  Thanks,

Alex


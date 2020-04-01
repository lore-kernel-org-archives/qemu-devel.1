Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7354BC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 06:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B8F206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 06:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B8F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXJW-00032l-Fd
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 02:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJXIk-0002Tx-ES
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJXIj-0002a3-F2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:56:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:59380)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jJXIj-0002U8-6h
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:56:37 -0400
IronPort-SDR: OHOESvMjfU/DPJUQr2fb8jhdzzYgrW28QZY6r3S8zOR7WcuQWgRCr4nsB3TRY64nBOJf0WUrOO
 oZ6GkKMZMGlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 23:56:35 -0700
IronPort-SDR: ZHKo9NcYFHvR5O+ioN9XsHH48rSCXdD89IM4iaA2SaxBGa14zLbOHSjreSNEIRn5VQTr353E4K
 vvYD8nJMIEVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="422594453"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005.jf.intel.com with ESMTP; 31 Mar 2020 23:56:34 -0700
Date: Wed, 1 Apr 2020 02:47:00 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/vfio: let readonly flag take effect for mmaped regions
Message-ID: <20200401064700.GH6631@joy-OptiPlex-7040>
References: <20200327111934.71066-1-yan.y.zhao@intel.com>
 <11c90e84-6c0c-9411-0d6c-7955136413c6@redhat.com>
 <c4eb2313-96b3-7e76-f48c-0059a40eabf7@redhat.com>
 <9fddfb1f-2ab2-1b67-9e52-e0e522b0aca3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fddfb1f-2ab2-1b67-9e52-e0e522b0aca3@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 03:59:02PM +0800, Philippe Mathieu-Daudé wrote:
> On 3/27/20 5:17 PM, Paolo Bonzini wrote:
> > On 27/03/20 11:51, Philippe Mathieu-Daudé wrote:
> >>>    diff --git a/memory.c b/memory.c
> >>> index 601b749906..4b1071dc74 100644
> >>> --- a/memory.c
> >>> +++ b/memory.c
> >>> @@ -1313,6 +1313,9 @@ static void memory_region_ram_device_write(void
> >>> *opaque, hwaddr addr,
> >>>        MemoryRegion *mr = opaque;
> >>>          trace_memory_region_ram_device_write(get_cpu_index(), mr,
> >>> addr, data, size);
> >>> +    if (mr->readonly) {
> >>> +        return;
> >>> +    }
> >>
> >> Shouldn't this be in memory_region_dispatch_write()?
> > 
> > No, in general you want memory regions to get writes, so that they
> > become for example a machine-check exception of some sorts.  However,
> > memory_region_ram_device_write should probably be changed to a
> > .write_with_attrs operation, so that it can return MEMTX_ERROR.
> > 
> >> Please split this patch in 2, this (generic) hunk as first patch, then
> >> the VFIO more specific change.
> >>
> >>>          switch (size) {
> >>>        case 1:
> >>>
> >>
> > 
> > No need, I can just add my Acked-by for Alex to pick up the patch.
> 
> Having 2 different fix in 2 different patches helps when cherry-picking 
> (bisecting, backporting...) and reverting. My 2 cents anyway.
ok. I can seperate it in patch v2.

Thanks for your input:)



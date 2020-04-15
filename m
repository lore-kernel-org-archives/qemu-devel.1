Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEEC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F015020768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F015020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdQq-0001Uz-4M
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOdQ7-0000ea-Ns
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOdQ6-0002xS-Ki
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:61444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jOdQ6-0002wa-Cy
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:18 -0400
IronPort-SDR: OujNwXwoNnK57wV/aytZwQ5Re/QiznMj++hT6E+EOr2uuJp6QmOEkqjoHir3lcmvn1vfFtDKRu
 GZGCaJFfdS+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 01:29:17 -0700
IronPort-SDR: 4nfTuhY9ZpcYE/nLXBRtxMcHATvsxOT9XU+W4c1t/tkx8hfzt/cFDLQngr7LJ0BTtlAE5ToWvN
 68QJ9bNR920w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="277543555"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2020 01:29:15 -0700
Date: Wed, 15 Apr 2020 04:19:37 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200415081937.GH10586@joy-OptiPlex-7040>
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
 <20200413063713.84659-1-yan.y.zhao@intel.com>
 <36cbf8f3-65e6-936f-6278-ab45dc470b02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cbf8f3-65e6-936f-6278-ab45dc470b02@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 05:35:22PM +0800, Philippe Mathieu-Daudé wrote:
> On 4/13/20 8:37 AM, Yan Zhao wrote:
> > for ram device regions, drop guest writes if the regions is read-only.
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > ---
> >   memory.c     | 6 +++++-
> >   trace-events | 2 +-
> >   2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/memory.c b/memory.c
> > index 601b749906..a380b59980 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1312,7 +1312,11 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> >   {
> >       MemoryRegion *mr = opaque;
> >   
> > -    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
> > +    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data,
> > +                                         size, mr->readonly);
> > +    if (mr->readonly) {
> 
>             qemu_log_mask(LOG_GUEST_ERROR, ...)?
>
ok. will add it in next version.

Thanks
Yan

> > +        return;
> > +    }
> >   
> >       switch (size) {
> >       case 1:
> > diff --git a/trace-events b/trace-events
> > index 42107ebc69..e1de662973 100644
> > --- a/trace-events
> > +++ b/trace-events
> > @@ -61,7 +61,7 @@ memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value,
> >   memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> >   memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
> >   memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> > -memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> > +memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size, bool readonly) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u" " is_readonly_region=%d"
> >   flatview_new(void *view, void *root) "%p (root %p)"
> >   flatview_destroy(void *view, void *root) "%p (root %p)"
> >   flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
> > 
> 


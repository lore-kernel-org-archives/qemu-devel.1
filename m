Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C00C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC30220784
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC30220784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdRn-0002fk-12
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOdQT-0001CU-Dt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jOdQS-0003F6-Cv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:61287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jOdQS-0003Dq-3j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:29:40 -0400
IronPort-SDR: iN8wq2x1ORtPJaMQDbhwKCWWuMoiWMw9QCYaKkjlxZzjCktzsb0FQJj1L8eRSlj5AE1JvUqbGn
 D+VEQDkeiJeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 01:29:38 -0700
IronPort-SDR: EkMz3UsYNqC04ddmiE2HBeDWWwkSAlKTVIokEmwotXRaiKZHnazE37sml1YPxzu4DBlzG/9nJa
 14cTfs9H3OnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="277543630"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2020 01:29:36 -0700
Date: Wed, 15 Apr 2020 04:19:58 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 3/3] hw/vfio: let read-only flag take effect for
 mmap'd regions
Message-ID: <20200415081958.GI10586@joy-OptiPlex-7040>
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
 <20200413063747.84753-1-yan.y.zhao@intel.com>
 <c2a0631b-4c2a-6b46-ec11-cd247b751dae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2a0631b-4c2a-6b46-ec11-cd247b751dae@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.43
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

On Tue, Apr 14, 2020 at 05:37:58PM +0800, Philippe Mathieu-Daudé wrote:
> On 4/13/20 8:37 AM, Yan Zhao wrote:
> > along side setting host page table to be read-only, the memory regions
> > are also required to be read-only, so that when guest writes to the
> > read-only & mmap'd regions, vmexits would happen and region write handlers
> > are called.
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> > ---
> >   hw/vfio/common.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index fd6ee1fe3e..fc7618e041 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -977,6 +977,10 @@ int vfio_region_mmap(VFIORegion *region)
> >                                             name, region->mmaps[i].size,
> >                                             region->mmaps[i].mmap);
> >           g_free(name);
> > +
> > +        if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> > +            memory_region_set_readonly(&region->mmaps[i].mem, true);
> > +        }
> >           memory_region_add_subregion(region->mem, region->mmaps[i].offset,
> >                                       &region->mmaps[i].mem);
> >   
> > 
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!


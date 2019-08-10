Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F82AC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 21:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDF8208C3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 21:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDF8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwZ2Y-0007qI-7h
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 17:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bo.liu@linux.alibaba.com>) id 1hwZ1x-0007Pg-A0
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 17:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bo.liu@linux.alibaba.com>) id 1hwZ1v-0004Rr-Dk
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 17:36:05 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bo.liu@linux.alibaba.com>)
 id 1hwZ1v-0004P8-3H
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 17:36:03 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07486; MF=bo.liu@linux.alibaba.com; NM=1;
 PH=DS; RN=4; SR=0; TI=SMTPD_---0TZ7877c_1565472956; 
Received: from US-160370MP2.local(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0TZ7877c_1565472956) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 11 Aug 2019 05:35:58 +0800
Date: Sat, 10 Aug 2019 14:35:55 -0700
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20190810213555.hqdkm4yio4asnh5t@US-160370MP2.local>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
 <20190808095316.GC2852@work-vm> <20190808125320.GB3147@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808125320.GB3147@redhat.com>
User-Agent: NeoMutt/20180323
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
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
Reply-To: bo.liu@linux.alibaba.com
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 08, 2019 at 08:53:20AM -0400, Vivek Goyal wrote:
> On Thu, Aug 08, 2019 at 10:53:16AM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> > > > Kernel also serializes MAP/UNMAP on one inode. So you will need to run
> > > > multiple jobs operating on different inodes to see parallel MAP/UNMAP
> > > > (atleast from kernel's point of view).
> > > 
> > > Okay, there is still room to experiment with how MAP and UNMAP are
> > > handled by virtiofsd and QEMU even if the host kernel ultimately becomes
> > > the bottleneck.
> > > 
> > > One possible optimization is to eliminate REMOVEMAPPING requests when
> > > the guest driver knows a SETUPMAPPING will follow immediately.  I see
> > > the following request pattern in a fio randread iodepth=64 job:
> > > 
> > >   unique: 995348, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
> > >   lo_setupmapping(ino=135, fi=0x(nil), foffset=3860856832, len=2097152, moffset=859832320, flags=0)
> > >      unique: 995348, success, outsize: 16
> > >   unique: 995350, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
> > >      unique: 995350, success, outsize: 16
> > >   unique: 995352, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
> > >   lo_setupmapping(ino=135, fi=0x(nil), foffset=16777216, len=2097152, moffset=861929472, flags=0)
> > >      unique: 995352, success, outsize: 16
> > >   unique: 995354, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
> > >      unique: 995354, success, outsize: 16
> > >   virtio_send_msg: elem 9: with 1 in desc of length 16
> > >   unique: 995356, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
> > >   lo_setupmapping(ino=135, fi=0x(nil), foffset=383778816, len=2097152, moffset=864026624, flags=0)
> > >      unique: 995356, success, outsize: 16
> > >   unique: 995358, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
> > > 
> > > The REMOVEMAPPING requests are unnecessary since we can map over the top
> > > of the old mapping instead of taking the extra step of removing it
> > > first.
> > 
> > Yep, those should go - I think Vivek likes to keep them for testing
> > since they make things fail more completely if there's a screwup.
> 
> I like to keep them because otherwise they keep the resources busy
> on host. If DAX range is being used immediately, then this optimization
> makes more sense. I will keep this in mind.
>

Other than the resource not being released, do you think there'll be
any stale data problem if we don't do removemapping at all, neither
background reclaim nor inline reclaim?
(truncate/punch_hole/evict_inode still needs to remove mapping though)

thanks,
-liubo

> > 
> > > Some more questions to consider for DAX performance optimization:
> > > 
> > > 1. Is FUSE_READ/FUSE_WRITE more efficient than DAX for some I/O patterns?
> > 
> > Probably for cases where the data is only accessed once, and you can't
> > preemptively map.
> > Another variant on (1) is whether we could do read/writes while the mmap
> > is happening to absorb the latency.
> 
> For small random I/O, dax might not be very effective. Overhead of
> setting up mapping and tearing it down is significant.
> 
> Vivek
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B5C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F13221479
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F13221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvf7M-0005SD-Vj
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54663)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvf6s-0004Zt-M1
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvf6r-000693-Di
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvf6r-00068O-5k
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:53:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EABA612AC9
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 09:53:23 +0000 (UTC)
Received: from work-vm (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D3119C7F;
 Thu,  8 Aug 2019 09:53:18 +0000 (UTC)
Date: Thu, 8 Aug 2019 10:53:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190808095316.GC2852@work-vm>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808090213.GD31476@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 08 Aug 2019 09:53:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> > Kernel also serializes MAP/UNMAP on one inode. So you will need to run
> > multiple jobs operating on different inodes to see parallel MAP/UNMAP
> > (atleast from kernel's point of view).
> 
> Okay, there is still room to experiment with how MAP and UNMAP are
> handled by virtiofsd and QEMU even if the host kernel ultimately becomes
> the bottleneck.
> 
> One possible optimization is to eliminate REMOVEMAPPING requests when
> the guest driver knows a SETUPMAPPING will follow immediately.  I see
> the following request pattern in a fio randread iodepth=64 job:
> 
>   unique: 995348, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
>   lo_setupmapping(ino=135, fi=0x(nil), foffset=3860856832, len=2097152, moffset=859832320, flags=0)
>      unique: 995348, success, outsize: 16
>   unique: 995350, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
>      unique: 995350, success, outsize: 16
>   unique: 995352, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
>   lo_setupmapping(ino=135, fi=0x(nil), foffset=16777216, len=2097152, moffset=861929472, flags=0)
>      unique: 995352, success, outsize: 16
>   unique: 995354, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
>      unique: 995354, success, outsize: 16
>   virtio_send_msg: elem 9: with 1 in desc of length 16
>   unique: 995356, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
>   lo_setupmapping(ino=135, fi=0x(nil), foffset=383778816, len=2097152, moffset=864026624, flags=0)
>      unique: 995356, success, outsize: 16
>   unique: 995358, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
> 
> The REMOVEMAPPING requests are unnecessary since we can map over the top
> of the old mapping instead of taking the extra step of removing it
> first.

Yep, those should go - I think Vivek likes to keep them for testing
since they make things fail more completely if there's a screwup.

> Some more questions to consider for DAX performance optimization:
> 
> 1. Is FUSE_READ/FUSE_WRITE more efficient than DAX for some I/O patterns?

Probably for cases where the data is only accessed once, and you can't
preemptively map.
Another variant on (1) is whether we could do read/writes while the mmap
is happening to absorb the latency.

> 2. Can MAP/UNMAP be performed directly in QEMU via a separate virtqueue?

I think there's two things to solve here that I don't currently know the
answer to:
  2a) We'd need to get the fd to qemu for the thing to mmap;
      we might be able to cache the fd on the qemu side for existing
      mappings, so when asking for a new mapping for an existing file then
      it would already have the fd.

  2b) Running a device with a mix of queues inside QEMU and on
      vhost-user; I don't think we have anything with that mix
 
> 3. Can READ/WRITE be performed directly in QEMU via a separate virtqueue
>    to eliminate the bad address problem?

Are you thinking of doing all read/writes that way, or just the corner
cases? It doesn't seem worth it for the corner cases unless you're
finding them cropping up in real work loads.

> 4. Can OPEN+MAP be fused into a single request for small files, avoiding
>    the 2nd request?

Sounds possible.

> I'm not going to tackle DAX optimization myself right now but wanted to
> share these ideas.

One I was thinking about that feels easier than (2) was to change the
vhost slave protocol to be split transaction; it wouldn't do anything
for the latency but it would be able to do some in parallel if we can
get the kernel to feed it.

Dave

> Stefan



> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


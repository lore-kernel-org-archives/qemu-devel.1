Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33BC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D89A2173C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D89A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvT0N-0000wn-M6
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vgoyal@redhat.com>) id 1hvSzs-0000Wp-0q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1hvSzq-000896-Vr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:57:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1hvSzq-00085l-Qb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA2CE30FB8C5
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 20:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB4C7600C6;
 Wed,  7 Aug 2019 20:57:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6BC2022377E; Wed,  7 Aug 2019 16:57:15 -0400 (EDT)
Date: Wed, 7 Aug 2019 16:57:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190807205715.GE18557@redhat.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807180355.GA22758@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 07 Aug 2019 20:57:20 +0000 (UTC)
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 07:03:55PM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 01, 2019 at 05:54:05PM +0100, Stefan Hajnoczi wrote:
> > Performance
> > -----------
> > Please try these patches out and share your results.
> 
> Here are the performance numbers:
> 
>   Threadpool | iodepth | iodepth
>      size    |    1    |   64
>   -----------+---------+--------
>   None       |   4451  |  4876
>   1          |   4360  |  4858
>   64         |   4359  | 33,266
> 
> A graph is available here:
> https://vmsplice.net/~stefan/virtiofsd-threadpool-performance.png
> 
> Summary:
> 
>  * iodepth=64 performance is increased by 6.8 times.
>  * iodepth=1 performance degrades by 2%.
>  * DAX is bottlenecked by QEMU's single-threaded
>    VHOST_USER_SLAVE_FS_MAP/UNMAP handler.
> 
> Threadpool size "none" is virtiofsd commit 813a824b707 ("virtiofsd: use
> fuse_lowlevel_is_virtio() in fuse_session_destroy()") without any of the
> multithreading preparation patches.  I benchmarked this to check whether
> the patches introduce a regression for iodepth=1.  They do, but it's
> only around 2%.
> 
> I also ran with DAX but found there was not much difference between
> iodepth=1 and iodepth=64.  This might be because the host mmap(2)
> syscall becomes the bottleneck and a serialization point.  QEMU only
> processes one VHOST_USER_SLAVE_FS_MAP/UNMAP at a time.  If we want to
> accelerate DAX it may be necessary to parallelize mmap, assuming the
> host kernel can do them in parallel on a single file.  This performance
> optimization is future work and not directly related to this patch
> series.

Good to see nice improvement with higher queue depth.

Kernel also serializes MAP/UNMAP on one inode. So you will need to run
multiple jobs operating on different inodes to see parallel MAP/UNMAP
(atleast from kernel's point of view).

Thanks
Vivek


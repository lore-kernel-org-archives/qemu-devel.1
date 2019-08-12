Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110E6C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB060206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB060206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9nf-00077u-3b
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hx9nB-0006Ig-I9
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hx9n9-0003BN-Re
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hx9n7-00039l-T1
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:51:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB702300C22C;
 Mon, 12 Aug 2019 12:51:11 +0000 (UTC)
Received: from work-vm (ovpn-117-191.ams2.redhat.com [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F24927CD8F;
 Mon, 12 Aug 2019 12:51:05 +0000 (UTC)
Date: Mon, 12 Aug 2019 13:51:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190812125103.GC2703@work-vm>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
 <20190808095316.GC2852@work-vm>
 <20190809082102.GB25286@stefanha-x1.localdomain>
 <277d9cd6-a8fa-fa1f-9cbc-7a7cd0897c84@huawei.com>
 <20190812100546.GB9959@stefanha-x1.localdomain>
 <d2dde785-5b25-751f-0385-8c229fc03e57@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2dde785-5b25-751f-0385-8c229fc03e57@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 12:51:11 +0000 (UTC)
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
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* piaojun (piaojun@huawei.com) wrote:
> 
> 
> On 2019/8/12 18:05, Stefan Hajnoczi wrote:
> > On Sun, Aug 11, 2019 at 10:26:18AM +0800, piaojun wrote:
> >> On 2019/8/9 16:21, Stefan Hajnoczi wrote:
> >>> On Thu, Aug 08, 2019 at 10:53:16AM +0100, Dr. David Alan Gilbert wrote:
> >>>> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> >>>>> On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> >>>>> 3. Can READ/WRITE be performed directly in QEMU via a separate virtqueue
> >>>>>    to eliminate the bad address problem?
> >>>>
> >>>> Are you thinking of doing all read/writes that way, or just the corner
> >>>> cases? It doesn't seem worth it for the corner cases unless you're
> >>>> finding them cropping up in real work loads.
> >>>
> >>> Send all READ/WRITE requests to QEMU instead of virtiofsd.
> >>>
> >>> Only handle metadata requests in virtiofsd (OPEN, RELEASE, READDIR,
> >>> MKDIR, etc).
> >>>
> >>
> >> Sorry for not catching your point, and I like the virtiofsd to do
> >> READ/WRITE requests and qemu handle metadata requests, as virtiofsd is
> >> good at processing dataplane things due to thread-pool and CPU
> >> affinity(maybe in the future). As you said, virtiofsd is just acting as
> >> a vhost-user device which should care less about ctrl request.
> >>
> >> If our concern is improving mmap/write/read performance, why not adding
> >> a delay worker for unmmap which could decrease the ummap times. Maybe
> >> virtiofsd could still handle both data and meta requests by this way.
> > 
> > Doing READ/WRITE in QEMU solves the problem that vhost-user slaves only
> > have access to guest RAM regions.  If a guest transfers other memory,
> > like an address in the DAX Window, to/from the vhost-user device then
> > virtqueue buffer address translation fails.
> > 
> > Dave added a code path that bounces such accesses through the QEMU
> > process using the VHOST_USER_SLAVE_FS_IO slavefd request, but it would
> > be simpler, faster, and cleaner to do I/O in QEMU in the first place.
> > 
> > What I don't like about moving READ/WRITE into QEMU is that we need to
> > use even more virtqueues for multiqueue operation :).
> > 
> > Stefan
> 
> Thanks for your detailed explanation. If DAX is not good at small files,
> shall we just let the users choose the I/O path according to their user
> cases?

The problem is how/when to decide and where to keep policy like that.
My understanding is it's also tricky to flip in the kernel from DAX to
non-DAX for any one file.

So without knowing access patterns it's tricky.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


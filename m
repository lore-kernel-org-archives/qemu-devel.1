Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28171C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03FC20644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03FC20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htC34-0004J4-7n
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54216)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1htC2X-0003t7-MR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1htC2W-0000ju-BC
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1htC2W-0000jQ-3y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:26:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F9E230BD1DA
 for <qemu-devel@nongnu.org>; Thu,  1 Aug 2019 14:26:43 +0000 (UTC)
Received: from work-vm (ovpn-117-184.ams2.redhat.com [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE7545D9CA;
 Thu,  1 Aug 2019 14:26:39 +0000 (UTC)
Date: Thu, 1 Aug 2019 15:26:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190801142637.GJ2773@work-vm>
References: <5D3F8F04.3030404@huawei.com>
 <4ec43f2f-1d72-5fe1-3b93-2c75ee6f87b4@redhat.com>
 <20190801142016.GI2773@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801142016.GI2773@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 14:26:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH] virtiofsd: fix compile error
 if 'F_OFD_GETLK' not defined
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

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Eric Blake (eblake@redhat.com) wrote:
> > On 7/29/19 7:27 PM, piaojun wrote:
> > > Use F_GETLK for fcntl when F_OFD_GETLK not defined.
> > 
> > Which system are you hitting this problem on?
> > 
> > The problem with F_GETLK is that it is NOT as safe as F_OFD_GETLK.
> > 
> > We already have fcntl_op_getlk and qemu_probe_lock_ops() in util/osdep.c
> > to not only determine which form to use, but also to emit a warning to
> > the end user if we had to fall back to the unsafe F_GETLK. Why is your
> > code not reusing that logic?
> > 
> > > 
> > > Signed-off-by: Jun Piao <piaojun@huawei.com>
> > > ---
> > >  contrib/virtiofsd/passthrough_ll.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> > > index 9ae1381..757785b 100644
> > > --- a/contrib/virtiofsd/passthrough_ll.c
> > > +++ b/contrib/virtiofsd/passthrough_ll.c
> > > @@ -1619,7 +1619,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino,
> > >  		return;
> > >  	}
> > > 
> > > +#ifdef F_OFD_GETLK
> > >  	ret = fcntl(plock->fd, F_OFD_GETLK, lock);
> > > +#else
> > > +	ret = fcntl(plock->fd, F_GETLK, lock);
> > > +#endif
> > 
> > Hmm. Since this is in contrib, you are trying to compile something that
> > is independent of util/osdep.c (at least, I assume that's the case, as
> > contrib/virtiofsd/ is not even part of qemu.git master yet - in which
> > case, why is this not being squashed in to the patch introducing that
> > file, rather than sent standalone).  On the other hand, that raises the
> > question - who is trying to use virtiofsd on a kernel that is too old to
> > provid F_OFD_GETLK?  Isn't the whole point of virtiofsd to be speeding
> > up modern usage, at which point an old kernel is just gumming up the
> > works?  It seems like you are better off letting compilation fail on a
> > system that is too old to support decent F_OFD_GETLK, rather than
> > silently falling back to something that is unsafe.
> 
> It is, but I guess the answer here is someone wanted to build on RHEL7.

although looking at the tools it went in 7.6

Dave

> Dave
> 
> > 
> > -- 
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.           +1-919-301-3226
> > Virtualization:  qemu.org | libvirt.org
> > 
> 
> 
> 
> 
> > _______________________________________________
> > Virtio-fs mailing list
> > Virtio-fs@redhat.com
> > https://www.redhat.com/mailman/listinfo/virtio-fs
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


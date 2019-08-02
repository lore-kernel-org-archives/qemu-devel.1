Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD44C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09D72064A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09D72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htVTK-00062c-3R
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1htVSQ-0005DP-80
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1htVSP-0003nv-0M
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1htVSO-0003n7-OB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:10:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDAD3308219E;
 Fri,  2 Aug 2019 11:10:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-44.ams2.redhat.com [10.36.112.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 650D3600D1;
 Fri,  2 Aug 2019 11:10:38 +0000 (UTC)
Date: Fri, 2 Aug 2019 12:10:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190802111034.GC30115@redhat.com>
References: <5D43F688.8000607@huawei.com>
 <20190802105352.GF2899@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802105352.GF2899@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 02 Aug 2019 11:10:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtiofsd: fix compile error if
 'F_OFD_GETLK' not defined
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: piaojun <piaojun@huawei.com>, virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 11:53:52AM +0100, Dr. David Alan Gilbert wrote:
> * piaojun (piaojun@huawei.com) wrote:
> > Use F_GETLK for fcntl when F_OFD_GETLK not defined, such as kernel 3.10.
> > 
> > Signed-off-by: Jun Piao <piaojun@huawei.com>
> 
> 
> > ---
> > v2:
> > - Use F_OFD_SETLK to replace F_OFD_GETLK in #ifdef.
> > 
> > ---
> >  contrib/virtiofsd/passthrough_ll.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> > index a81c01d..c69f2f3 100644
> > --- a/contrib/virtiofsd/passthrough_ll.c
> > +++ b/contrib/virtiofsd/passthrough_ll.c
> > @@ -1780,7 +1780,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino,
> >  		goto out;
> >  	}
> > 
> > +#ifdef F_OFD_GETLK
> >  	ret = fcntl(plock->fd, F_OFD_GETLK, lock);
> > +#else
> > +	ret = fcntl(plock->fd, F_GETLK, lock);
> > +#endif
> >  	if (ret == -1)
> >  		saverr = errno;
> > 
> > @@ -1831,7 +1835,11 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,
> > 
> >  	/* TODO: Is it alright to modify flock? */
> >  	lock->l_pid = 0;
> > +#ifdef F_OFD_SETLK
> >  	ret = fcntl(plock->fd, F_OFD_SETLK, lock);
> > +#else
> > +	ret = fcntl(plock->fd, F_GETLK, lock);
>                                ^^^^^^^
> 
> Typo! You've got GETLK rather than SETLK.
> 
> But, a bigger question - does this actually work!
> The manpage says:
>    'If a process closes any file descriptor referring to a file, then
>    all of the process's locks on that file are released, regardless of the
>    file descriptor(s) on which the locks were obtained.'
> 
> the fd we're using here came from lookup_create_plock_ctx which did
> a new openat to get this fd; so we've already got multiple fd's
> referring to this file; and thus I worry we're going to close
> one of them and lose all our locks on it.

Yeah, this is what makes F_GETLK/F_SETLK such an awful thing to
use. It is just about managable if an app is single threaded
and the developer can examine all code paths to make sure there
are no other open FDs referring to the same underling file.
If code has multiple FDs open, and/or is a multithreaded app,
F_SETLK is really fragile / error prone.

In QEMU proper, we used the fallback to F_GETLK/F_SETLK because
we were adding locking to existing features. If we didn't have
the fallback then we would either be breaking existing usage by
mandating OFD locks, or leaving those users with no locking at
all by disabling locking entirely.

For a program like virtiofsd that is brand new functionality
we don't have to worry about breaking existing users. Thus I
would strongly recommend we just mandate OFD locks, and entirely
disable the build of virtiofsd if OFD is missing on the host.

RHEL-7's 3.10 kernel *does* have OFD locking as it was backported
and QEMU in RHEL-7 already uses this. Users just need to make
sure they have updates applied to their RHEL-7 hosts to get this.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


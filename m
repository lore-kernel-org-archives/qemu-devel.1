Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D987AFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE802089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE802089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Uu-00084Z-8V
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iL7ed-0008CG-FD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iL7eb-0001Ce-Tz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iL7eb-0001Aq-ON
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:25:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0602B30832C0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:25:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69D8619C7F;
 Thu, 17 Oct 2019 15:25:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 0031A2202E5; Thu, 17 Oct 2019 11:25:22 -0400 (EDT)
Date: Thu, 17 Oct 2019 11:25:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Message-ID: <20191017152522.GB12588@redhat.com>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 17 Oct 2019 15:25:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 01:23:57PM +0200, Miklos Szeredi wrote:
> On Thu, Oct 17, 2019 at 12:05 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Wed, Oct 16, 2019 at 07:37:52PM +0900, Misono Tomohiro wrote:
> > > Hello,
> > >
> > > I test xattr operation on virtiofs using xfstest generic/062
> > > (with -o xattr option and XFS backend) and see some problems.
> > >
> > > These patches fixes the two of the problems.
> > >
> > > The remaining problems are:
> > >  1. we cannot xattr to block device created by mknod
> > >     which does not have actual device (since open in virtiofsd fails)
> > >  2. we cannot xattr to symbolic link
> > >
> > > I don't think 1 is a big problem but can we fix 2?
> >
> > Sorry, I don't know the answer.  Maybe it would be necessary to add a
> > new O_SYMLINK open flag to open(2) so that fgetxattr()/fsetxattr()
> > operations can be performed.  A kernel change like that would take some
> > time to get accepted upstream and shipped by distros, but it might be
> > the only way since the current syscall interface doesn't seem to offer a
> > way to do this.
> 
> The real problem is that open() on a non-regular, non-directory file
> may have side effects (unless O_PATH is used).  These patches try to
> paper over that, but the fact is: opening special files from a file
> server is forbidden.
> 
> I see why this is being done, and it's not easy to fix properly
> without the ..at() versions of these syscalls.  One idea is to fork()
> + fchdir(lo->proc_self_fd) + ..xattr().  Another related idea is to do
> a unshare(CLONE_FS) after each thread's startup (will pthread library
> balk?  I don't know) so that it's safe to do fchdir(lo->proc_self_fd)
> + ...xattr() + fchdir(lo->root_fd).

Hi Miklos,

Trying to understand your proposal. So if we want to do an ..xattr()
operation on a special file (and we don't have _at() variants), how
will fchdir() help. Are you suggesting fchdir() to parent and then
do something special.

Can you please elaborate your proposal a bit more. I think I have
missed the core idea completely.

I understand that you want to do unshare(CLONE_FS) to make sure one thrad's
fchdir() does not impact other thread. But did not understand that how
fchdir() alone is enough to do getxattr()/setxattr() on special file.

Thanks
Vivek


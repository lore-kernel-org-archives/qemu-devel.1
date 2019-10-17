Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF6FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9F920872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9F920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL91G-0000fj-N0
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1iL7yD-00073f-3o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1iL7yB-0006ZN-Qe
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1iL7yB-0006ZB-Hz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:45:43 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC9E4C01092E
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:45:42 +0000 (UTC)
Received: by mail-il1-f198.google.com with SMTP id z14so564125ill.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rsTtqszdhKCS/phiSsJlsMq5U4uYG/uT+8eIkmBKras=;
 b=EW7dYsl2FKs67mhfi9Z05De7YWB86mjbVx3KXwQUYMX0Q/o5gYmCqqNRWE+FsvXea/
 SSCQqaek6rzvGCx+7tYcGM3T/6/0BBtz6EBQrLrzFcIlv2VOZId+U7AptPkjtuX5pxgo
 7i2VatEKTaeFww3NtTXSVXYWfenWrv94YjmeTI31YN2Fh4dZ2fVZ9xY87VYUfeVefR2W
 zi9E37lVVT971qakefbc/EDUu3LXnzTtAy19UDgY2yaUt6eHEcmzY/TG2lVFKH/079cy
 2S99tb7KyxBS3VLpB4/8ettpvdz82NTgWIihSBNopI8MFp0oZQkB0qJgFKjtnldZJV1p
 uEug==
X-Gm-Message-State: APjAAAX4OsCkAV4kL454UxFMCYTkc/D1JGP3n6ZSE0u+cjboc94Dghp5
 8yxHbg95KPmvTNKw4WJozNvyJ1IMkE7d8VQFkAwEFL/gGbqbQ7jCvAZRq4qzOx6KRtqviu44sfQ
 lv7y17U1p+GISQFor39Q+wplgovHjark=
X-Received: by 2002:a92:8c85:: with SMTP id s5mr4476514ill.273.1571327142101; 
 Thu, 17 Oct 2019 08:45:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxb5SMg5aCRjh0hXbbRQhClwTYxD2VyBQjhUICMF7B/5+fJaZUhAmDTa9ih8g4i7Zd0pk9gv9tT+YlKXqN8E3Y=
X-Received: by 2002:a92:8c85:: with SMTP id s5mr4476496ill.273.1571327141875; 
 Thu, 17 Oct 2019 08:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017152522.GB12588@redhat.com>
In-Reply-To: <20191017152522.GB12588@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 17 Oct 2019 17:45:30 +0200
Message-ID: <CAOssrKc=EsNT6YGMJcHKmBLpz9xZnrVLA+Mov3n9RPv1M6z3sA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Oct 17, 2019 at 5:25 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Oct 17, 2019 at 01:23:57PM +0200, Miklos Szeredi wrote:
> > On Thu, Oct 17, 2019 at 12:05 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Wed, Oct 16, 2019 at 07:37:52PM +0900, Misono Tomohiro wrote:
> > > > Hello,
> > > >
> > > > I test xattr operation on virtiofs using xfstest generic/062
> > > > (with -o xattr option and XFS backend) and see some problems.
> > > >
> > > > These patches fixes the two of the problems.
> > > >
> > > > The remaining problems are:
> > > >  1. we cannot xattr to block device created by mknod
> > > >     which does not have actual device (since open in virtiofsd fails)
> > > >  2. we cannot xattr to symbolic link
> > > >
> > > > I don't think 1 is a big problem but can we fix 2?
> > >
> > > Sorry, I don't know the answer.  Maybe it would be necessary to add a
> > > new O_SYMLINK open flag to open(2) so that fgetxattr()/fsetxattr()
> > > operations can be performed.  A kernel change like that would take some
> > > time to get accepted upstream and shipped by distros, but it might be
> > > the only way since the current syscall interface doesn't seem to offer a
> > > way to do this.
> >
> > The real problem is that open() on a non-regular, non-directory file
> > may have side effects (unless O_PATH is used).  These patches try to
> > paper over that, but the fact is: opening special files from a file
> > server is forbidden.
> >
> > I see why this is being done, and it's not easy to fix properly
> > without the ..at() versions of these syscalls.  One idea is to fork()
> > + fchdir(lo->proc_self_fd) + ..xattr().  Another related idea is to do
> > a unshare(CLONE_FS) after each thread's startup (will pthread library
> > balk?  I don't know) so that it's safe to do fchdir(lo->proc_self_fd)
> > + ...xattr() + fchdir(lo->root_fd).
>
> Hi Miklos,
>
> Trying to understand your proposal. So if we want to do an ..xattr()
> operation on a special file (and we don't have _at() variants), how
> will fchdir() help. Are you suggesting fchdir() to parent and then
> do something special.
>
> Can you please elaborate your proposal a bit more. I think I have
> missed the core idea completely.
>
> I understand that you want to do unshare(CLONE_FS) to make sure one thrad's
> fchdir() does not impact other thread. But did not understand that how
> fchdir() alone is enough to do getxattr()/setxattr() on special file.

The fchdir() call is to avoid having to do openat().  The openat() was
needed because  /proc/self/fd/ is only accessible through a file
handle (lo->proc_self_fd).

Thanks,
Miklos


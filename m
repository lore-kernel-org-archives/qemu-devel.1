Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67971ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F095020820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F095020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9cv-0003Q8-J5
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1iL8xG-0003sY-Id
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1iL8xD-0005Vz-Rj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1iL8xD-0005VX-Jv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:48:47 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5324F89AC2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:48:46 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id w8so3976268iol.20
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y4rHzJCRGmNizBTI5vprS4vyA5fTwk2yNR5VfJsgrFQ=;
 b=Lsd0JBbczVqw+rVInZjHuUwp1njfMfSgWDO8lyaTSGRCiMQr7jUnhrPmlSobUfy56e
 1cYN2kvU3+WJmHQwwGPCwQAkhr3Fofl3yLWJ//cVdiz4YjoHrLowCjVa/bj+fsqdw+w6
 CUYmOKq2CeG+LmF6tajG2078d+zampp4SDncWu9TRny7uxcZ5Av6mefSHrje+slqigqC
 eiDYxqUrgDlJvTtzHf5TYOKHXEugrZqj7aJC9dwRX7xwhLxSyWolqen8x7loY/Fnxn96
 575wLtKDV6OoY5Bwkw910wrD75maKbIJA3mo6DbKIySGr9sLXuZ+C52GiLnsS2ki0J4/
 mm9w==
X-Gm-Message-State: APjAAAXQuQiLIOxSgcN7zH7kYscBMnbwgNa2cqu9QV7pARcuUxg6gIHG
 niCyLGm6cW/ZY6OVMcfW5pJCVxbnpZaEVkIwjHtSCQiO7Atb6AYbK9HoklHXFUxVfyBDOOgmbm3
 dTvEJYspDC7WFkkFSBdXQ5i4CRc8+TAk=
X-Received: by 2002:a02:2302:: with SMTP id u2mr4283366jau.70.1571330925655;
 Thu, 17 Oct 2019 09:48:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3F8CQzzgEEMNVm9WqsXKqg2V9UOgRNZfQr/OsGaw9Y0qH8XgHN7gSUEpfO54wAXM0rIOgaOAkIngHbMZtKj0=
X-Received: by 2002:a02:2302:: with SMTP id u2mr4283345jau.70.1571330925395;
 Thu, 17 Oct 2019 09:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
In-Reply-To: <20191017160953.GC1266@stefanha-x1.localdomain>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 17 Oct 2019 18:48:33 +0200
Message-ID: <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
To: Stefan Hajnoczi <stefanha@redhat.com>
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
Cc: virtio-fs@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 6:09 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
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
> Looking at the f*xattr() code in the kernel, it doesn't really care
> about the file descriptor, it wants the inode instead.  So the O_SYMLINK
> idea I mentioned could also be called O_XATTR and be similar to O_PATH,
> except that only f*xattr() calls are allowed on this file descriptor.

Even simpler: allow O_PATH descriptors for f*xattr().

Thanks,
Miklos


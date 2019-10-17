Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA61FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E342067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E342067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4zU-0003lV-W3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1iL3t7-0007bK-1I
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1iL3t5-00064G-IR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1iL3t5-00063Q-D9
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:24:11 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B755DC057E3C
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:24:09 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id w1so2784293ioj.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 04:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KIlvdxjquMP8D6iZz8pMvSRRxqczlnDyMCAaCQUvZRU=;
 b=Bt1BQEcfdglJ8KeNALKYJxbDLN76SzGtSC2cyvKcBlMkvKM8ye2GFuTNg4LpcmZzEl
 iULVUHq78iCrL9YHpnwW/LpjWgmZ3HWLQzGd9ijy9bM/RLANe1DCRqCYRWThsU69VgS+
 kZnVXWfdXp8mA4uLSkgWIj0lHP1M7xy3AL1aX/nqEFE/fIlKz2vZMYSoDnRl84Sy/xM2
 2xgQL7/UdNrXt151yjOepYewUt65xJn/BNRU5FaiQdkgRF5EBx9+pkPwdYSodjcYC6aC
 h8F3zJWc2OcQ3nXutKVVYFronOg7dxYy1pfqRpP1tV+bgXZAybh7/BqBcO79oy7MJZM+
 wx0A==
X-Gm-Message-State: APjAAAVxn4qM+y34vTNPVgAszDRkttv2hutnydq7toah4UED6JclCLlN
 jebqMM9hfK7yKlxp5EZOUZE7jzx5XcxO4nafB/fQThys3eDbugu0ARL9A4scwaD+e7CsaQQtX1m
 +pCJsClh8fnQwYAx404paw6OQB6wEl8c=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr3144519iln.6.1571311449151;
 Thu, 17 Oct 2019 04:24:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZKDjn8jAIEK4RlDfzAmTrjDo1jVm3VEPUhWZPFSwDUfjGchYtYSUI3gESKeovbENyiADTnDyUxTInt/VUv8s=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr3144495iln.6.1571311448908;
 Thu, 17 Oct 2019 04:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
In-Reply-To: <20191017100528.GA24790@stefanha-x1.localdomain>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 17 Oct 2019 13:23:57 +0200
Message-ID: <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Thu, 17 Oct 2019 08:31:58 -0400
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

On Thu, Oct 17, 2019 at 12:05 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Oct 16, 2019 at 07:37:52PM +0900, Misono Tomohiro wrote:
> > Hello,
> >
> > I test xattr operation on virtiofs using xfstest generic/062
> > (with -o xattr option and XFS backend) and see some problems.
> >
> > These patches fixes the two of the problems.
> >
> > The remaining problems are:
> >  1. we cannot xattr to block device created by mknod
> >     which does not have actual device (since open in virtiofsd fails)
> >  2. we cannot xattr to symbolic link
> >
> > I don't think 1 is a big problem but can we fix 2?
>
> Sorry, I don't know the answer.  Maybe it would be necessary to add a
> new O_SYMLINK open flag to open(2) so that fgetxattr()/fsetxattr()
> operations can be performed.  A kernel change like that would take some
> time to get accepted upstream and shipped by distros, but it might be
> the only way since the current syscall interface doesn't seem to offer a
> way to do this.

The real problem is that open() on a non-regular, non-directory file
may have side effects (unless O_PATH is used).  These patches try to
paper over that, but the fact is: opening special files from a file
server is forbidden.

I see why this is being done, and it's not easy to fix properly
without the ..at() versions of these syscalls.  One idea is to fork()
+ fchdir(lo->proc_self_fd) + ..xattr().  Another related idea is to do
a unshare(CLONE_FS) after each thread's startup (will pthread library
balk?  I don't know) so that it's safe to do fchdir(lo->proc_self_fd)
+ ...xattr() + fchdir(lo->root_fd).

Thanks,
Miklos


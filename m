Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B07C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA6221973
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9lQSOgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA6221973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jToII-0008Ck-BN
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jToHA-0007Ae-6y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1jToH7-00032l-D9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:05:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1jToH6-0002jk-VK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588172717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RALG6go9qqRSJvBNn1g0PU4/PnFr0tuIQWkAT+DTzVk=;
 b=f9lQSOghaBEZdMAIaJ5WP77lOZcNldVuTOp+UjnEhTsDpHhkaSiXbvz6CxrzvryBcrEEvq
 e0Qig9C3QZlX7IfNYhHsyAWExEPl3fzV7FP9ToDZ5OBNldSNzx9qNqpgX0EuZATUPPmJtL
 fMVeIJMIxcPbmSBk1TtDEQdhDbtEpWY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-uZQ19nOgMf24bJJBmRm9LA-1; Wed, 29 Apr 2020 11:05:16 -0400
X-MC-Unique: uZQ19nOgMf24bJJBmRm9LA-1
Received: by mail-qt1-f197.google.com with SMTP id n22so3027375qtp.15
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 08:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yl6KhjZuzkGhAahWzTjwP8t18DjgeYcQ1sE/3se79Wg=;
 b=tlyyks/W95SacrknC2IZNACvd1KuuFPfrnT7pfFMi+DEAIX3OuT5zBtT4tytsRKvZ5
 yo4jPtKdXUPikgEoFrT/PwsWdtHBT/A8OKDwA4nGSG9pPxf3efkPzmmhdR4oWO6jfo4O
 JgvKBqVE3hbNSPgkYv24ANcCKeQh+MwjIBOZ7LwGI9FJ5UnjMAeOiXA+9CBGfhFd9ZmW
 b1wac5iLSa9nFvoRY4DOthEX1zRM/oIHuH8WXKGt0IeWfRpuPLFCXeQm5lH6P70Mq9sE
 ofmVdSY+TUM+M5f92XAxhMAOCHeRuPR+yeWugDDPNR4Nm/F6IkF7iSoXlYfMUDulxsba
 ERJA==
X-Gm-Message-State: AGi0Pubz1jQWaqyD0ud7g1uNjzEL88ekc6+jI19oDflydcvbvfhMupax
 G6iDrAfZtZulfZ8BxXzvIbfsi+hEF7GQosg/rDkDVIhYwHxXDz2NXHeBC8/OnltDHJNAcKQ+1Xv
 B4YeilvowNh++I159qeiglWNvoXO8RHM=
X-Received: by 2002:a05:6214:150f:: with SMTP id
 e15mr32295767qvy.18.1588172715884; 
 Wed, 29 Apr 2020 08:05:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJTbuuyOW/5D5s69BLtzVLSu8eZExWXQxvww/3cA7cYMe8fStLpVl7T2DZGnU5ErzcZpS5mnUZI3LI2x/+weBw=
X-Received: by 2002:a05:6214:150f:: with SMTP id
 e15mr32295743qvy.18.1588172715592; 
 Wed, 29 Apr 2020 08:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200429124733.22488-1-mszeredi@redhat.com>
 <20200429143600.GE231284@redhat.com>
 <CAOssrKcOgP7eLo+uQdv==HssuqU3qpBKibvYAXypU88QXvypKw@mail.gmail.com>
 <20200429150038.GF231284@redhat.com>
In-Reply-To: <20200429150038.GF231284@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Apr 2020 17:05:04 +0200
Message-ID: <CAOssrKfk9DUW+H_TNYdLohSry_40qdCbp5YwwwJ=GJOP0rRO4A@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
To: Vivek Goyal <vgoyal@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 5:00 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Apr 29, 2020 at 04:47:19PM +0200, Miklos Szeredi wrote:
> > On Wed, Apr 29, 2020 at 4:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> > > > While it's not possible to escape the proc filesystem through
> > > > lo->proc_self_fd, it is possible to escape to the root of the proc
> > > > filesystem itself through "../..".
> > >
> > > Hi Miklos,
> > >
> > > So this attack will work with some form of *at(lo->proc_self_fd, "../=
..")
> > > call?
> >
> > Right.
> >
> > >
> > > >
> > > > Use a temporary mount for opening lo->proc_self_fd, that has it's r=
oot at
> > > > /proc/self/fd/, preventing access to the ancestor directories.
> > >
> > > Does this mean that now similar attack can happen using "../.." on tm=
pdir
> > > fd instead and be able to look at peers of tmpdir. Or it is blocked
> > > due to mount point or something else.
> >
> > No, because tmpdir is detached, the root of that tree will be the
> > directory pointed to by the fd.  ".." will just lead to the same
> > directory.
>
> Aha.. got it. Thanks.
>
> One more question. We seem to be using PID namespaces. Can't we mount
> fresh instance of proc so that we don't see other processes apart from
> virtiofd. May be we are already doing it. I have not checked it yet. If
> yes, that should mitigate this concern?

Yes, it's doing that already just above this patch:

    /* The child must remount /proc to use the new pid namespace */
    if (mount("proc", "/proc", "proc",
              MS_NODEV | MS_NOEXEC | MS_NOSUID | MS_RELATIME, NULL) < 0) {
        fuse_log(FUSE_LOG_ERR, "mount(/proc): %m\n");
        exit(1);
    }

Thanks,
Miklos



Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24914C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6F52067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6F52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWcg-0006RY-9d
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <nsoffer@redhat.com>) id 1hxWbu-0005K0-9B
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1hxWbr-0001Ak-Bn
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:13:10 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hxWbr-0001A2-5O
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:13:07 -0400
Received: by mail-ot1-f52.google.com with SMTP id j7so27399519ota.9
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L9B6m4i9obO6Jg6xivdC0yGFvXAJs55zIyCay0s842o=;
 b=XyMxKXDrWKNx/6Cpsy6+lPy4cuzl23qhULKcrKt87WRXATu8y3xt1267/HsrjLVmJg
 su1UKiC3+9a50w6ZPJYK1T+9zo1beK86TjsVgpi2ijCOZ8pAo7NnEDnFwJWC0TgKxZAf
 zZ++dyizgMKbE5U8deT0ZsKR5zXgg8Xmf5wjcg1PF0EpfSb5FdONWwtcSOknRh/5jinR
 rOWJTOOUUeSUdrMcpE4YY9b8AqKuOj9c33wIr5UO5A45OQJDEDrjJb4Lwjf88FGqLonj
 2aWZhiAWclbHuYB/XWpCWwtKdCnnGGVLjKyRJxWaOo/HBS1iAX16jU0Cot1XhTYHajER
 McRA==
X-Gm-Message-State: APjAAAXMw9SvoomoSENuV1Ip6g+pHmAweF8TBPMRk2LRUfGvOMoMxCTj
 n7Bufv3CE9GB9LizQFGg0jzJjPlPGZtA174TTOJywA==
X-Google-Smtp-Source: APXvYqxdgFzWGMH/K8w/jFXaYZ1JXQaqIYd0tXd2sBlf4sAraMhW0CYvRRzo9Dxi4jDghHi3QhPOYxV+rOowr37kAuY=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr35481233otb.81.1565701986051; 
 Tue, 13 Aug 2019 06:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190811205024.19482-1-nsoffer@redhat.com>
 <20190812142352.GB6400@localhost.localdomain>
 <CAMRbyyvAXcpEsHUke74=z3=eDhpAz52A+0F-8PdvRUsbYgDjxg@mail.gmail.com>
 <20190813112146.GF4663@localhost.localdomain>
In-Reply-To: <20190813112146.GF4663@localhost.localdomain>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 13 Aug 2019 16:12:54 +0300
Message-ID: <CAMRbyys4EoKAs13W_kS6SD1q0vQBZTn=mEVAAffFuztMh_epPw@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.52
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] block: posix: Handle undetectable
 alignment
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
Cc: Sahina Bose <sabose@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Krutika Dhananjay <kdhananj@redhat.com>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 13, 2019 at 2:21 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 13.08.2019 um 12:45 hat Nir Soffer geschrieben:
> > On Mon, Aug 12, 2019 at 5:23 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > > Am 11.08.2019 um 22:50 hat Nir Soffer geschrieben:
> > > > In some cases buf_align or request_alignment cannot be detected:
> > > >
> > > > - With Gluster, buf_align cannot be detected since the actual I/O is
> > > >   done on Gluster server, and qemu buffer alignment does not matter.
> > >
> > > If it doesn't matter, the best value would be buf_align = 1.
> > >
> >
> > Right, if we know that this is gluster.
> >
> > > - With local XFS filesystem, buf_align cannot be detected if reading
> > > >   from unallocated area.
> > >
> > > Here, we actually do need alignment, but it's unknown whether it would
> > > be 512 or 4096 or something entirely. Failing to align requests
> > > correctly results in I/O errors.
> > >
> > > > - With Gluster backed by XFS, request_alignment cannot be detected if
> > > >   reading from unallocated area.
> > >
> > > This is like buf_align for XFS: We don't know the right value, but
> > > getting it wrong causes I/O errors.
> > >
> > > > - With NFS, the server does not use direct I/O, so both buf_align
> > > >   cannot be detected.
> > >
> > > This suggests that byte-aligned requests are fine for NFS, i.e.
> > > buf_align = request_alignment = 1 would be optimal in this case.
> > >
> >
> > Right, but again we don't know this is NFS.
>
> Yes, I agree. I was just trying to list the optimal settings for each
> case so I could compare them against the actual results the path
> provides. I'm well aware that we don't know a way to get the optimal
> results for all four cases.
>
> > > These cases seems to work when storage sector size is 512 bytes,
> because
> > > > the current code starts checking align=512. If the check succeeds
> > > > because alignment cannot be detected we use 512. But this does not
> work
> > > > for storage with 4k sector size.
> > > >
> > > > Practically the alignment requirements are the same for buffer
> > > > alignment, buffer length, and offset in file. So in case we cannot
> > > > detect buf_align, we can use request alignment. If we cannot detect
> > > > request alignment, we can fallback to a safe value.
> > >
> > > This makes sense in general.
> > >
> > > What the commit message doesn't explain, but probably should do is how
> > > we determine whether we could successfully detect request alignment.
> The
> > > approach taken here is that a detected alignment of 1 is understood as
> > > failure to detect the real alignment.
> >
> > Failing with EINVAL when using 1, and succeeding with another value is
> > considered a successful detection.
> >
> > We have 3 issues preventing detection:
> > - filesystem not using direct I/O on the remote server (NFS, Gluster
> > when network.remote-dio=on)
> > - area probed is unallocated with XFS or Gluster backed by XFS
> > - filesystem without buffer alignment requirement (e.g. Gluster)
>
> I would say case 1 is effectively a subset of case 3 (i.e. it's just one
> specific reason why we don't have a buffer alignment requirement).
>
> > For handling unallocated areas, we can:
> > - always allocate the first block when creating an image (qemu-img
> > create/convert)
> > - use write() instead of read().
> >
> > In oVirt we went with the second option - when we initialize a file
> > storage domain, we create a special file and do direct write to this
> > file with 1, 512, and 4096 bytes length. If we detect 512 or 4096, we
> > use this value for creating the domain (e.g. for sanlock).  If we
> > detect 1, we use the user provided value (default 512).
>
> Yes, but there's the important difference that oVirt controls the image
> files, whereas QEMU doesn't. Even if qemu-img create made sure that we
> allocate the first block, the user could still pass us an image that
> was created using a different way.
>
> Using write() is actually an interesting thought. Obviously, we can't
> just overwrite the user image. But maybe what we could do is read the
> first block and then try to rewrite it with different alignments.
>

Yes, this is what we do in ovirt-imageio for file based storage:
https://github.com/oVirt/ovirt-imageio/blob/ca70170886b0c1fbeca8640b12bcf54f01a3fea0/common/ovirt_imageio_common/backends/file.py#L311

But we have lot of assumptions that may not work for qemu:
- we don't support read only images
- we assume nobody else is writing to the image imageio uses
  (enforced by oVirt)

So this will not work for qemu-img read-only operations.

However, this will break down with read-only images, so if we can't
> write, we'd still have to fall back to a safe default.
>
> Also, given the straces we saw, I'm afraid we might trigger gluster bugs
> where writes that failed with EINVAL mess up the internal state so that
> even later aligned requests would fail.
>

If this happen only when using Gluster performance.strict-o-direct = off,
we will
enforce performance.strict-o-direct = in oVirt.

Otherwise this is a Gluster bug and it should be fixed in Gluster.

> You can see the code here:
> >
> https://github.com/oVirt/vdsm/blob/4733018f9a719729242738b486906d3b9ed058cd/lib/vdsm/storage/fileSD.py#L838
> >
> > One way we can use in qemu is to create a temporary file:
> >
> >     /path/to/image.tmp9vo8US
> >
> > Delete the file, keeping the fd open, and detect the alignment on this
> > file using write().
>
> This isn't going to fly. We might not have write permission to the
> directory even for read-write images. Worse, we might get passed only a
> file descriptor instead of a path. So whatever we do, we must do it with
> the image file descriptor.
>
> > With this we fixed all the cases listed above, but creating new files
> > requires write permission in the directory where the image is in, and
> > will not work for some strange setups (.e.g bind-mount images).
> >
> > One issue with this is that there is no guarantee that the temporary
> > file will be deleted so the user will have to deal with leftover
> > files.
>
> On Linux, we could use O_TMPFILE for this. However, as I mentioned
> above, we may not even know the directory.
>
...

Nir

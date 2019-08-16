Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5106C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 22:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A696D206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 22:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A696D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hykzH-0007Nf-S0
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 18:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1hykyP-0006rr-V4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1hykyN-0001NZ-UB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:45:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hykyN-0001MB-NV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:45:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id c15so5944600oic.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 15:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dB5DagYUO0GFtr/ln+REl1/BC9gsEokFUf6ThW9mgJg=;
 b=eqQiqeinUPQHus1xPbX2kFUnqOeBHmdXEgxfZ7UjiVYGzVJfhXDWw42zWX0pTWnDUT
 qTgoVVuGf6K2NI8VogCsH9L8RBSopjfb1Aj0GCBPDmZZL+pIlGhUY8CfbgTQxBFSS+aU
 TtPUKBsG/4xkIrf/Y572M+/5bnavYoKOFGCyCmHorfNoWRxXBW6K88Ea2+gVGpgVqQ86
 3MgzG0GcwHVZzOHtMgCmdShOPLzpsnk8RR4u4to6DQNG6fYAOkCa7ljwkt6840KKO04r
 jqrdN1bMtOF6jyEdivC99ZafeE7CjIbWIbj3N6SC427qLjo9AKFJPsPgfCpNtWypKwoC
 QzkA==
X-Gm-Message-State: APjAAAVoU7GssvuTp7H0OEj3TRRxi14LfHYpKo/3d68KcZkokoDOpSBy
 U8U6IKqwErgVcUD/gRrxcnPD33A2C2GcKm2YoqNOkA==
X-Google-Smtp-Source: APXvYqzMslUR4Umbsh1Kcp/UkoOA5CkjjfiVjXvSYzQPAUwHTkrbc2QbdVB6mCY9eHtRFL20rlo8cnvjzTY43lZyJkc=
X-Received: by 2002:aca:3fc4:: with SMTP id m187mr6052500oia.156.1565995525822; 
 Fri, 16 Aug 2019 15:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <b24959b4-f2b2-d720-f8b5-4adc25b89278@redhat.com>
In-Reply-To: <b24959b4-f2b2-d720-f8b5-4adc25b89278@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 17 Aug 2019 01:45:14 +0300
Message-ID: <CAMRbyytThpP1KXPmJLpA_i3JLot7j9UshjcqRerkFtmN_T5Seg@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.195
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: posix: Always allocate
 the first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 17, 2019 at 12:57 AM John Snow <jsnow@redhat.com> wrote:

> On 8/16/19 5:21 PM, Nir Soffer wrote:
> > When creating an image with preallocation "off" or "falloc", the first
> > block of the image is typically not allocated. When using Gluster
> > storage backed by XFS filesystem, reading this block using direct I/O
> > succeeds regardless of request length, fooling alignment detection.
> >
> > In this case we fallback to a safe value (4096) instead of the optimal
> > value (512), which may lead to unneeded data copying when aligning
> > requests.  Allocating the first block avoids the fallback.
> >
>
> Where does this detection/fallback happen? (Can it be improved?)
>

In raw_probe_alignment().

This patch explain the issues:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00568.html

Here Kevin and me discussed ways to improve it:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00426.html

> When using preallocation=off, we always allocate at least one filesystem
> > block:
> >
> >     $ ./qemu-img create -f raw test.raw 1g
> >     Formatting 'test.raw', fmt=raw size=1073741824
> >
> >     $ ls -lhs test.raw
> >     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
> >
> > I did quick performance tests for these flows:
> > - Provisioning a VM with a new raw image.
> > - Copying disks with qemu-img convert to new raw target image
> >
> > I installed Fedora 29 server on raw sparse image, measuring the time
> > from clicking "Begin installation" until the "Reboot" button appears:
> >
> > Before(s)  After(s)     Diff(%)
> > -------------------------------
> >      356        389        +8.4
> >
> > I ran this only once, so we cannot tell much from these results.
> >
>
> That seems like a pretty big difference for just having pre-allocated a
> single block. What was the actual command line / block graph for that test?
>

Having the first block allocated changes the alignment.

Before this patch, we detect request_alignment=1, so we fallback to 4096.
Then we detect buf_align=1, so we fallback to value of request alignment.

The guest see a disk with:
logical_block_size = 512
physical_block_size = 512

But qemu uses:
request_alignment = 4096
buf_align = 4096

storage uses:
logical_block_size = 512
physical_block_size = 512

If the guest does direct I/O using 512 bytes aligment, qemu has to copy
the buffer to align them to 4096 bytes.

After this patch, qemu detects the alignment correctly, so we have:

guest
logical_block_size = 512
physical_block_size = 512

qemu
request_alignment = 512
buf_align = 512

storage:
logical_block_size = 512
physical_block_size = 512

We expect this to be more efficient because qemu does not have to emulate
anything.

Was this over a network that could explain the variance?
>

Maybe, this is complete install of Fedora 29 server, I'm not sure if the
installation
access the network.

> The second test was cloning the installation image with qemu-img
> > convert, doing 10 runs:
> >
> >     for i in $(seq 10); do
> >         rm -f dst.raw
> >         sleep 10
> >         time ./qemu-img convert -f raw -O raw -t none -T none src.raw
> dst.raw
> >     done
> >
> > Here is a table comparing the total time spent:
> >
> > Type    Before(s)   After(s)    Diff(%)
> > ---------------------------------------
> > real      530.028    469.123      -11.4
> > user       17.204     10.768      -37.4
> > sys        17.881      7.011      -60.7
> >
> > Here we see very clear improvement in CPU usage.
> >
>
> Hard to argue much with that. I feel a little strange trying to force
> the allocation of the first block, but I suppose in practice "almost no
> preallocation" is indistinguishable from "exactly no preallocation" if
> you squint.
>

Right.

The real issue is that filesystems and block devices do not expose the
alignment
requirement for direct I/O, so we need to use these hacks and assumptions.

With local XFS we use xfsctl(XFS_IOC_DIOINFO) to get request_alignment, but
this does
not help for XFS filesystem used by Gluster on the server side.

I hope that Niels is working on adding similar ioctl for Glsuter, os it can
expose the properties
of the remote filesystem.

Nir

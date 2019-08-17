Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B3C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 17:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DCF21019
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 17:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DCF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz2mN-0004KT-Lt
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 13:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1hz2le-0003p0-0s
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 13:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1hz2lb-0004ep-DZ
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 13:45:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hz2lb-0004eE-67
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 13:45:27 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 860D985365
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 17:45:25 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id c1so946624otb.22
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 10:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JJ3Nwh8XSEpFRjCyFQubrIwJ4x76uYzZW175cvZGJ0Y=;
 b=ZncFlZIoqChCuHXz4gOCV5IHodvsAXEMYGjxvtS3Dv9Mm8XMXanZdjVPHWkPsvRqZC
 p/YHXXzeqEv7Y35OcHcihinaRyCxVjoe4PcWQdEViOGHLR7sUB3xT5ZkIo4WWojJqgWG
 tBJD7JqFB1shrHuV6hhfGkQtKEhxnrlJ3KPBVdfAtMRvpxVfTlFhlq6JgN6xRaImJWbd
 xoGnqRs5PSkI5QEk6XziOCo76i4hIbfVZ3QrYoCpFPg8oKN7OIhf0Xp/bwWnOpwRD1pN
 jy54yu93OPXHzuIEHSgyw+ZAuUYefLogKE9HSiuMPJqeha/LaA+QXPX48TGBgpfTnUhe
 haYg==
X-Gm-Message-State: APjAAAW9D1SreFwO0Bnsgn3egB9zcMqbpZPjSz1L0ss8jJA1OXfkH4Ws
 WCKpXnw2S79pZ5+4rJId72VYR+HbKKOQNqxq7KHljdoCb/2hTtFYCbGVsTdoOCzdJhS93NFoPRo
 Pbym9WOgybgMAEcuBHdB47ZIX1/oE2e0=
X-Received: by 2002:a05:6830:2018:: with SMTP id
 e24mr11175528otp.315.1566063924959; 
 Sat, 17 Aug 2019 10:45:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvRH599AxokpihVERDNjf6Cbgnpkt5rkEvfcpXkzeOfHx0TESn9wyrbJJqcTl4HeYJ6iHts1vM+JfCzfwiIOs=
X-Received: by 2002:a05:6830:2018:: with SMTP id
 e24mr11175509otp.315.1566063924677; 
 Sat, 17 Aug 2019 10:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155157.3719-1-kwolf@redhat.com>
 <20190326155157.3719-6-kwolf@redhat.com>
 <fb6063ca-d4c4-7add-adec-5e92c3805ad8@redhat.com>
 <20190815102947.GB7415@linux.fritz.box>
In-Reply-To: <20190815102947.GB7415@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 17 Aug 2019 20:45:13 +0300
Message-ID: <CAMRbyyvXUCXD+9r2gurCrXMn8Nz2GSYM4UjzofOFpZQXHzJVEQ@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PULL 5/7] file-posix: Support
 BDRV_REQ_NO_FALLBACK for zero writes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 1:29 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 15.08.2019 um 04:44 hat Eric Blake geschrieben:
> > On 3/26/19 10:51 AM, Kevin Wolf wrote:
> > > We know that the kernel implements a slow fallback code path for
> > > BLKZEROOUT, so if BDRV_REQ_NO_FALLBACK is given, we shouldn't call it.
> > > The other operations we call in the context of .bdrv_co_pwrite_zeroes
> > > should usually be quick, so no modification should be needed for them.
> > > If we ever notice that there are additional problematic cases, we can
> > > still make these conditional as well.
> >
> > Are there cases where fallocate(FALLOC_FL_ZERO_RANGE) falls back to slow
> > writes?  It may be fast on some file systems, but when used on a block
> > device, that may equally trigger slow fallbacks.  The man page is not
> > clear on that fact; I suspect that there may be cases in there that need
> > to be made conditional (it would be awesome if the kernel folks would
> > give us another FALLOC_ flag when we want to guarantee no fallback).
>
> The NO_FALLBACK changes were based on the Linux code rather than
> documentation because no interface is explicitly documented to forbid
> fallbacks.
>
> I think for file systems, we can generally assume that we don't get
> fallbacks because for file systems, just deallocating blocks is the
> easiest way to implement the function anyway. (Hm, or is it when we
> don't punch holes...?)
>
> And for block devices, we don't try FALLOC_FL_ZERO_RANGE because it also
> involves the same slow fallback as BLKZEROOUT. In other words,
> bdrv_co_pwrite_zeroes() with NO_FALLBACK, but without MAY_UNMAP, always
> fails on Linux block devices, and we fall back to emulation in user
> space.
>
> We would need a kernel interface that calls blkdev_issue_zeroout() with
> BLKDEV_ZERO_NOUNMAP | BLKDEV_ZERO_NOFALLBACK, but no such interface
> exists.
>
> When I talked to some file system people, they insisted that "efficient"
> or "fast" wasn't well-defined enough for them or something, so if we
> want to get a kernel change, maybe a new block device ioctl would be the
> most realistic thing.
>
> We do use FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE for MAY_UNMAP,
> which works for both file systems (I assume - each file system has a
> separate implementation) and block devices without slow fallbacks.
>
> qemu-img create sets MAY_UNMAP, so the case we are most interested in is
> covered with a fast implementation.
>
> > By the way, is there an easy setup to prove (maybe some qemu-img convert
> > command on a specially-prepared source image) whether the no fallback
> > flag makes a difference?  I'm about to cross-post a series of patches to
> > nbd/qemu/nbdkit/libnbd that adds a new NBD_CMD_FLAG_FAST_ZERO which fits
> > the bill of BDRV_REQ_NO_FALLBACK, but would like to include some
> > benchmark numbers in my cover letter if I can reproduce a setup where it
> > matters.
>
> Hm, the original case came from Nir, maybe he can suggest something.
>

The original case came from RHEL 7.{5,6}. The flow was:

qemu-img convert -> nbdkit rhv plugin -> imageio -> storage

nbdkit got NBD_CMD_WRITE_ZEROES request, converted it to imageio ZERO
request.

For block devices, imageio was trying:
1. fallocate(ZERO_RANGE) - fails
2. ioctl(BLKZEROOUT) - succeeds

See
https://github.com/oVirt/ovirt-imageio/blob/ca70170886b0c1fbeca8640b12bcf54f01a3fea0/common/ovirt_imageio_common/backends/file.py#L247

BLKZEROOUT can be fast (100 GiB/s) or slow (100 MiB/s) depending on the
server,
and on the allocation status of that area.

On our current storage (3PAR), if the device is fully allocated, for
example:

   dd if=/dev/zero bs=8M of=/dev/vg/lv

Then blkdiscard -z is slow (800 MiB/s):

But if you discard the device:

    blkdiscard /dev/vg/lv

blkdiscard -z becomes fast (100 GiB/s).

Previously we had XtremIO storage, which was able to zero 50 GiB/s
regardless
of the allocation.

You'll definitely need a block device that doesn't support
> FALLOC_FL_PUNCH_HOLE,


Old kernels (CentOS 7) did not support this.

# uname -r
3.10.0-957.21.3.el7.x86_64

# strace -e trace=fallocate fallocate -l 100m /dev/loop0
fallocate(3, 0, 0, 104857600)           = -1 ENODEV (No such device)
fallocate: fallocate failed: No such device
+++ exited with 1 +++

# strace -e trace=fallocate fallocate -p -l 100m /dev/loop0
fallocate(3, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 0, 104857600) = -1
ENODEV (No such device)
fallocate: fallocate failed: No such device
+++ exited with 1 +++

# strace -e trace=fallocate fallocate -z -l 100m /dev/loop0
fallocate(3, FALLOC_FL_ZERO_RANGE, 0, 104857600) = -1 ENODEV (No such
device)
fallocate: fallocate failed: No such device
+++ exited with 1 +++

otherwise you can't trigger the fallback. My
> first though was a loop device, but this actually does support the
> operation and passes it through to the underlying file system. So maybe
> if you know a file system that doesn't support it. Or if you have an old
> hard disk handy.

...

Nir

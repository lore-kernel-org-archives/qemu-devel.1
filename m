Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61766CA9EC7
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 00:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B9120862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 00:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B9120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPyQt-00025n-9x
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 20:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPyQ3-0001OW-IH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 20:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPyQ0-00054c-Gd
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 20:34:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPyQ0-0004zK-7R
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 20:34:28 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E71E6859FC
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 00:34:24 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id g62so3993970qkb.20
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 17:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YwoEediH85hkUzt+W73MXJaRTgNSuvW1jTPdfShxCHM=;
 b=bCG5SzA4JLLmmCT/ZG3xJ2r88JBl3w94w0CkEDNydeHf573K/1EpoW9GI8fFZloRXS
 C97UFfKQ1Qtw30ipXW2EfuSqDmxaCrOvcwVF0qYbZ+iq5RDi/31Wube13mxH+I386F+F
 APJZkT3lMNPKPzED3tE/ZHyK08xQMAGMFtvQSfKwhVSxcsTlW8tMgCSEpY/bcYYJTi3B
 OfbmPkk3MZZbtpSMmBC33FZGy/RFQgto70Kb+y3GbF0mQKpqp+bQGIBuCkveeKWkUAsJ
 yc18W5U/snI6eXZRxIWaETCn535tsA+hkx3rJ3EvrtvoWbzuHyRdfjpePXtZ1jYa88dz
 Zzsw==
X-Gm-Message-State: APjAAAXV8K8P3mWF/NV+YPgi5yLD9BrUvs4CrInstfbOi2SSbD4fYMo6
 m716d5Rhmz5CrodaF/D/QhuacMT37PQ4w4ui+338ueWFa44S3nLNcsGKkkpetBpXYjRejtGhgZ2
 rT8NzHru73kEbDdU=
X-Received: by 2002:a0c:efc2:: with SMTP id a2mr2067308qvt.44.1572482064058;
 Wed, 30 Oct 2019 17:34:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAXEFmLAdig6rcAzBUgbaZ+wYrtg2NgzdZdiadi2nIREDoK/6jOWGF7VbCYxkelU1NPACBaA==
X-Received: by 2002:a0c:efc2:: with SMTP id a2mr2067282qvt.44.1572482063677;
 Wed, 30 Oct 2019 17:34:23 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id n62sm1032598qkn.47.2019.10.30.17.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 17:34:22 -0700 (PDT)
Date: Wed, 30 Oct 2019 20:34:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191030203315-mutt-send-email-mst@kernel.org>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191029185004-mutt-send-email-mst@kernel.org>
 <20191030104700.GA3114@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030104700.GA3114@work-vm>
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 10:47:00AM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Mon, Oct 21, 2019 at 11:58:02AM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Hi,
> > >   This is the 1st set for the virtiofsd - a daemon
> > > that implements the user space side of virtiofs.
> > > 
> > >   The kernel and qemu device parts recently went in,
> > > so the daemon is the only thing missing to have a working
> > > set.
> > 
> > 
> > So I went back and forth on this but this is huge
> > and there's not a lot of time for review.
> > So I parked it + the security patches on a next branch in my tree.
> > I will rebase once after rc1 is out, and then stop.
> 
> Thanks; I'll work on the extra sets that can go later (the
> threading and cleanups+fixes).
> 
> Dave


Apropos I would really like to figure out
a better way to know that we did not miss
anything when adding the security patchset.


> > 
> > >   This set is the absolute minimal base set of patches;
> > > it's not yet safe to use (from security or correctness);
> > > 
> > > I'll follow up with ~3 more series in the next few days
> > > with:
> > > 
> > >     a) Security patches that add sandboxing and checking
> > >        compared with normal fuse - that makes it safe.
> > >     b) Performance improvements including threading
> > >     c) Other fixes, including correctness.
> > > 
> > > but, this is a good start and gets things rolling.
> > > 
> > > The set pulls in a big chunk of the upstream libfuse library
> > > (unmodified so that it's easy to check it really is upstream),
> > > chops all the stuff out we don't need and then adds the
> > > new transport we need.
> > > 
> > > For new files I've formatted the code according to qemu
> > > standards; for files that are from upstream libfuse
> > > I've kept with their standards for ease of future updating.
> > > 
> > > We can't just link with libfuse, since we have to make ABI incompatible
> > > changes for the new transport.
> > > 
> > > Running this daemon is typically done with:
> > > 
> > >    ./virtiofsd -o vhost_user_socket=/path/socket -o source=/path/to/fs
> > > 
> > > connected to a qemu that's then started with:
> > >    -chardev socket,id=char0,path=/path/socket -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs
> > > 
> > > and then in the guest mount with:
> > >    mount -t virtiofs myfs /mnt
> > > 
> > > Our development branch is: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev
> > > 
> > > Dave
> > > 
> > > 
> > > Dr. David Alan Gilbert (22):
> > >   virtiofsd: Pull in upstream headers
> > >   virtiofsd: Pull in kernel's fuse.h
> > >   virtiofsd: Add auxiliary .c's
> > >   virtiofsd: Add fuse_lowlevel.c
> > >   virtiofsd: Add passthrough_ll
> > >   virtiofsd: Trim down imported files
> > >   virtiofsd: Fix fuse_daemonize ignored return values
> > >   virtiofsd: Fix common header and define for QEMU builds
> > >   virtiofsd: fuse: Make iov_length usable outside fuse_lowlevel.c
> > >   virtiofsd: Add options for virtio
> > >   virtiofsd: Open vhost connection instead of mounting
> > >   virtiofsd: Start wiring up vhost-user
> > >   virtiofsd: Add main virtio loop
> > >   virtiofsd: get/set features callbacks
> > >   virtiofsd: Start queue threads
> > >   virtiofsd: Poll kick_fd for queue
> > >   virtiofsd: Start reading commands from queue
> > >   virtiofsd: Send replies to messages
> > >   virtiofsd: Keep track of replies
> > >   virtiofsd: Add Makefile wiring for virtiofsd contrib
> > >   virtiofsd: Fast path for virtio read
> > >   virtiofs: Add maintainers entry
> > > 
> > > Stefan Hajnoczi (7):
> > >   virtiofsd: remove mountpoint dummy argument
> > >   virtiofsd: remove unused notify reply support
> > >   virtiofsd: add -o source=PATH to help output
> > >   virtiofsd: add --fd=FDNUM fd passing option
> > >   virtiofsd: make -f (foreground) the default
> > >   virtiofsd: add vhost-user.json file
> > >   virtiofsd: add --print-capabilities option
> > > 
> > > Vivek Goyal (1):
> > >   virtiofsd: Make fsync work even if only inode is passed in
> > > 
> > >  .gitignore                                  |    1 +
> > >  MAINTAINERS                                 |    8 +
> > >  Makefile                                    |    9 +
> > >  Makefile.objs                               |    1 +
> > >  contrib/virtiofsd/50-qemu-virtiofsd.json.in |    5 +
> > >  contrib/virtiofsd/Makefile.objs             |   10 +
> > >  contrib/virtiofsd/buffer.c                  |  318 +++
> > >  contrib/virtiofsd/fuse.h                    | 1268 ++++++++++
> > >  contrib/virtiofsd/fuse_common.h             |  823 +++++++
> > >  contrib/virtiofsd/fuse_i.h                  |  131 ++
> > >  contrib/virtiofsd/fuse_kernel.h             |  858 +++++++
> > >  contrib/virtiofsd/fuse_log.c                |   40 +
> > >  contrib/virtiofsd/fuse_log.h                |   82 +
> > >  contrib/virtiofsd/fuse_loop_mt.c            |   54 +
> > >  contrib/virtiofsd/fuse_lowlevel.c           | 2302 +++++++++++++++++++
> > >  contrib/virtiofsd/fuse_lowlevel.h           | 2024 ++++++++++++++++
> > >  contrib/virtiofsd/fuse_misc.h               |   59 +
> > >  contrib/virtiofsd/fuse_opt.c                |  422 ++++
> > >  contrib/virtiofsd/fuse_opt.h                |  271 +++
> > >  contrib/virtiofsd/fuse_signals.c            |   90 +
> > >  contrib/virtiofsd/fuse_virtio.c             |  717 ++++++
> > >  contrib/virtiofsd/fuse_virtio.h             |   33 +
> > >  contrib/virtiofsd/helper.c                  |  300 +++
> > >  contrib/virtiofsd/passthrough_helpers.h     |   76 +
> > >  contrib/virtiofsd/passthrough_ll.c          | 1341 +++++++++++
> > >  docs/interop/vhost-user.json                |    4 +-
> > >  26 files changed, 11246 insertions(+), 1 deletion(-)
> > >  create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in
> > >  create mode 100644 contrib/virtiofsd/Makefile.objs
> > >  create mode 100644 contrib/virtiofsd/buffer.c
> > >  create mode 100644 contrib/virtiofsd/fuse.h
> > >  create mode 100644 contrib/virtiofsd/fuse_common.h
> > >  create mode 100644 contrib/virtiofsd/fuse_i.h
> > >  create mode 100644 contrib/virtiofsd/fuse_kernel.h
> > >  create mode 100644 contrib/virtiofsd/fuse_log.c
> > >  create mode 100644 contrib/virtiofsd/fuse_log.h
> > >  create mode 100644 contrib/virtiofsd/fuse_loop_mt.c
> > >  create mode 100644 contrib/virtiofsd/fuse_lowlevel.c
> > >  create mode 100644 contrib/virtiofsd/fuse_lowlevel.h
> > >  create mode 100644 contrib/virtiofsd/fuse_misc.h
> > >  create mode 100644 contrib/virtiofsd/fuse_opt.c
> > >  create mode 100644 contrib/virtiofsd/fuse_opt.h
> > >  create mode 100644 contrib/virtiofsd/fuse_signals.c
> > >  create mode 100644 contrib/virtiofsd/fuse_virtio.c
> > >  create mode 100644 contrib/virtiofsd/fuse_virtio.h
> > >  create mode 100644 contrib/virtiofsd/helper.c
> > >  create mode 100644 contrib/virtiofsd/passthrough_helpers.h
> > >  create mode 100644 contrib/virtiofsd/passthrough_ll.c
> > > 
> > > -- 
> > > 2.23.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


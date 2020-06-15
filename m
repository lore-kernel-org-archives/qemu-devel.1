Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9709AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E57020578
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iy19n/FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E57020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkkmN-0000Om-GP
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 04:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jkkl3-0007v3-NG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:46:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jkkl1-0003zL-7s
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592210777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHUixd2bUcA+l5VmdyRZT1ulfuJr0aI6m83KrgFWx9A=;
 b=iy19n/FVgMuxc+gssXBykH1+mjQssMBv2s/vKZwDM/viRQbYMpSGiBkC4vsiWqo/QNnLW8
 OmYrjs3hfy/D9bMRC3SYlhPswOnSum8dSvx1W1xFoLd1lSGcJmJy4BtzVfv7zd/vxvZN73
 egyRtKsBMdtOJqZLOeVVJzi4BrFyS+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-sLsJN3plPw6YCYT2Ksv7rQ-1; Mon, 15 Jun 2020 04:46:15 -0400
X-MC-Unique: sLsJN3plPw6YCYT2Ksv7rQ-1
Received: by mail-wm1-f70.google.com with SMTP id x6so6401879wmj.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 01:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sHUixd2bUcA+l5VmdyRZT1ulfuJr0aI6m83KrgFWx9A=;
 b=j49JTDtTdSia+L0d7Tr6w9zmJGE1pVK336Hy9fc/7/5Qb5/1Bndw4FxeeZjgr877dE
 cw3NjDKsMPnKyHLHWQQG24N864sIxHDWbxmRwOIFMd5yKHeMIEL31PfpIFQC8gwlVT0b
 XH0rJctDQhFcdmMPbgI18MtnXQL+dP3N/PQQwpwJKSoKg4/P/GDTNuYAKlKIhNX6FgaK
 xRbbX9INpweVKkObQdazGH5qOvXwUMVm2pJVn0wMbZAl1nzxxqRawEbKFGhatWIP/Ty1
 cob22R6JXZEJMGYNnEI0DezuQq5A7CpummT0DxPUQnG9sMGftTE8Yr3QM8qL3WfP7zho
 o0TQ==
X-Gm-Message-State: AOAM532mZ1/CgGGVp27z4bpCBpITo5o9/rLI1nj3DsSZcKk/HPJTV8AU
 cSnRv4DnYdC1htT0m8CODmq+VchRKJlwejWV6O0wTFt7SGNmEN/N0R5VkHzyfw/HH1h6KgZuMwP
 5DjGz0uMx5Zga6Ac=
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr12365714wmg.71.1592210774355; 
 Mon, 15 Jun 2020 01:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8l9ZVSRXdmisx9tFCdKe38+XMXX1M4yMwvDxGRw+69WSKE47ntz7xS/B0SQPhBtFdbdfy5w==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr12365687wmg.71.1592210774076; 
 Mon, 15 Jun 2020 01:46:14 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id t129sm23290028wmf.41.2020.06.15.01.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 01:46:13 -0700 (PDT)
Date: Mon, 15 Jun 2020 10:46:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v8 0/4] vhost-user block device backend implementation
Message-ID: <20200615084425.cjqlpazef4644huk@steredhat>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200611123703.jpokj4m75woxt55f@steredhat>
 <20200614184640.ydfsi6dhs5jkhaqx@r>
MIME-Version: 1.0
In-Reply-To: <20200614184640.ydfsi6dhs5jkhaqx@r>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 02:46:40AM +0800, Coiby Xu wrote:
> Hi Stefano Garzarella,
> 
> On Thu, Jun 11, 2020 at 02:37:03PM +0200, Stefano Garzarella wrote:
> > Hi Coiby Xu,
> > 
> > On Fri, Jun 05, 2020 at 07:35:34AM +0800, Coiby Xu wrote:
> > > v8
> > >  - re-try connecting to socket server to fix asan error
> > >  - fix license naming issue
> > > 
> > > v7
> > >  - fix docker-test-debug@fedora errors by freeing malloced memory
> > > 
> > > v6
> > >  - add missing license header and include guard
> > >  - vhost-user server only serve one client one time
> > >  - fix a bug in custom vu_message_read
> > >  - using qemu-storage-daemon to start vhost-user-blk-server
> > >  - a bug fix to pass docker-test-clang@ubuntu
> > > 
> > > v5:
> > >  * re-use vu_kick_cb in libvhost-user
> > >  * keeping processing VhostUserMsg in the same coroutine until there is
> > >    detachment/attachment of AIOContext
> > >  * Spawn separate coroutine for each VuVirtqElement
> > >  * Other changes including relocating vhost-user-blk-server.c, coding
> > >    style etc.
> > > 
> > > v4:
> > >  * add object properties in class_init
> > >  * relocate vhost-user-blk-test
> > >  * other changes including using SocketAddress, coding style, etc.
> > > 
> > > v3:
> > >  * separate generic vhost-user-server code from vhost-user-blk-server
> > >    code
> > >  * re-write vu_message_read and kick hander function as coroutines to
> > >    directly call blk_co_preadv, blk_co_pwritev, etc.
> > >  * add aio_context notifier functions to support multi-threading model
> > >  * other fixes regarding coding style, warning report, etc.
> > > 
> > > v2:
> > >  * Only enable this feature for Linux because eventfd is a Linux-specific
> > >    feature
> > > 
> > > 
> > > This patch series is an implementation of vhost-user block device
> > > backend server, thanks to Stefan and Kevin's guidance.
> > > 
> > > Vhost-user block device backend server is a UserCreatable object and can be
> > > started using object_add,
> > > 
> > >  (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
> > >  (qemu) object_del ID
> > > 
> > > or appending the "-object" option when starting QEMU,
> > > 
> > >   $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
> > > 
> > > Then vhost-user client can connect to the server backend.
> > > For example, QEMU could act as a client,
> > > 
> > >   $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1
> > > 
> > > And guest OS could access this vhost-user block device after mounting it.
> > > 
> > > Coiby Xu (4):
> > >   Allow vu_message_read to be replaced
> > >   generic vhost user server
> > >   vhost-user block device backend server
> > >   new qTest case to test the vhost-user-blk-server
> > > 
> > >  block/Makefile.objs                        |   1 +
> > >  block/export/vhost-user-blk-server.c       | 716 ++++++++++++++++++++
> > >  block/export/vhost-user-blk-server.h       |  34 +
> > >  contrib/libvhost-user/libvhost-user-glib.c |   2 +-
> > >  contrib/libvhost-user/libvhost-user.c      |  11 +-
> > >  contrib/libvhost-user/libvhost-user.h      |  21 +
> > >  softmmu/vl.c                               |   4 +
> > >  tests/Makefile.include                     |   3 +-
> > >  tests/qtest/Makefile.include               |   2 +
> > >  tests/qtest/libqos/vhost-user-blk.c        | 130 ++++
> > >  tests/qtest/libqos/vhost-user-blk.h        |  44 ++
> > >  tests/qtest/libqtest.c                     |  54 +-
> > >  tests/qtest/libqtest.h                     |  38 ++
> > >  tests/qtest/vhost-user-blk-test.c          | 737 +++++++++++++++++++++
> > >  tests/vhost-user-bridge.c                  |   2 +
> > >  tools/virtiofsd/fuse_virtio.c              |   4 +-
> > >  util/Makefile.objs                         |   1 +
> > >  util/vhost-user-server.c                   | 406 ++++++++++++
> > >  util/vhost-user-server.h                   |  59 ++
> > >  19 files changed, 2229 insertions(+), 40 deletions(-)
> > >  create mode 100644 block/export/vhost-user-blk-server.c
> > >  create mode 100644 block/export/vhost-user-blk-server.h
> > >  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
> > >  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
> > >  create mode 100644 tests/qtest/vhost-user-blk-test.c
> > >  create mode 100644 util/vhost-user-server.c
> > >  create mode 100644 util/vhost-user-server.h
> > > 
> > 
> > Should we add an entry in the MAINTAINERS file for some of the new files?
> > (e.g. util/vhost-user-server.*)
> 
> Yes, please. Thank you!

I think the best thing should be to edit MAINTAINERS in this series,
since you're adding new files, but I don't know who will maintain them ;-)

Thanks,
Stefano



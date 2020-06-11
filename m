Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B662C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A31520747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpZdWyGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31520747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjMT1-0007RN-CV
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jjMSH-0006bX-FS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:37:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jjMSF-0005do-Rz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591879030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xP8Ggnvzb9GtfL1DGOgP29GBgZzvkfp6thQ+mfZkJ+o=;
 b=BpZdWyGTFwTWRBA7RJF7jDGRzBsKVY2r4UPgPQ2aL+mkrggi2L7mglXLgnsO+WUJ9lJ531
 +MI6aHy32quaNaWtGBG0JtfEz1aFjgSrRhy31UTf7IVdYOCnhzzP7bRT6MkqDgeIuiLFFq
 E0n0RAQyeQ9yXvxXMpTitlyAwFrJeSA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-vSLSYw53MOOUvjOd11azlw-1; Thu, 11 Jun 2020 08:37:08 -0400
X-MC-Unique: vSLSYw53MOOUvjOd11azlw-1
Received: by mail-wm1-f72.google.com with SMTP id b63so2870383wme.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xP8Ggnvzb9GtfL1DGOgP29GBgZzvkfp6thQ+mfZkJ+o=;
 b=hFrT5Wwfpd/POJdYslaGV2fm5rtRnH+T4ZD1HbV0U2gMkxbbqxPJvxsciBbiXdBQbX
 ru1iE30cYq0uvUT04Z7rTEdgX5nFRWGFdRxCJvGPWu7EYBl5eyH2SF7XR2pCF6NgNjPC
 l39atxAZiXSoP51h4HRinVO29gz5qPhrU7XSxhWJIP4o4SMvq4Vgv8QtVq4Ez+CPvUJW
 5rle8yucHP9BdX4ege3M+pkzo4SY29cQ+peSUFtZpNSFyFrKao/e8956LNjNEO8fDwxq
 9H1ZsDp5Uz4/3LZIIVnTIMDbJdqWgr9aw+Njci19PYonP7MRdYNjfKiUJAR9iANwQLue
 nybw==
X-Gm-Message-State: AOAM533j1Y1mRTQmC41Yzd8sd7wPyHgqkZpELvEt4AVAcTwSmBvgqCu5
 hP2uzx8nQAKzIqBqSvMfgLaK9ewjz6EyBg0ON3irAtawJ/w4p2/kvZBOODED2hGL6xbSWLJYcG2
 wZBjW/BzoJAlfNEY=
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr9379125wrw.91.1591879027017; 
 Thu, 11 Jun 2020 05:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+MXvlBbovROTcG/ylgeNna6A2UbRQmSWGCRtSqUAuEodQHFwqm6KmJ+NmdcPn/KX0DTEXlQ==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr9379080wrw.91.1591879026366; 
 Thu, 11 Jun 2020 05:37:06 -0700 (PDT)
Received: from steredhat (host-79-49-207-108.retail.telecomitalia.it.
 [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id b8sm4887719wrm.35.2020.06.11.05.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 05:37:05 -0700 (PDT)
Date: Thu, 11 Jun 2020 14:37:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v8 0/4] vhost-user block device backend implementation
Message-ID: <20200611123703.jpokj4m75woxt55f@steredhat>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200604233538.256325-1-coiby.xu@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Coiby Xu,

On Fri, Jun 05, 2020 at 07:35:34AM +0800, Coiby Xu wrote:
> v8
>  - re-try connecting to socket server to fix asan error
>  - fix license naming issue
> 
> v7
>  - fix docker-test-debug@fedora errors by freeing malloced memory
> 
> v6
>  - add missing license header and include guard
>  - vhost-user server only serve one client one time
>  - fix a bug in custom vu_message_read
>  - using qemu-storage-daemon to start vhost-user-blk-server
>  - a bug fix to pass docker-test-clang@ubuntu
> 
> v5:
>  * re-use vu_kick_cb in libvhost-user
>  * keeping processing VhostUserMsg in the same coroutine until there is
>    detachment/attachment of AIOContext
>  * Spawn separate coroutine for each VuVirtqElement
>  * Other changes including relocating vhost-user-blk-server.c, coding
>    style etc.
> 
> v4:
>  * add object properties in class_init
>  * relocate vhost-user-blk-test
>  * other changes including using SocketAddress, coding style, etc.
> 
> v3:
>  * separate generic vhost-user-server code from vhost-user-blk-server
>    code
>  * re-write vu_message_read and kick hander function as coroutines to
>    directly call blk_co_preadv, blk_co_pwritev, etc.
>  * add aio_context notifier functions to support multi-threading model
>  * other fixes regarding coding style, warning report, etc.
> 
> v2:
>  * Only enable this feature for Linux because eventfd is a Linux-specific
>    feature
> 
> 
> This patch series is an implementation of vhost-user block device
> backend server, thanks to Stefan and Kevin's guidance.
> 
> Vhost-user block device backend server is a UserCreatable object and can be
> started using object_add,
> 
>  (qemu) object_add vhost-user-blk-server,id=ID,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
>  (qemu) object_del ID
> 
> or appending the "-object" option when starting QEMU,
> 
>   $ -object vhost-user-blk-server,id=disk,unix-socket=/tmp/vhost-user-blk_vhost.socket,node-name=DRIVE_NAME,writable=off,blk-size=512
> 
> Then vhost-user client can connect to the server backend.
> For example, QEMU could act as a client,
> 
>   $ -m 256 -object memory-backend-memfd,id=mem,size=256M,share=on -numa node,memdev=mem -chardev socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket -device vhost-user-blk-pci,id=blk0,chardev=char1
> 
> And guest OS could access this vhost-user block device after mounting it.
> 
> Coiby Xu (4):
>   Allow vu_message_read to be replaced
>   generic vhost user server
>   vhost-user block device backend server
>   new qTest case to test the vhost-user-blk-server
> 
>  block/Makefile.objs                        |   1 +
>  block/export/vhost-user-blk-server.c       | 716 ++++++++++++++++++++
>  block/export/vhost-user-blk-server.h       |  34 +
>  contrib/libvhost-user/libvhost-user-glib.c |   2 +-
>  contrib/libvhost-user/libvhost-user.c      |  11 +-
>  contrib/libvhost-user/libvhost-user.h      |  21 +
>  softmmu/vl.c                               |   4 +
>  tests/Makefile.include                     |   3 +-
>  tests/qtest/Makefile.include               |   2 +
>  tests/qtest/libqos/vhost-user-blk.c        | 130 ++++
>  tests/qtest/libqos/vhost-user-blk.h        |  44 ++
>  tests/qtest/libqtest.c                     |  54 +-
>  tests/qtest/libqtest.h                     |  38 ++
>  tests/qtest/vhost-user-blk-test.c          | 737 +++++++++++++++++++++
>  tests/vhost-user-bridge.c                  |   2 +
>  tools/virtiofsd/fuse_virtio.c              |   4 +-
>  util/Makefile.objs                         |   1 +
>  util/vhost-user-server.c                   | 406 ++++++++++++
>  util/vhost-user-server.h                   |  59 ++
>  19 files changed, 2229 insertions(+), 40 deletions(-)
>  create mode 100644 block/export/vhost-user-blk-server.c
>  create mode 100644 block/export/vhost-user-blk-server.h
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>  create mode 100644 tests/qtest/vhost-user-blk-test.c
>  create mode 100644 util/vhost-user-server.c
>  create mode 100644 util/vhost-user-server.h
> 

Should we add an entry in the MAINTAINERS file for some of the new files?
(e.g. util/vhost-user-server.*)

Thanks,
Stefano



Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C0C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A32A21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A32A21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8HQ-00083A-83
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD8Ga-0007WH-Jp
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD8GZ-0005jF-CS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:27:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD8GZ-0005ir-3i
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:27:39 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43C1B3DE04
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:27:38 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id f15so6068660qth.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M3zbMdw/IGoPpcTit1ivVJq2ZE3+8MBHCLS1O9oaN5E=;
 b=aRwc+WXPAukeELwW+Bqu9GykY09tEGLZDx04U+80g8c+GBtPbgDa5H6SCH99jYPYIR
 6Q/yl7FuKuNUQwuozMtDIy8bkAp2k3Mg1iJhDkvrBnKWydLv4ws40jj/x5GZapafi4Lr
 jCHhvpvXZm3CcMA6wfqQHpJ5lzI4CM6JndcUC/UFPE9dr1at8ry93i8/Tm62GUwKAwre
 29Hq2iucaFKvgJGg8Tq3NPbynlyiEr+Oe8UIlDRqbU2M8+3sZRMHZsSQxLQ5sAEwzT5r
 Jjkhy0sDXiDOLJ1HhGGRRBuewEEMawfyY6bAZjcIJ9K+W4Pd7a6gTTsa8RhsEOvk1iDb
 GFMQ==
X-Gm-Message-State: APjAAAXd0xAaM5uShJjLuSstRTHmpiOKCnzRdpKaz4J8JYJhn8jcpjQG
 949VCsJwERorUQPNj7Idh2cBAEtfVHddbA19ZaSuR5ASH8n2PZXbpJJMSU60zGtQB44hWoXLrdh
 n2Va+7QO6Yfilys8=
X-Received: by 2002:ac8:16d9:: with SMTP id y25mr9013680qtk.72.1569421657226; 
 Wed, 25 Sep 2019 07:27:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDdQijDk4h5iUDTCNIZwUeK85dczRY2/4Ksp4A3I9Thgu/4a+qvbyB5vDfRBSa6q5Li7Gx9Q==
X-Received: by 2002:ac8:16d9:: with SMTP id y25mr9013668qtk.72.1569421657008; 
 Wed, 25 Sep 2019 07:27:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id k17sm3090231qtk.7.2019.09.25.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 07:27:36 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:27:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 0/3] Add virtio-fs (experimental)
Message-ID: <20190925102657-mutt-send-email-mst@kernel.org>
References: <20190917160057.11847-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917160057.11847-1-dgilbert@redhat.com>
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
Cc: mszeredi@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 05:00:54PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This set of patches adds the core of the virtio-fs support to qemu;
> it's marked experimental since the kernel patch isn't in yet; but
> it's nearly there;  the spec has passed the voting stage, and
> the kernel changes are queued in fuse-next.


Was going to apply this but turns out headers didn't land in Linux yet.
Replied on the specific patches.

>   A future set of patches will add the optional DAX mapping support.
> 
>   The actual qemu change is pretty minimal, since it's really only
> a virtio device with some queues.
> 
> Some links:
>   Mailing list: https://www.redhat.com/mailman/listinfo/virtio-fs
>   Dev tree: Including filesystem daemon: https://gitlab.com/virtio-fs/qemu
>   kernel:
>          dev world:
>             https://gitlab.com/virtio-fs/linux
>          fuse next:
>            https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next
>   virtio spec changes:
>          https://lists.oasis-open.org/archives/virtio-dev/201908/msg00112.html
> 
> v3
>   Split the kernel header update out
>     The contents correspond to the fuse-next world+a patch Stefan just
>     sent to make that use the newer 'num_request_queues' name
> 
>   Update copyright year,
>   Remove the assert in vuf_handle_output
>     the virtio core code sometimes calls it during cleanup if the
>     daemon dies first
>   (I've not changed the comment about guest_notifier_mask/virtio-pci
>    since that's copied in a bunch of virtio code going back ~5 years)
> 
> Dr. David Alan Gilbert (3):
>   virtio: Add virito_fs linux headers
>   virtio: add vhost-user-fs base device
>   virtio: add vhost-user-fs-pci device
> 
>  configure                                   |  13 +
>  hw/virtio/Makefile.objs                     |   2 +
>  hw/virtio/vhost-user-fs-pci.c               |  85 ++++++
>  hw/virtio/vhost-user-fs.c                   | 299 ++++++++++++++++++++
>  include/hw/virtio/vhost-user-fs.h           |  45 +++
>  include/standard-headers/linux/virtio_fs.h  |  41 +++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  7 files changed, 486 insertions(+)
>  create mode 100644 hw/virtio/vhost-user-fs-pci.c
>  create mode 100644 hw/virtio/vhost-user-fs.c
>  create mode 100644 include/hw/virtio/vhost-user-fs.h
>  create mode 100644 include/standard-headers/linux/virtio_fs.h
> 
> -- 
> 2.21.0


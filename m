Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BFFC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098E72171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098E72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHchC-0000sd-Ax
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:13:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcgL-0000WV-NK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcgK-00015L-Fw
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:12:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hHcgK-00014k-Ag
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:12:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id k14so231465qtb.0
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=rzQKaRZww6NIUnqpQG31dlUhQC68YulqUceUiZFekE8=;
	b=Cv3rT/qykI2kkjJw5QnBMjXZwRFF3yQIY5C0BQPXrtAK0Lv+QYsRU54Ed0tKAaXu+1
	+JA/VXLpVjZhZkQnnGJNV409Ze+r0k16cSgP1TBgCb5FGSnHBSqIorIeivGIN2l5mogS
	rTcKNcGmErKsnTeHFHrn0pDdbrDWZbnNtTsO4KE5RMxfeQDbCVKFaW5v8jlG61JYHuKR
	FJq9UEczaPQDs2ij3JmmFH5mWARsL85cZRUwy0GMDw85uM4nNK7ml5x3cqx70vdv78Wi
	VvvfYc/k0c4psMPxHWPkT04VoU0ZOnyn+TrJXlA5d0Lkrwjffz/Lh6OkANojYyGzng2A
	C0JQ==
X-Gm-Message-State: APjAAAWxyiy/Xn9gGsKQHjhCCHS/rDAusYc+NYNF+3hsgzPVgdj+BuK2
	LNNfUTmUThcHsjLKR6nQ5EcfBg==
X-Google-Smtp-Source: APXvYqxpVRq5LKDu+p0SnckaUPpJy+qr7KX6fZklM6bJYjYBTb6khGRLINbek3iyCHlHAuz4rG8isg==
X-Received: by 2002:ac8:6a02:: with SMTP id t2mr1396016qtr.253.1555715550326; 
	Fri, 19 Apr 2019 16:12:30 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	k44sm3496493qta.35.2019.04.19.16.12.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 16:12:29 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:12:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Streetman <dan.streetman@canonical.com>
Message-ID: <20190419191210-mutt-send-email-mst@kernel.org>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190416184624.15397-1-dan.streetman@canonical.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH 0/2] vhost-user race condition on shutdown
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: maxime.coquelin@redhat.com, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419231227.e_ACiAENYq9hgBj1iZDH5P7Nx05BealuY99MBTJDJ14@z>

On Tue, Apr 16, 2019 at 02:46:22PM -0400, Dan Streetman wrote:
> From: Dan Streetman <ddstreet@canonical.com>
> 
> Buglink: https://launchpad.net/bugs/1823458

Cc Maxime.


> This is a race condition between the normal shutdown of a guest
> and the handling of its vhost-user net being externally closed.
> It's explained in more detail at the bug link; the short version
> is that there are 2 problems, fixed by the 2 patches.  The first
> patch fixes the race condition where multiple threads call
> vhost_net_stop(), and the second patch prevents vhost-user from
> calling vhost_net_cleanup() on CHR_EVENT_CLOSED, because it will
> be cleaned up later and its fields will be accessed when
> vhost_net_stop() is called later.
> 
> As explained in the bug report, this requires a rather complicated
> setup to reproduce, and I'm not able to create a setup to reproduce
> it myself.  However this has been reported to me/Canonical, and the
> reporter is able to reproduce it consistently, so I've used them for
> debug and testing.  This reproduction was done with the older 2.5
> qemu, from Ubuntu Xenial; but the problem does still appear to exist
> in upstream qemu, based on review of the code, which is why I'm sending
> these patches.
> 
> Dan Streetman (2):
>   add VirtIONet vhost_stopped flag to prevent multiple stops
>   do not call vhost_net_cleanup() on running net from char user event
> 
>  hw/net/virtio-net.c            | 3 ++-
>  include/hw/virtio/virtio-net.h | 1 +
>  net/vhost-user.c               | 1 -
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1


Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A25FC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6433A2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6433A2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHcjc-0001kg-Jn
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:15:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcif-0001Gf-Dt
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hHcie-0002QB-4L
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:14:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hHcie-0002Ph-0a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:14:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id i14so6810902qtr.10
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=IeCXH8Ky+jp6FMiCaKH0kYSR67aveZm8ZKsLO+NfYKA=;
	b=BTqhwAVNGzk1cJ8dTsWFzMHIqwjOzx0sr45h/UEeIZhUeAMLe+E9aVNTMUaStsTrUi
	O24RInNgEhijVChMqiJ4a3BBJsH70iZxqMFDjBOSzys0dZFKGxtKjMcGZoPfpQNjxdwz
	xgLj/ICUrB49SLcA/FirSQdNQ5ot67mjYiRHMtKpCsbJIBM8oS0FntOVn6fyayV0hhom
	1CAO+Rzhj6Nt6Sj7AGZ+tRaGtkYoxtibxKAj4C21K2DFUf3S86ukdqKZU2tiJ4OCBUa2
	jLAADMnkxGD5tfBvMSOCmLz1EBNkzEAii+3Et6401zYxxjp8irUmQV+HkXr4nYYj0sbj
	0mcg==
X-Gm-Message-State: APjAAAVzSNRhlx2gCctyFWDKEhX+UW4SsYt5nZ3hsolcRWI9yMkoIDFV
	keGJ4VzrErzVrdtnNIVlBQZIog==
X-Google-Smtp-Source: APXvYqxoKKPCyZIsS4yYN94QPx8Z5PIDgASMwSTArE3CrM+RCimFEZV3l6HaqwURM++5rW/agu1l1A==
X-Received: by 2002:ac8:33cf:: with SMTP id d15mr5554055qtb.149.1555715695430; 
	Fri, 19 Apr 2019 16:14:55 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	f65sm2955388qkb.83.2019.04.19.16.14.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 16:14:54 -0700 (PDT)
Date: Fri, 19 Apr 2019 19:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Streetman <dan.streetman@canonical.com>
Message-ID: <20190419191328-mutt-send-email-mst@kernel.org>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190416184624.15397-2-dan.streetman@canonical.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419231452.fm6lLtKjXGpbTCidS8XSvoVuMIXqbjUO1Zqn3T9FUKE@z>

On Tue, Apr 16, 2019 at 02:46:23PM -0400, Dan Streetman wrote:
> From: Dan Streetman <ddstreet@canonical.com>
> 
> Buglink: https://launchpad.net/bugs/1823458
> 
> There is a race condition when using the vhost-user driver, between a guest
> shutdown and the vhost-user interface being closed.  This is explained in
> more detail at the bug link above; the short explanation is the vhost-user
> device can be closed while the main thread is in the middle of stopping
> the vhost_net.  In this case, the main thread handling shutdown will
> enter virtio_net_vhost_status() and move into the n->vhost_started (else)
> block, and call vhost_net_stop(); while it is running that function,
> another thread is notified that the vhost-user device has been closed,
> and (indirectly) calls into virtio_net_vhost_status() also.  Since the
> vhost_net status hasn't yet changed, the second thread also enters
> the n->vhost_started block, and also calls vhost_net_stop().  This
> causes problems for the second thread when it tries to stop the network
> that's already been stopped.
> 
> This adds a flag to the struct that's atomically set to prevent more than
> one thread from calling vhost_net_stop().  The atomic_fetch_inc() is likely
> overkill and probably could be done with a simple check-and-set, but
> since it's a race condition there would still be a (very, very) small
> window without using an atomic to set it.

How? Isn't all this under the BQL?

> 
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
>  hw/net/virtio-net.c            | 3 ++-
>  include/hw/virtio/virtio-net.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ffe0872fff..d36f50d5dd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/iov.h"
> +#include "qemu/atomic.h"
>  #include "hw/virtio/virtio.h"
>  #include "net/net.h"
>  #include "net/checksum.h"
> @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
>                           "falling back on userspace virtio", -r);
>              n->vhost_started = 0;
>          }
> -    } else {
> +    } else if (atomic_fetch_inc(&n->vhost_stopped) == 0) {
>          vhost_net_stop(vdev, n->nic->ncs, queues);
>          n->vhost_started = 0;
>      }
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b96f0c643f..d03fd933d0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -164,6 +164,7 @@ struct VirtIONet {
>      uint8_t nouni;
>      uint8_t nobcast;
>      uint8_t vhost_started;
> +    int vhost_stopped;
>      struct {
>          uint32_t in_use;
>          uint32_t first_multi;

OK questions same as any state:

- do we need to migrate this?
- reset it on device reset?

> -- 
> 2.20.1


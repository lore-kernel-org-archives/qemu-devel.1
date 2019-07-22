Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6AEC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740FF218EA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740FF218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUpU-0000Hv-Lb
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpUpL-0008Kt-28
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpUpK-0005Na-4V
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:41:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hpUpJ-0005MS-Uz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:41:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so34604602wmg.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mr9PkR41k95xu9r+Hc0XIR4t4irdiuIpaHXeSMYyE1s=;
 b=qITReEQ+fpd/MxxVnMsUYyOBJbSbyKUuOsSqpHy2p0d8FI0/F3RkSAIEkrTb9ofmUg
 kHxcwr5qKjpw/YWLJWMRfuBf5Z+EpGv23VMX9UlMd9FOTENXtG5AEkMt0HaOYzx7a/3R
 7jiNDgaN8qoNt1r+CexvQxrHJqIPYhH7opmsH/i91eZ956KGbd+6M7OLfDtmaLs/ETa5
 dlPlHdd7blj8TryJJEnhRQ/LdY4Re1UmfJZzZ3fqbwcuy/tBZLV2b+qoEtiSK3Ex3Fr6
 QJrmHEIF/tZTh1gJcCvw6FD/2gOFJx1k++ilOVlSwh8Ka1E1oVQIDE/2l0Vm0sP7Uip5
 x9ZA==
X-Gm-Message-State: APjAAAV+WmhUiuUsHZU7BwkbNNactoNy2UaSJTKyxztl9d2Y6pSIxU+d
 TTPhglMRRfN96uNMDMCHsR7pNg==
X-Google-Smtp-Source: APXvYqziwMHH2AdYBX6NEq2bm2arzcW9dRprq/q/PyWZIOJttLBvkTt4KW4eN/M8TekQsCV2udoqog==
X-Received: by 2002:a1c:1b97:: with SMTP id
 b145mr59935800wmb.158.1563788508387; 
 Mon, 22 Jul 2019 02:41:48 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id s15sm22155596wrw.21.2019.07.22.02.41.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 02:41:47 -0700 (PDT)
Date: Mon, 22 Jul 2019 11:41:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190722094145.yjqqmrbqkm56u7k5@steredhat>
References: <20190719151920.22586-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719151920.22586-1-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2] virtio-net: Always check for guest
 header length
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 03:21:15PM +0000, Oleinik, Alexander wrote:
> While fuzzing the virtio-net tx vq, I ran into an assertion failure due
> to iov_copy offsets larger than the total iov size. Though there is
> a check to cover this, it does not execute when !n->has_vnet_hdr. This
> change always copies the guest header into the mhdr buffer and checks its
> length, even if mhdr is not needed.
> 
> The call stack for the assertion failure:
> 
>  #8 in __assert_fail (libc.so.6+0x300f1)
>  #9 in iov_copy iov.c:266:5
>  #10 in virtio_net_flush_tx virtio-net.c:2073:23
>  #11 in virtio_net_tx_bh virtio-net.c:2197:11
>  #12 in aio_bh_poll async.c:118:13
>  #13 in aio_dispatch aio-posix.c:460:5
>  #14 in aio_ctx_dispatch async.c:261:5
>  #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
>  #16 in glib_pollfds_poll main-loop.c:213:9
>  #17 in os_host_main_loop_wait main-loop.c:236
>  #18 in main_loop_wait main-loop.c:512
>  #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  hw/net/virtio-net.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


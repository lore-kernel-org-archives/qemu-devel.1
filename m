Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EE5ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE9F206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE9F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvkQ-00077v-3W
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIvfm-0001m0-8y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIvfk-0007P5-4W
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:13:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIvfj-0007OQ-S4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:13:36 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CA0F83F3D
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 14:13:34 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id j5so9531693qtn.10
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 07:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lQoM6SVgSl+WUsWqGtYAQJaCewCcSYBKjWOyzD9L0gQ=;
 b=G3QJJbFWkRUjGln7Rwrcpfj8Pqgz53nfJLOwrt2nL+aTGQ2fkatDxVFHtPeAnNwl+n
 d1R/ozht8T0a6+LoK0Hxye2Pnz5sDJ2LAPg0J9OUyyXWdpaoah+LtmTM6qZkVJC416dN
 mWnazKNu+vrGdWzmpEa+FZJtnhltdSPdzHnug5pSOGy92MlVDKfiWawu8eyWU7ATwgoe
 IkN9u1nPUJ9cumQBo8V83do207KoGPcDWkHhnpCx62TRQODFzVKMPT6Uc7Zyoli58pEr
 jLJUlK7hXSlDhFGn+JDopvOh+BrQMvC4n/0Eb80fOn8TGGO/uOfPqs7sdXPPU1rpj/Ee
 Tm8A==
X-Gm-Message-State: APjAAAV5p2oEKErTZCvoh9Swq9pfLIpA9aPkVLG7JhXpiosAY8nw9YzQ
 gJZqQpCmZ/MGW81o4fajotXAygmESPo4BQxsMZ2fo6s5wnasKbvTQakQSTN7/isGyKgnEvdGnjE
 gTmPfSgDdaUIeTew=
X-Received: by 2002:a0c:8731:: with SMTP id 46mr16155311qvh.141.1570803212786; 
 Fri, 11 Oct 2019 07:13:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAASb3gjZlozG19qgcwrpxSU0KZwm5JB+sCE1oCGKCpT3ECttkgZ+oJuzpk+97VRMvupWWKQ==
X-Received: by 2002:a0c:8731:: with SMTP id 46mr16155286qvh.141.1570803212452; 
 Fri, 11 Oct 2019 07:13:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 g25sm4022997qtp.96.2019.10.11.07.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 07:13:31 -0700 (PDT)
Date: Fri, 11 Oct 2019 10:13:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Subject: Re: [PATCH v4 2/2] virtio-net: prevent offloads reset on migration
Message-ID: <20191011101256-mutt-send-email-mst@kernel.org>
References: <1570802284-3064-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <1570802284-3064-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570802284-3064-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 03:58:04PM +0200, Mikhail Sennikovsky wrote:
> Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET
> command are not preserved on VM migration.
> Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_FEATURES)
> get enabled.
> What happens is: first the VirtIONet::curr_guest_offloads gets restored and offloads
> are getting set correctly:
> 
>  #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=0, tso6=0, ecn=0, ufo=0) at net/net.c:474
>  #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
>  #2  virtio_net_post_load_device (opaque=0x555557701ca0, version_id=11) at hw/net/virtio-net.c:2334
>  #3  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577c80 <vmstate_virtio_net_device>, opaque=0x555557701ca0, version_id=11)
>      at migration/vmstate.c:168
>  #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2197
>  #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
>  #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
>  #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
>  #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
>  #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
>  #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
>  #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449
> 
> However later on the features are getting restored, and offloads get reset to
> everything supported by features:
> 
>  #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=1, tso6=1, ecn=0, ufo=0) at net/net.c:474
>  #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
>  #2  virtio_net_set_features (vdev=0x555557701ca0, features=5104441767) at hw/net/virtio-net.c:773
>  #3  virtio_set_features_nocheck (vdev=0x555557701ca0, val=5104441767) at hw/virtio/virtio.c:2052
>  #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2220
>  #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
>  #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
>  #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
>  #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
>  #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
>  #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
>  #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449
> 
> Fix this by preserving the state in saved_guest_offloads field and
> pushing out offload initialization to the new post load hook.
> 
> Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>

kind of ugly, but works:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Jason can you merge this and the previous patch pls?

> ---
>  hw/net/virtio-net.c            | 27 ++++++++++++++++++++++++---
>  include/hw/virtio/virtio-net.h |  2 ++
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index b9e1cd7..6adb0fe 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2330,9 +2330,13 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>          n->curr_guest_offloads = virtio_net_supported_guest_offloads(n);
>      }
>  
> -    if (peer_has_vnet_hdr(n)) {
> -        virtio_net_apply_guest_offloads(n);
> -    }
> +    /*
> +     * curr_guest_offloads will be later overwritten by the
> +     * virtio_set_features_nocheck call done from the virtio_load.
> +     * Here we make sure it is preserved and restored accordingly
> +     * in the virtio_net_post_load_virtio callback.
> +     */
> +    n->saved_guest_offloads = n->curr_guest_offloads;
>  
>      virtio_net_set_queues(n);
>  
> @@ -2367,6 +2371,22 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>      return 0;
>  }
>  
> +static int virtio_net_post_load_virtio(VirtIODevice *vdev)
> +{
> +    VirtIONet *n = VIRTIO_NET(vdev);
> +    /*
> +     * The actual needed state is now in saved_guest_offloads,
> +     * see virtio_net_post_load_device for detail.
> +     * Restore it back and apply the desired offloads.
> +     */
> +    n->curr_guest_offloads = n->saved_guest_offloads;
> +    if (peer_has_vnet_hdr(n)) {
> +        virtio_net_apply_guest_offloads(n);
> +    }
> +
> +    return 0;
> +}
> +
>  /* tx_waiting field of a VirtIONetQueue */
>  static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
>      .name = "virtio-net-queue-tx_waiting",
> @@ -2909,6 +2929,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
>      vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
>      vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
>      vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
> +    vdc->post_load = virtio_net_post_load_virtio;
>      vdc->vmsd = &vmstate_virtio_net_device;
>  }
>  
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b96f0c6..07a9319 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -182,6 +182,8 @@ struct VirtIONet {
>      char *netclient_name;
>      char *netclient_type;
>      uint64_t curr_guest_offloads;
> +    /* used on saved state restore phase to preserve the curr_guest_offloads */
> +    uint64_t saved_guest_offloads;
>      AnnounceTimer announce_timer;
>      bool needs_vnet_hdr_swap;
>      bool mtu_bypass_backend;
> -- 
> 2.7.4


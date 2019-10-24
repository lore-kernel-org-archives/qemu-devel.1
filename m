Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBFCA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66217205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="YrLAtOpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66217205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeV9-0001vT-1O
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iNdYk-00010P-8r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iNdYi-0002BU-Fj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:53:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iNdYi-0002AF-7X
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:53:48 -0400
Received: by mail-ot1-x342.google.com with SMTP id m19so20745244otp.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HmogxET9v+HvnhvGZBsQkdFHds5aLbermjRr6JUrQp8=;
 b=YrLAtOpUBXjgwmq4BrlVCczGxguTW8eo60i2zbx01xNmlStCkd94c49C1dQuhGUf0L
 8FbgJddg2g2O3zGPbVbXSI0fUiy6V5hJStzBYB/Uj7Sx8INL1/xLkIt8ImJaG2IUcI2Y
 7PIvdC7SAAuX7UAo6CKvTALkaDTnebWjZw8WISZ0t/KyK/6IarkpOp/9ehtAgeg3zy2Q
 DOP5b/RQmTkcyaQd0cpkPRafuIbT6dGfoyFfw5N+cdbqGDCyMtIPOtm/CZRbkdDUjlvq
 Lfn8UOZxadVX4rkySki061+3udCEVKvVNrxYxO5u6wk5sgQVCN4YT8S0KPNF8LkDyodn
 ka3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HmogxET9v+HvnhvGZBsQkdFHds5aLbermjRr6JUrQp8=;
 b=oje4VoX5i2/29hO0+GKwEE9J/eJvj/siZNnNOm+6Ok3z7lXV6SmeuBJLze9MOHg+4L
 ewwzEdnMOy0ak3/iqG7S/vyhtXPD1W1rQ8bjiBrRNB8F/1wxXqykEdOnomLxr6V4MkNx
 gjfVl6C1uNNlO1w7z9aecNLZuam1HGVvpCbXrZ62hPOlkySLxjmKJK7bPT/O+sHVan6/
 kUzhUeA+iYMvNL4/OmSGUmXUSVrsbzckJMENZ6VSw+CpfoHbKz7fZRMQJNmN0P72iFaK
 efBS3SihYHNZhXGWs26E43V51Y0xSIyLV+4z7KKCEHVstS9oGp7Rr9R0a2CF799U2njC
 s8mg==
X-Gm-Message-State: APjAAAUTvnjUFEjZoCfS4i8T3MQN1PnOnuwnRYZE2+/T/GK5NwfxoE4a
 KvrWYqld6SS5K1d+2sV+Xq0bBzyGahAoRB1HRVWbGg==
X-Google-Smtp-Source: APXvYqyB+DOmh/ecMs3uJ2QJQ785Y4v8stzCIOSiaeSXuEiuB1xx9Q3sdqBVXvl748D+jpj92sK+dzvE+j5cZfVm0YQ=
X-Received: by 2002:a9d:458a:: with SMTP id x10mr11195894ote.365.1571925226700; 
 Thu, 24 Oct 2019 06:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <1570802284-3064-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <1570802284-3064-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
 <20191011101256-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191011101256-mutt-send-email-mst@kernel.org>
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Date: Thu, 24 Oct 2019 15:53:35 +0200
Message-ID: <CALHVEJYEaoUaWAzhK0313EXdu2ccyfRvDHGVB2EkkT2p33y4xA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] virtio-net: prevent offloads reset on migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 stefanha@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Guys,

Sorry I was on vacation last week, so did not track it much.
Seems like the patch has not been applied yet. Is this because there
are still some concerns about the way of fixing the problem?

Regards,
Mikhail


Am Fr., 11. Okt. 2019 um 16:13 Uhr schrieb Michael S. Tsirkin <mst@redhat.com>:
>
> On Fri, Oct 11, 2019 at 03:58:04PM +0200, Mikhail Sennikovsky wrote:
> > Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET
> > command are not preserved on VM migration.
> > Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_FEATURES)
> > get enabled.
> > What happens is: first the VirtIONet::curr_guest_offloads gets restored and offloads
> > are getting set correctly:
> >
> >  #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=0, tso6=0, ecn=0, ufo=0) at net/net.c:474
> >  #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
> >  #2  virtio_net_post_load_device (opaque=0x555557701ca0, version_id=11) at hw/net/virtio-net.c:2334
> >  #3  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577c80 <vmstate_virtio_net_device>, opaque=0x555557701ca0, version_id=11)
> >      at migration/vmstate.c:168
> >  #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2197
> >  #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
> >  #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
> >  #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
> >  #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
> >  #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
> >  #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
> >  #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449
> >
> > However later on the features are getting restored, and offloads get reset to
> > everything supported by features:
> >
> >  #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=1, tso6=1, ecn=0, ufo=0) at net/net.c:474
> >  #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
> >  #2  virtio_net_set_features (vdev=0x555557701ca0, features=5104441767) at hw/net/virtio-net.c:773
> >  #3  virtio_set_features_nocheck (vdev=0x555557701ca0, val=5104441767) at hw/virtio/virtio.c:2052
> >  #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2220
> >  #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
> >  #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
> >  #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
> >  #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
> >  #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
> >  #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
> >  #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449
> >
> > Fix this by preserving the state in saved_guest_offloads field and
> > pushing out offload initialization to the new post load hook.
> >
> > Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
>
> kind of ugly, but works:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Jason can you merge this and the previous patch pls?
>
> > ---
> >  hw/net/virtio-net.c            | 27 ++++++++++++++++++++++++---
> >  include/hw/virtio/virtio-net.h |  2 ++
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index b9e1cd7..6adb0fe 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -2330,9 +2330,13 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
> >          n->curr_guest_offloads = virtio_net_supported_guest_offloads(n);
> >      }
> >
> > -    if (peer_has_vnet_hdr(n)) {
> > -        virtio_net_apply_guest_offloads(n);
> > -    }
> > +    /*
> > +     * curr_guest_offloads will be later overwritten by the
> > +     * virtio_set_features_nocheck call done from the virtio_load.
> > +     * Here we make sure it is preserved and restored accordingly
> > +     * in the virtio_net_post_load_virtio callback.
> > +     */
> > +    n->saved_guest_offloads = n->curr_guest_offloads;
> >
> >      virtio_net_set_queues(n);
> >
> > @@ -2367,6 +2371,22 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
> >      return 0;
> >  }
> >
> > +static int virtio_net_post_load_virtio(VirtIODevice *vdev)
> > +{
> > +    VirtIONet *n = VIRTIO_NET(vdev);
> > +    /*
> > +     * The actual needed state is now in saved_guest_offloads,
> > +     * see virtio_net_post_load_device for detail.
> > +     * Restore it back and apply the desired offloads.
> > +     */
> > +    n->curr_guest_offloads = n->saved_guest_offloads;
> > +    if (peer_has_vnet_hdr(n)) {
> > +        virtio_net_apply_guest_offloads(n);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  /* tx_waiting field of a VirtIONetQueue */
> >  static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
> >      .name = "virtio-net-queue-tx_waiting",
> > @@ -2909,6 +2929,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
> >      vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
> >      vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
> >      vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
> > +    vdc->post_load = virtio_net_post_load_virtio;
> >      vdc->vmsd = &vmstate_virtio_net_device;
> >  }
> >
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> > index b96f0c6..07a9319 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -182,6 +182,8 @@ struct VirtIONet {
> >      char *netclient_name;
> >      char *netclient_type;
> >      uint64_t curr_guest_offloads;
> > +    /* used on saved state restore phase to preserve the curr_guest_offloads */
> > +    uint64_t saved_guest_offloads;
> >      AnnounceTimer announce_timer;
> >      bool needs_vnet_hdr_swap;
> >      bool mtu_bypass_backend;
> > --
> > 2.7.4


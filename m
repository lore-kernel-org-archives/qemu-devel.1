Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FCC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A71D23A63
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYXVQWN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A71D23A63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUrn-0002Kb-Co
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 19:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kKUqH-0001Tq-2X
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:03:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kKUqF-0007nX-4b
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:03:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id m13so9439956otl.9
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E99WVkrNU7/pkSa53shdU6qWYyXj6gfrbMTJ87HX1hc=;
 b=SYXVQWN9GbRCk2UHrAxSgggP3VTFTyADZEMP2yCPaj/aVwQ4Y4U3pq0JrqVCKn/oWI
 G23RS77n6FHMpc9pPOA0E3DT7sXJh7T8af5hEDqbuPZbppNLP4MkV48zo0pAiY940cSi
 S/9PB0zO/JTmnukQoVdmsWntG846y2UAMYXygxNR+m5DAuXeGNGSir1aBxTf0RBlWW0K
 WddrFa246PX2Xop50MOp4Sbp9OG8EV4R7U+2ndEXYuDvzJzAVGwdFVhQreBwyGsZ0Qor
 tX9aOS01WRcQzKd6OEDxiUhmoSyCUI3x2HwcRHNzz7bVGjE9lgR5aDP3M1rvMuYmEw4R
 sWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E99WVkrNU7/pkSa53shdU6qWYyXj6gfrbMTJ87HX1hc=;
 b=EarG4j93OJfZ7at7l/j1+24SetK8p0tvibutcL4lpTQ5EwvuAy6f/iUfcrt6cgEhCs
 AO73msXPTcLBLqve+LofBk0TXX/zlt9WyawfL+7A8j1uEgsX04rGfDjfCsIPuh0djc/y
 TNOg19ys9o/YHsPvsdZslAX1SLE6HGPpMBxmifjMQTapby+itObhhZbLgxMc1BPEC0Pr
 P2vYdm0tjY5pZVSyn8kl7QqXd5+4llVoc5KPlxZGJlBCAE/ieV6cm5zy4eNR9uzlUchi
 Eo1zOoT5bEUFTsjYlruWmLKue2qfyElxV0sO1CN2axxaYajKkNZ1SXDYeve50FeRDig+
 J8sw==
X-Gm-Message-State: AOAM530jgfS6py9NksWYKHiyritd80GAXTxKtULeHet4aVVqdEXKmZe7
 Zj/elAN2BRYNzC58wrJ5t5bdlglSL01zAv+EK2Q=
X-Google-Smtp-Source: ABdhPJzrli18IA6cg86/wiEFld9rXGo2DS5qRBhUxOaXHfs3WMATuVs/J/4R5LUlZzfPo0wilm10GKNjMKvhXBow8f4=
X-Received: by 2002:a9d:2384:: with SMTP id t4mr1007583otb.337.1600729405469; 
 Mon, 21 Sep 2020 16:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134851.7817-1-jin.yu@intel.com>
 <CAFubqFuBY9-KpxUfb7HorV-q960Ns4EiCLCzq-TRFciDuaUiUQ@mail.gmail.com>
 <MN2PR11MB372522EE6FFC2CD0ECF2ADE680200@MN2PR11MB3725.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB372522EE6FFC2CD0ECF2ADE680200@MN2PR11MB3725.namprd11.prod.outlook.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 21 Sep 2020 19:03:14 -0400
Message-ID: <CAFubqFtpkNUVq5ZYa2LK96LF0CRcBGx7PtkxNGb8L++nhZOUHA@mail.gmail.com>
Subject: Re: [PATCH] vhost-blk: set features before setting inflight feature
To: "Yu, Jin" <jin.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I see your point - all the open source backends I could find which
support VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD rely on knowing the vq
type to allocate the fd.

That said, it looks like dpdk supports both
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD and packed vqs without needing
such an API https://github.com/DPDK/dpdk/blob/main/lib/librte_vhost/vhost_user.c#L1509.
I'm not sure exactly how the VQ state is sent to DPDK before the
inflight fd negotiation, but ideally vhost-user-blk could be made to
work the same way. Maybe someone with more vhost-net and dpdk
knowledge could chime in on how vhost-net backends do it?

On Mon, Sep 14, 2020 at 10:52 PM Yu, Jin <jin.yu@intel.com> wrote:
>
> > -----Original Message-----
> > From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
> > Sent: Tuesday, September 15, 2020 9:25 AM
> > To: Yu, Jin <jin.yu@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; Raphael Norwitz
> > <raphael.norwitz@nutanix.com>; Kevin Wolf <kwolf@redhat.com>; Max
> > Reitz <mreitz@redhat.com>; QEMU <qemu-devel@nongnu.org>
> > Subject: Re: [PATCH] vhost-blk: set features before setting inflight feature
> >
> > Backends already receive the format in vhost_dev_start before the memory
> > tables are set or any of the virtqueues are started. Can you elaborate on why
> > you need to know the virtqueue format before setting the inflight FD?
> >
> First, when the backend receives the get_inflight_fd sent by QEMU, it needs to allocate vq's inflight memory,
> and it needs to know the format of vq.
> Second, when the backend reconnects to QEMU, QEMU sends set_inflight_fd, and the backend restores the inflight memory of vq.
> It also needs to know the format of vq.
> Thanks.
> > On Thu, Sep 10, 2020 at 2:15 AM Jin Yu <jin.yu@intel.com> wrote:
> > >
> > > Virtqueue has split and packed, so before setting inflight, you need
> > > to inform the back-end virtqueue format.
> > >
> > > Signed-off-by: Jin Yu <jin.yu@intel.com>
> > > ---
> > >  hw/block/vhost-user-blk.c |  6 ++++++
> > >  hw/virtio/vhost.c         | 18 ++++++++++++++++++
> > >  include/hw/virtio/vhost.h |  1 +
> > >  3 files changed, 25 insertions(+)
> > >
> > > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > > index 39aec42dae..9e0e9ebec0 100644
> > > --- a/hw/block/vhost-user-blk.c
> > > +++ b/hw/block/vhost-user-blk.c
> > > @@ -131,6 +131,12 @@ static int vhost_user_blk_start(VirtIODevice
> > > *vdev)
> > >
> > >      s->dev.acked_features = vdev->guest_features;
> > >
> > > +    ret = vhost_dev_prepare_inflight(&s->dev);
> > > +    if (ret < 0) {
> > > +        error_report("Error set inflight format: %d", -ret);
> > > +        goto err_guest_notifiers;
> > > +    }
> > > +
> > >      if (!s->inflight->addr) {
> > >          ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
> > >          if (ret < 0) {
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
> > > 1a1384e7a6..4027c11886 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -1616,6 +1616,24 @@ int vhost_dev_load_inflight(struct vhost_inflight
> > *inflight, QEMUFile *f)
> > >      return 0;
> > >  }
> > >
> > > +int vhost_dev_prepare_inflight(struct vhost_dev *hdev) {
> > > +    int r;
> > > +
> > > +    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
> > > +        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    r = vhost_dev_set_features(hdev, hdev->log_enabled);
> > > +    if (r < 0) {
> > > +        VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
> > > +        return r;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  int vhost_dev_set_inflight(struct vhost_dev *dev,
> > >                             struct vhost_inflight *inflight)  { diff
> > > --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h index
> > > 767a95ec0b..4e2fc75528 100644
> > > --- a/include/hw/virtio/vhost.h
> > > +++ b/include/hw/virtio/vhost.h
> > > @@ -140,6 +140,7 @@ void vhost_dev_reset_inflight(struct
> > > vhost_inflight *inflight);  void vhost_dev_free_inflight(struct
> > > vhost_inflight *inflight);  void vhost_dev_save_inflight(struct
> > > vhost_inflight *inflight, QEMUFile *f);  int
> > > vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
> > > +int vhost_dev_prepare_inflight(struct vhost_dev *hdev);
> > >  int vhost_dev_set_inflight(struct vhost_dev *dev,
> > >                             struct vhost_inflight *inflight);  int
> > > vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
> > > --
> > > 2.17.2
> > >
> > >


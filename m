Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D73C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 03:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A027F20719
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 03:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTN9Csae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A027F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCwtJ-0004O6-Or
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 23:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kCwsO-0003RQ-86; Mon, 31 Aug 2020 23:22:28 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kCwsM-0004Gc-K3; Mon, 31 Aug 2020 23:22:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id x19so2953101oix.3;
 Mon, 31 Aug 2020 20:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3d2ZNUUIrmSwsXjDWMA+bBt4z4tiOBcpvhGS/hr11UA=;
 b=aTN9Csae1tzHG2XWfeFsPGC4I9D82gjbmwz6FCOCU6ybx9Kn5T/6D4+1uH8arPlSMQ
 19yOD5BNsO+KxmsXmbV6BQbR6hvMHSMO/bfKxrQmJ4LUTeSaj/k47NgfIFvOYzS7PZec
 JnpmTVfRawW5vvQYDFs3zimlvobl5NYI7MMa0unCAZjECsLqNddpOzM12zke3jac4fi2
 ThxiWq640Pm+todqprOxQbtqHb2gnjpyFvmnxPVRkuIZnkXtsMVCrkggF03ApF5lVCfM
 Uk8v0gxutc60BVpIVqqgkocc4Rex4QVvTXsEQSZJFLu5lhxImegAbX69H0oBtdqZDn2b
 D/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3d2ZNUUIrmSwsXjDWMA+bBt4z4tiOBcpvhGS/hr11UA=;
 b=GhsA/VmKcmaOAFNmncYik30xm60qDPbH+ZxpXU6z6dZAPndCkBZFSbDuea+EJ2sEtd
 iGa2SlF2lIrjpbbnjhsNUM9yV0FnfwU7k6hjFZh7ZZRp8i7cRam2zgtJ9oEjx9EtH3Ip
 vCUSm45hRurSw8omtL3hLRA9EFRpTIOgQrH5hjSS/n+BRwqZ096rB2SzwrDcZ/VW/3d2
 OK/7MztIYAH47OTatY6FRvzMXD/AjzkFFtf73rviB7NH6S6ghb57MIn99kCAp2XgY60A
 JuQeKIyXHLec9E3XVSnwLOk/TpeXfP3IEXmB8+7k+jOtkvBF1jyIYc/upDWDgHwdC3Vd
 DgBQ==
X-Gm-Message-State: AOAM531a2vAriG5HepcVye8B9tmRhehQDJhWFkZUM7qUePOPfdHt5rgj
 E4ln8liUr5YJxBBaNVyrhm6ls+1UNaBi9nzgYHQ=
X-Google-Smtp-Source: ABdhPJyHzrNOz74TVAvma1tXj8dXwg7djdUhusROVh5iuCmn2aW13X9GElOkt1EKrKhyelVfMobBcb1xB2QIqXDFjRw=
X-Received: by 2002:a05:6808:49:: with SMTP id v9mr1425819oic.51.1598930545211; 
 Mon, 31 Aug 2020 20:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598257838.git.dimastep@yandex-team.ru>
 <a2eca26b79e1fcc30128a266bfa416237366c533.1598257838.git.dimastep@yandex-team.ru>
 <CAFubqFsnc3VjkYB-CqgeQ6Knwtvgb0Zyw-nOHD1CugLzTBe9Ew@mail.gmail.com>
 <20200831083740.GA6083@dimastep-nix>
In-Reply-To: <20200831083740.GA6083@dimastep-nix>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 31 Aug 2020 23:22:14 -0400
Message-ID: <CAFubqFu8ek_gBVFV1+MaLHnhjkQ=955QYP8Ss84diZrkbuNOAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] vhost: check queue state in the vhost_dev_set_log
 routine
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 4:37 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> On Thu, Aug 27, 2020 at 09:46:03PM -0400, Raphael Norwitz wrote:
> > On Mon, Aug 24, 2020 at 4:41 AM Dima Stepanov <dimastep@yandex-team.ru>=
 wrote:
> > >
> > > If the vhost-user-blk daemon provides only one virtqueue, but device =
was
> > > added with several queues, then QEMU will send more VHOST-USER comman=
d
> > > than expected by daemon side. The vhost_virtqueue_start() routine
> > > handles such case by checking the return value from the
> > > virtio_queue_get_desc_addr() function call. Add the same check to the
> > > vhost_dev_set_log() routine.
> > >
> > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > > ---
> > >  hw/virtio/vhost.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index ffef7ab..a33ffd4 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -825,12 +825,24 @@ static int vhost_dev_set_features(struct vhost_=
dev *dev,
> > >  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> > >  {
> > >      int r, i, idx;
> > > +    hwaddr addr;
> > > +
> > >      r =3D vhost_dev_set_features(dev, enable_log);
> > >      if (r < 0) {
> > >          goto err_features;
> > >      }
> > >      for (i =3D 0; i < dev->nvqs; ++i) {
> > >          idx =3D dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_inde=
x + i);
> > > +        addr =3D virtio_queue_get_desc_addr(dev->vdev, idx);
> > > +        if (!addr) {
> > > +            /*
> > > +             * The queue might not be ready for start. If this
> > > +             * is the case there is no reason to continue the proces=
s.
> > > +             * The similar logic is used by the vhost_virtqueue_star=
t()
> > > +             * routine.
> > > +             */
> >
> > Shouldn=E2=80=99t we goto err_vq here to reset the logging state of any=
 vqs
> > which have already been set?
> As i understand it, no we shouldn't reset the state of other queues. In
> general it is pretty valid case. Let's assume that the backend
> vhost-user device supports only two queues. But for instance, the QEMU
> command line is using value 4 to define number of virtqueues of such
> device. In this case only 2 queues will be initializaed.

I see - makes more sense now.

>
> I've tried to reflect it in the comment section, that the
> vhost_virtqueue_start() routine has been alread made the same:
>   "if a queue isn't ready for start, just return 0 without any error"
> So i made the same here.
>

In your example is a reason why, if queue 3 is uninitialized, queue 4
must also be uninitialized? I realize queue 4 being initialized while
queue 3 is not is a strange case, but it may still make the code more
robust to use a "continue" here instead of a "break". This also seems
more like the logic in vhost_virtqueue_start()/vhost_dev_start().

> I've found this issue, while testing migration with the default
> vhost-user-blk daemon. It fails with assert or sigsegv (don't remember),
> because it receives NULL for the queues it doesn't have. In general
> the daemon should not fall, because of unexpected VHOST_USER
> communication, but also there is no reason for QEMU to send additional
> packets.
>
> >
> > > +            break;
> > > +        }
> > >          r =3D vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
> > >                                       enable_log);
> > >          if (r < 0) {
> > > --
> > > 2.7.4
> > >
> > >


Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0FFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702E62067D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icu+Pr6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702E62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7sF-0001aK-El
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kY7q6-0008VU-A8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:19:38 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:34027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kY7q0-000560-Mu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:19:37 -0400
Received: by mail-yb1-xb44.google.com with SMTP id o70so2155933ybc.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lxcYkXAHKsoB60PAcCUe+ktmsd2SU8nSxyCpHKofuUs=;
 b=icu+Pr6vzo3zVGbLOrkjT5aaS4jceBuNcntW/ksb5C5oK6naTDmy759cEUoVfO+u8o
 vfjJ6q6Ys0WhnQ3Zt2gFD/7Ojb70GLcpAjwfldeQ/JaNMWf8cEB2njJvhEZT2ctpQJi8
 83gRlZFotzGe5t6fOFx6HykIfHk0MBgD3RLg/8cNB9Wclt3khtgkElDrBCkjz2RJl1Ex
 3LsgdRi2db4Pfv0/e2B7o9g/U0z2Vc2AbfsvMnkWkXh3NkjuAEODk2n2Y62W+EQ+enow
 vc6Ld+R7+5Et5gCFgxOQUC7zIj8smgs/+J3DPyRj4//8bHmisr5GjVMIJm0lFWsdqcbo
 6Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lxcYkXAHKsoB60PAcCUe+ktmsd2SU8nSxyCpHKofuUs=;
 b=FiAO86oUSGPymlIvjB6F07dFZ9dnPWtoyEnIQc1otpDIFkLE8EJ3jcmK9dofNA+jgb
 5hXOnfb+g4grfHIltQuS8t3E+BxFxfmnENhwSmlCIcl2ijQbGgPz2akBVksb4uxISWoK
 cT6LpivGeVwMrDWexPR6WEoo/Uy+E4vkIzkiilQpuNJe9EYbo/xfMeyuFfe6MZYx90cQ
 UUKA0zsRcxwafD7nuuVx2x1b8Ewr51/ZAqs8pPven67UdLvogWuk0TtpGnu+Av8Cp9nm
 ypJLMIZIIvibCOfNhckHKw4xSUnCfJaWRIQ/rvH1gHtiuwLdSHwf+jDGUje09Hdbge2o
 Rt4Q==
X-Gm-Message-State: AOAM530bRLWEngSMD7lyDrZ8bDQDBdq3MxPn0Al0Y1wiz1PsasDdseH3
 saGfS3YxD5N7pnNne+jY69/uklulcbWavuPYHpM=
X-Google-Smtp-Source: ABdhPJzKgFVUd9FawGG4zWwRLdJUqgr18KtkHlMnwSsFFckZQlflmcHEdKVj3uEaaq9J3/jFTW1br8SpYIv8wJsLFy0=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr6360830ybk.387.1603977571714; 
 Thu, 29 Oct 2020 06:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
 <5833982.jYnqBMCBrJ@silver>
In-Reply-To: <5833982.jYnqBMCBrJ@silver>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 29 Oct 2020 21:19:22 +0800
Message-ID: <CAEUhbmXmJShRaiJjcY_v+WK1_TcMBTxLKs=RE7rGYjr=FX1xLA@mail.gmail.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Christian,

On Thu, Oct 29, 2020 at 8:52 PM Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Donnerstag, 29. Oktober 2020 09:25:41 CET Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > At present the virtio device config space access is handled by the
> > virtio_config_readX() and virtio_config_writeX() APIs. They perform
> > a sanity check on the result of address plus size against the config
> > space size before the access occurs.
>
> Since I am not very familiar with the virtio implementation side, I hope
> Michael would have a look at this patch.
>
> But some comments from my side ...

Thanks for the review.

>
> >
> > For unaligned access, the last converted naturally aligned access
> > will fail the sanity check on 9pfs. For example, with a mount_tag
> > `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> > read at the mount_tag offset which is not 4 byte aligned, the read
> > result will be `p9\377\377`, which is wrong.
>
> Why 4? Shouldn't this rather consider worst case alignment?
>

Both pci and mmio transports only support 1/2/4 bytes access
granularity in the config space, hence the worst case alignment is 4.

> >
> > This changes the size of device config space to be a multiple of 4
> > bytes so that correct result can be returned in all circumstances.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/9pfs/virtio-9p-device.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > index 14371a7..e6a1432 100644
> > --- a/hw/9pfs/virtio-9p-device.c
> > +++ b/hw/9pfs/virtio-9p-device.c
> > @@ -201,6 +201,7 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
> >      V9fsVirtioState *v = VIRTIO_9P(dev);
> >      V9fsState *s = &v->state;
> >      FsDriverEntry *fse = get_fsdev_fsentry(s->fsconf.fsdev_id);
> > +    size_t config_size;
> >
> >      if (qtest_enabled() && fse) {
> >          fse->export_flags |= V9FS_NO_PERF_WARN;
> > @@ -211,7 +212,8 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
> >      }
> >
> >      v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
> > -    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
> > +    config_size = ROUND_UP(v->config_size, 4);
> > +    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, config_size);
> >      v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
> >  }
>
> Shouldn't this config_size correction rather be handled on virtio.c side
> instead, i.e. in virtio_init()?

I checked other existing virtio devices, and their config space sizes
seem to be already multiple of 4 bytes. If we fix it in virtio_init()
that sounds to be future-proof. Michael?

Regards,
Bin


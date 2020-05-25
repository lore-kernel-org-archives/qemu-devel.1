Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC759C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 20:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A3A2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 20:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj9JTRzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A3A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdK9S-00083D-Q6
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 16:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jdK8u-0007Ym-Sh; Mon, 25 May 2020 16:56:16 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jdK8t-0002ns-Cg; Mon, 25 May 2020 16:56:16 -0400
Received: by mail-io1-xd43.google.com with SMTP id h10so19799498iob.10;
 Mon, 25 May 2020 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RPhfd55HVFFy1KzvqyMIxLUMQm7utjDdsmSDwwbE96w=;
 b=Cj9JTRzvN6Su8Rdmf3qYxBTIWcj8ThvT0ieN3vEUOqSemquFZAZtTPm8rW7upD/PnS
 PagfIxfkQAwXYtqLQk5apnlL6tLf0tcRWdR5bkMq3FOGqb+FFzMehR8y0z0vG6v/vArS
 RvGT8ViZMEiO8+oMeVMMmmNxt1cpRBNJwUBEXp+PyHwM5frWXTKNbbzGd8qgXcSE+2F+
 OV3rz8ibOG40B5IStWedt2ZEXY4y6gpjQEXhaPwhjz8QNiGbLoHQh7tIGv9xeKpsEwGG
 hKi0z7+UlQVlIhxNbmsZWYbam1sVQFiYhNzKuG9bKSob5cQw70kP1zSN735IZyMGhww5
 Thpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RPhfd55HVFFy1KzvqyMIxLUMQm7utjDdsmSDwwbE96w=;
 b=VcoJHSTcy68pZOShh2ZsBMSCYtpb5MlZmGGzoIz6fIfExRMGfMAmF4L/6blg06cnk5
 hObQ3R2IYwVHAolp8ymMAmy+l6E3nMT30hAhM4R818lvxfIECihClxdLdO4L0iwM7VxC
 9xTunIMk7WB+rLaZ9q3TwXvgU9H/KOroSBAZl5ugAy/e3M+E6a6G1CW7yb/s6A6cW5Bf
 IMxWE9r7wkGiMhHnRE87IHaVpRAnqP/noaejNU50EXSRpZMIs7UOVD3MFMPAJyXUJHBM
 2TwrWI90aHxW756PuXrs9UhERwDI4EhBN99oyiUt1ltXt5hUf3seE8xQYgBO9tse7XDD
 CNuQ==
X-Gm-Message-State: AOAM530g4SGS+lI3pWXXXPb+S4snFm9ebfDBRYqeQZ1OhcDG7QlhI9yx
 aNFiWCKMzwFl8xJgYBu+ayd+otB7akfn4gua2gg=
X-Google-Smtp-Source: ABdhPJwnJRca61kC47ZARr3OYpStMhVnM7yHIBujrFdShVJsqWED1JiwjwlSSsRIYZW41dtFIDWl6sMw4gr2WyP289w=
X-Received: by 2002:a02:908b:: with SMTP id x11mr4258549jaf.41.1590440173748; 
 Mon, 25 May 2020 13:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589989075.git.dimastep@yandex-team.ru>
 <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
 <20200525085741.GA7645@dimastep-nix>
In-Reply-To: <20200525085741.GA7645@dimastep-nix>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 25 May 2020 16:56:02 -0400
Message-ID: <CAFubqFsvieb923CmO4Rs8AEVPrJs6HQSuXkCvWK7CcNSoc4GNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 4:58 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> On Wed, May 20, 2020 at 06:53:13PM +0300, Dima Stepanov wrote:
> > A socket write during vhost-user communication may trigger a disconnect
> > event, calling vhost_user_blk_disconnect() and clearing all the
> > vhost_dev structures holding data that vhost-user functions expect to
> > remain valid to roll back initialization correctly. Delay the cleanup to
> > keep vhost_dev structure valid.
> > There are two possible states to handle:
> > 1. RUN_STATE_PRELAUNCH: skip bh oneshot call and perform disconnect in
> > the caller routine.
> > 2. RUN_STATE_RUNNING: delay by using bh
> >
> > BH changes are based on the similar changes for the vhost-user-net
> > device:
> >   commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
> >   "vhost-user: delay vhost_user_stop"
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
>
> I've reworked the patch based on Raphael's comment and send it for
> review. Also i added a TODO comment in the vhost_user_blk_event()
> routine. After review i'll send a v4 patch set.

Looks good to me.

>
> ---
>  hw/block/vhost-user-blk.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9d8c0b3..76838e7 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -349,6 +349,19 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
>      vhost_dev_cleanup(&s->dev);
>  }
>
> +static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_blk_chr_closed_bh(void *opaque)
> +{
> +    DeviceState *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +
> +    vhost_user_blk_disconnect(dev);
> +    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
> +            NULL, opaque, NULL, true);
> +}
> +
>  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>  {
>      DeviceState *dev = opaque;
> @@ -363,7 +376,30 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>          }
>          break;
>      case CHR_EVENT_CLOSED:
> -        vhost_user_blk_disconnect(dev);
> +        /*
> +         * A close event may happen during a read/write, but vhost
> +         * code assumes the vhost_dev remains setup, so delay the
> +         * stop & clear. There are two possible paths to hit this
> +         * disconnect event:
> +         * 1. When VM is in the RUN_STATE_PRELAUNCH state. The
> +         * vhost_user_blk_device_realize() is a caller.
> +         * 2. In tha main loop phase after VM start.
> +         *
> +         * For p2 the disconnect event will be delayed. We can't
> +         * do the same for p1, because we are not running the loop
> +         * at this moment. So just skip this step and perform
> +         * disconnect in the caller function.
> +         *
> +         * TODO: maybe it is a good idea to make the same fix
> +         * for other vhost-user devices.
> +         */
> +        if (runstate_is_running()) {
> +            AioContext *ctx = qemu_get_current_aio_context();
> +
> +            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL,
> +                    NULL, NULL, false);
> +            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
> +        }
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> --
> 2.7.4
>
>


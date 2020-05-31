Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12031C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 00:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C787E2074B
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 00:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuGfLXIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C787E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfCH0-0008De-1g
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 20:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jfCGO-0007jC-Q9; Sat, 30 May 2020 20:55:44 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:44661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jfCGN-0007fR-Ka; Sat, 30 May 2020 20:55:44 -0400
Received: by mail-il1-x142.google.com with SMTP id j3so6073288ilk.11;
 Sat, 30 May 2020 17:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iSoq54k6CMj8oEAMo6ge/wDcrJxGGTq1iTDY0QwBp3c=;
 b=kuGfLXIkWCdCxSOce5xDxEHTgjOBbz2S24HTq9Zkh5rW1ab/ohfYmEbzuUNN6+PuMI
 q/dcm6x9UtbGJnSCM0Dot9kDBncHnPzZ7kRNy3ubo4V3D8DRMK+YutBstjJhgJ1lyp2f
 8HV20rHqSPTO3cIQkvjC1xemRgajNJSQoUAHn9so8/fpbTKwmwgcESTwFfaYGZ+3qs6f
 9xMyzX4geYRyEelwt49TPZis1bh0u2onLYIcM02c9pCX91SlXtLJItVX8XF8Wf4dbRoG
 TUKHBbak0KmdJ1ZizgiJjpme9foQ5iisbHOf2ylbWhR/djbD9opPK7AycIZH2MDOMI8Q
 oqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iSoq54k6CMj8oEAMo6ge/wDcrJxGGTq1iTDY0QwBp3c=;
 b=c6h5z+1I3cW2N4pC4qtkjRE61/rzP9vv5tzsIIM8dj9cHMpgFIGimD0u9vb8DDdl/1
 XbWMZhkBAF8BlRZqoysezwGI3qb14bQ11kf5S3O+HmdmxeQaMS9YQI863D0CkMGaQVpU
 UHMlcEVvJcIbh7OJBHjBoBlZDzqqfBaSgtcBhim9SjCvaAeJhfscD05B/QSrcxaPwa7p
 mxpnjg2//UOckjlH4HA1I89XT6Ai6ajO5gPGbVLXlsdcHxGgzSoWm2DyPyQZH0m081r1
 BB3d/OQZ74CrxTLgroi30by/3b53TuV1Yg2aJCnJC/yK0NO7z488/4RV6xkP5t/LlIA6
 ThgQ==
X-Gm-Message-State: AOAM531lOqTHOpcFRtHOYjOfZIXaf8wnmUfCuRFobTYGOFQ/cTBb//f8
 wI5+RUBEMzgflo06f9xRJxrSOoG9rcDCVmCnnic=
X-Google-Smtp-Source: ABdhPJzmNo5NPDH+AgpBzJnWfKMF9UejeQxwZl3jfyUNAeiHUCrSFt3cv4A6NHE4zbUZIu7zbhW72uT24glMEjfzH8E=
X-Received: by 2002:a05:6e02:972:: with SMTP id
 q18mr580022ilt.60.1590886541466; 
 Sat, 30 May 2020 17:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590396396.git.dimastep@yandex-team.ru>
 <69b73b94dcd066065595266c852810e0863a0895.1590396396.git.dimastep@yandex-team.ru>
In-Reply-To: <69b73b94dcd066065595266c852810e0863a0895.1590396396.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 30 May 2020 20:55:30 -0400
Message-ID: <CAFubqFvOU-ZFnhmCUNGH9gyuwa4us0UNPvZ6QTggDLwUr7y=RA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x142.google.com
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
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 5:13 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> A socket write during vhost-user communication may trigger a disconnect
> event, calling vhost_user_blk_disconnect() and clearing all the
> vhost_dev structures holding data that vhost-user functions expect to
> remain valid to roll back initialization correctly. Delay the cleanup to
> keep vhost_dev structure valid.
> There are two possible states to handle:
> 1. RUN_STATE_PRELAUNCH: skip bh oneshot call and perform disconnect in
> the caller routine.
> 2. RUN_STATE_RUNNING: delay by using bh
>
> BH changes are based on the similar changes for the vhost-user-net
> device:
>   commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
>   "vhost-user: delay vhost_user_stop"
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Li Feng - would you also like to sign off here?

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


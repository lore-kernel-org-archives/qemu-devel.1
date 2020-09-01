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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3019C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 03:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90D62071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 03:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjfqXHok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90D62071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCxJX-0001wR-TZ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 23:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kCxIk-0001J1-Pi; Mon, 31 Aug 2020 23:49:42 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kCxIi-0008Dj-PG; Mon, 31 Aug 2020 23:49:42 -0400
Received: by mail-oi1-x243.google.com with SMTP id 185so2967464oie.11;
 Mon, 31 Aug 2020 20:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gN595ozgvdJrTBlgoHuECk6TUZEf2R+uz6MIFwjGuEo=;
 b=LjfqXHokzKrutTPB0NN/WVjTDM5SSZv9+R+OGjOMXSG/M+d2QWjHAtE7bmB92cMOkE
 fHhkQqIv0NtLlZLJ76iG859TP6fI6Z2HLdx5NLwom9GDiLmNDzLf80cJawcNBjmXQDu7
 mhb5nL+gq12cVuM2mJKDnNEyc/O2qtGbBn986rW3zbgtYSWG+eBeGE21vOA7sknNKLc4
 QrChzIRpBADnCEiTYOvptKriCBpe/6TvjEQfYrQobknbnGn7qrQLitOjRLipCAFC5yoO
 hyIbYto3pY5izbz2RWf7TPCmgNMQ8bZewBBsYxS/mOGPkZ7u9TXqInpEvnIsyv9GsP4d
 QygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gN595ozgvdJrTBlgoHuECk6TUZEf2R+uz6MIFwjGuEo=;
 b=P230Uw64tPlQ4glgtGMl5Bd6G+gZj5Zo71+YIdergR9OeEGASPJmHikJibMPfaDGrP
 2gwrGzd2dmwhwnZbtLK0/7kXr2A/j0YGcNEPY3Lqn757AIhhK1SSYeQJ0NN/US/JDSiB
 IV38VG13PMoxaa+LTbtgaw4kHOuGlItE5cKroBkFx2F6nc7JKTEE6OiFnkG/Uq5L1j4n
 7BTMNs5ecY1Zm3Hp0zFND9sKyFOJR/ssiEwqR6Dn3JdhDmkCxA89XVp4Ic23z56AsI2z
 R3wjYqDztPlulKkneszToizrOX3VwkBPbEaWLc2D58bgOsMpxKPiiMjawRF/hTico9Dw
 6lkQ==
X-Gm-Message-State: AOAM532oJVXWDIg3BZfxTVRsQ86xPougnzQziOaVqLnvpNLvUo0nFP//
 c3xsbY8JAX/5aauMC4W3LCje3b8Z4n/CXJqWBPU=
X-Google-Smtp-Source: ABdhPJxdImtlgT2lb8QCwbMPL5rh1UwUm7r34qtITXo6Il2c/3i/C24Bwon6kij0M8hleap7dia24S4UDc6sWyhFt90=
X-Received: by 2002:aca:4dd3:: with SMTP id a202mr31633oib.157.1598932179099; 
 Mon, 31 Aug 2020 20:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598865610.git.dimastep@yandex-team.ru>
 <a35178fe9e90d2552990a6b359a626e0a40d8b17.1598865610.git.dimastep@yandex-team.ru>
In-Reply-To: <a35178fe9e90d2552990a6b359a626e0a40d8b17.1598865610.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 31 Aug 2020 23:49:28 -0400
Message-ID: <CAFubqFvCKR7aR-Bvmq=eyrZ9qYwQBG=_e21aH2AbJPUx3-QaTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vhost: recheck dev state in the
 vhost_migration_log routine
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Aug 31, 2020 at 5:28 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> vhost-user devices can get a disconnect in the middle of the VHOST-USER
> handshake on the migration start. If disconnect event happened right
> before sending next VHOST-USER command, then the vhost_dev_set_log()
> call in the vhost_migration_log() function will return error. This error
> will lead to the assert() and close the QEMU migration source process.
> For the vhost-user devices the disconnect event should not break the
> migration process, because:
>   - the device will be in the stopped state, so it will not be changed
>     during migration
>   - if reconnect will be made the migration log will be reinitialized as
>     part of reconnect/init process:
>     #0  vhost_log_global_start (listener=0x563989cf7be0)
>     at hw/virtio/vhost.c:920
>     #1  0x000056398603d8bc in listener_add_address_space (listener=0x563989cf7be0,
>         as=0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2664
>     #2  0x000056398603dd30 in memory_listener_register (listener=0x563989cf7be0,
>         as=0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2740
>     #3  0x0000563985fd6956 in vhost_dev_init (hdev=0x563989cf7bd8,
>         opaque=0x563989cf7e30, backend_type=VHOST_BACKEND_TYPE_USER,
>         busyloop_timeout=0)
>     at hw/virtio/vhost.c:1385
>     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=0x563989cf7990)
>     at hw/block/vhost-user-blk.c:315
>     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=0x563989cf7990,
>         event=CHR_EVENT_OPENED)
>     at hw/block/vhost-user-blk.c:379
> Update the vhost-user-blk device with the internal started_vu field which
> will be used for initialization (vhost_user_blk_start) and clean up
> (vhost_user_blk_stop). This additional flag in the VhostUserBlk structure
> will be used to track whether the device really needs to be stopped and
> cleaned up on a vhost-user level.
> The disconnect event will set the overall VHOST device (not vhost-user) to
> the stopped state, so it can be used by the general vhost_migration_log
> routine.
> Such approach could be propogated to the other vhost-user devices, but
> better idea is just to make the same connect/disconnect code for all the
> vhost-user devices.
>
> This migration issue was slightly discussed earlier:
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  hw/block/vhost-user-blk.c          | 19 ++++++++++++++++---
>  hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
>  include/hw/virtio/vhost-user-blk.h | 10 ++++++++++
>  3 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 39aec42..a076b1e 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
>          error_report("Error starting vhost: %d", -ret);
>          goto err_guest_notifiers;
>      }
> +    s->started_vu = true;
>
>      /* guest_notifier_mask/pending not used yet, so just unmask
>       * everything here. virtio-pci will do the right thing by
> @@ -175,6 +176,11 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>      int ret;
>
> +    if (!s->started_vu) {
> +        return;
> +    }
> +    s->started_vu = false;
> +
>      if (!k->set_guest_notifiers) {
>          return;
>      }
> @@ -341,9 +347,7 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
>      }
>      s->connected = false;
>
> -    if (s->dev.started) {
> -        vhost_user_blk_stop(vdev);
> -    }
> +    vhost_user_blk_stop(vdev);
>
>      vhost_dev_cleanup(&s->dev);
>  }
> @@ -399,6 +403,15 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>                      NULL, NULL, false);
>              aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
>          }
> +
> +        /*
> +         * Move vhost device to the stopped state. The vhost-user device
> +         * will be clean up and disconnected in BH. This can be useful in
> +         * the vhost migration code. If disconnect was caught there is an
> +         * option for the general vhost code to get the dev state without
> +         * knowing its type (in this case vhost-user).
> +         */
> +        s->dev.started = false;
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e..ffef7ab 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -861,21 +861,42 @@ static int vhost_migration_log(MemoryListener *listener, bool enable)
>          dev->log_enabled = enable;
>          return 0;
>      }
> +
> +    r = 0;
>      if (!enable) {
>          r = vhost_dev_set_log(dev, false);
>          if (r < 0) {
> -            return r;
> +            goto check_dev_state;
>          }
>          vhost_log_put(dev, false);
>      } else {
>          vhost_dev_log_resize(dev, vhost_get_log_size(dev));
>          r = vhost_dev_set_log(dev, true);
>          if (r < 0) {
> -            return r;
> +            goto check_dev_state;
>          }
>      }
> +
> +check_dev_state:
>      dev->log_enabled = enable;
> -    return 0;
> +    /*
> +     * vhost-user-* devices could change their state during log
> +     * initialization due to disconnect. So check dev state after
> +     * vhost communication.
> +     */
> +    if (!dev->started) {
> +        /*
> +         * Since device is in the stopped state, it is okay for
> +         * migration. Return success.
> +         */
> +        r = 0;
> +    }
> +    if (r) {
> +        /* An error is occured. */
> +        dev->log_enabled = false;
> +    }
> +
> +    return r;
>  }
>
>  static void vhost_log_global_start(MemoryListener *listener)
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index 292d171..4d6f4c0 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -40,7 +40,17 @@ typedef struct VHostUserBlk {
>      VhostUserState vhost_user;
>      struct vhost_virtqueue *vhost_vqs;
>      VirtQueue **virtqs;
> +
> +    /*
> +     * There are at least two steps of initialization of the
> +     * vhost-user device. The first is a "connect" step and
> +     * second is a "start" step. Make a separation between
> +     * those initialization phases by using two fields.
> +     */
> +    /* vhost_user_blk_connect/vhost_user_blk_disconnect */
>      bool connected;
> +    /* vhost_user_blk_start/vhost_user_blk_stop */
> +    bool started_vu;
>  } VHostUserBlk;
>
>  #endif
> --
> 2.7.4
>
>


Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F675C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1792075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNkMHfSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1792075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBTSk-0002MB-6v
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 21:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kBTRf-0001q8-5w; Thu, 27 Aug 2020 21:44:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kBTRd-0002It-3F; Thu, 27 Aug 2020 21:44:46 -0400
Received: by mail-ot1-x343.google.com with SMTP id k20so6153412otr.1;
 Thu, 27 Aug 2020 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XQVlUKTr7iriE74P5YthkHGP5fa8NM4IqINvEl03Dzo=;
 b=XNkMHfSS3P37esvwPLB2Ayra9X1IkrQ2c7sfdDBb/fVt1E9keazuFxlQehsP56PS0y
 PabcEkuYgdOpqmJLktmiVGTsIjUBeGi2gkFd8qNpWp6QMy2B8kuDmAuVqY7O7PhqZwX9
 jVdTMv/YJOPdy/qefIc/QQ/te5GadMNFY4RcrTOfCFH03vy+xq1b2Xwu3573M26LjIXi
 QcydpLS2t4TUqEau35bKWOVqTP9ZcW6mMggtAVz4si8mgLU3VZURzn3gmbGFDpHLs5JJ
 X74icR2dKtOx6RKoo4auNhrz+tOX+6P+JDqZHL/S/5eDdk57HIlfWaWpH86SUxcibAMo
 sAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XQVlUKTr7iriE74P5YthkHGP5fa8NM4IqINvEl03Dzo=;
 b=rcmSQhjznBcGUTt7EFvh31cp1PfNyOOgCg0qH2DvlDBhBW8ND9CJFpxVXduruaCEgx
 iQvQlnIn8DSGVGJfubrlOYGR0KHBf/kTfYPoarZkdv+oAxAIfmgVJOpZgzmNw4mF1uW6
 J47q2uKss58DhcVINdZs5SU9L204fUnzau6kwi/v+vYaywN+n1GJWhmpWxIBdrNMVdyn
 PYbYtNuCpxCyWUDkqpn5TkLGgmPcbzrR/gb5BGZ5LC2fPH2LFAv/TiO5YyQ9xg82Ce2B
 Nx83cpuBSNfxzhPLzMJKHy+KlNDbP2j4Yg3ArjvZHfTFZHS1PJX1Ei8GGUC6FmhJ44qU
 KajA==
X-Gm-Message-State: AOAM533yubPpDwaApHvbgyQ7qheaBYOImAPfuI0O8EQk/wxwyMEcy8vj
 B+uzll0U48Xy75vunxT6iYF8oiK4pcFthzF957Q=
X-Google-Smtp-Source: ABdhPJzX7R2rC/ODFmbIk7wXU1+OeWix3JtScALrqaKDsAh4ZGmZTqYtYMe3I3E6CtxOSOtDoI/dzgm7W6id1J6Xs2Y=
X-Received: by 2002:a9d:2f04:: with SMTP id h4mr14327216otb.326.1598579083074; 
 Thu, 27 Aug 2020 18:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598257838.git.dimastep@yandex-team.ru>
 <e63c6abf81084026da70990569e570b6b4720977.1598257838.git.dimastep@yandex-team.ru>
In-Reply-To: <e63c6abf81084026da70990569e570b6b4720977.1598257838.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 27 Aug 2020 21:44:22 -0400
Message-ID: <CAFubqFuE06frhZ3F_pVtWVFY6cQW9rxNGREy9WsEq59JG6Z_FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: recheck dev state in the
 vhost_migration_log routine
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x343.google.com
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

Generally I=E2=80=99m happy with this. Some comments:

On Mon, Aug 24, 2020 at 4:40 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
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
>     #0  vhost_log_global_start (listener=3D0x563989cf7be0)
>     at hw/virtio/vhost.c:920
>     #1  0x000056398603d8bc in listener_add_address_space (listener=3D0x56=
3989cf7be0,
>         as=3D0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2664
>     #2  0x000056398603dd30 in memory_listener_register (listener=3D0x5639=
89cf7be0,
>         as=3D0x563986ea4340 <address_space_memory>)
>     at softmmu/memory.c:2740
>     #3  0x0000563985fd6956 in vhost_dev_init (hdev=3D0x563989cf7bd8,
>         opaque=3D0x563989cf7e30, backend_type=3DVHOST_BACKEND_TYPE_USER,
>         busyloop_timeout=3D0)
>     at hw/virtio/vhost.c:1385
>     #4  0x0000563985f7d0b8 in vhost_user_blk_connect (dev=3D0x563989cf799=
0)
>     at hw/block/vhost-user-blk.c:315
>     #5  0x0000563985f7d3f6 in vhost_user_blk_event (opaque=3D0x563989cf79=
90,
>         event=3DCHR_EVENT_OPENED)
>     at hw/block/vhost-user-blk.c:379
> Update the vhost-user-blk device with the internal started field which
> will be used for initialization and clean up. The disconnect event will
> set the overall VHOST device to the stopped state, so it can be used by
> the vhost_migration_log routine.
> Such approach could be propogated to the other vhost-user devices, but
> better idea is just to make the same connect/disconnect code for all the
> vhost-user devices.
>
> This migration issue was slightly discussed earlier:
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg01509.html
>   - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05241.html
>

What you=E2=80=99re doing here on a structural level is adding an additiona=
l
flag =E2=80=9Cstarted=E2=80=9D to VhostUserBlk to track whether the device =
really
needs to be stopped and cleaned up on a vhost level on a disconnect.
Can you make that more clear in the commit message as you have in the
comments?


> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c          | 19 ++++++++++++++++---
>  hw/virtio/vhost.c                  | 27 ++++++++++++++++++++++++---
>  include/hw/virtio/vhost-user-blk.h | 10 ++++++++++
>  3 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a00b854..5573e89 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -150,6 +150,7 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
>          error_report("Error starting vhost: %d", -ret);
>          goto err_guest_notifiers;
>      }
> +    s->started =3D true;
>
>      /* guest_notifier_mask/pending not used yet, so just unmask
>       * everything here. virtio-pci will do the right thing by
> @@ -175,6 +176,11 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret;
>
> +    if (!s->started) {
> +        return;
> +    }
> +    s->started =3D false;
> +
>      if (!k->set_guest_notifiers) {
>          return;
>      }
> @@ -341,9 +347,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
>      }
>      s->connected =3D false;
>
> -    if (s->dev.started) {
> -        vhost_user_blk_stop(vdev);
> -    }
> +    vhost_user_blk_stop(vdev);
>
>      vhost_dev_cleanup(&s->dev);
>  }
> @@ -399,6 +403,15 @@ static void vhost_user_blk_event(void *opaque, QEMUC=
hrEvent event)
>                      NULL, NULL, false);
>              aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, o=
paque);
>          }
> +
> +        /*
> +         * Move vhost device to the stopped state. The vhost-user device
> +         * will be clean up and disconnected in BH. This can be useful i=
n
> +         * the vhost migration code. If disconnect was caught there is a=
n
> +         * option for the general vhost code to get the dev state withou=
t
> +         * knowing its type (in this case vhost-user).
> +         */
> +        s->dev.started =3D false;
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e..ffef7ab 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -861,21 +861,42 @@ static int vhost_migration_log(MemoryListener *list=
ener, bool enable)
>          dev->log_enabled =3D enable;
>          return 0;
>      }
> +
> +    r =3D 0;
>      if (!enable) {
>          r =3D vhost_dev_set_log(dev, false);
>          if (r < 0) {
> -            return r;
> +            goto check_dev_state;
>          }
>          vhost_log_put(dev, false);
>      } else {
>          vhost_dev_log_resize(dev, vhost_get_log_size(dev));
>          r =3D vhost_dev_set_log(dev, true);
>          if (r < 0) {
> -            return r;
> +            goto check_dev_state;
>          }
>      }
> +
> +check_dev_state:
>      dev->log_enabled =3D enable;
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
> +        r =3D 0;
> +    }
> +    if (r) {
> +        /* An error is occured. */
> +        dev->log_enabled =3D false;
> +    }
> +
> +    return r;
>  }
>
>  static void vhost_log_global_start(MemoryListener *listener)
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index 34ad6f0..f4c0754 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -38,7 +38,17 @@ typedef struct VHostUserBlk {
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

I don=E2=80=99t like the name =E2=80=9Cstarted=E2=80=9D for the vhost-user-=
blk flag because
it=E2=80=99s easy to get confused with the vhost_dev "started" field, and t=
hey
are used for very different things. Maybe call it =E2=80=9Cneeds_cleanup=E2=
=80=9D or
=E2=80=9Cstarted_internal=E2=80=9D, or something to that effect?


> +    bool started;
>  } VHostUserBlk;
>
>  #endif
> --
> 2.7.4
>
>


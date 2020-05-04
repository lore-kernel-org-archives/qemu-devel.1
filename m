Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF6C28CBC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 01:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5492071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 01:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM/99et6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5492071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVPZx-00051g-0W
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 21:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jVPZM-0004T9-NO; Sun, 03 May 2020 21:06:52 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jVPZL-0003Cn-D8; Sun, 03 May 2020 21:06:52 -0400
Received: by mail-il1-x141.google.com with SMTP id w6so9779745ilg.1;
 Sun, 03 May 2020 18:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DbxeRw/Hr9Fe9x0VfJ8XcSFF3qkwBs20C1VmFcUlvl0=;
 b=KM/99et6XYnReFw4B//1KUWuZjJtGOM2XHM7UqF2ColTVXrskc+06E8K4/fa7x5Dxi
 XqKyZL7rjNy7kjIXURkLw1LYCbdCfmTbXYrFdcxy922cJdgAKe+ZDaHpWNC5UTNoKwn1
 nb64EcOUosb97MtDtMzQx25rNY6WPxWhMu2d3BnUyFwRIJ8jNn6N07KbL6n3ROb5g0Iv
 gR/ePyEnoA4Je4KJjP0+HPwur8VoCWUe6gVMUvi4PQB+NqTMh0DVUaXgPt/25kkcNTD/
 zjDDX0r9QNjLcOYLCgNO/8FdMkNgZ9A4Ou3KlMIOKsYs3NkfGrg3SzgPoXMSd3/uQALo
 mHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DbxeRw/Hr9Fe9x0VfJ8XcSFF3qkwBs20C1VmFcUlvl0=;
 b=kGLPq9umwwi6T2s4a6lw6AO9Lz0KVlhXPFXj0O8qlXZ9ibGbJCzieke79apSdd4paW
 lVRQtQ/KyFA7GZS3YJEpfdq3mEJYu5KbotuBK+QLgMqP8BsHarZWJTclqHqTzBb0jRIy
 V05pgNe3U7mwnZX9mLgQdULT7cG1NbjiLlj3PhKbh81k9lDqeJcDqE562lLvSkmS9DAz
 MDLKcQAKJ+VOKmxvSkwbtlfo/bhHGEoId/FuHWb5sIy+ph5MF75nj8kixVQPXlWpX/1G
 PKwhwywglT3yfZx9QbFMX9lBQm9i7vNp0AyFHD0Ripajsf6ymP5dvCCJMXL/utv+31Ln
 QpGQ==
X-Gm-Message-State: AGi0PubQICjaVXFmghMyYrQzZTkbbfL0TITCFeukQx87u4G1eVW1ASeu
 JQyKE3Zlrk+B0jWZvWgLnN+4BDZnnYHwQU9SrVA=
X-Google-Smtp-Source: APiQypJjJKbwIzcBvRSiRFgyQNIC4ecTK9QL6IlZYpFbbTWflm5dyk6MpTH9I6WXUh6o1YW2ADp3NxV3rpdGsG4LIHM=
X-Received: by 2002:a92:ccc5:: with SMTP id u5mr13331029ilq.126.1588554409387; 
 Sun, 03 May 2020 18:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d20d6de600837aebbf644666be064f761f764832.1588252862.git.dimastep@yandex-team.ru>
In-Reply-To: <d20d6de600837aebbf644666be064f761f764832.1588252862.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sun, 3 May 2020 21:06:38 -0400
Message-ID: <CAFubqFsmXhB68FWEATmtat-VrANcRAdC2-YNwKiYiXvcMO15rQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vhost-user-blk: add mechanism to track the guest
 notifiers init state
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x141.google.com
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Apologies for mixing up patches last time. This looks good from a
vhost-user-blk perspective, but I worry that some of these changes
could impact other vhost device types.

I agree with adding notifiers_set to struct vhost_dev, and setting it in
vhost_dev_enable/disable notifiers, but is there any reason notifiers_set
can=E2=80=99t be checked inside vhost-user-blk?

On Thu, Apr 30, 2020 at 9:55 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> In case of the vhost-user devices the daemon can be killed at any
> moment. Since QEMU supports the reconnet functionality the guest
> notifiers should be reset and disabled after "disconnect" event. The
> most issues were found if the "disconnect" event happened during vhost
> device initialization step.
> The disconnect event leads to the call of the vhost_dev_cleanup()
> routine. Which memset to 0 a vhost device structure. Because of this, if
> device was not started (dev.started =3D=3D false) and the connection is
> broken, then the set_guest_notifier method will produce assertion error.
> Also connection can be broken after the dev.started field is set to
> true.
> A new notifiers_set field is added to the vhost_dev structure to track
> the state of the guest notifiers during the initialization process.
>

From what I can tell this patch does two things:

(1)
In vhost.c you=E2=80=99re adding checks to abort early, while still returni=
ng
successfully, from
vhost_dev_drop_guest_notifiers() and vhost_dev_disable_notifiers() if
notifiers have
not been enabled. This new logic will affect all existing vhost devices.

(2)
For vhost-user-blk backend disconnect, you are ensuring that notifiers
are dropped and
disabled if and only if the notifiers are currently enabled.

I completely agree with (2), but I don't think we need all of what
you've done for
(1) to accomplish (2).

Either way, please clarify in your commit message.

> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c |  8 ++++----
>  hw/virtio/vhost.c         | 11 +++++++++++
>  include/hw/virtio/vhost.h |  1 +
>  3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 70d7842..5a3de0f 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -175,7 +175,9 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>          return;
>      }
>
> -    vhost_dev_stop(&s->dev, vdev);
> +    if (s->dev.started) {
> +        vhost_dev_stop(&s->dev, vdev);
> +    }
>

Couldn't we check if s->dev.notifiers_set here before calling
vhost_dev_drop_guest_notifiers()?

>      ret =3D vhost_dev_drop_guest_notifiers(&s->dev, vdev, s->dev.nvqs);
>      if (ret < 0) {
> @@ -337,9 +339,7 @@ static void vhost_user_blk_disconnect(DeviceState *de=
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
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index fa3da9c..ddbdc53 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1380,6 +1380,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hd=
ev, VirtIODevice *vdev)
>              goto fail_vq;
>          }
>      }
> +    hdev->notifiers_set =3D true;
>
>      return 0;
>  fail_vq:
> @@ -1407,6 +1408,10 @@ void vhost_dev_disable_notifiers(struct vhost_dev =
*hdev, VirtIODevice *vdev)
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      int i, r;
>

I=E2=80=99m a little weary of short circuiting logic like this without at
least propagating an
error up. Couldn=E2=80=99t we leave it to the backends to check notifiers_s=
et
before they
call vhost_dev_disable_notifiers() or vhost_dev_drop_guest_notifiers()?

Then, if anything, maybe make this check an assert?

> +    if (!hdev->notifiers_set) {
> +        return;
> +    }
> +
>      for (i =3D 0; i < hdev->nvqs; ++i) {
>          r =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_in=
dex + i,
>                                           false);
> @@ -1417,6 +1422,8 @@ void vhost_dev_disable_notifiers(struct vhost_dev *=
hdev, VirtIODevice *vdev)
>          virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_inde=
x + i);
>      }
>      virtio_device_release_ioeventfd(vdev);
> +
> +    hdev->notifiers_set =3D false;
>  }
>
>  /*
> @@ -1449,6 +1456,10 @@ int vhost_dev_drop_guest_notifiers(struct vhost_de=
v *hdev,
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret;
>

Same comment as above - I=E2=80=99d prefer vhost-user-blk (and other backen=
ds
supporting reconnect)
check before calling the function instead of changing existing API
behavior for other vhost devices.

> +    if (!hdev->notifiers_set) {
> +        return 0;
> +    }
> +
>      ret =3D k->set_guest_notifiers(qbus->parent, nvqs, false);
>      if (ret < 0) {
>          error_report("Error reset guest notifier: %d", -ret);
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 4d0d2e2..e3711a7 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -90,6 +90,7 @@ struct vhost_dev {
>      QLIST_HEAD(, vhost_iommu) iommu_list;
>      IOMMUNotifier n;
>      const VhostDevConfigOps *config_ops;
> +    bool notifiers_set;
>  };
>
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> --
> 2.7.4
>
>


Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961E72071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKbiabxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961E72071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd4If-0008Qc-PS
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 00:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jd4Hp-0007rA-1q; Mon, 25 May 2020 00:00:25 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:42693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jd4Hn-0000wD-LQ; Mon, 25 May 2020 00:00:24 -0400
Received: by mail-io1-xd44.google.com with SMTP id d5so7912249ios.9;
 Sun, 24 May 2020 21:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a5B3uXYBPMjQlR9nBdBb8niL5An0C2WJilQQ2OFLtEE=;
 b=WKbiabxxuAdl8w8BmOr64zvB7IpHvpTPh5F6YhG4udJ+jaKQrH0YTkqBXIDKzqd8ku
 lsToeSkjWmgubmPeaatMcVE1EZTB8xv1C4RtUHRlFLX+8BGXE/wQZuVZiCrLw12SrIX0
 OhLbJqA5lAjm80i5S8xAz7WiT/snp3PoZZB0y6LpvWTvmZmfEQcs4i0jWkTVA2jUoQlz
 sPCrTolrSB8TEkDf76i21ByAp3/XT2t84CmpwxjLdSvoH1Ca02ufF9g5g0LQ+BeYbcVl
 M8dNalSj01HmlMQ1jMrJyqQ8BTLjSneNqnfpjWfXudi/ssAJSJAFdJ2ewLeknKmoHAfB
 HMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a5B3uXYBPMjQlR9nBdBb8niL5An0C2WJilQQ2OFLtEE=;
 b=Ec0iecmy3tBJ6/HAxC/W9GQ3pQb7eQW62hmVGtUjxLMu1DkqsZ5i3n7t1f4Za8NrK1
 B22EiIRfdwjp8RXNTN7UfVdKue1tZzeK4MfCq/O6pnffc9aAqOPlufx0QJqHmR0tHDwB
 /LXjHyEGYi1cy6GW7rb1N5VpOvjFlboHb7cZel69DBsPlMPR3T73VDbPv0uieMANIfuM
 3VJHbXyaCEh7l0CAHj2jeJJ4ztYVvhdtQfT3ty9RCns5V3ZYcLhAEMcLkdlzqzgCf4kf
 fSsZN7Mo8QRkTUZ+bkGF1OWBIYqNiW8p5k0k0fVoG5SVXTPqL/vdcCb8i+zsxNQABqs/
 XoOA==
X-Gm-Message-State: AOAM532ERvJFl/I6Xv+TZmajGv8kvQy5M+zmYcw91ebS63KasvD5WrK5
 XI1gZp+2WuvQbrWE0po6+KNBZ87ceEKAPyr9j6U=
X-Google-Smtp-Source: ABdhPJynlBFkEJwvCjqkf4AGLCA8J0/iJ4nLNhBBRxW2W6nTpq9Ly/jmTm7YjFt57rCI56JKBy0WmsQSUmSgUc8DGS8=
X-Received: by 2002:a02:8529:: with SMTP id g38mr6637839jai.143.1590379221428; 
 Sun, 24 May 2020 21:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589989075.git.dimastep@yandex-team.ru>
 <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
In-Reply-To: <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 25 May 2020 00:00:10 -0400
Message-ID: <CAFubqFsqm+xo7uVSi6EfTvFdJ7dLm1+xfr9LvrUZK_nktDdiXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, dgilbert@redhat.com, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm mostly happy with this. A couple comments.

On Wed, May 20, 2020 at 11:54 AM Dima Stepanov <dimastep@yandex-team.ru> wr=
ote:
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
I'd also give credit to Li Feng here - he sent a similar patch:

https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg02255.html

> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c | 49 +++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9d8c0b3..447fc9c 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -337,11 +337,6 @@ static void vhost_user_blk_disconnect(DeviceState *d=
ev)
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>
> -    if (!s->connected) {
> -        return;
> -    }
> -    s->connected =3D false;
> -
>      if (s->dev.started) {
>          vhost_user_blk_stop(vdev);
>      }
> @@ -349,6 +344,19 @@ static void vhost_user_blk_disconnect(DeviceState *d=
ev)
>      vhost_dev_cleanup(&s->dev);
>  }
>
> +static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> +
> +static void vhost_user_blk_chr_closed_bh(void *opaque)
> +{
> +    DeviceState *dev =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> +
> +    vhost_user_blk_disconnect(dev);
> +    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_eve=
nt,
> +            NULL, opaque, NULL, true);
> +}
> +
>  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>  {
>      DeviceState *dev =3D opaque;
> @@ -363,7 +371,28 @@ static void vhost_user_blk_event(void *opaque, QEMUC=
hrEvent event)
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
> +         */
> +        if (s->connected && runstate_is_running()) {
> +            AioContext *ctx =3D qemu_get_current_aio_context();
> +
> +            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL=
,
> +                    NULL, NULL, false);
> +            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, o=
paque);
> +        }
> +        s->connected =3D false;
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> @@ -428,6 +457,14 @@ reconnect:
>
>      ret =3D vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
>                                 sizeof(struct virtio_blk_config));

I find checking s->connected before ret a little confusing. I think we
should also enforce a reconnect if s->connected is false. AFIK if
s->connected is false, ret must also be less than 0, but to be safe
I=E2=80=99d prefer something like:

if (ret < 0 || !s->connected) {
    if (!s->connected) {
        /*
         * Perform disconnect before making reconnect. More detailed
         * comment why it was delayed is in the vhost_user_blk_event()
         * routine.
         */
          vhost_user_blk_disconnect(dev);
    }
    if (ret < 0) {
           error_report(=E2=80=9Cvhost-user-blk: get block config failed=E2=
=80=9D);
    }
    goto reconnect;
}

> +    if (!s->connected) {
> +        /*
> +         * Perform disconnect before making reconnect. More detailed
> +         * comment why it was delayed is in the vhost_user_blk_event()
> +         * routine.
> +         */
> +        vhost_user_blk_disconnect(dev);
> +    }
>      if (ret < 0) {
>          error_report("vhost-user-blk: get block config failed");
>          goto reconnect;
> --
> 2.7.4
>
>


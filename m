Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF54C28CBC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 01:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59080206EB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 01:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4TecXPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59080206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVPgh-00072A-Kh
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 21:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jVPg9-0006bQ-Fw; Sun, 03 May 2020 21:13:53 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jVPg8-0007IE-Ji; Sun, 03 May 2020 21:13:53 -0400
Received: by mail-io1-xd42.google.com with SMTP id e9so10627635iok.9;
 Sun, 03 May 2020 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4M+UTZ7M0vQhNkfbUqHz3UQPgntMzg+8m6tQzEjQ2h4=;
 b=X4TecXPfTtzwFeM5uH/Ph3T+Qmf9NljR33gx8t5jQtwAjIwN2CpAJpoqKWfZNPYsbh
 9mEdBHoPvQg1M1Ae1QCEgHS4MdI7kNFypy+ovebncARwSr9XYZS/rhAmR5mn5W7fDouo
 Gg90hMxVNad9ix8yCQ5YrkMnjEF/kpL6kTOHRyZGqrJwOEMgTcb+x1ZOnDnzV57NOtIi
 +7Q8pdwx1ndjSlRcnnUfsPU+S293j0G3/Q3r51z/9jWJI8byglM1wJ0LVsosPeId744i
 ae8/R8T5L2t9bryaMbOBH9ofglCYTNT6Rz2FqgpZ8nVvFchr12PVEbOV6crKJUKzF5ND
 CXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4M+UTZ7M0vQhNkfbUqHz3UQPgntMzg+8m6tQzEjQ2h4=;
 b=f6S5yUx3PgszXl2FMpCNbTAXnlj3OWCbdWlFzUlDR+zM/6bIQxGTUV99VTyeQ3yTG4
 qjYjHysTEBkzPk30v1ToovNeDzcpKeR86iPo7skLCmq16hMAjVvlqWcUUv73x+sBL2iw
 rQfbtXBso3j7PjgcqHtS8wBccEcaToitIx+zXy6tXYnZkZ8TamBD9JPWfgi19J/Lq2HH
 ULRHC8BgTFe/xBcTOungXEdFlyTETigcF6KDgBTmbNs7qHJe9sgmRRjZqnIB395DF1XF
 IwdK+3pLP7VzMFxD5GIBTrRPfytmWmC4Sjh0xIIdMr4tAIf/yACeSoFXAYjJGP+YRSjr
 Z2eg==
X-Gm-Message-State: AGi0PuaQ4u0CRXfw+JWPA7UueDDs/Kt5v40FyfktdXV9HgwPwtSpKfDR
 QIiCUqaOOHLTV2w+lB+iQDBtDigH0OjoJ3q0h0U=
X-Google-Smtp-Source: APiQypJ966aRVhFJqx7ho1/yIUFSLiMKh++bDC0AfnGvS9jmApSBZ6+3iGiXpZ+XqLf8xZIiABondptRBNXQmOH/nyM=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr12622888jac.98.1588554830749; 
 Sun, 03 May 2020 18:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <2d4952df2cc246f7421b4b9023a581b22210fc41.1588252862.git.dimastep@yandex-team.ru>
In-Reply-To: <2d4952df2cc246f7421b4b9023a581b22210fc41.1588252862.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sun, 3 May 2020 21:13:40 -0400
Message-ID: <CAFubqFuc7DjTN3PHL=75TAJzyTgSFsjSK-G+7YEUWjaFsNpKFw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vhost: check vring address before calling unmap
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd42.google.com
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

On Thu, Apr 30, 2020 at 9:50 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> Since disconnect can happen at any time during initialization not all
> vring buffers (for instance used vring) can be intialized successfully.
> If the buffer was not initialized then vhost_memory_unmap call will lead
> to SIGSEGV. Add checks for the vring address value before calling unmap.
> Also add assert() in the vhost_memory_unmap() routine.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  hw/virtio/vhost.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ddbdc53..3ee50c4 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -314,6 +314,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>                                 hwaddr len, int is_write,
>                                 hwaddr access_len)
>  {
> +    assert(buffer);
> +
>      if (!vhost_dev_has_iommu(dev)) {
>          cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>      }
> @@ -1132,12 +1134,25 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
> -                       1, virtio_queue_get_used_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
> -                       0, virtio_queue_get_avail_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
> -                       0, virtio_queue_get_desc_size(vdev, idx));
> +    /*
> +     * Since the vhost-user disconnect can happen during initialization
> +     * check if vring was initialized, before making unmap.
> +     */
> +    if (vq->used) {
> +        vhost_memory_unmap(dev, vq->used,
> +                           virtio_queue_get_used_size(vdev, idx),
> +                           1, virtio_queue_get_used_size(vdev, idx));
> +    }
> +    if (vq->avail) {
> +        vhost_memory_unmap(dev, vq->avail,
> +                           virtio_queue_get_avail_size(vdev, idx),
> +                           0, virtio_queue_get_avail_size(vdev, idx));
> +    }
> +    if (vq->desc) {
> +        vhost_memory_unmap(dev, vq->desc,
> +                           virtio_queue_get_desc_size(vdev, idx),
> +                           0, virtio_queue_get_desc_size(vdev, idx));
> +    }
>  }
>
>  static void vhost_eventfd_add(MemoryListener *listener,
> --
> 2.7.4
>
>


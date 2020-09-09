Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA8620EDD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chi87DGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA8620EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqJC-0002L1-6G
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 22:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqIN-0001pB-W3; Tue, 08 Sep 2020 22:57:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqIM-00081l-9b; Tue, 08 Sep 2020 22:57:15 -0400
Received: by mail-oi1-x242.google.com with SMTP id 3so954282oih.0;
 Tue, 08 Sep 2020 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HYmZqHJl01zRxFK2rdXxUTkRqkqhxPmr8VZslIohZoY=;
 b=Chi87DGZ566XllqTQqdl+bmgA6g4T20mZhfQKq8+acbSSXu+EqtI8MAP00lYXbb+MU
 6jZl+IAmWGwXxucx6FisSWKOHW0YCl4bh9VI+5otdbNQPR4F5ooSRCxQnMFSlHWEycLi
 RupQfzdweuOQaArnqZLeiUzesbZVUzhIapPn1/BkdJF21E0ZVKMS+RNMx52wr9goU5Qe
 BF2D6oVEMztxfzTD51OPSfywDdj6cKaqZvn1d9QWOrxcTiNRAj09JFsIKJlDXkh7nsyi
 b6YKaiiV5322OE48Ph7VN48vfqhWd4bfir45DUAPpHBx9FyN53dq3US2b4iOy509MpPo
 uk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HYmZqHJl01zRxFK2rdXxUTkRqkqhxPmr8VZslIohZoY=;
 b=YWqDCdX30YFYVeMSMl9mSijxU+oFg6G0X+6n3/3y4C2u98uExHxsac2ZYfQFaAoGeH
 MOPvD8PzXXtyF9Wyya9OVyMVU1esLhPqbmuEMhvW59xtb/Uq2FjyJKcWQIEbzg54CKPk
 Pyqw+rU/QbdlVEVSpxEnoqe8Xoazp/cBxQjZlmFkuH30ZT3WrbHx4I1wjzLt/GyiCIez
 tDWR1HGK7ZpsQJ5pRfdGGUEm84Di2iEubJgJBiM+LUKLTYxMA612hwqOjOr0ZCA3Cut4
 Rc5AUo66OMJKl+19vK+FAALEtQ0HfiEbi+nQLsyNM1wfY7aBHIB/n6xoXgODcMkCWJbm
 1Rfg==
X-Gm-Message-State: AOAM532E5Kc9kSBhgPKO6L//A9OtbzhuDxLCIw2z+JlpLv767AZmwp5X
 QQNYJVsQ6lo6BcELmcW62R/3+AVDFHxougZAFRA=
X-Google-Smtp-Source: ABdhPJxhY+FIpebQfd3QqGs2VOlJN2shZrIUyg3+3Y/kUVZj0SLP2ZW9G2ehJ9BmXDgXdXB4+va/qVRHBcHCW4kLyl0=
X-Received: by 2002:aca:4894:: with SMTP id v142mr1318284oia.157.1599620232025; 
 Tue, 08 Sep 2020 19:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <132917f71e5f267370f9564cd21189ce53569fce.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <132917f71e5f267370f9564cd21189ce53569fce.1599211479.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 8 Sep 2020 22:57:01 -0400
Message-ID: <CAFubqFtQEwYi_+OHcowJ7dU51r=pMqqR9sWgqt5q2R2wnR_rCg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] vhost: check queue state in the vhost_dev_set_log
 routine
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x242.google.com
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

On Fri, Sep 4, 2020 at 5:32 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> If the vhost-user-blk daemon provides only one virtqueue, but device was
> added with several queues, then QEMU will send more VHOST-USER command
> than expected by daemon side. The vhost_virtqueue_start() routine
> handles such case by checking the return value from the
> virtio_queue_get_desc_addr() function call. Add the same check to the
> vhost_dev_set_log() routine.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>


> ---
>  hw/virtio/vhost.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ffef7ab..a08b7d8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -825,12 +825,24 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
>  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>  {
>      int r, i, idx;
> +    hwaddr addr;
> +
>      r = vhost_dev_set_features(dev, enable_log);
>      if (r < 0) {
>          goto err_features;
>      }
>      for (i = 0; i < dev->nvqs; ++i) {
>          idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
> +        addr = virtio_queue_get_desc_addr(dev->vdev, idx);
> +        if (!addr) {
> +            /*
> +             * The queue might not be ready for start. If this
> +             * is the case there is no reason to continue the process.
> +             * The similar logic is used by the vhost_virtqueue_start()
> +             * routine.
> +             */
> +            continue;
> +        }
>          r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
>                                       enable_log);
>          if (r < 0) {
> --
> 2.7.4
>
>


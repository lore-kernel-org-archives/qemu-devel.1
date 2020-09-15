Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB82C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A88620738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFIQWrEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A88620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHzjv-00059s-0R
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 21:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kHzis-0004NE-Bw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:25:30 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:38187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kHziq-0005ne-1t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:25:30 -0400
Received: by mail-oo1-xc41.google.com with SMTP id r10so350309oor.5
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 18:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MBDCggUjZCm7UwpIgJEesq62UsKUfDNPE0DUreqbQrE=;
 b=mFIQWrELFMrKYBpiT7NHKsIAqDPA+hUHKNOidvjGgCqcspKFKX9S5mOLQ2znyXdcI9
 mBdKFfembq3XYI2lALIhtqFmG6jMCqIfbCrH7vXCPPxU97Qr0a/dukD8TyVKw2rWCvQO
 jrkyXRHCgrp71CxVWMApMDNWrdPYqMQr2OII8kBW02zzE+kn2TweOWxsof1wcpNbE8sS
 sDU0pUP16/cUEcQTlj6wbiPcCfhpv6oq1pu9s2Q2oUBCbrdbOh1rGcM2b0Q97Hr/pvVU
 Z1ev3We3QkDV3Vd7BRO+nr7UqV3MUdGcnZD7lLhF70PuSCF35g6SKmCIAIRoBCXxPPwK
 MixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MBDCggUjZCm7UwpIgJEesq62UsKUfDNPE0DUreqbQrE=;
 b=bUg9M7mw3ufMsF3yyGfYceW081dsNKH8e4NAQ7IiFxhiZgmTHrxcTbtnS5Z5xhT1xv
 fCr/gweKdfs0PMCcBDxAyLUx9zFnudyun3iZYlG7Ztw2TkqPgx2cEykDekJsoDdhp+qW
 fQX2HouskFWPJ5CFy1zHlMKA7+41viCaI+qVzAm/xBqGtEDngOulQZp5G9k1H7fzBaPd
 qsGDGJiMKcv4Sl31o5wwU9yn2kvNCn98NxAwvVp0j68bLNCQNsxDOwdjEDNoOuPCNnb2
 a43aBnWSXCGLu8BC42ii4zhiALsKbAa0szoN8cmExCLoSdF7tnyTXwS1DxL8zlKS1VGP
 SCRA==
X-Gm-Message-State: AOAM533ZcPFCjK9nBQorv91oSKgLJy10epMklEZ1gBwPDt+ZzuU2uH6r
 WMUoEZR0mP5SWR8FSldHpq06I5sPpGsMlwubqA1/OnADbuoVQIrE
X-Google-Smtp-Source: ABdhPJx5rvN0YvNRqGp51O9xJqWTiHl1mKu9C+jYuMLGKD8I02jHBOz2IHCtsRMyoujNbUgbftlwNRjJchCzkZ08OTQ=
X-Received: by 2002:a4a:614f:: with SMTP id u15mr12081621ooe.70.1600133126599; 
 Mon, 14 Sep 2020 18:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134851.7817-1-jin.yu@intel.com>
In-Reply-To: <20200910134851.7817-1-jin.yu@intel.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 14 Sep 2020 21:25:15 -0400
Message-ID: <CAFubqFuBY9-KpxUfb7HorV-q960Ns4EiCLCzq-TRFciDuaUiUQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-blk: set features before setting inflight feature
To: Jin Yu <jin.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc41.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Backends already receive the format in vhost_dev_start before the
memory tables are set or any of the virtqueues are started. Can you
elaborate on why you need to know the virtqueue format before setting
the inflight FD?

On Thu, Sep 10, 2020 at 2:15 AM Jin Yu <jin.yu@intel.com> wrote:
>
> Virtqueue has split and packed, so before setting inflight,
> you need to inform the back-end virtqueue format.
>
> Signed-off-by: Jin Yu <jin.yu@intel.com>
> ---
>  hw/block/vhost-user-blk.c |  6 ++++++
>  hw/virtio/vhost.c         | 18 ++++++++++++++++++
>  include/hw/virtio/vhost.h |  1 +
>  3 files changed, 25 insertions(+)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 39aec42dae..9e0e9ebec0 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -131,6 +131,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
>
>      s->dev.acked_features = vdev->guest_features;
>
> +    ret = vhost_dev_prepare_inflight(&s->dev);
> +    if (ret < 0) {
> +        error_report("Error set inflight format: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +
>      if (!s->inflight->addr) {
>          ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
>          if (ret < 0) {
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e7a6..4027c11886 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1616,6 +1616,24 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
>      return 0;
>  }
>
> +int vhost_dev_prepare_inflight(struct vhost_dev *hdev)
> +{
> +    int r;
> +
> +    if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
> +        hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
> +        return 0;
> +    }
> +
> +    r = vhost_dev_set_features(hdev, hdev->log_enabled);
> +    if (r < 0) {
> +        VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
> +        return r;
> +    }
> +
> +    return 0;
> +}
> +
>  int vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight)
>  {
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 767a95ec0b..4e2fc75528 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -140,6 +140,7 @@ void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
>  void vhost_dev_free_inflight(struct vhost_inflight *inflight);
>  void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
>  int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
> +int vhost_dev_prepare_inflight(struct vhost_dev *hdev);
>  int vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight);
>  int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
> --
> 2.17.2
>
>


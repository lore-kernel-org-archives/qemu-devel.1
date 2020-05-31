Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C1C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 02:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9502073B
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 02:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsnEDeHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9502073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfDw7-0005DQ-8t
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 22:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jfDvX-0004j7-59; Sat, 30 May 2020 22:42:19 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jfDvW-0006JH-4Y; Sat, 30 May 2020 22:42:18 -0400
Received: by mail-il1-x141.google.com with SMTP id v11so6251250ilh.1;
 Sat, 30 May 2020 19:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=50rNKJqpSTkW6JYwcIbij8rKFlwp/evO3Fs4IPVmjg4=;
 b=ZsnEDeHVuMPNf00oHv/8/pbN/y4jExVFFGhu8sezjIOMo/f7Ysyv0YllJLSGPf0Q0I
 DmEjb7lV4N8eaxz2KxddAn0KGCGZlKoG3xpzBqSlFwjttZmx8VRTvnMM3xZgOJxmAv8a
 4tOiJPF2Mr9WqZ7/Tfuy39mQBpa5kHk+X686AedcdED+JXoncrvegc/6duwzs8wCehDP
 GdI/Y3Q8GGrp9LY313cLptnZM3+3UXBaKr+ReBDIxBFXHuHMaH4pOhWUOr57zaZLkWUh
 jZPaEUthaUfBK+Ltdsj32gVbWqnoj+/wsLrRU/aQqxwiv9g65y2daw/UgOGq5IPfksyx
 PTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=50rNKJqpSTkW6JYwcIbij8rKFlwp/evO3Fs4IPVmjg4=;
 b=S758uJH9ahEfCOl8WXP1x/QVf5AJX5axH/B8eloqXqz7bbhvWim0alSwzmxDGTYavv
 SkCQpxtHPA80QHlU9rw/lyIR1OJe4M73fwJkYhVVtYYot3dLH2PDYXVdzwS+xNeFcjiT
 S2CAn+nfRn/agxQ9TRhxfnaUazbC9l/e3ccNetdKPTDXOHFsJjV/d5z+Bc4T6l1JwzdC
 F26zhCzCIvn6A+mfdKbFqcRg+QTXLYC6LLlv6/CB7W9mpy93Jgvg6vpYQzQPwBRyqmk3
 Hkcsa7QlNr1N+qnzuaJWO/UwZxb+qGnr4hWF9PzDT2PkOSMpLVl7evdrz4C67wI4YNr1
 jYDQ==
X-Gm-Message-State: AOAM531QpZkl6YKw/VIyfI2+PoIlCEFHSJa4m7i9QAFagpRQvxs+MVoH
 PBTirD2nuOaCDdPc/Fv9ulJAh4nBtErNrI1gU+E=
X-Google-Smtp-Source: ABdhPJzfj16ESWNg/bA1zzkVp7ULKzeboPIvN3FVU0a0CIygosGjdQs+eGSrKawXvC4QhC+2rUp1IEa97W+2us16IWw=
X-Received: by 2002:a05:6e02:972:: with SMTP id
 q18mr813900ilt.60.1590892936662; 
 Sat, 30 May 2020 19:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-6-stefanha@redhat.com>
In-Reply-To: <20200527102925.128013-6-stefanha@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 30 May 2020 22:42:05 -0400
Message-ID: <CAFubqFuCk42dRtKvC=V-A288y7JC398-fWSDPx7YsU97O8foGg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] vhost-user-blk: default num_queues to -smp N
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm happy with the code but as David pointed out with virtio-scsi, we
should probably add a comment about virtio_pci_optimal_num_queues()
capping the number of VQs here too.


On Wed, May 27, 2020 at 6:34 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Automatically size the number of request virtqueues to match the number
> of vCPUs.  This ensures that completion interrupts are handled on the
> same vCPU that submitted the request.  No IPI is necessary to complete
> an I/O request and performance is improved.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/virtio/vhost-user-blk.h | 2 ++
>  hw/block/vhost-user-blk.c          | 6 +++++-
>  hw/core/machine.c                  | 1 +
>  hw/virtio/vhost-user-blk-pci.c     | 4 ++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index 34ad6f0c0e..292d17147c 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -25,6 +25,8 @@
>  #define VHOST_USER_BLK(obj) \
>          OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
>
> +#define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
> +
>  typedef struct VHostUserBlk {
>      VirtIODevice parent_obj;
>      CharBackend chardev;
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 9d8c0b3909..7a8639516f 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -385,6 +385,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>
> +    if (s->num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> +        s->num_queues = 1;
> +    }
>      if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
>          error_setg(errp, "vhost-user-blk: invalid number of IO queues");
>          return;
> @@ -496,7 +499,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>
>  static Property vhost_user_blk_properties[] = {
>      DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> -    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
> +    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
> +                       VHOST_USER_BLK_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
>      DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4aba3bdd3c..8cc4b54eec 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -32,6 +32,7 @@ GlobalProperty hw_compat_5_0[] = {
>      { "virtio-blk-device", "num-queues", "1"},
>      { "virtio-scsi-device", "num_queues", "1"},
>      { "vhost-scsi", "num_queues", "1"},
> +    { "vhost-user-blk", "num-queues", "1"},
>      { "vhost-user-scsi", "num_queues", "1"},
>  };
>  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
> diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
> index 58d7c31735..1c8ab7f5e6 100644
> --- a/hw/virtio/vhost-user-blk-pci.c
> +++ b/hw/virtio/vhost-user-blk-pci.c
> @@ -54,6 +54,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
>
> +    if (dev->vdev.num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> +        dev->vdev.num_queues = virtio_pci_optimal_num_queues(0);
> +    }
> +
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
>          vpci_dev->nvectors = dev->vdev.num_queues + 1;
>      }
> --
> 2.25.4
>


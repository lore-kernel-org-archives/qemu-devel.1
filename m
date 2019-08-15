Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDAC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1971A2133F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1971A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGDZ-0006Ui-6a
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 09:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hyGCn-0005qJ-Sb
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hyGCl-0000aH-0l
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:54:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hyGCk-0000Vj-Rk
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:54:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so1095079plp.9
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 06:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D5d7UKjZK1DIN4VHoZOYfjri0arMQikd3DYAbT6818w=;
 b=PpsAb7DmMNSSxftBwMFWJ5JWToq16KCqUaOswtZ6vCr8GWQ3dWKuu5BSTrqR1SMWJX
 aYFZisZviXvAUe8Iy+B6km295/gpi/MzsCzzhU9olZSUEXmV+/utokS0Vq7CDy9ETdN7
 5OQR2B3zLYAkaoGpUi7XLsfplygNkGY5KUxQMs/8yno28QkQdQboDq8ecWyNb/wgCZuQ
 JyVEDQjCSNu/foxVDfY0yy3g5DLiFr6fYAIRDmBImEZOH0wTbBIiOxd+zYh41Pm8I2y1
 w8bCMU0+kwtKey7TPUNj3TW0m0IzCPf2+JZyj1TuUT9TdYeYJHXFrBx1du1f8e6HnTAy
 Q+6A==
X-Gm-Message-State: APjAAAXFKuKf1lN8NmQ1xwCmpKsksVXGJrCehvS1XHaI3/qtFULgd3t7
 eFEf0hcIEZHS6vr9MDjm+UQcfw==
X-Google-Smtp-Source: APXvYqwUrJbt4o+02bDe3Ht50fX6xvsg74V5n/mrmiw4zE0l6lQkH0axFHBS+2q/3XXovTocIViNLQ==
X-Received: by 2002:a17:902:b084:: with SMTP id
 p4mr4352728plr.309.1565877252870; 
 Thu, 15 Aug 2019 06:54:12 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c26sm2626103pfr.172.2019.08.15.06.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 06:54:12 -0700 (PDT)
Date: Thu, 15 Aug 2019 21:54:00 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190815135400.GC8463@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-4-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.195
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 03/15] virtio-iommu: Add
 skeleton
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 07:21:25PM +0200, Eric Auger wrote:
> +static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
> +    struct virtio_iommu_req_head head;
> +    struct virtio_iommu_req_tail tail;

[1]

> +    VirtQueueElement *elem;
> +    unsigned int iov_cnt;
> +    struct iovec *iov;
> +    size_t sz;
> +
> +    for (;;) {
> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            return;
> +        }
> +
> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
> +            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
> +            virtio_error(vdev, "virtio-iommu bad head/tail size");
> +            virtqueue_detach_element(vq, elem, 0);
> +            g_free(elem);
> +            break;
> +        }
> +
> +        iov_cnt = elem->out_num;
> +        iov = g_memdup(elem->out_sg, sizeof(struct iovec) * elem->out_num);

Could I ask why memdup is needed here?

> +        sz = iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
> +        if (unlikely(sz != sizeof(head))) {
> +            tail.status = VIRTIO_IOMMU_S_DEVERR;

Do you need to zero the reserved bits to make sure it won't contain
garbage?  Same question to below uses of tail.

> +            goto out;
> +        }
> +        qemu_mutex_lock(&s->mutex);
> +        switch (head.type) {
> +        case VIRTIO_IOMMU_T_ATTACH:
> +            tail.status = virtio_iommu_handle_attach(s, iov, iov_cnt);
> +            break;
> +        case VIRTIO_IOMMU_T_DETACH:
> +            tail.status = virtio_iommu_handle_detach(s, iov, iov_cnt);
> +            break;
> +        case VIRTIO_IOMMU_T_MAP:
> +            tail.status = virtio_iommu_handle_map(s, iov, iov_cnt);
> +            break;
> +        case VIRTIO_IOMMU_T_UNMAP:
> +            tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
> +            break;
> +        default:
> +            tail.status = VIRTIO_IOMMU_S_UNSUPP;
> +        }
> +        qemu_mutex_unlock(&s->mutex);
> +
> +out:
> +        sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
> +                          &tail, sizeof(tail));
> +        assert(sz == sizeof(tail));
> +
> +        virtqueue_push(vq, elem, sizeof(tail));

s/tail/head/ (though they are the same size)?

> +        virtio_notify(vdev, vq);
> +        g_free(elem);
> +    }
> +}

[...]

> +static void virtio_iommu_set_features(VirtIODevice *vdev, uint64_t val)
> +{
> +    VirtIOIOMMU *dev = VIRTIO_IOMMU(vdev);
> +
> +    dev->acked_features = val;
> +    trace_virtio_iommu_set_features(dev->acked_features);
> +}
> +
> +static const VMStateDescription vmstate_virtio_iommu_device = {
> +    .name = "virtio-iommu-device",
> +    .unmigratable = 1,

Curious, is there explicit reason to not support migration from the
first version? :)

> +};
> +
> +static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
> +
> +    virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
> +                sizeof(struct virtio_iommu_config));
> +
> +    s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
> +                             virtio_iommu_handle_command);
> +    s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
> +
> +    s->config.page_size_mask = TARGET_PAGE_MASK;
> +    s->config.input_range.end = -1UL;
> +    s->config.domain_range.start = 0;

Zero input_range.start = 0?  After all domain_range.start is zeroed.

> +    s->config.domain_range.end = 32;
> +
> +    virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
> +    virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
> +    virtio_add_feature(&s->features, VIRTIO_F_VERSION_1);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_INPUT_RANGE);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_DOMAIN_RANGE);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> +}

Regards,

-- 
Peter Xu


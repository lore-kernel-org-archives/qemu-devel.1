Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 09:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9AF2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 09:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TK+o5YXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9AF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlUCO-0007aS-QA
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 05:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jlUBI-0006tc-C6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:16:28 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jlUBG-00048h-5J
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:16:28 -0400
Received: by mail-ej1-x641.google.com with SMTP id l27so1551966ejc.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ax1yDnXBvkLcGMNsFOw5wOp2zPFHgKXIAUpNw3iy4xo=;
 b=TK+o5YXmTO9BjaUwhLYcqDReAlCiaaxMk1zc/amDqYQ4/1z14cAY/If1YbeBR84MB9
 ngXHzvfhnqYaeWoKV9QkfNVWk/+0XnUzGAsaUglK3K8iFqHZnjmymWwxKhoL28eBCALJ
 GxaL8hGhey/0IYQSC0u2tZAQPx7yz3YVSnRz1HHxLlEKxzbB7fjnzbqPqcywJvjNkRKo
 MaboT5Ar8W98O793OSSCFaPX07FFtfZn1QYUfr7+LkVeFByosih9oDh4eg/1IxAvxEAC
 uK2Afc1tZr8+3zD90W6YmnVN41kDRCBANBiJEtuWwNcuwj786L5ElzZyrSh0JP4fWBUG
 iToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ax1yDnXBvkLcGMNsFOw5wOp2zPFHgKXIAUpNw3iy4xo=;
 b=MbSrURXWJdSupi3JiVmfYe/xybeX6aNPgOfmdbDtnQVeXKncmwnl/rAjR7lYFuVSNZ
 itAaNm1mzlYs6IEHDHMutl9fd8M5OdOxHDqQTW26YrsTw56ylEV1Xc+LtWoPE3EQEuBT
 uiZndGRGTlkytuG+HnZdfvH1L2BMyPLBWjCPpZYLfpLHhABm2qOmNvelJ0UktKuVYQY5
 NW1ySqGpEIbubPztwHMZRWUG39ReF6Kc2fpi8X9GgpPvRHRkdtRmwGH8OEI7VIbla8wq
 350/V/UBVmh/CjY0RtHwzJzLWQ8grZvSig/Re89xl0qQgAZQwlwocFC8GY6tBxutCOc1
 APUg==
X-Gm-Message-State: AOAM530YuHR5MzBFO/60XMdvWlGcReBY9Vry+eOfBaTqu2wroF3ls3aq
 e35Aa/KdbsF0UTVDlOa/LYca8g==
X-Google-Smtp-Source: ABdhPJy9q+HKIaBunIF8bkbxzSA4HY5PCCxqthc01Ppjy3aGx+G/U5rnE8DVekpsqZIa8zgB7hLGnA==
X-Received: by 2002:a17:906:3282:: with SMTP id 2mr6442934ejw.93.1592385384321; 
 Wed, 17 Jun 2020 02:16:24 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y2sm12907218ejj.103.2020.06.17.02.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 02:16:23 -0700 (PDT)
Date: Wed, 17 Jun 2020 11:16:13 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 2/5] virtio-iommu: Implement RESV_MEM probe request
Message-ID: <20200617091613.GA871763@myrica>
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611151209.22547-3-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 05:12:06PM +0200, Eric Auger wrote:
> This patch implements the PROBE request. At the moment,
> only THE RESV_MEM property is handled. The first goal is
> to report iommu wide reserved regions such as the MSI regions
> set by the machine code. On x86 this will be the IOAPIC MSI
> region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
> doorbell.
> 
> In the future we may introduce per device reserved regions.
> This will be useful when protecting host assigned devices
> which may expose their own reserved regions
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Looks good to me apart from one comment inconsistency (below)

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> 
> ---
> 
> v2 -> v3:
> - on probe, do not fill the reminder of the buffer with zeroes
>   as the buffer was already zero initialized (Bharat)
> 
> v1 -> v2:
> - move the unlock back to the same place
> - remove the push label and factorize the code after the out label
> - fix a bunch of cpu_to_leX according to the latest spec revision
> - do not remove sizeof(last) from free space
> - check the ep exists
> ---
>  include/hw/virtio/virtio-iommu.h |  2 +
>  hw/virtio/virtio-iommu.c         | 91 ++++++++++++++++++++++++++++++--
>  hw/virtio/trace-events           |  1 +
>  3 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index e653004d7c..49eb105cd8 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -53,6 +53,8 @@ typedef struct VirtIOIOMMU {
>      GHashTable *as_by_busptr;
>      IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>      PCIBus *primary_bus;
> +    ReservedRegion *reserved_regions;
> +    uint32_t nb_reserved_regions;
>      GTree *domains;
>      QemuMutex mutex;
>      GTree *endpoints;
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 483883ec1d..be1527c1d6 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -38,6 +38,7 @@
>  
>  /* Max size */
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> +#define VIOMMU_PROBE_SIZE 512
>  
>  typedef struct VirtIOIOMMUDomain {
>      uint32_t id;
> @@ -378,6 +379,62 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      return ret;
>  }
>  
> +static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
> +                                               uint8_t *buf, size_t free)
> +{
> +    struct virtio_iommu_probe_resv_mem prop = {};
> +    size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
> +    int i;
> +
> +    total = size * s->nb_reserved_regions;
> +
> +    if (total > free) {
> +        return -ENOSPC;
> +    }
> +
> +    for (i = 0; i < s->nb_reserved_regions; i++) {
> +        prop.head.type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM);
> +        prop.head.length = cpu_to_le16(length);
> +        prop.subtype = s->reserved_regions[i].type;
> +        prop.start = cpu_to_le64(s->reserved_regions[i].low);
> +        prop.end = cpu_to_le64(s->reserved_regions[i].high);
> +
> +        memcpy(buf, &prop, size);
> +
> +        trace_virtio_iommu_fill_resv_property(ep, prop.subtype,
> +                                              prop.start, prop.end);
> +        buf += size;
> +    }
> +    return total;
> +}
> +
> +/**
> + * virtio_iommu_probe - Fill the probe request buffer with
> + * the properties the device is able to return and add a NONE
> + * property at the end.

The NONE property doesn't exist anymore

> + */
> +static int virtio_iommu_probe(VirtIOIOMMU *s,
> +                              struct virtio_iommu_req_probe *req,
> +                              uint8_t *buf)
> +{
> +    uint32_t ep_id = le32_to_cpu(req->endpoint);
> +    size_t free = VIOMMU_PROBE_SIZE;
> +    ssize_t count;
> +
> +    if (!virtio_iommu_mr(s, ep_id)) {
> +        return VIRTIO_IOMMU_S_NOENT;
> +    }
> +
> +    count = virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
> +    if (count < 0) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +    buf += count;
> +    free -= count;

Nit: could be removed since we only support one property at the moment.

> +
> +    return VIRTIO_IOMMU_S_OK;
> +}
> +
>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>                                     unsigned int iov_cnt,
>                                     void *req, size_t req_sz)
> @@ -407,15 +464,27 @@ virtio_iommu_handle_req(detach)
>  virtio_iommu_handle_req(map)
>  virtio_iommu_handle_req(unmap)
>  
> +static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
> +                                     struct iovec *iov,
> +                                     unsigned int iov_cnt,
> +                                     uint8_t *buf)
> +{
> +    struct virtio_iommu_req_probe req;
> +    int ret = virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req));
> +
> +    return ret ? ret : virtio_iommu_probe(s, &req, buf);
> +}
> +
>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
>      struct virtio_iommu_req_head head;
>      struct virtio_iommu_req_tail tail = {};
> +    size_t output_size = sizeof(tail), sz;
>      VirtQueueElement *elem;
>      unsigned int iov_cnt;
>      struct iovec *iov;
> -    size_t sz;
> +    void *buf = NULL;
>  
>      for (;;) {
>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> @@ -452,6 +521,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>          case VIRTIO_IOMMU_T_UNMAP:
>              tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
>              break;
> +        case VIRTIO_IOMMU_T_PROBE:
> +        {
> +            struct virtio_iommu_req_tail *ptail;
> +
> +            output_size = s->config.probe_size + sizeof(tail);
> +            buf = g_malloc0(output_size);
> +
> +            ptail = (struct virtio_iommu_req_tail *)
> +                        (buf + s->config.probe_size);
> +            ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
> +        }
>          default:
>              tail.status = VIRTIO_IOMMU_S_UNSUPP;
>          }
> @@ -459,12 +539,13 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>  
>  out:
>          sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
> -                          &tail, sizeof(tail));
> -        assert(sz == sizeof(tail));
> +                          buf ? buf : &tail, output_size);
> +        assert(sz == output_size);
>  
> -        virtqueue_push(vq, elem, sizeof(tail));
> +        virtqueue_push(vq, elem, sz);
>          virtio_notify(vdev, vq);
>          g_free(elem);
> +        g_free(buf);
>      }
>  }
>  
> @@ -667,6 +748,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      s->config.page_size_mask = TARGET_PAGE_MASK;
>      s->config.input_range.end = -1UL;
>      s->config.domain_range.end = 32;
> +    s->config.probe_size = VIOMMU_PROBE_SIZE;
>  
>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
> @@ -676,6 +758,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>  
>      qemu_mutex_init(&s->mutex);
>  
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 6427a0047d..23109f69bb 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -74,3 +74,4 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>  virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
> +virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
> -- 
> 2.20.1
> 


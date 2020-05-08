Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3385C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B62208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/xk8vft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B62208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzHd-0000MM-TU
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 05:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jWzGs-0008Fh-Rl
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:26:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jWzGr-00087i-CM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:26:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id m12so4575906wmc.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VmMh+jqzek/DyUAQYhooLKmziQFLl0vhpC/AJ9Ek3Pk=;
 b=V/xk8vfttyJH58ce0xNpateZn8QZp7BxrDDE+ldwiszwzYbRux5W8yVEQHgUBSnB41
 wUTIFmuk2WZGiUbtWD30d9796qnUDBTP04M1k9w4WSFWCKCAsNtsFa8jR5quCZzis1c3
 GtYzrj5DUZMPh/Tl+jolQTTBS3b3yUDr+UXHXDu4uCEtmkAXwm/iUxzVnjfW4hYXSsuH
 lsCsCSoTmCu5YM8DIjZU+NGF7L/y/O1ghldCqq5BLymhOmtSx45VPYqU/sTIH04054R4
 Zf0noITMOwVBktMeeRdgWm1y3Mwarytt7X2EmrfPP6OLsXUe/gofvxedERqDHXr1/ChU
 IpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VmMh+jqzek/DyUAQYhooLKmziQFLl0vhpC/AJ9Ek3Pk=;
 b=MlmzMgITi9kW0fXKUVriYD+ND2hofjlTtYaIgvDWtxZJSYX3uPKEtHHiGVuXvdTICU
 +rn6AWuZlM7T/MyaAGsuRYDt0QITTeuEIPKxNEMqbA/MPGFtD5LtYRSMo1XRPxUPgOeX
 Fx2ay2khYLGvIEDI9VQIgaZ0LgdsTH3SoQbvoDdzM0JZuYq5hTGmGi13IB6NSGb35g0s
 ZHF0si/pPic29SLvW9zSYeuDCusda+2/MvSrVlXRQGDzWObrpcP0ax7HJDOz98lL0CW6
 fsOPp39KZf0rOclswXP3R5MMhv57TrLxas+3r+qWszZF4WWSttOy0zJ+0GygdyO57qtQ
 4Edg==
X-Gm-Message-State: AGi0Pubbdh+aZf0q8764c6ocxG6sGJyP0fT7tbZ9HyIsOBckBfrtRYBT
 jHiCchXPimUOQMFZJX5Xb5QVhQ==
X-Google-Smtp-Source: APiQypLO9BEkZM7OTiYs5yzC/li5Y96HSzHf3l52Yv7tfqgtNuJgDSkxlTmKbRf3Pbn+l5wNn1nLiQ==
X-Received: by 2002:a1c:9816:: with SMTP id a22mr14401471wme.125.1588929975824; 
 Fri, 08 May 2020 02:26:15 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 77sm2137641wrc.6.2020.05.08.02.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 02:26:15 -0700 (PDT)
Date: Fri, 8 May 2020 11:26:05 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 2/5] virtio-iommu: Implement RESV_MEM probe request
Message-ID: <20200508092605.GB1770804@myrica>
References: <20200507143201.31080-1-eric.auger@redhat.com>
 <20200507143201.31080-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507143201.31080-3-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 07, 2020 at 04:31:58PM +0200, Eric Auger wrote:
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
> +        prop.head.type = VIRTIO_IOMMU_PROBE_T_RESV_MEM;

cpu_to_le16

> +        prop.head.length = cpu_to_le64(length);

same here

> +        prop.subtype = cpu_to_le64(s->reserved_regions[i].type);

and subtype is a byte

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
> + */
> +static int virtio_iommu_probe(VirtIOIOMMU *s,
> +                              struct virtio_iommu_req_probe *req,
> +                              uint8_t *buf)
> +{
> +    uint32_t ep_id = le32_to_cpu(req->endpoint);

I think we should check that the endpoint ID is sane even if we're not
using it at the moment (it is a SHOULD in the spec, and the page size mask
patch will need the ep anyway).

> +    struct virtio_iommu_probe_property last = {};
> +    size_t free = VIOMMU_PROBE_SIZE - sizeof(last);

last isn't needed, you can fill the whole probe buffer with valid
properties

> +    ssize_t count;
> +
> +    count = virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
> +    if (count < 0) {
> +            return VIRTIO_IOMMU_S_INVAL;

indentation?

Thanks,
Jean

> +    }
> +    buf += count;
> +    free -= count;
> +
> +    /* Fill the rest with zeroes */
> +    memset(buf, 0, free);
> +
> +    return VIRTIO_IOMMU_S_OK;
> +}
> +
>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>                                     unsigned int iov_cnt,
>                                     void *req, size_t req_sz)
> @@ -407,6 +464,17 @@ virtio_iommu_handle_req(detach)
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
> @@ -452,17 +520,33 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>          case VIRTIO_IOMMU_T_UNMAP:
>              tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
>              break;
> +        case VIRTIO_IOMMU_T_PROBE:
> +        {
> +            struct virtio_iommu_req_tail *ptail;
> +            uint8_t *buf = g_malloc0(s->config.probe_size + sizeof(tail));
> +
> +            ptail = (struct virtio_iommu_req_tail *)
> +                        (buf + s->config.probe_size);
> +            ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
> +
> +            sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
> +                              buf, s->config.probe_size + sizeof(tail));
> +            g_free(buf);
> +            assert(sz == s->config.probe_size + sizeof(tail));
> +            goto push;
> +        }
>          default:
>              tail.status = VIRTIO_IOMMU_S_UNSUPP;
>          }
> -        qemu_mutex_unlock(&s->mutex);
>  
>  out:
>          sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>                            &tail, sizeof(tail));
>          assert(sz == sizeof(tail));
>  
> -        virtqueue_push(vq, elem, sizeof(tail));
> +push:
> +        qemu_mutex_unlock(&s->mutex);
> +        virtqueue_push(vq, elem, sz);
>          virtio_notify(vdev, vq);
>          g_free(elem);
>      }
> @@ -667,6 +751,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      s->config.page_size_mask = TARGET_PAGE_MASK;
>      s->config.input_range.end = -1UL;
>      s->config.domain_range.end = 32;
> +    s->config.probe_size = VIOMMU_PROBE_SIZE;
>  
>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
> @@ -676,6 +761,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>  
>      qemu_mutex_init(&s->mutex);
>  
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index e83500bee9..5550475691 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -73,3 +73,4 @@ virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>  virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
> +virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
> -- 
> 2.20.1
> 


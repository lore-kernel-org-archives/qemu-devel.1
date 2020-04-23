Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67AEC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9089220704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5s1hPav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9089220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReUi-0003YQ-MN
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1jReQR-0005Un-95
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1jReQP-0006EI-Iu
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:10:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jReQP-0006Dj-44
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:10:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id v8so7814619wma.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nWdrkLY2zpQLK8W8mhoILd295IuGxGR8r2Xr8cPPU94=;
 b=e5s1hPavrfSiCmJgMHv0mbKBd/Bwu4d819eQJh2hCEvQDPJxjxf2rZIPLmCKBM6NBL
 UYBCVLagLkSzJg49Zp3la5FWmj4PmwoHzLiTY4Ge7Mk4RtZ8wYVsRSQezf5ce1h6BYoi
 u9h7KWxmfIPdNG3NOjmq6ZBuoskGDLXXcgRV5Wuw1I2T992wIiRnMPOw26zF0laek5+6
 L9XxY7I159lEdFopP8rSX90u0iQNviJqgSAjf9j+eHSfzR3ULugrEM1FaKIq7V7XIV2N
 Hx3NkMPuJhxMfBo3sG4cZur71E+Hu0efWbdJ0BoZaPSCLcKvu4Jj5CT+riyrOBgpgAvA
 GSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nWdrkLY2zpQLK8W8mhoILd295IuGxGR8r2Xr8cPPU94=;
 b=PMG8k9/xUygMi5TU+wwHSfFTRtrwB3Z1m2XmRwxhrlXaoTx/LFwDTIR770G3Q6PvCR
 ZbR+iVfAqMnXZfdtD5J4M2TdY+bkBDRLq0e9TCtini9nZzAQtDN/6Jrl74pT2/uuX1JY
 2kT6/fy3iXaoLNCYzKU7FMdfJHq/bFmakj8SEoV0a8stSxa7RE7MyJKBOPJirW/O3XWv
 GAWDubviy5c1NcCJMQsS6ci2+BsA1hpfuhwivM6nNRm7gKuLEZ/MWGQga8/gWV0q60Dp
 Pt4ZzsO+7bCvevvnBwXjBK0l8CLkMsTZPne+Bbps2zVjAdBWxLUBP+RvAs/kKjetESVt
 2L9g==
X-Gm-Message-State: AGi0PuZSF5Xqq+45Wz+90iMjAOS+1gO1LPgfywPhzgaoz4sDXWOiDKrJ
 ilJ9izl2IK97rPDlEoQHk/M9ig==
X-Google-Smtp-Source: APiQypJw0+nBFJOP59uOa9Rl9R1vLUGo5q9v6ObA5iN21ruHs5JbgtKYCLY2/mv2tFLtEsdVdnoerQ==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr5195666wmc.121.1587658202498; 
 Thu, 23 Apr 2020 09:10:02 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t20sm11032225wmi.2.2020.04.23.09.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 09:10:01 -0700 (PDT)
Date: Thu, 23 Apr 2020 18:09:52 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH v9 8/9] virtio-iommu: Implement probe request
Message-ID: <20200423160952.GB645865@myrica>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-9-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323084617.1782-9-bbhushan2@marvell.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, bharatb.linux@gmail.com,
 linuc.decode@gmail.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

A few more things found while rebasing

On Mon, Mar 23, 2020 at 02:16:16PM +0530, Bharat Bhushan wrote:
> This patch implements the PROBE request. Currently supported
> page size mask per endpoint is returned. Also append a NONE
> property in the end.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/standard-headers/linux/virtio_iommu.h |   6 +
>  hw/virtio/virtio-iommu.c                      | 161 +++++++++++++++++-
>  hw/virtio/trace-events                        |   2 +
>  3 files changed, 166 insertions(+), 3 deletions(-)
> 
> diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/standard-headers/linux/virtio_iommu.h
> index b9443b83a1..8a0d47b907 100644
> --- a/include/standard-headers/linux/virtio_iommu.h
> +++ b/include/standard-headers/linux/virtio_iommu.h
> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>  
>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>  
>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>  
> @@ -130,6 +131,11 @@ struct virtio_iommu_probe_resv_mem {
>  	uint64_t					end;
>  };
>  
> +struct virtio_iommu_probe_pgsize_mask {
> +	struct virtio_iommu_probe_property      head;
> +	uint64_t				pgsize_bitmap;
> +};
> +
>  struct virtio_iommu_req_probe {
>  	struct virtio_iommu_req_head		head;
>  	uint32_t					endpoint;
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 747e3cf1da..63fbacdcdc 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -38,6 +38,10 @@
>  
>  /* Max size */
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> +#define VIOMMU_PROBE_SIZE 512
> +
> +#define SUPPORTED_PROBE_PROPERTIES (\
> +    1 << VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK)
>  
>  typedef struct VirtIOIOMMUDomain {
>      uint32_t id;
> @@ -62,6 +66,13 @@ typedef struct VirtIOIOMMUMapping {
>      uint32_t flags;
>  } VirtIOIOMMUMapping;
>  
> +typedef struct VirtIOIOMMUPropBuffer {
> +    VirtIOIOMMUEndpoint *endpoint;
> +    size_t filled;
> +    uint8_t *start;
> +    bool error;

It doesn't seem like bufstate->error gets used anywhere

> +} VirtIOIOMMUPropBuffer;
> +
>  static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
>  {
>      return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
> @@ -490,6 +501,114 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      return ret;
>  }
>  
> +static int virtio_iommu_fill_none_prop(VirtIOIOMMUPropBuffer *bufstate)
> +{
> +    struct virtio_iommu_probe_property *prop;
> +
> +    prop = (struct virtio_iommu_probe_property *)
> +                (bufstate->start + bufstate->filled);
> +    prop->type = 0;
> +    prop->length = 0;
> +    bufstate->filled += sizeof(*prop);
> +    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
> +    return 0;
> +}
> +
> +static int virtio_iommu_fill_page_size_mask(VirtIOIOMMUPropBuffer *bufstate)
> +{
> +    struct virtio_iommu_probe_pgsize_mask *page_size_mask;
> +    size_t prop_size = sizeof(*page_size_mask);
> +    VirtIOIOMMUEndpoint *ep = bufstate->endpoint;
> +    VirtIOIOMMU *s = ep->viommu;
> +    IOMMUDevice *sdev;
> +
> +    if (bufstate->filled + prop_size >= VIOMMU_PROBE_SIZE) {
> +        bufstate->error = true;
> +        /* get the traversal stopped by returning true */
> +        return true;
> +    }
> +
> +    page_size_mask = (struct virtio_iommu_probe_pgsize_mask *)
> +                     (bufstate->start + bufstate->filled);
> +
> +    page_size_mask->head.type = VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK;
> +    page_size_mask->head.length = prop_size;
> +    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
> +        if (ep->id == sdev->devfn) {
> +            page_size_mask->pgsize_bitmap = sdev->page_size_mask;

Do we need a cpu_to_le64 here?

> +	}
> +    }
> +    bufstate->filled += sizeof(*page_size_mask);
> +    trace_virtio_iommu_fill_pgsize_mask_property(bufstate->endpoint->id,
> +                                                 page_size_mask->pgsize_bitmap,
> +                                                 bufstate->filled);
> +    return false;
> +}
> +
> +/* Fill the properties[] buffer with properties of type @type */
> +static int virtio_iommu_fill_property(int type,
> +                                      VirtIOIOMMUPropBuffer *bufstate)
> +{
> +    int ret = -ENOSPC;
> +
> +    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
> +            >= VIOMMU_PROBE_SIZE) {
> +        /* no space left for the header */
> +        bufstate->error = true;
> +        goto out;
> +    }
> +
> +    switch (type) {
> +    case VIRTIO_IOMMU_PROBE_T_NONE:
> +        ret = virtio_iommu_fill_none_prop(bufstate);
> +        break;
> +    case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> +    {
> +        ret = virtio_iommu_fill_page_size_mask(bufstate);
> +	break;
> +    }
> +    default:
> +        ret = -ENOENT;
> +        break;
> +    }
> +out:
> +    if (ret) {
> +        error_report("%s property of type=%d could not be filled (%d),"
> +                     " remaining size = 0x%lx",
> +                     __func__, type, ret, bufstate->filled);
> +    }
> +    return ret;
> +}
> +
> +/**
> + * virtio_iommu_probe - Fill the probe request buffer with all
> + * the properties the device is able to return and add a NONE
> + * property at the end. @buf points to properties[].
> + */
> +static int virtio_iommu_probe(VirtIOIOMMU *s,
> +                              struct virtio_iommu_req_probe *req,
> +                              uint8_t *buf)
> +{
> +    uint32_t ep_id = le32_to_cpu(req->endpoint);
> +    VirtIOIOMMUEndpoint *ep = virtio_iommu_get_endpoint(s, ep_id);
> +    int16_t prop_types = SUPPORTED_PROBE_PROPERTIES, type;
> +    VirtIOIOMMUPropBuffer bufstate = {.start = buf, .filled = 0,
> +                                       .error = false, .endpoint = ep};

Probably need to check if ep is valid before going further

> +
> +    while ((type = ctz32(prop_types)) != 32) {
> +        if (virtio_iommu_fill_property(type, &bufstate)) {
> +            goto failure;
> +        }
> +        prop_types &= ~(1 << type);
> +    }
> +    if (virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufstate)) {
> +        goto failure;
> +    }

We got rid of the NONE property in the spec, now there is: 

 "If the device doesn’t fill all probe_size bytes with properties, it
  SHOULD fill the remaining bytes of properties with zeroes."

So I think you can get rid of virtio_iommu_fill_none_prop() and fill the
rest of the buffer with zeroes here instead.

Thanks,
Jean

> +    return VIRTIO_IOMMU_S_OK;
> +failure:
> +    return VIRTIO_IOMMU_S_INVAL;
> +}
> +
>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>                                     unsigned int iov_cnt,
>                                     void *req, size_t req_sz)
> @@ -519,6 +638,17 @@ virtio_iommu_handle_req(detach)
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
> @@ -564,17 +694,33 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
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
> @@ -634,16 +780,23 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      VirtIOIOMMUEndpoint *ep;
>      uint32_t sid, flags;
>      bool bypass_allowed;
> +    hwaddr addr_mask;
>      bool found;
>  
>      interval.low = addr;
>      interval.high = addr + 1;
>  
> +    if (sdev->page_size_mask) {
> +        addr_mask = (1 << ctz32(sdev->page_size_mask)) - 1;
> +    } else {
> +        addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1;
> +    }
> +
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
>          .iova = addr,
>          .translated_addr = addr,
> -        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
> +        .addr_mask = addr_mask,
>          .perm = IOMMU_NONE,
>      };
>  
> @@ -831,6 +984,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      s->config.page_size_mask = TARGET_PAGE_MASK;
>      s->config.input_range.end = -1UL;
>      s->config.domain_range.end = 32;
> +    s->config.probe_size = VIOMMU_PROBE_SIZE;
>  
>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
> @@ -840,6 +994,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>  
>      qemu_mutex_init(&s->mutex);
>  
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8bae651191..b0a6e4bda3 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -76,3 +76,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uin
>  virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64
>  virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64
>  virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
> +virtio_iommu_fill_none_property(uint32_t devid) "devid=%d"
> +virtio_iommu_fill_pgsize_mask_property(uint32_t devid, uint64_t pgsize_mask, size_t filled) "dev= %d, pgsize_mask=0x%"PRIx64" filled=0x%lx"
> -- 
> 2.17.1
> 


Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7819FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 09:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401382082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 09:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5mlISA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401382082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlUD1-00084X-JC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 05:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jlUBa-00077A-RE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:16:47 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jlUBY-0004AB-8A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:16:46 -0400
Received: by mail-ej1-x644.google.com with SMTP id f7so1524404ejq.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 02:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nRCDKf2HNZDAY7OuaGZch6IGukm4fUokUREbl4fAGNI=;
 b=P5mlISA3qcXe6vEWMFhCG6HfOVOVc1fACWoOFLv0HSyJeXA+4K/s/FxKHPw+qqDU0B
 OZfWlmbdDif7I7KAzFJH0KkFo5gB4Fb0mwwuRudmuzvdb2wMlvTQV4v0UxlmJV85QXOK
 bSbe5pQq5OfjyG7KlKW8RWLf+zv7bfU7xKNzH5T4EOUJG6ETwpjGisvryRgtL8KB3XJZ
 lKrdUZzQYRpPF/kzoiwL614/uijpsjAoaYX01x8g5SL5fU0RNNAwk87sbY6b9Gw+jnJ+
 w8lS2zM2q/zaic7Cs+C4VQ24eUrxe17V3BTRJsOgvcamiVPMTIFHts/IZcFvJVCTzzZa
 d7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nRCDKf2HNZDAY7OuaGZch6IGukm4fUokUREbl4fAGNI=;
 b=olcDwfOvMAjTib1FBptJ1CspDDOQWB4x741qSNL6lH0g4EcvfShYNIUECkquwD0+xP
 3QTHS7wKL6z6/yT8dnm7k2niPaDhF4mY4DUE0sM1d7azSTUDIRVOyFCB5hWJ9+YC760D
 ijmCfL7FF7GeSmYLolf5F3xx40C4YjEFbrhQpC0PlYXcS7qp3G6FBMeX+dVsqfr8j3Rv
 WVeFmFgs/j4hIQPj1O95HiNuCNND3ZgQnB6XAFTmxWGmu51Kyl5dsgcSyhvCWTSLWwOa
 TdIqoz8NEQ5yVA/HuPVXmP/ArzVkmPT0nqF317ftm41I3i6JKemBkwsE5JB9U6cQcCX4
 iDWw==
X-Gm-Message-State: AOAM530UIQv+qKNfVM9IhtQ2aAP9PKXR8TdpN50wvyRzrsXToRlhgqAq
 J61Tl+BpWhQKmlFx6jsP8zhhww==
X-Google-Smtp-Source: ABdhPJwitTHys2Ad+NJZmVDR5ZIytk3mvloUShLXgmlLWbqhM9BQGe4N11Or0gQHGmrodI/IsHUvvg==
X-Received: by 2002:a17:906:d933:: with SMTP id
 rn19mr6832697ejb.158.1592385402464; 
 Wed, 17 Jun 2020 02:16:42 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 38sm11887201edq.6.2020.06.17.02.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 02:16:42 -0700 (PDT)
Date: Wed, 17 Jun 2020 11:16:31 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 3/5] virtio-iommu: Handle reserved regions in the
 translation process
Message-ID: <20200617091631.GB871763@myrica>
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611151209.22547-4-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x644.google.com
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

On Thu, Jun 11, 2020 at 05:12:07PM +0200, Eric Auger wrote:
> When translating an address we need to check if it belongs to
> a reserved virtual address range. If it does, there are 2 cases:
> 
> - it belongs to a RESERVED region: the guest should neither use
>   this address in a MAP not instruct the end-point to DMA on
>   them. We report an error
> 
> - It belongs to an MSI region: we bypass the translation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
> 
> v1 -> v2:
> - use addr when testing addr belongs to the reserved region
>   and use a block local variable
> ---
>  hw/virtio/virtio-iommu.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index be1527c1d6..03535a6a14 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -604,6 +604,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      uint32_t sid, flags;
>      bool bypass_allowed;
>      bool found;
> +    int i;
>  
>      interval.low = addr;
>      interval.high = addr + 1;
> @@ -637,6 +638,25 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto unlock;
>      }
>  
> +    for (i = 0; i < s->nb_reserved_regions; i++) {
> +        ReservedRegion *reg = &s->reserved_regions[i];
> +
> +        if (addr >= reg->low && addr <= reg->high) {
> +            switch (reg->type) {
> +            case VIRTIO_IOMMU_RESV_MEM_T_MSI:
> +                entry.perm = flag;
> +                break;
> +            case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
> +            default:
> +                virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
> +                                          VIRTIO_IOMMU_FAULT_F_ADDRESS,
> +                                          sid, addr);
> +                break;
> +            }
> +            goto unlock;
> +        }
> +    }
> +
>      if (!ep->domain) {
>          if (!bypass_allowed) {
>              error_report_once("%s %02x:%02x.%01x not attached to any domain",
> -- 
> 2.20.1
> 


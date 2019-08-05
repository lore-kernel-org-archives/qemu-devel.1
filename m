Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B79C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D3D20644
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnbEhUTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hueHF-0000ku-Te
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hueGj-0000DW-7y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hueGi-0006H7-7J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:47:25 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hueGi-0006GK-0s
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:47:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id l12so1574675oil.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/nl/WkNbFtK4oDCY/sJp5HyAz2vVgFv/Gwuty8xGzHY=;
 b=EnbEhUTDqCi8p0Nut56C0/rgXFX7fkBRWcGNTU030BH1SlZOksuP4GaE0UYH1D3Psj
 WCfbXv6uHxK3ibfuTojMz7BVwqSA6I66nznYxzNgclrk87GmvJAkw6MFBKQgR1Mh7lj4
 UKSB0xXymGUD7UegNjEwcfp/xgRJAq37fcvU4+v4z77BoeoyAqmkmgs+DoGu5NBgoqYz
 dRSCxqWzvUyMtlccBSzE2jRloBXCqH60RgwpTnXbf19pcm1K93TFyoU3w4benEP5A815
 O0Rhi6CryF4NBY3Vt1AWpPNBe7I95za/7yFgdcWu7MvrZuMEwlP2Nw/AyCIYqK2tzUdW
 Ibkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/nl/WkNbFtK4oDCY/sJp5HyAz2vVgFv/Gwuty8xGzHY=;
 b=CLzo+GipsQvSGFZqeV5TDU8lFZe5+HSFcpuoSh8yBg7PgvghO8WYEmOUTXvM0JvrKP
 clSjuH5X5csVtxO30ohODHVfG7OzaLr2vYz952hSE3PgjI9qHfnO0g8722UKeEDwmmak
 LW35QGx9w++nC9EFTZbshLClXbzVOu44iniDZRE9G17EDJ3chs+avsKju0ic2cKPrhYz
 8bFDFL2bgXQ0C9C3qJGXrW3OdYng6hDgevmmvWO5IWan/ZACaAX0GV07vrTm+ySZ7Wrn
 sHyfG3xW5dDzEbZow6yMh0i3jq9dVylecVywSXHborsjIQLjnkOTcWMfem2izs5ytMFc
 Eivg==
X-Gm-Message-State: APjAAAWe4DqUXtkCd5uGtM4kxy3NMoWe1B1B07pL+vL4d/opv3KT46cy
 wUFNLviS/Ah0mLWJINVI3CfPjraa7AQRwRNqt31DZA==
X-Google-Smtp-Source: APXvYqyuBAkzyzRpm4D6nj2fvZAmI3+da/9xbzjE3H/o04Zb0qyVgpTiizbegqdKWsK7AnsHtJEixv0MuKEvGte784s=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr11142438oij.98.1565016443077; 
 Mon, 05 Aug 2019 07:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190711061857.13086-1-eric.auger@redhat.com>
 <20190711061857.13086-3-eric.auger@redhat.com>
In-Reply-To: <20190711061857.13086-3-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 15:47:12 +0100
Message-ID: <CAFEAcA_UvvCydihGLhGy8Y_gk6Qh3UDGm1tC4xb3g4-UCbM1zg@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v3 2/5] memory: Add
 IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 07:19, Eric Auger <eric.auger@redhat.com> wrote:
>
> We introduce a new IOMMU Memory Region attribute,
> IOMMU_ATTR_VFIO_NESTED that tells whether the virtual IOMMU
> requires HW nested paging for VFIO integration.
>
> Current Intel virtual IOMMU device supports "Caching
> Mode" and does not require 2 stages at physical level to be
> integrated with VFIO. However SMMUv3 does not implement such
> "caching mode" and requires to use HW nested paging.
>
> As such SMMUv3 is the first IOMMU device to advertise this
> attribute.

I'm not sure the name of the attribute really captures
the intention here, though I don't have any better
suggestions. Maybe IOMMU_ATTR_VFIO_NEEDS_HW_NESTED_PAGING ?

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c       | 12 ++++++++++++
>  include/exec/memory.h |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e96d5beb9a..384c02cb91 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1490,6 +1490,17 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      }
>  }
>
> +static int smmuv3_get_attr(IOMMUMemoryRegion *iommu,
> +                           enum IOMMUMemoryRegionAttr attr,
> +                           void *data)
> +{
> +    if (attr == IOMMU_ATTR_VFIO_NESTED) {
> +        *(bool *) data = true;

I'm surprised checkpatch doesn't warn about the space after
the cast here.

> +        return 0;
> +    }
> +    return -EINVAL;
> +}
> +
>  static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>                                                    void *data)
>  {
> @@ -1497,6 +1508,7 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>
>      imrc->translate = smmuv3_translate;
>      imrc->notify_flag_changed = smmuv3_notify_flag_changed;
> +    imrc->get_attr = smmuv3_get_attr;
>  }
>
>  static const TypeInfo smmuv3_type_info = {
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index a078cd033f..e477a630a8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -204,7 +204,8 @@ struct MemoryRegionOps {
>  };
>
>  enum IOMMUMemoryRegionAttr {
> -    IOMMU_ATTR_SPAPR_TCE_FD
> +    IOMMU_ATTR_SPAPR_TCE_FD,
> +    IOMMU_ATTR_VFIO_NESTED,
>  };

Could we have a comment documenting what the attribute's meaning
and semantics are, please? (including what the type is that the
data pointer is expected to point to, ie 'bool'.)

(We ought also to document the spapr-specific attribute...)

thanks
-- PMM


Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6632FC2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3474C2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8rMi0Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3474C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiWf-0005zQ-D6
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiVn-0005HJ-Pu
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiVm-00028i-RA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:37:23 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieiVm-00028S-Kf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:37:22 -0500
Received: by mail-wr1-x442.google.com with SMTP id b6so20882637wrq.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TS8bXKSl6jHU0cVwDFmZM85QEliVGmGHepmEnSkPSts=;
 b=W8rMi0AcwZDJ7di99vHnVlD8Z27RaZmDdQYYYvq7WANbmGIqPMGraHnrAGzOVCr2bo
 pvo4D0xqVMrF2JedG0nvR9BjT+1tX5FYi+89cCSYjfBBrmi1D//M/ymGN0cLCdIeuytW
 TpU0G/4Irrhzcirtznobbdf2mfhF9Ty6//ItnmrtUvFJMYYISK8z2WxuEH5Rz3OBEVQM
 JL7tjrr0ttDDYd+jC1mk8SuGsmxJk5LWXS9KO7yBTBsXQofUH8UAcx0wHcNYS5RAwiKt
 zO6xx46yPIV17dQAXw5jBajLZo9VnNy8l4hPTTdhHyWfsy34oR2vmbvEcWIsaaR+PqWl
 Zusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TS8bXKSl6jHU0cVwDFmZM85QEliVGmGHepmEnSkPSts=;
 b=J9K+f4J0GZhk0LuYRUeTXWH1r8HYOFbuZ5H+nPyfbeNtdMgfURj4YeNnEg+dYfxcUu
 +aqlXY76+wuV/13n5xGm8BTHHQ5IQwCTTN3I73EAt7asOzx7yRBDWNxBLwORTZbvmAqT
 jdsqmDRQfZ/ognHseFAvGPBZUx2dqv1BAS1j5yBa8dM47SHkzW4X9uo40lfQLFI0Wlp6
 QlUhGL3WOFeXdH5CORajoRLmX37dMwYKlOcW3jUKKXzQff1Zn4EyBdlChZZFNUcDgSNA
 ttREOQ2eFXfcz9kuUG6pZVsgzmDoS4V3j6hGhtmLjOJ/TjzcXoqTJCQbTGAREh2NbdUP
 Z1WQ==
X-Gm-Message-State: APjAAAXE6STRw9F3i0mHT/mdfZzDm8zFjr7ee0/XiUt+MN/wJIT6qqG0
 jJGtLtJAikckSGKPzmbf256kbg==
X-Google-Smtp-Source: APXvYqxT+id6lAe9dtPusHQxl3sXymIOGIAh/Cg61XvNMY7njU1Zwb8lVxwhgvwtGS04Nwx6EBQBeQ==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr4554644wrm.80.1575995841218;
 Tue, 10 Dec 2019 08:37:21 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id s1sm3687632wmc.23.2019.12.10.08.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:37:20 -0800 (PST)
Date: Tue, 10 Dec 2019 17:37:16 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 05/20] virtio-iommu: Endpoint and domains
 structs and helpers
Message-ID: <20191210163716.GD277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-6-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:28PM +0100, Eric Auger wrote:
> +typedef struct viommu_domain {
> +    uint32_t id;
> +    GTree *mappings;
> +    QLIST_HEAD(, viommu_endpoint) endpoint_list;
> +} viommu_domain;
> +
> +typedef struct viommu_endpoint {
> +    uint32_t id;
> +    viommu_domain *domain;
> +    QLIST_ENTRY(viommu_endpoint) next;
> +} viommu_endpoint;

There might be a way to merge viommu_endpoint and the IOMMUDevice
structure introduced in patch 4, since they both represent one endpoint.
Maybe virtio_iommu_find_add_pci_as() could add the IOMMUDevice to
s->endpoints, and IOMMUDevice could store the endpoint ID rather than bus
and devfn.

> +typedef struct viommu_interval {
> +    uint64_t low;
> +    uint64_t high;
> +} viommu_interval;

I guess these should be named in CamelCase? Although if we're allowed to
choose my vote goes to underscores :)

Thanks,
Jean


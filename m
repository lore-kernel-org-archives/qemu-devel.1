Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57196C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE442073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QL3B9wwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE442073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiSX-0000NY-GC
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiQd-00079z-OM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiQc-0007gc-Lm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:03 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieiQc-0007fz-EB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:32:02 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so20803301wrt.6
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yFJvEW6PL4Wk9dE8Q8kwfKDDjO3R418aBjP/+OttZ5A=;
 b=QL3B9wwzzN9AcFnvQWPzk69I2vS9i13JtB5K3ng8EPET4KlE2XDjpWJ2fNy2dAbjNQ
 dHflE7wG8NvhZUEAU+fT630hhR7x70Xr7zTrYIOrgfefmzOhrf7kPav7fqTy/RzNILrA
 3bCH0f6ptEdJE+iPzvDm1Bb3BcwUo+Eg7lTaadOOOk6TQPeIVy5vIZ11epYqvV5pHM5w
 YpbBaDswRn29senin0FPUedkNbM794QSWPO2h4Pgr2eoAMVZrfrKrDrO3hjbpFU3rg+X
 Jr4MZkuLZ1y8fpfhdhg6JDdB8IFXgH5lFw7A+fGmuqMf7J/YfGIlr/oSJB2X2mT8iStN
 0nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yFJvEW6PL4Wk9dE8Q8kwfKDDjO3R418aBjP/+OttZ5A=;
 b=fUgsK8QM95TIN5yVO+W32R1hOhlGRVs/68oM9oV0gNOAlWLy46E+hmz6vI4sHrbpDs
 EGWsdL+YJjYsO4UUAsRz/D7qm3U911zoRhpb9QNkCY80o64ic3U0YLM+FquHXgMx9XYg
 3S6NoVOqHSAIcHWc3YAb1j55XoChAuCSig9/1OozoOg4Qmq93wXfWLMFnyYOdLdgsRBP
 oQoW/2Iqb5+ZsIt+EFA6ySeucB+Tj4plvaFpJZqSnk2o/x74ARt9kfsQSf+0qQFTl7Zn
 OnHnnV9b2mnfLDw6VgJVXjoThvNqQGOz7bffmo4xY04sT3G+5M0Jd5jdvqsZjsyZEJa4
 GPnA==
X-Gm-Message-State: APjAAAW0o+pK9jiwzmu0WOY+X74pwEuytJfhWYMH1vukUIljSJzKpFPm
 ruRVOQ022ooDQWfVZ3BG3INkCg==
X-Google-Smtp-Source: APXvYqzjNyutGRXO8/G4WT7haieLoxlV0LaBYWCWz9kz1jBfJ5Fem0xDlkK1Isa0r6cI50zPINvIAA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr4380682wrj.392.1575995520619; 
 Tue, 10 Dec 2019 08:32:00 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id x17sm3807881wrt.74.2019.12.10.08.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:31:59 -0800 (PST)
Date: Tue, 10 Dec 2019 17:31:55 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 02/20] virtio-iommu: Add skeleton
Message-ID: <20191210163155.GA277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-3-eric.auger@redhat.com>
X-TUID: HBRCdcJechMs
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Hi Eric,

On Fri, Nov 22, 2019 at 07:29:25PM +0100, Eric Auger wrote:
> +typedef struct VirtIOIOMMU {
> +    VirtIODevice parent_obj;
> +    VirtQueue *req_vq;
> +    VirtQueue *event_vq;
> +    struct virtio_iommu_config config;
> +    uint64_t features;
> +    uint64_t acked_features;

We already have guest_features in the parent object.

> +    GHashTable *as_by_busptr;
> +    IOMMUPciBus *as_by_bus_num[IOMMU_PCI_BUS_MAX];

Doesn't seem used anymore.

Thanks,
Jean

> +    PCIBus *primary_bus;
> +    GTree *domains;
> +    QemuMutex mutex;
> +    GTree *endpoints;
> +} VirtIOIOMMU;
> +
> +#endif
> -- 
> 2.20.1
> 
> 


Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24401C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F912463F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y64EBT4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F912463F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdeE-0002YY-9S
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVddC-0001ZA-Dz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:40:02 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVddA-0006YR-Gl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:40:01 -0400
Received: by mail-ej1-x643.google.com with SMTP id z5so3242207ejw.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Nxpnk3tXHJ8Sue2ulDb2Pbocdf9vIRjjLavrsbAqp58=;
 b=Y64EBT4gQC3pA3au/DACJGZAZRaxtJD3EOv+mSjPw1QcY44AP7cWE+KIywvFX1yJGC
 T/MLw/Tjl6/VeD6HRv3FqKwm0vV3i7UZyrS8XLCLTNiRCxa3nRRYgBi6LJQsCi7/YMxq
 YVKZqdtFg5VnIs35k1KS5jJZJhjEvd1TCzkLobI6qi5pQufdsV9h2OXto54KosK/giLs
 RWDbIWzs6s1yM5NCQQxSPxK9+xjpPeMl9l3QYghI6+eo4g52WracAhR0euC0UoTHmu4s
 N1R0L2ivMOm/lNM6KZvev1eUGSskADqW09uEcAbIoNe3estzBJbvUN2SKqA/pkV6oQIC
 4OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nxpnk3tXHJ8Sue2ulDb2Pbocdf9vIRjjLavrsbAqp58=;
 b=ZUFrGwnuUnqLb9+YGk+eknwODA0ugDXC8HBDGawSg+BJQY+XPFG8bMZJTO8WvKZ9F3
 VeMv5PBzMZHmmdiZ55lSRhrwEghtTxEKpgpc/yQga8iJFT8nOk1m53u+K3g/1QXn9lAo
 2o/hpsgls3Wj2IcNjdG32jPmurwPyW6ZXcvvm61YLwQT+T9m2YVzDqalNd6YL9UN91Fu
 4sQX3L21pLUqloz2xMhgz2NkV2bFEZd7v8NopWLf7KpX9RZy8fBe1oAm2BSDDAzDt4w1
 bBM4HMHLMtAXGXC79B22mzQYftl1gU5ETUD+sZLHme65X8P5b2SJo04Tss5rgMOpjyOT
 4OlA==
X-Gm-Message-State: AOAM531Qa9zCwSuaWA7SY6oNrQNtYHdQL1HGMnY7leKGDUztp/4/gKnk
 NY7iyjX00Dxq+/DTLO054QQmlA==
X-Google-Smtp-Source: ABdhPJxRO+EYijHBHKMx6ohWgLoVyt/tMUd8xPSTJoLj3JlKb80E8Ye3ChsE1qoiV4POfd7Y5AxB7w==
X-Received: by 2002:a17:907:42fd:: with SMTP id
 oa21mr2977386ejb.247.1603384797961; 
 Thu, 22 Oct 2020 09:39:57 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p15sm1146390eji.40.2020.10.22.09.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 09:39:57 -0700 (PDT)
Date: Thu, 22 Oct 2020 18:39:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201022163937.GB1808268@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <20201019213539.GC3203@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019213539.GC3203@xz-x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 05:35:39PM -0400, Peter Xu wrote:
> > +    /*
> > +     * Disallow shrinking the page size. For example if an endpoint only
> > +     * supports 64kB pages, we can't globally enable 4kB pages. But that
> > +     * shouldn't happen, the host is unlikely to setup differing page granules.
> > +     * The other bits are only hints describing optimal block sizes.
> > +     */
> > +    if (new_granule < old_granule) {
> > +        error_setg(errp, "memory region shrinks the virtio-iommu page granule");
> > +        return -1;
> > +    }
> 
> My understanding is that shrink is actually allowed, instead we should forbid
> growing of the mask?  For example, initially the old_granule will always points
> to the guest page size.  Then as long as the host page size (which new_granule
> represents) is smaller than the old_granule, then it seems fine... Or am I wrong?

The case I was checking against is two assigned devices with different
page sizes. First one sets a 64kB page size, then the second one shouldn't
be able to shrink it back to 4kB, because the guest would create mappings
not aligned on 64kB, which can't be applied by the pIOMMU of the first
device.

But let's forget this case for now, in practice all assigned devices use
the host page size.

> 
> Another thing, IIUC this function will be majorly called in vfio code when the
> container page mask will be passed into it.  If there're multiple vfio
> containers that support different host IOMMU page sizes, then IIUC the order of
> the call to virtio_iommu_set_page_size_mask() is undefined.  It's probably
> related to which "-device vfio-pci,..." parameter is earlier.
> 
> To make this simpler, I'm thinking whether we should just forbid the case where
> devices have different iommu page sizes.  So when assigned devices are used, we
> make sure all host iommu page sizes are the same, and the value should be
> smaller than guest page size.  Otherwise we'll simply fall back to guest psize.

Mostly agree, I need to simplify this function.

I don't think we care about guest page size, though. Currently our default
mask is TARGET_PAGE_MASK, which is the smallest size supported by vCPUs
(generally 4kB), but it doesn't really mean guest page size, since the
guest can choose a larger granule at runtime. Besides virtio-iommu can in
theory map at byte granule if there isn't any assigned device, so our
default mask could as well be ~0ULL (but doesn't work at the moment, I've
tried).

So what I'd like to do for next version:

* Set qemu_real_host_page_mask as the default page mask, instead of the
  rather arbitrary TARGET_PAGE_MASK. Otherwise we cannot hotplug assigned
  devices on a 64kB host, since TARGET_PAGE_MASK is pretty much always
  4kB.

* Disallow changing the page size. It's simpler and works in
  practice if we default to qemu_real_host_page_mask.

* For non-hotplug devices, allow changing the rest of the mask. For
  hotplug devices, only warn about it.

Thanks,
Jean


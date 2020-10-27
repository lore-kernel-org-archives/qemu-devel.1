Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8121C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5318224181
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcRzu+RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5318224181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT69-0005Tl-8x
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kXSw4-0001Dv-Oj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:39:04 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kXSw2-0003b5-Is
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:39:04 -0400
Received: by mail-ed1-x543.google.com with SMTP id o18so2329289edq.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N32c2I2QD7KkAZG+NzeqUi5ns8CRp0X11+vh9YrLZm0=;
 b=zcRzu+RPOQsyRNhAOCMWuyBeMUpCFV5FaYXavHBQbwMWfMvhe8Y+/8630yD+wMIkxd
 wlJUgRoT0Xp/DO9msCQIgPm/xstIsga5LU7PseN+rPLHBAsRqCkT12BswappmdcxhabP
 jjYlvLImhxSLA+WbWiXJUpmjvU5DlHkfJHgbGMAlA1DlprIBF12NKNPGwOqKsNsmQK38
 y9fC0mB4SV7f/qyiZvISkY2CAA11mVK/96QdpVwkgjceh/2xmsyHHFVcUog+kmvZ0cVT
 fj/7jij0OwO5jeZUmPJmOU8TDEqNuUNSFC02nt+XVwU/kS/gylybwnfNLBYh/4S27LK5
 slNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N32c2I2QD7KkAZG+NzeqUi5ns8CRp0X11+vh9YrLZm0=;
 b=Xl1KI9SaCiq3bYExiLTjrYOUpZjilpmqXvG4YC2MjEV6LEVdD4FlwM2Dw24MSwVw5T
 KyF1yhQPxHHRZYnIVONdEtJ6U/mB2yuJORmEI9CU+wp3A2+4VtWUS8fUvLmbPLwA44cm
 Ex7XRHDE4UUlwizV4XLoY99PQQA6w2Q6/S+y6fVM02YCKUCzPt13QlKg7iAaa13wO3qz
 4lqyfx8aaCwdXReDwKuhQFU7IYEnDRW7KXHa4kDfMII5BuYbr3C0NDg5UAHn5XvOEnVd
 HAKs5LpI4GsL/EXf6D8Tu/oUHbDUd02HpafTEy15A2CI4czSbgGDfgKMUGvF7zh6R+BF
 tzZQ==
X-Gm-Message-State: AOAM530oYZCgqvQ+edOY5USdTQmFdErLu+poS61HTRsb9B8oKAjnSQ/x
 0OVCqOTgwIOkw8XcLsS8L/PqYQ==
X-Google-Smtp-Source: ABdhPJzOGACE98lA96reZb5s0l5Svp799cZ70twwJfw+bzm58B9td9Y3zK+wrmvKZ0F4/+eZGk0UHw==
X-Received: by 2002:a05:6402:7c8:: with SMTP id
 u8mr3485393edy.153.1603820340153; 
 Tue, 27 Oct 2020 10:39:00 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k9sm1456404ejv.113.2020.10.27.10.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 10:38:59 -0700 (PDT)
Date: Tue, 27 Oct 2020 18:38:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201027173840.GA2320704@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <20201019213539.GC3203@xz-x1> <20201022163937.GB1808268@myrica>
 <20201022205616.GD3208@xz-x1> <20201023074858.GA2265982@myrica>
 <20201023164702.GF3208@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023164702.GF3208@xz-x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=jean-philippe@linaro.org; helo=mail-ed1-x543.google.com
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

On Fri, Oct 23, 2020 at 12:47:02PM -0400, Peter Xu wrote:
> On Fri, Oct 23, 2020 at 09:48:58AM +0200, Jean-Philippe Brucker wrote:
> > Arm CPUs and SMMU support 4k, 16k and 64k page sizes. I don't think 16k is
> > used anywhere but some distributions chose 64k (RHEL, I think?), others
> > 4k, so we need to support both.
> > 
> > Unfortunately as noted above host64k-guest4k is not possible without
> > adding a negotiation mechanism to virtio-iommu, host VFIO and IOMMU
> > driver.
> 
> I see.  Then it seems we would still need to support host4k-guest64k.
> 
> Maybe for assigned case, we can simply AND all the psize_masks of all the vfio
> containers that supported to replace the default psize mask (TARGET_PAGE_SIZE)
> without caring about whether it's shrinking or not?  Note that current patch
> only update config.psize_mask to the new one, but I think we need to calculate
> the subset of all containers rather than a simply update.

Yes I think an AND is the right operation. We'll return an error if the
resulting mask is 0. Then for hotplug, I think I'll keep the current "best
effort" code from this patch. If necessary we could later add a parameter
to set a default mask and guarantee hotplug success.

Thanks,
Jean

> Then with the help
> of 39b3b3c9cac1 imho we'll gracefully fail the probe if the psize is not
> suitable anyway, e.g., host64k-guest4k.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 


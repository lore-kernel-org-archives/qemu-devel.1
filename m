Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C5C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB00D22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xo+LFOUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB00D22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdh1-0005WF-Tw
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdfc-0004HE-Ua
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:42:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdfb-0006zw-A9
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:42:32 -0400
Received: by mail-ed1-x543.google.com with SMTP id p13so2411853edi.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dyhBC52eRH4HAs8jzj6F4GMDv13zQ2T1IHonUg0kYEM=;
 b=xo+LFOUN2lnoqrtDnJFdJpvYONjmrZQoz9F4zfTOh7ryKMLusHkEnAi6RjZYNW0dXS
 sVnlY9uKztuvXKx60BdFvZjMeWgINfRVHBgLzAGAmcEH+jW4WAvrAG1JWDUVew+Dp+AL
 tBPSFRMlC8HoYgqJcXiZ/xeZVA4c2kmL5uQtMBvvU4NfVGlIJONppSSjTZmXv96wiGGH
 cXftyN1KgAqXttc5QYQlVEOuCmdHBdgtutBx8qWwU9zvcXyhK3yfS4dlstYE6zmhneCO
 8+4EKLDr9pNyOez3RYtiu+7j3ZRQrLOBgEw+3wlkYX/xgpguhsyhJfis991x/vVp5VQo
 8hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dyhBC52eRH4HAs8jzj6F4GMDv13zQ2T1IHonUg0kYEM=;
 b=YCAwNFGbCFp0xMTG8Kf6TI4TUgSJ0I/EuFHXNQWOM7xRrjCeaZVIyupF7mLjMZxs6T
 VP6SN4JEI87DdkT9IwgwMk77Aem5A7h8DxS6nSqQotBDuIXyTNmlZV9R62uTNwXav1UE
 C3f3dDOnfFKyEB1XeBzUJ/KF7m47sXo1BnS9ERfwwJrxZi8Nj5VRztIgpIGwNyO1ARE6
 A0SIL2EMDUyRD4JgyOn6xe/4Z7Dw85zWmFpVpdEG0796d6qamOQ6S+2JaPKkhTjHMpBV
 p4d/GF+eIvMn/03Sr3ZSUmW6FNDF4hOqRUjH7BCyJfRpkk/hFD83urpvNXk4a64pxeU4
 YVmQ==
X-Gm-Message-State: AOAM533aWc7AlBzz4W5RtKxDTj5SAPW1KDBISpI/+VUlXJShuHRLomM8
 87384AlfMyQmm4L6u39ottD1jR6dpExgvg==
X-Google-Smtp-Source: ABdhPJwZ/P9GOLwwkiB4mzuhRNFAzUvP0Ep41TVRcWBP4GhOixxNaU29wAa3D6X/alOGDb5dfbNLWw==
X-Received: by 2002:a50:d751:: with SMTP id i17mr3060060edj.337.1603384949819; 
 Thu, 22 Oct 2020 09:42:29 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v6sm1136513ejx.101.2020.10.22.09.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 09:42:29 -0700 (PDT)
Date: Thu, 22 Oct 2020 18:42:09 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 05/10] virtio-iommu: Add replay() memory region
 callback
Message-ID: <20201022164209.GD1808268@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-6-jean-philippe@linaro.org>
 <056334ec-583d-83c0-74e3-4f87fea365db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056334ec-583d-83c0-74e3-4f87fea365db@redhat.com>
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 11:12:35AM +0200, Auger Eric wrote:
> > +static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
> > +{
> > +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
> > +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> > +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> > +
> > +    trace_virtio_iommu_remap(mr->parent_obj.name, interval->low, interval->high,
> > +                             mapping->phys_addr);
> > +    virtio_iommu_notify_unmap(mr, interval->low, interval->high);
> > +    virtio_iommu_notify_map(mr, interval->low, interval->high,
> > +                            mapping->phys_addr);
> I don't get the preliminary unmap with the same data. Why isn't the map
> sufficient to replay?
> 
> The default implementation only notifies for valid entries.

Yes it should be enough, I'll remove the unmap

Thanks,
Jean


Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A9EC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231CD22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWmSfITE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231CD22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdi0-00070l-2I
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdgw-0005jq-Jm
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:43:54 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdgu-0007AR-P5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:43:54 -0400
Received: by mail-ej1-x643.google.com with SMTP id dt13so3239531ejb.12
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B1QZ4x0wGiARNg7YcjEOtDWeEEni+ZOnqhhP5a46/NQ=;
 b=lWmSfITE0tdFeI4qd5qZxvvut3SJPJYbc/YUSLmjekZYuTILIDAtZK1giWZED8Is7T
 Xr6bcHix1CGaXWNBw/IgVwObbqRhkYPPFo2zrwqA0f2w61gOULVFMvwt8Xr/dysoNUmt
 0WSFnEKUj1PFDUyAQwQpkq8Wlht8tGh98wrp/xqbeo2xKcS3TIwnRtdbTi83wjjdhJxB
 OKzVBul6MZnYJvk296LJxmileKMCpap9bXU1wwHcYmgI6Ghm5TaMCSC2tLuS9XvoXzzj
 D/A4f4lgSnCri4Ojp27v6rRIZi3GeVYbYOrnlor+OEA2fg+IdHS87ReYJEQ53/WcQZj/
 lq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B1QZ4x0wGiARNg7YcjEOtDWeEEni+ZOnqhhP5a46/NQ=;
 b=BepaGKPfUL1tGECmNbvK9MwEb50ZNVkHr56PuZTVwEYkM6cv703vsmX2x8Dfn/9+GY
 wl0vAASSVfS5F/s7uYptAbaVsAR6lLIW7abk4RbUQ7vR+GYhiEDbq84y+MADjGoVPhLB
 RELnp72LfEEHilSfxXTRBv06g04iaOPKW8RZpC5QGeLKNQcEd/FGHtHULCBV4zF5QYje
 dMs4+uZbP/vqCHmP1GlgC0fpMe9lz8EGFSgeZuLtXNvCgpgi4TG+v2/pZTI4JAh4m7Gs
 aB0R9yZ+hBFgLzUxz3nMVw/eHcWwEAjwyQ2aCmE80bj+QXUcAN5NQPHJlDbknZBzCU5A
 Ec4g==
X-Gm-Message-State: AOAM533TH5iz0BEFTTsBzGOaEkb4czoIPDR9NhUXbE1pnJP1i1JBtDr4
 5fIwPWD0C4rqA597Fy0gTK9xW5nEuwbwvQ==
X-Google-Smtp-Source: ABdhPJynn3nLuXUEcQ+8WUeBGy6ESl/KQiqkjHWhmRnzNtw8hpnlIQj/33GSx5Py8U4W+Q8TKLNDLA==
X-Received: by 2002:a17:906:5402:: with SMTP id
 q2mr3099468ejo.316.1603385031582; 
 Thu, 22 Oct 2020 09:43:51 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id e17sm1159122ejh.64.2020.10.22.09.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 09:43:50 -0700 (PDT)
Date: Thu, 22 Oct 2020 18:43:31 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 07/10] memory: Add interface to set iommu page size
 mask
Message-ID: <20201022164331.GE1808268@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-8-jean-philippe@linaro.org>
 <1596d3e7-274c-5744-5f2f-8f5cb50cdb40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596d3e7-274c-5744-5f2f-8f5cb50cdb40@redhat.com>
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 11:24:08AM +0200, Auger Eric wrote:
> > +    /*
> > +     * Set supported IOMMU page size
> > +     *
> > +     * If supported, allows to restrict the page size mask that can be supported
> To match other docs: Optional method:
> > +     * with a given IOMMU memory region. For example, to propagate host physical
> > +     * IOMMU page size mask limitations to the virtual IOMMU.
> > +     *
> > +     * Returns 0 on success, or a negative error. In case of failure, the error
> > +     * object must be created.
> document args as done for other functions?

I'll change this comment to:

    /**
     * @iommu_set_page_size_mask:
     *
     * Restrict the page size mask that can be supported with a given IOMMU
     * memory region. Used for example to propagate host physical IOMMU page
     * size mask limitations to the virtual IOMMU.
     *
     * Optional method: if this method is not provided, then the default global
     * page mask is used.
     *
     * @iommu: the IOMMUMemoryRegion
     *
     * @page_size_mask: a bitmask of supported page sizes. At least one bit,
     * representing the smallest page size, must be set. Additional set bits
     * represent supported block sizes. For example a host physical IOMMU that
     * uses page tables with a page size of 4kB, and supports 2MB and 4GB
     * blocks, will set mask 0x40201000. A granule of 4kB with indiscriminate
     * block sizes is specified with mask 0xfffffffffffff000.
     *
     * Returns 0 on success, or a negative error. In case of failure, the error
     * object must be created.
     */

Thanks,
Jean


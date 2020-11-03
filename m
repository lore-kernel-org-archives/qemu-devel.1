Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B1BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D3F206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAwczqSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D3F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzFn-0008UP-O0
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kZzEx-00084c-4f
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:32:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kZzEu-00064f-92
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:32:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id s9so19192087wro.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5Ka9U8P8h2s/zofWKqtlqy8RjhNIiXxQ9N/LBwqf87U=;
 b=YAwczqSf43ri6XRhVAT4pa3+jmjwdnJ7SfuZ1H8h8ZJet9ARtUEWO0rxpzQ/0sybIy
 fgg8rmBgUlgGjtJYML0Pc3E/4S0GqVAqjSUjEuvMif9R6aA8XVzv5GgqPzreivbjiUin
 9jJxbtOXfSoZFrs22YLAUK5d2zLIbSRLyfG4T+yi0jdf+U7uye3wc2PZ5cXYtYTx7bUu
 La+rCYziES+FLraePNRIJ4pZRaYcuizEMXmbHJytL/1FdoBQE1L4DxNhPlAjui2EMxbK
 zx94EaFVN78mTAxIuiuXBGRYquGzA1cwyIlUNRDAA5EkACGqNFIhpQ2hgbGKnIcVb+HT
 0iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5Ka9U8P8h2s/zofWKqtlqy8RjhNIiXxQ9N/LBwqf87U=;
 b=N+C8RGXcM/E5uBalqkOcbZ8kPR9X3ZnZJHb9TbbSNj5gRpNlIvEOcHPjlztssrA8d8
 GjA5IWJ+GDT5wf8nlSHoKHfQSqnFbEOZSmasT7PxPIDfputTq6z+M1U44wXXTE80Gqnq
 vrZDXvHPHG8I6CfZ6B6bTYLAyv+/pvboY0EghcnrxhSpSB1ag89OfEdQM+P5upvodp3R
 K23V9s8EqQr+7TW8MdZIwkY5ffIDbPdQ3F5PjNgbmqIdzWRmdPGh1oMtXSfISZIUwKU5
 5OZsLPLpBucMVI1Sm/JwdkDwdqRbh3GZ3UKokLNg35snj27BWEk/X8/EOgb2prxGdNbs
 rSww==
X-Gm-Message-State: AOAM5334FEEeEXkz0es8MKZipW7tIhmSrv34Tyzx7lXJGV3I74d3pl3w
 vw7jaJ7N66a4LmnW/LGIXZ9Xdg==
X-Google-Smtp-Source: ABdhPJwHhRk+zKuWVcuy/Du9UQsDLErbX21dRH9LFlmT1REwc2Tkr4nhetpzSpqSJWJck/VZuOFFcA==
X-Received: by 2002:adf:a315:: with SMTP id c21mr2445832wrb.272.1604421174019; 
 Tue, 03 Nov 2020 08:32:54 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f4sm26777161wrq.54.2020.11.03.08.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 08:32:53 -0800 (PST)
Date: Tue, 3 Nov 2020 17:32:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v11 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201103163234.GB6723@myrica>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
 <20201030180510.747225-10-jean-philippe@linaro.org>
 <20201102224725.GF20600@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102224725.GF20600@xz-x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x442.google.com
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

On Mon, Nov 02, 2020 at 05:47:25PM -0500, Peter Xu wrote:
> On Fri, Oct 30, 2020 at 07:05:09PM +0100, Jean-Philippe Brucker wrote:
> > From: Bharat Bhushan <bbhushan2@marvell.com>
> > 
> > The virtio-iommu device can deal with arbitrary page sizes for virtual
> > endpoints, but for endpoints assigned with VFIO it must follow the page
> > granule used by the host IOMMU driver.
> > 
> > Implement the interface to set the vIOMMU page size mask, called by VFIO
> > for each endpoint. We assume that all host IOMMU drivers use the same
> > page granule (the host page granule). Override the page_size_mask field
> > in the virtio config space.
> 
> (Nit: Seems slightly mismatched with the code below)
> 
> [...]
> 
> > +    /*
> > +     * After the machine is finalized, we can't change the mask anymore. If by
> > +     * chance the hotplugged device supports the same granule, we can still
> > +     * accept it. Having a different masks is possible but the guest will use
> > +     * sub-optimal block sizes, so warn about it.
> > +     */
> > +    if (qdev_hotplug) {
> > +        int new_granule = ctz64(new_mask);
> > +        int cur_granule = ctz64(cur_mask);
> > +
> > +        if (new_granule != cur_granule) {
> > +            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
> > +                       " is incompatible with mask 0x%"PRIx64, cur_mask,
> > +                       new_mask);
> > +            return -1;
> > +        } else if (new_mask != cur_mask) {
> > +            warn_report("virtio-iommu page mask 0x%"PRIx64
> > +                        " does not match 0x%"PRIx64, cur_mask, new_mask);
> 
> IMHO, new_mask!=cur_mask is ok, as long as it's a superset of reported
> cur_mask, then it'll still guarantee to work.
> 
> Meanwhile, checking against granule seems not safe enough if the guest driver
> started to use huge pages in iommu pgtables...

As the guest doesn't directly touch the page tables I think it is safe,
albeit slow. If the host IOMMU driver cannot support one huge page for a
mapping, then it will use several small pages instead.

> 
> In summary:
> 
>     if (qdev_hotplug) {
>         if ((new_mask & cur_mask) == cur_mask) {
>             /* Superset of old mask; we're good.  Keep the old mask since same */
>             return 0;

That looks correct, but a bit too restrictive. If we start with
cur_mask = 0xfffffffffffff000, and we hotplug a VFIO device with
new_mask = 0x40201000 (4k page, 2M 1G blocks), then this code rejects it
even though it would work.

Thanks,
Jean

>         } else {
>             /* Guest driver can use any psize in cur_mask, not safe to continue */
>             error_setg(...);
>             return -1;
>         }
>     }
> 
> Maybe we can also work on top too (if this is the only reason to repost,
> especially if Michael would like to pick this up sooner), so I just raise this
> up.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 


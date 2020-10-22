Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E5C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D927A22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4X0jULs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D927A22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdjd-0000Kw-JG
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdhR-0006W0-4p
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:44:25 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kVdhJ-0007Dx-VC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:44:20 -0400
Received: by mail-ej1-x642.google.com with SMTP id h24so3250326ejg.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PmgHQu2/Ta5SnxqN9OMKtFv3XXuOUeW2u7e0q1byElY=;
 b=F4X0jULs/dHyPYSZCTnH8AS9r1Ly6u+qiYF7cGfSTqbGHGKtiS+12QFTU0OK62RLTH
 DAeO8n6ob6Fc3j8VOsrcbItY5IVSrScSqEh00rs26YmhkLhpx5xzmlUJM/WpO6dxR0qU
 P/0VXd/6/GDivywgknFraa/qnO2Vdjlj36Gk0EIHJRSzkTE5wRbYQ+ovHQVLpEH2Cyck
 Teu/zAuHZEcisUaq+Y3xEYa6nc3J1ny6ZNdqjwsb1uXZgkpNuHEnsBIKDD2Ks3lnrUUk
 oGWthsaC/fIlDVVm7oKuoiU9mAM9wW2Gshui6hQXz2D1gHs8KXoKBIqW3B/jyhQR5osI
 TnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PmgHQu2/Ta5SnxqN9OMKtFv3XXuOUeW2u7e0q1byElY=;
 b=EXRfweHwoMEMeDetADTpL73qcFnlyhL8mlprg9ZPptz5bE09gcWXgvu9hv96yGn3hO
 AUIGafiztz59ZSE40odLipGbQQOLRLa9gNcX5eoj/2gz4Mgx2eBUdeus5Er088iKwv5M
 u7gW+4pN7fhmmST3lZOSNQgUs7iObhDQ2oTcX9nQK5fpG2ZGlbqeFAvMOuqDxuFlt+D1
 jXh4D2lawCbHqgFyCwM3MbksqoQirwRio9iGM3FF9uuUqsr0EeHDln/ezbTKOkNk0NmB
 eyUzlLnQKxcre+alP3OzZAn8hiY7Wh6soIwI9HJkrusJ37hViRwzxPAoKEJce/Dhuzoj
 UV/g==
X-Gm-Message-State: AOAM533Vx/8gSWQ+VeVLgdzXs1k8pfxMLt6f1ciEt8V+y5TL1039nRbA
 /MuH67edaWpm+bfw+ViHHDQ3yeqwmD66hQ==
X-Google-Smtp-Source: ABdhPJxnu5OSoCQpNdtI5RTQit7VP25513YUoFNpore235bRaYkxKxkjpghmfrLk+O0mRsjSawey/Q==
X-Received: by 2002:a17:906:6bce:: with SMTP id
 t14mr3282138ejs.118.1603385056679; 
 Thu, 22 Oct 2020 09:44:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id i20sm1001116edv.96.2020.10.22.09.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 09:44:16 -0700 (PDT)
Date: Thu, 22 Oct 2020 18:43:56 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
Message-ID: <20201022164356.GF1808268@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
 <53892fd2-a69f-bd83-4167-b1d2569fb4c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53892fd2-a69f-bd83-4167-b1d2569fb4c3@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x642.google.com
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

On Fri, Oct 16, 2020 at 03:08:03PM +0200, Auger Eric wrote:
> > +static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> > +                                           uint64_t page_size_mask,
> > +                                           Error **errp)
> > +{
> > +    int new_granule, old_granule;
> > +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> > +    VirtIOIOMMU *s = sdev->viommu;
> > +
> > +    if (!page_size_mask) {
> set errp

Woops, fixed

> > +        return -1;
> > +    }
> > +
> > +    new_granule = ctz64(page_size_mask);
> > +    old_granule = ctz64(s->config.page_size_mask);
> 
> I think this would be interesting to add a trace point

Agreed

Thanks,
Jean


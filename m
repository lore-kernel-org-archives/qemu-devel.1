Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C892C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6404320756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5RZ1iCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6404320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWDV-000859-CM
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYWBn-0006Z5-Gc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:19:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYWBl-0007fr-NG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:19:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id n18so6873204wrs.5
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8QB9I6mMci1xR6eomkHumDTJYFSsbMERs0j5avDl3co=;
 b=p5RZ1iCizeLqtthrCnIU6VuVxn6KqxTUUjbv2NB3ZC0qh9BlwPFM2UoFDi3onjLc6l
 ng9ggEk4ICNH4m56ETLaIbSQ7e9UQfv1OxQYyR9iW7xOGTVkj3FQpSVzIC3LtV2V6kUW
 U7VHSy/MjG7XSUWjBnpaoUtydPDrpnuGb1wcwHnRr90igVsloC08vSaQwpRmlKigrgau
 qzAjXTpJdTmBJ/q35dyoQcoFAN+sz4RSjwJ8NjiRhVLsP0Xt7SMDVzG+JD6pSQ95k2cT
 yVKh6pJV/mRGoElPSXf2PjeGo7Zrodo0ZNhI6q70hUZ8y+rkym7a4ReSofYan21LGSRr
 qO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8QB9I6mMci1xR6eomkHumDTJYFSsbMERs0j5avDl3co=;
 b=spu0eySH3KEUJjEu1pMTfv7ak3KCQfMcGHOpbpi8LLpjOYrguj4S6eaQsUW0F3yP/W
 iqExaND1aBiMC83wCb3+WarX69BEGM3EJqTxqbEsVjYiKjbTX2/IhIW0MjreJymFQtY+
 q7twvJp1JfmBSv8aIBBi3qwHitRdV9xq59e9ioHyg+wxyF1aROqWDll2swjFKGKfLawM
 0d2F+K9GeGSDXplO9qoWbTmgg3fVYLS1wx5t3poDrpeAbNV3uyjAIwL1gRiW2TyASOf4
 eyXsATISIUkAoKudcfRKgmwvytBaihNIeftQeqyg0GVw2GAM7LPzp/Wo79QpvjTsOdzd
 857g==
X-Gm-Message-State: AOAM531akChy8RmGznvbziaIGHXLv4QmvnKu9z9G3Wd+MbxFc+bu1bD/
 nZxQ+6RfhY0JDGNchUnmFlWgFw==
X-Google-Smtp-Source: ABdhPJwPeuzj9X9472twUAyoTdw/0UZm0uTOtkFbRq//9cMCCG22wE01tPp8UM/ciPaiYR7EIDmfeQ==
X-Received: by 2002:adf:cd82:: with SMTP id q2mr4040079wrj.118.1604071174864; 
 Fri, 30 Oct 2020 08:19:34 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g17sm11126485wrw.37.2020.10.30.08.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 08:19:34 -0700 (PDT)
Date: Fri, 30 Oct 2020 16:19:14 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 08/10] vfio: Set IOMMU page size as per host
 supported page size
Message-ID: <20201030151914.GC294997@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-9-jean-philippe@linaro.org>
 <20201008152254.7bf6d8a7@w520.home>
 <20201030062606-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030062606-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 06:26:31AM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 08, 2020 at 03:22:54PM -0600, Alex Williamson wrote:
> > On Thu,  8 Oct 2020 19:15:56 +0200
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> > 
> > > From: Bharat Bhushan <bbhushan2@marvell.com>
> > > 
> > > Set IOMMU supported page size mask same as host Linux supported page
> > > size mask.
> > > 
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  hw/vfio/common.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index 13471ae2943..e66054b02a7 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -636,6 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
> > >                              int128_get64(llend),
> > >                              iommu_idx);
> > >  
> > > +        ret = memory_region_iommu_set_page_size_mask(giommu->iommu,
> > > +                                                     container->pgsizes,
> > > +                                                     &err);
> > > +        if (ret) {
> > > +            g_free(giommu);
> > > +            goto fail;
> > > +        }
> > > +
> > >          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
> > >                                                      &err);
> > >          if (ret) {
> > 
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> 
> This one too, seems independent of the rest of the
> patchset and can be merged separately, right?

This depends on patch 7 which introduces the function

Thanks,
Jean

> If so
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 


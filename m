Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5A32073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4Mg2svv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5A32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieilL-0002nK-JW
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieidn-0004O7-BM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieidm-0004qP-9E
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:45:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieidj-0004m2-Ew
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:45:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id q10so20877534wrm.11
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=J9i3/MkcXXwFrp7MwGhstFhrn0JoZM+nuz8kFsu3TVs=;
 b=B4Mg2svv2Enjp6/cLsAW+6qr1toLBoUc624xx9f0y5aI9fYj4m3x66uYs7t2sJAPJa
 hsQq1YhwflwdTMQxuMAX5Jk6dMa5XbQ6UQfi6Gh8XSe09jhYhn8ZhAjnuzm6bkgU1hDR
 Emd8abkwuv12lv+fvHhfvw0mEmlb6yxgjqNnRzn813Y2i8jefUrggZEqacIFpBF+AwG4
 PUUxWRWOgodys1WeeW99iGdXkpxfL++J8YexKTnZ1PusfUg7ya36D+gMTOw7d6EDJ0V0
 DbyrguN/KPM6a+UZq/CPck78Ryz30C6yzzdw08IiAKTdbFCEJKNGlxALIL8SWzvQRPJg
 GGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J9i3/MkcXXwFrp7MwGhstFhrn0JoZM+nuz8kFsu3TVs=;
 b=YbeN6c3cQsHyvsOi/3CG29wh6EQsSafxkztGOaEFR+CUyF8nmhBA0+FnORQgyywCgz
 XQxuSZzzAyIg//xPij4D86JDryIFaOEsar9xhLO9jPCA2ihMjMnX3eTZ7FKyskxNZUCE
 xnKJ3hQDHds+FvaSVRVyhIyFJqfenX8VwZ2rwXsKfubDbOsnart2PLsWVTiJ41Hmu/BR
 pTPCl5W2w9TTm8346VPLaUAfnUK8JNtcNTqOPsFjVKsPQ0IU50BTrbX0HgUxWP4Pqobo
 /fdxjAbmgtPG11qbQOTMLGsd99fZKhUdZDFWAabsQMRlrIO4XCGh0Os4+QTqCiM3qVOc
 2zWg==
X-Gm-Message-State: APjAAAW5E+ntw/48kmVgd6QVu6xSLVZtu4dmFzlFWhYFLevbRyMSMtfP
 5ur7652xIKKjmNAkYX9GFypAOg==
X-Google-Smtp-Source: APXvYqyZ7Q/kWlwUTEDAmH6FUoWnHKchBRgXb1VlIGofFVKDPPpDPZlr1HpfGBaE3DvfAf+N0aXMbw==
X-Received: by 2002:a05:6000:12ce:: with SMTP id
 l14mr4601426wrx.342.1575996333166; 
 Tue, 10 Dec 2019 08:45:33 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id v4sm3484387wml.2.2019.12.10.08.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:45:32 -0800 (PST)
Date: Tue, 10 Dec 2019 17:45:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 11/20] hw/arm/virt: Add the virtio-iommu
 device tree mappings
Message-ID: <20191210164528.GJ277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-12-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-12-eric.auger@redhat.com>
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

On Fri, Nov 22, 2019 at 07:29:34PM +0100, Eric Auger wrote:
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> index 280230b31e..4cfae1f9df 100644
> --- a/hw/virtio/virtio-iommu-pci.c
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -31,9 +31,6 @@ struct VirtIOIOMMUPCI {
>  
>  static Property virtio_iommu_pci_properties[] = {
>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> -    DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
> -                      vdev.nb_reserved_regions, vdev.reserved_regions,
> -                      qdev_prop_interval, Interval),

Belongs in patch 10?

Apart from that 
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>



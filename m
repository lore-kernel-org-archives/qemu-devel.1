Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F51C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66E520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7zTvBpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66E520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00XG-0006De-W5
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1j00WG-0004kp-OE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1j00WF-0001Sl-Ax
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:05:52 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1j00WF-0001Jv-2K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:05:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so1919626wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 02:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CkNISUU2YEwgtDbE7wGrX6zHwwImz3m8DQldgou+fwU=;
 b=m7zTvBpXxHV6nlyseiblGba2cS5Y9ANFNqUZyf5aRhLssqPPJTvGnv/RGQw3ipxKL1
 WqcxUFRL8RfjkkV8eCaZ8qDc1uhpWISvzA2sPq1bIL+Td3Hdoo9hsM9Rjr2I6vgWA2y8
 ZVWK7Tfq1HOwTr91reCVv6fLsW/vzeeKTthjrEOnrb6LmvstJr2jJgBb2Y7y9mk1/nLX
 LkdPGsl8ckCPPYU9S6lKHT21qO4JkNBbFe+zmoBZKRBCHjT8z33mgnnWDGQRhgUEFIP2
 iQ2CofwI6btDQDVNcvOHbCWj4SoeRM2KgOA+Ju0lFfdvdLaiw4QeKze7FVhSwuSlag7+
 NZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CkNISUU2YEwgtDbE7wGrX6zHwwImz3m8DQldgou+fwU=;
 b=YHEYQMStnioJ8O5U5GZBAVLMYOWk/EDBQPjkoF7tN93svPG3e7ykUo0pQmTIA3aHfo
 aj782Siu7wABdzYQ0f5TpV1pqiYYPFf/9Ck/mDfPyQPgt/c/8TOLvlu/rtLbaUmLy2AE
 Kt3IdXjCG6DiKAuJAW129E1xJm8j76hTiFuOZOTiofna06iI387TR/8OotVRCHBl9dgd
 Doh+ZwBqWOXeqA+hHNglSl+LjQhx2rUJr2pfq/qW79M8K8m/XRASd4T4/wbqM8jkp6IW
 6OtVn8+jtFaY5KUKWTwLsEqMtn3U1A0AMYJt5WNrk+xJf/OrCAkhjFJWDQT+ET3BD1U4
 W54g==
X-Gm-Message-State: APjAAAX6zL+MYwclH7iC8TFB0z8mazOafiEcGjZJufFTn562YQo6MjfM
 8JFAIeEDX6s1rYYqBN0YaHvRBw==
X-Google-Smtp-Source: APXvYqw50QXNPMLTG6L3xiJSBNf8KPx5IaZ4QkUmh4hTySd5l9fVGztmz04OGWByNHYSdVqNsixp+A==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr4005701wrl.117.1581069949332; 
 Fri, 07 Feb 2020 02:05:49 -0800 (PST)
Received: from myrica ([2001:171b:c9ad:af70:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 18sm2672839wmf.1.2020.02.07.02.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 02:05:48 -0800 (PST)
Date: Fri, 7 Feb 2020 11:05:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200207100540.GA1999431@myrica>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207093203.3788-9-eric.auger@redhat.com>
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> At the moment, the kernel only supports device tree
> integration of the virtio-iommu. DT bindings between the
> PCI root complex and the IOMMU must be created by the machine
> in conformance to:
> 
> Documentation/devicetree/bindings/virtio/iommu.txt.
> 
> To make sure the end-user is aware of this, force him to use the
> temporary device option "x-dt-binding" and also double check the
> machine has a hotplug handler for the virtio-iommu-pci device.
> This hotplug handler is in charge of creating those DT bindings.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
[...]
> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
>  
> +    if (!dev->dt_binding) {
> +        error_setg(errp,
> +                   "Instantiation currently only is possible if the machine "
> +                   "creates device tree iommu-map bindings, ie. ACPI is not "
> +                   "yet supported");
> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");

"use -device virtio-iommu-pci,x-dt-binding"?

Can the option be safely removed as soon as we implement a topology
description for the remaining platforms?  Or will we need to carry it
forever for backward-compatibility (ie. ensure that an old command-line
invocation that contains this option still works)?

Thanks,
Jean


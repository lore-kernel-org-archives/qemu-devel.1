Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F1C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E3620735
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rd83KKIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E3620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWyHI-00023d-Ug
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jWyGK-0000mo-11
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:21:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jWyGI-0001Xv-B8
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:21:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so9289188wmc.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0/AgBiC6qKeHKJYdAkiVkky+NGmrOIHqcX4j3U3cGLU=;
 b=rd83KKIc0rAng26v4lLrAz6DoMzjBez9W4x0XeId/pg0zqNdtwSqXjcZb92wUSvG3o
 /tgBSOxfapo3T5IZFFMnZB/1JtOsQ9NEOEEWzVzu24VqqhVM9ZfP94Jlgm1hUbHupr/U
 d8HyP1AcLtSY7p9Mv9byV9+4ZAVMG3haLbr4cRcU2hYHUsYfoynvCoJ4iyPAcrswNplE
 upn1kW5hoz/ZKIUVGG+B/yhrsq/KiWlnJnW0+O0CIcCacKcqj1+HNr8FOzDwauZF6Vzo
 a+GxzbVF2xINsn1efSh9SgO88CSixI5mOGCsrQGLfIcxIi5tNU4m7KoIMIG+NnwC4rC3
 Wb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0/AgBiC6qKeHKJYdAkiVkky+NGmrOIHqcX4j3U3cGLU=;
 b=X55S9cFgzZw8M9GNz77dXwjBBFTUVpPVQw0OVQ+pQcMeC+w/U4ZFWv0+HSHoxIvwqj
 sMkxW1WP5JN5VcabYy/eOqWBcDixk7jhjwP+lfWunAWvq0KpJBubIDNJIDCqp0NLNNGH
 kJYRtmX2R6kIJ0OBfRLA6h7sBhzjEcEeABAJUtFYU3uwsMfGjI6mGa0Yq8PKVOiFwaWw
 ZcLMXL0PnttY9lPg7Bh1vLIlekcwqxdE+26S96zspMTNNakSTfjbaaUF6jrnsx4VYEZM
 w8ldqRGODutqRPEaNrtQC+lgi8ARoOch1EaRowMByw9GUvYj6w9SK26l16Zsi/w7z92w
 W48w==
X-Gm-Message-State: AGi0PubEHQ+hlM9YwEV+EocTFXaLHBCKYHnch7c9VF4xXNg0kn3MvFzV
 jHWbMNH9FpntSWepokmuEx/VFQ==
X-Google-Smtp-Source: APiQypJ9XmUKIvWeeoSFrD8E8yC72Rnc3/cQ2mbgbsabEfMpyYVF9P1veb1wpJLW1MEKzRSKFS5z3w==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr14648882wmk.158.1588926096545; 
 Fri, 08 May 2020 01:21:36 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id p7sm1781670wrf.31.2020.05.08.01.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:21:35 -0700 (PDT)
Date: Fri, 8 May 2020 10:21:26 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
Message-ID: <20200508082126.GA1770804@myrica>
References: <20200507143201.31080-1-eric.auger@redhat.com>
 <20200507143201.31080-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507143201.31080-6-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 07, 2020 at 04:32:01PM +0200, Eric Auger wrote:
> At the moment the virtio-iommu translates MSI transactions.
> This behavior is inherited from ARM SMMU. The virt machine
> code knows where the guest MSI doorbells are so we can easily
> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> setting the guest will not map MSIs through the IOMMU and those
> transactions will be simply bypassed. The ITS does MSI translation
> anyway.

Makes sense. I think we have to check that the ITS is used before
declaring the resv region, though. When using gicv2m, the guest will see
this MSI region and deduce that it doesn't need to create a SW mapping for
MSIs (might be wrong, I haven't tested it yet).

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 171e6908ec..6a041e97a5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2138,6 +2138,11 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
> +        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +        qdev_prop_set_string(dev, "reserved-regions[0]",
> +                             "0x8090000, 0x809FFFF, 1");

Maybe worth adding a comment saying this is the GITS_TRANSLATER page?

Thanks,
Jean


Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E60C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B322073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytkYdsWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B322073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieikJ-0001cA-BK
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiiE-00083p-7D
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiiD-0006QQ-3M
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:50:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieiiC-0006Py-Se
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:50:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so3968460wmi.5
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=r8wiVmuohB+E6DxPcyxULVV8ixEmXNvbFga4Fjsd5gs=;
 b=ytkYdsWxjkbQ145QRW5KgM8/L9+9b3Gd8CuOQHfBcMvtHGvFazwETTkKBRABoi36lc
 RVYTNwCMvxCRtL/r7qYgFAcshjQ8TxfDIhKkMF5XJr63ZWEoxaoK40Sn3P9H2l/zgdF2
 zNGbWEBV3hPAZdUZNEVG9vSkj2/x4jlEhhWs0mFexkEZPmfw9yTWoLr/XcHwR60Xy91+
 8KPlGw3hHb/8sMc4fIt7UCkVFItqinXe0+ZaE9VNCMjBVkZrR0CfUu6WyS/NpYCgBUSr
 UFALSDTEkSbgdeJNdOExQcEHgf3TojcI04AWP0061ZhSD6fig9EIibesm9fzAUFt8PID
 jF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r8wiVmuohB+E6DxPcyxULVV8ixEmXNvbFga4Fjsd5gs=;
 b=PahFo1xSJ+vjGsKI9J7N6Q/eBMwJg5VnTMuteGKMHLDsD2P2RtMxKLGZ+LCvlEG9dB
 nkS4QIS63Wf2s7O2JH570p/SFkTy9OKjOJa4fRHN6mAlOwYCDowGhpz96LzsJuHcttas
 606cKYR0ikOKE0rDWKWXVtz+HkKyFmsk+HPFSji2rOLul+aqpYRulMHqT4mDp5esVwnR
 mdtlKNCpSVgSwWHnQBbazNz4dZhliSKj8U/2YBgOkGY+unb2JZsYAO8D+hrUJ3Mk07vx
 un+z37UBvgk6PICw3YugAyJ+F8d6xN4y9ywGKWGTCHaRewqsVp5xJ4BB7E1CJfTDtsfc
 UFPA==
X-Gm-Message-State: APjAAAVinAIpX6e1EJ5Ms7OzLHzjVtYfA3jTacki3ElhdHskzLZXd3rD
 Tdxq+n8+v5KK4Z2vZhCG/4YzJQ==
X-Google-Smtp-Source: APXvYqwuFYFJNREQM+tpSI2EiAdhiApENKlYKeWCRwrSi5x0FlbhZVdJz1p6JphQdtYW1qgTyjWmiw==
X-Received: by 2002:a05:600c:1105:: with SMTP id
 b5mr6634272wma.159.1575996611555; 
 Tue, 10 Dec 2019 08:50:11 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id e18sm3769701wrr.95.2019.12.10.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:50:10 -0800 (PST)
Date: Tue, 10 Dec 2019 17:50:06 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 18/20] virtio-iommu: Support migration
Message-ID: <20191210165006.GP277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-19-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-19-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On Fri, Nov 22, 2019 at 07:29:41PM +0100, Eric Auger wrote:
> +static const VMStateDescription vmstate_virtio_iommu_device = {
> +    .name = "virtio-iommu-device",
> +    .minimum_version_id = 1,
> +    .version_id = 1,
> +    .post_load = iommu_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 1,
> +                                   &vmstate_domain, viommu_domain),
> +        VMSTATE_GTREE_DIRECT_KEY_V(endpoints, VirtIOIOMMU, 1,
> +                                   &vmstate_endpoint, viommu_endpoint),

So if I understand correctly these fields are state that is modified by
the guest? We don't need to save/load fields that cannot be modified by
the guest, static information that is created from the QEMU command-line. 

I think the above covers everything we need to migrate in VirtIOIOMMU
then, except for acked_features, which (as I pointed out on another patch)
seems redundant anyway since there is vdev->guest_features.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +
>  static const VMStateDescription vmstate_virtio_iommu = {
>      .name = "virtio-iommu",
>      .minimum_version_id = 1,
> -- 
> 2.20.1
> 
> 


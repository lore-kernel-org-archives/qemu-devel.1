Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F63CCA9ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE70217F5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKPvNnFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE70217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRkSu-0005N7-0t
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1iRh8k-00064s-7a
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1iRh8h-000492-SV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:31:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1iRh8b-00047u-FZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:31:39 -0500
Received: by mail-wm1-x342.google.com with SMTP id 8so10154641wmo.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=P8PibeiupuNi15dHm5+jUR5CChJ9w0TTLJd6WN7BGpg=;
 b=zKPvNnFTHPGsmJ+HlfIRPewnCGM9caXmxt4I3/bpQ+JkqrtLbBlQmkfB75j94yvcbD
 i9whR6nKmUCxfQv7QRCdMPTfeB5XQdYtN1TWDeXCjSp6ZB7zKLEEcwU0TUvx/bRNywMP
 EgwogmRw+ESqVLaFS+1Yap2YQeRc1u8Jd0tBOdmpvx/POKm++nh4LsWyQKxGS8Wxp5Zf
 FsBN4T+PI382Zwy9wdyISDUz7ptKMpmQp0HI9/PvY2r10d/iTYopOjKKnX/HeFIci703
 N8/5jCoRUPEUSd1cBtF7i53WUYZFOPyZwehnDHliWdut+Vq6j2Kx7j9iE26Dd7Uowl82
 Xu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P8PibeiupuNi15dHm5+jUR5CChJ9w0TTLJd6WN7BGpg=;
 b=Ux43yN9u5QWlUp9hMEVtexd3y+pspGSMTguTzdugfYtlMGj0lbg4U62f8/bdIV7lPp
 F8+tiebDgj9lCv41AVT9Obbxi0XDsQIELiAcEn6RJYATaoOi9fAEpv6LaYpcChGznism
 qkqiDof6ero+/406SlmGy64gREQ1acbPwx9ION7G+VKLfRSPiDvcOi5nSkt0cwsxktW2
 jlc2GLldKkHZArxHJsgxsAWdDgmRf+L/o7Lp2X9elwMxvYXO89EG0iE9FX1R+z46VGmZ
 Z2mAekhnM1vLS6VMViMfv8cKFS9s8elciJHgNTz2hS2k4eSDBuaoIbk4xh26MWuvFfcx
 bf6w==
X-Gm-Message-State: APjAAAV94igH94U425nnHv0+hRMwOESF3u9qKHkzICs3V4H4LNQTa2BK
 kheD9uTtu8kjrHkSVd/avcO0oQ==
X-Google-Smtp-Source: APXvYqxqp5pHCK/mjeMQmeeI+htVrSsTS5BrhAqowMaMuEqOXgXp6VTTnNHoL8DJyJUxOSbbKBIk7A==
X-Received: by 2002:a05:600c:1002:: with SMTP id
 c2mr417364wmc.79.1572892294020; 
 Mon, 04 Nov 2019 10:31:34 -0800 (PST)
Received: from lophozonia ([85.195.192.192])
 by smtp.gmail.com with ESMTPSA id g14sm18776667wro.33.2019.11.04.10.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 10:31:33 -0800 (PST)
Date: Mon, 4 Nov 2019 19:31:31 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-4.2 v10 06/15] virtio-iommu: Endpoint and domains
 structs and helpers
Message-ID: <20191104183131.GA3540585@lophozonia>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-7-eric.auger@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Mon, 04 Nov 2019 17:02:21 -0500
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On Tue, Jul 30, 2019 at 07:21:28PM +0200, Eric Auger wrote:
>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
> +
> +    g_tree_destroy(s->domains);
> +    g_tree_destroy(s->endpoints);

virtio_iommu_device_reset() must completely clear the internal state as
well (noticed while testing modprobe/rmmod).

Thanks,
Jean


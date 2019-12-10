Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA87C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF552073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfoZ5P48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF552073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiiA-0007Vy-KO
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieif4-0005M8-RZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieif3-0005FR-QU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:46:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieif3-0005Ex-KW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:46:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so20921440wrr.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=t6xiBm4AewZPGvWuP/C57U7CBdnlU6ctV7vonpSTcNY=;
 b=QfoZ5P48W8GsomtBZLloAwVJKXIiOVSv8BYnO1KEc4cVmUvX8ODXUpoKPaJ0DNLX5v
 hIoItecgjGlxfqsTlIhq89JGVyTjbsdMgfgfoXyYLtfzMlgZfEqbVCSxumBZU5daq7jF
 uxknZNGmVEn5uYE+yVkB8BHyqanWi7ObXl1EH+m0EBm9lHsGilGYnVCnxoY16hWRkaFh
 9Ej/s0+ctL2JG8l5uuWj8u01+EyzvkH5MFI8hlOQJHaPn/zVlByD/96egQwVRkWRhCOP
 mTdMSWhlpkIUwP8O5H9Sav+mnYD3lANb0gMzx3pSUvxRLRTRR3o5dRW0ZtmAdZeyr7Gc
 +QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t6xiBm4AewZPGvWuP/C57U7CBdnlU6ctV7vonpSTcNY=;
 b=qRmuHdua8RtZ6tjkA0j5Ei4PB6tx9B/6k4SIe1bDWL86NEn1v+DtbyBuZVpPdwdGo3
 i9LhGhfRM5z3rpj/VlsiOu9lVl6+lqbYGJj/PGI8Zg5MjHIPuGG9Wo/ts9p9GHntSk5+
 1KBfeV5tMzvByBQm36yOThbgrLa5tgJSWFQAgSDU+JMqXpgGd33GIyTjGxY3AW/j80A1
 cV1QzkOwgCoKgkKg+pH4aaQDEUKY2OZjdPZH96bYi4x3s345gq1YgB7E4zKSm0LlqSM8
 MyZigVTV/5uFPFJKipVFnkrY+en/c8zXH4SSRT5b0D6sVLVdNyiMYRZDC5GlnrdH5bgd
 AIzA==
X-Gm-Message-State: APjAAAXNApbZoC9yeLSpEB7Sei6Bg1NByUGMczBYOJNveRpDTMgPEdxb
 Z9TNqXsm1E3Pikqnwu37Ha7FNQ==
X-Google-Smtp-Source: APXvYqx9XR6r84Xopmm1b212+fWkQzXvL9yJa3C/hKbkklYVUxSIArRDNTYIkSBmgTNPCdt+H2sL8A==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr4398038wrm.48.1575996416685;
 Tue, 10 Dec 2019 08:46:56 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id q6sm3927503wrx.72.2019.12.10.08.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:46:56 -0800 (PST)
Date: Tue, 10 Dec 2019 17:46:51 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 14/20] virtio-iommu: Handle reserved regions
 in the translation process
Message-ID: <20191210164651.GL277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-15-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-15-eric.auger@redhat.com>
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:37PM +0100, Eric Auger wrote:
> +    for (i = 0; i < s->nb_reserved_regions; i++) {
> +        if (interval.low >= s->reserved_regions[i].low &&
> +            interval.low <= s->reserved_regions[i].high) {
> +            switch (s->reserved_regions[i].type) {
> +            case VIRTIO_IOMMU_RESV_MEM_T_MSI:
> +                entry.perm = flag;
> +                goto unlock;
> +            case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
> +            default:
> +                virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
> +                                          0, sid, addr);

Needs the VIRTIO_IOMMU_FAULT_F_ADDRESS flag.

Thanks,
Jean



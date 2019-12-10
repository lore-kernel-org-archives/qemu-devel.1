Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F7C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308772073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwlGZP8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308772073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieii7-0007Re-Jj
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieidD-0003tI-2y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieidC-0004XR-3o
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:45:02 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieidB-0004Wp-Ug
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:45:02 -0500
Received: by mail-wr1-x444.google.com with SMTP id a15so20852656wrf.9
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g9cCMZtEkM7Y7AHaz9CHJEQ5Bqx3hepUjwcskldSK3k=;
 b=DwlGZP8+EpwQOTeJoLtucByNvZ9UpL03GK829rihVuEGOLULBNz27gCFJi/Y9asyhA
 /yagQyBTIKXfYCsif4YPCvJbeLoOViM5nGXhqxXYlgmTYkhnTJv5RJ/Tm+M7uQsAlBdz
 3pZyBSiQXfNRschF5jx2eAS19+lA3YNorgni/IIgCVFtGxsy01bK+19MfpLQpDlKMcrC
 GUisdoMI78UK5NWmssIS0hibeg8OIweSne2qOi/aywIcas+FK1bE1xob0FsOeLAv1BsG
 /6nI6fMq/NzZQJUmr07aa0CPG5rrmuzUBnkk0tBxYOdW6vd5x4frEWqvWAlA2Li5cwGb
 Xqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g9cCMZtEkM7Y7AHaz9CHJEQ5Bqx3hepUjwcskldSK3k=;
 b=Krbug6yzOp+GQV4kI68X/tSq0KiXMECQjQdrSZrqnE1vOXgZorAHNwLlPxeGdtGgFH
 NZrgIhdYkXmHQMqPwNA7nImW8A4/bScAt7pBfgePeXMMBu6aAyn7/FkbQA0H8RMk4X1t
 3CyF7hYPiRsTSJnHpEoSDgXnYxSnBrkzROeGAVTsFLOvKYemmvdYe8QgfPivaSko8Wke
 /kpuC1DzI38n8YMs6Mni3hQZ0Rf8JoCwgCFD0VsMUmnUr5ghjZcXUZ3FB1BsOi0MYWDa
 k7h3FsO4KOJVEYL+PNbdXIF55jYpuYhDmET21e8ij6r2cmHJsX65TCCtWdOr2TKRb5xn
 BQ6g==
X-Gm-Message-State: APjAAAX237fUaVMB646hNSLJXPJhLBjLDLRhWA1ei53LFelbBmJO5POs
 KIHSXmZXZDPYgeSF8HJdnhti5A==
X-Google-Smtp-Source: APXvYqyg6IvNiPboGL1KqEAv5dXfOxRf4UKen/I72vMGY8AyDRICYfqHTvUK0rdLm54PegAZ4hgDLg==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr4392337wrs.92.1575996300824;
 Tue, 10 Dec 2019 08:45:00 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id p10sm3682392wmi.15.2019.12.10.08.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:45:00 -0800 (PST)
Date: Tue, 10 Dec 2019 17:44:55 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 10/20] virtio-iommu-pci: Add virtio iommu pci
 support
Message-ID: <20191210164455.GI277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-11-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-11-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

On Fri, Nov 22, 2019 at 07:29:33PM +0100, Eric Auger wrote:
> This patch adds virtio-iommu-pci, which is the pci proxy for
> the virtio-iommu device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


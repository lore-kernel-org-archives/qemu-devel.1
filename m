Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E43C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD512073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnTss9rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD512073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieifI-00054E-S4
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieicm-0003Cx-3i
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieicl-0004M6-3Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:44:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieick-0004Ll-Sl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:44:35 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so20873833wrm.11
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Pc/HUtwzczF7hl6cnINcFfG6ZqHbQFHNh940PLCprkw=;
 b=RnTss9rSbsavmfAYaoiMDwVIsdegSm3Pwy0/t5YimwPdG0Tv+LXOQAikrquQ1gH/L3
 t/vDKRUi3Jpds48e+qclxshkUJMTwRB0d2Z1wWKfo37Bk0KI+5eSNqMcvp0pK4DKbHEh
 nyuqJYgoAfQg01JLLSalT+YN/J/pBKerH2xedN+0pQF6Kn0s7vvu2vaPZYHOA6ZeGcxS
 4mzyygEJZSbZpsZ3NQXNV1PZdZRQ1QomUgc4zDAP3hRV4kTJauoI+7QJ79sjdIYSYzZA
 MMS3U5K+wmQTiC/pTOaPd3uE7PE0u9HFilKg6hdez/KP+HMU4KXkiZdd8WsF5MqPfT7s
 QWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pc/HUtwzczF7hl6cnINcFfG6ZqHbQFHNh940PLCprkw=;
 b=ZtqSPtFTkkLd6jA3o+FJU9M/+ciRz1WK1NH7p+QXlWBZRQUDLXlFvWIIcfxx4PRQxj
 IwbGEboO/l4lL0Q5eHQ7Do8fbPxTPnuQSr7OZZ5ejCmRoH6qVUwF1m3nHN+kI3XNvfs8
 Jr0k6tdF2NuGbHEyA4J+DYacI16DBN4GN/xbRgfOoeTVkkApJTJ6fnqypRBoSYR7dVul
 JlDiea873kCRgmBLuHTDCfmFnlDKyJc7Qovv3XhuHHlZ6v8E9QC7W5Te7iUpges274eJ
 dNpyfy5Lu+mBlzAJAlQU5fd6Zduawadpgx5HMTv1wMeS7LiW9GE6oE/BQqR1lj2+nbMU
 uzHw==
X-Gm-Message-State: APjAAAXgR+02lm6/F+oFOsAcITzntuzOalAEhMoNgGcDk1vvLu+ANzGP
 1wC7nZbSbdaimPAb/qCGaMeN0Q==
X-Google-Smtp-Source: APXvYqxbShFZ86wmwb83jArVx6pbttNvj/034bI8PUddYwI18r5tKa8vHPCYqAoiYCkfSCQCFbEwtw==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr4138784wrm.151.1575996273900; 
 Tue, 10 Dec 2019 08:44:33 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id x18sm3823630wrr.75.2019.12.10.08.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:44:33 -0800 (PST)
Date: Tue, 10 Dec 2019 17:44:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 09/20] virtio-iommu: Implement fault reporting
Message-ID: <20191210164428.GH277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-10-eric.auger@redhat.com>
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

On Fri, Nov 22, 2019 at 07:29:32PM +0100, Eric Auger wrote:
> @@ -443,6 +489,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      if (!ep) {
>          if (!bypass_allowed) {
>              error_report_once("%s sid=%d is not known!!", __func__, sid);
> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
> +                                      0, sid, 0);

I guess we could report the faulting address as well, it can be useful for
diagnostics.

>          } else {
>              entry.perm = flag;
>          }
> @@ -455,6 +503,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                            "%s %02x:%02x.%01x not attached to any domain\n",
>                            __func__, PCI_BUS_NUM(sid),
>                            PCI_SLOT(sid), PCI_FUNC(sid));
> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
> +                                      0, sid, 0);

Here as well, especially since that error would get propagated by a linux
guest to the device driver

>          } else {
>              entry.perm = flag;
>          }
> @@ -468,16 +518,25 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s no mapping for 0x%"PRIx64" for sid=%d\n",
>                        __func__, addr, sid);
> +        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
> +                                  0, sid, addr);

Flag VIRTIO_IOMMU_FAULT_F_ADDRESS denotes a valid address field

Thanks,
Jean


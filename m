Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D35C2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E607E20780
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne0LxTmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E607E20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBSv-0003TS-4P
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhangfei.gao@linaro.org>) id 1jJAbZ-0005RJ-Nj
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangfei.gao@linaro.org>) id 1jJAbX-00026O-Ln
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:42:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangfei.gao@linaro.org>)
 id 1jJAbX-00023D-A5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:42:31 -0400
Received: by mail-pf1-x444.google.com with SMTP id i13so9884920pfe.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HWKo00iz8fvROFUAHZ5wh/5hjLTRWUP788xE8iR+dm0=;
 b=ne0LxTmXheyqWvplQua1gZp1Jj8sfmo3Iq5BVA2ncwOCl/Muu7H3VjyGs6rXpAeWXf
 1yrriluz6hVMviDugkkiRNuBhw1Tk8seAOqdlFgq9dZpv3OMT8IH478whrHXziN/54S9
 pilEljZBufxp50r/KFh1tMtzO/JStpVROUrPF8CF54Iz9Gt0/aaJU7mGm7iqn4eGoY6P
 o5xho3Af7F6ATfWmJcg5hCVTug/RLZYl8+YJU65bkaVmD94PCjeLfkfvybNOf+k81Au+
 7O55Jiq6dwD4zFh0yozIu7TlpUSi7pdYoYUSeySu8O/M2z5Um15m4tJY+MV9oQbcNCto
 vFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HWKo00iz8fvROFUAHZ5wh/5hjLTRWUP788xE8iR+dm0=;
 b=iPV3rGHjGrduVqkGO9F+rYJVeatBnj9WPGNhbjrffBSxkjgS98qvOJ6vy3s8u5daHT
 hHBTcQOtwr9kLS2hIudGnue1dP+9LVU57/Q9jzVrs+imHmrpV9NmSNIGSEwYAVulEiI9
 FnOwWBi3bHO7QEA7ENiQ8sFQ6lj9ic1V4K64u4dMIpRSOfB+3vBbb38dVvmjX4zDH3qu
 lsg3JXXW2lZjwomo823HrTGNEOXloy5sv2ks1dsYPpiKjgwXilYkGbOUjgKbp5qDSfLk
 uqDRGIkSvEZn77d4KxZx9AGFbdZmi6DN+zj/nyEzB5vtz36VdVhKBUVahtrfhwAPscMF
 9GGA==
X-Gm-Message-State: ANhLgQ3Ms1Y2+ITaFjNCNYfbMcy4Gm5o1NcCXQX5VgBuAR1zU6TwfxC9
 MLsVQtBO6K/Jua1JDCdIboIksQ==
X-Google-Smtp-Source: ADFU+vthuTu06kNRa5uYCsc8qlFnwqJm10MbvAx7J+r8BNYBVw+Ji3UV9o7tLUUaVbe754SlYTBnpw==
X-Received: by 2002:a63:bf4e:: with SMTP id i14mr16015360pgo.41.1585636944877; 
 Mon, 30 Mar 2020 23:42:24 -0700 (PDT)
Received: from [10.27.0.210] ([45.135.186.113])
 by smtp.gmail.com with ESMTPSA id h4sm1928170pgg.67.2020.03.30.23.42.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2020 23:42:24 -0700 (PDT)
Subject: Re: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
References: <20200320165840.30057-1-eric.auger@redhat.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <73b1c3e1-a418-f57c-d949-261250d6a79b@linaro.org>
Date: Tue, 31 Mar 2020 14:42:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200320165840.30057-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
X-Mailman-Approved-At: Tue, 31 Mar 2020 03:36:52 -0400
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
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 peterx@redhat.com, shameerali.kolothum.thodi@huawei.com,
 zhangfei.gao@linaro.org, bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Eric

On 2020/3/21 上午12:58, Eric Auger wrote:
> Up to now vSMMUv3 has not been integrated with VFIO. VFIO
> integration requires to program the physical IOMMU consistently
> with the guest mappings. However, as opposed to VTD, SMMUv3 has
> no "Caching Mode" which allows easy trapping of guest mappings.
> This means the vSMMUV3 cannot use the same VFIO integration as VTD.
>
> However SMMUv3 has 2 translation stages. This was devised with
> virtualization use case in mind where stage 1 is "owned" by the
> guest whereas the host uses stage 2 for VM isolation.
>
> This series sets up this nested translation stage. It only works
> if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
> other words, it does not work if there is a physical SMMUv2).
>
> - We force the host to use stage 2 instead of stage 1, when we
>    detect a vSMMUV3 is behind a VFIO device. For a VFIO device
>    without any virtual IOMMU, we still use stage 1 as many existing
>    SMMUs expect this behavior.
> - We use PCIPASIDOps to propage guest stage1 config changes on
>    STE (Stream Table Entry) changes.
> - We implement a specific UNMAP notifier that conveys guest
>    IOTLB invalidations to the host
> - We register MSI IOVA/GPA bindings to the host so that this latter
>    can build a nested stage translation
> - As the legacy MAP notifier is not called anymore, we must make
>    sure stage 2 mappings are set. This is achieved through another
>    prereg memory listener.
> - Physical SMMU stage 1 related faults are reported to the guest
>    via en eventfd mechanism and exposed trhough a dedicated VFIO-PCI
>    region. Then they are reinjected into the guest.
>
> Best Regards
>
> Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6
>
> Kernel Dependencies:
> [1] [PATCH v10 00/11] SMMUv3 Nested Stage Setup (VFIO part)
> [2] [PATCH v10 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
> branch at: https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10
Really appreciated that you re-start this work.

I tested your branch and some update.

Guest: https://github.com/Linaro/linux-kernel-warpdrive/tree/sva-devel 
<https://github.com/Linaro/linux-kernel-warpdrive/tree/sva-devel>
Host: 
https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10 
<https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stage-v10>
qemu: https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6 
<https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6>

The guest I am using is contains Jean's sva patches.
Since currently they are many patch conflict, so use two different tree.

Result
No-sva mode works.
This mode, guest directly get physical address via ioctl.

While vSVA can not work, there are still much work to do.
I am trying to SVA mode, and it fails, so choose no-sva instead.
iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)

I am in debugging how to enable this.

Thanks



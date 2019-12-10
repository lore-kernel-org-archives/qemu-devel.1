Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE2C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F4F2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGezvISl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F4F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieipd-0008Ig-07
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiid-0000AB-PF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieiic-0006de-PE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:50:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieiic-0006dL-Hw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:50:38 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so20910124wrw.8
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OlfjqJ3/LjH+g5cdCQ/k0akt9iUKtH6iUQLY+fs5ZCM=;
 b=qGezvISlVmrWMXOA1mS735B4gad1o68cfJ+LwEuX+V7e9Ev0R/9siXzsfbfyApCFhK
 1c5UXBmu/OT1IRn2lzF9Ao6FnzmgAbRfjFglthbVYHBmvDoEc6b+UDgwe24L9OX5uvi+
 w+6galaekwHD0liVsafcK1mIZpzBnYsZrCbd3Lzp6rZlKxb3y0Av52pgMurWs2pkP684
 1mWNs//a1A5jEyP/THJACCanF4h1ZtxhcvLKGzouyufnyIxavZCmcMOF9Z6NkwC14k3G
 GACHLLra0EDvtO9pdbVknKaKZtlTl/qcHXYtSsSSu8tYHpGO9xPShjLujukG2cBKsGqs
 tLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OlfjqJ3/LjH+g5cdCQ/k0akt9iUKtH6iUQLY+fs5ZCM=;
 b=Ili4IucCKZtoYovQlIDUt4xwp9/SazBKwF7dSQLuCdI74DTK2Z847Y8dEV/gthOhkq
 2BnUL4DycNnsWiDrSRQNE48iuHb/whEtsswOTdkUN5JS4ZL1Tpph4+0oFc6ZF5H2tLVv
 Vsmkh0kEmvk4OT+Z+lYWVIq7hkirZycFkcX4Nc0MjVJ99Dv346ghKfNAeEXRwA0X1wVT
 vWMEIQI4wGPqg4gAv8JejQVVMRn2+8bmpQInYdaMRGCQvuSSy0eOJnyJOD/er9z/hhon
 Mbw3l4F/BgQDzM5QTdsRzpMSduYun+ixk2x03ZjHOdrmDRuDmjzksVQ/xnAcQm2SgCMu
 vbRg==
X-Gm-Message-State: APjAAAWo/zLSKdU996Tb433NGnrNWdHgmMg7E7RzFl0Ms2msugmt90FB
 rGXwVH6P7FS/3/jg7R8hjqVBKA==
X-Google-Smtp-Source: APXvYqxutjvagaAitDymFgNYzAxJjxXMx8MD/eBp205r+vchYhXoEY+d33R7oUoTyIsZmQ87JFx7jw==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr4359722wrv.77.1575996637592;
 Tue, 10 Dec 2019 08:50:37 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id j12sm3978809wrw.54.2019.12.10.08.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:50:37 -0800 (PST)
Date: Tue, 10 Dec 2019 17:50:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 19/20] pc: Add support for virtio-iommu-pci
Message-ID: <20191210165032.GQ277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-20-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-20-eric.auger@redhat.com>
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

On Fri, Nov 22, 2019 at 07:29:42PM +0100, Eric Auger wrote:
> The virtio-iommu-pci is instantiated through the -device QEMU
> option. However if instantiated it also requires an IORT ACPI table
> to describe the ID mappings between the root complex and the iommu.
> 
> This patch adds the generation of the IORT table if the
> virtio-iommu-pci device is instantiated.
> 
> We also declare the [0xfee00000 - 0xfeefffff] MSI reserved region
> so that it gets bypassed by the IOMMU.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

It would be nice to factor the IORT code with arm, but this looks OK.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49207C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135EE2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkPzgErk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135EE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieidM-0003Zd-Ii
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieicC-0002Wz-PS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieicB-00049g-TF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:44:00 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieicB-000493-21
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:43:59 -0500
Received: by mail-wr1-x442.google.com with SMTP id a15so20848733wrf.9
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OlDxnhAEHtJOXMsOXwxoIBoY1rDQfYKSPVN/Ah8CeLg=;
 b=RkPzgErkwNvg/N/hYOb/+LM+QfNVPmUrh3IP8BwGL0zrTPfNkmO2EO0kyyaLyChNaa
 h3YLcgaSanQYYTZ95dWV8+ARp4BU9NAtPuSf+qAxEiRCY3hcoxUF5mK83MKBvKk6wiYW
 XkNowoTadaAtMTwl/QA+kfd6AZ7AzG+bkhKXosFHLAG1gB125LZULfLJnC3CAe1VPJ7U
 CBWNvOcLj+RW2G0OO81aM4oyUynYOtuxudtyF3gzzliBK46nn1nyrjBVON3s5u0wSXHL
 KQZwUJ+599bcYCxpxOzh7PCPdTm9ETE0D/HxTuEII1Q5bX6aEy+qmiO15dggtf0JCsca
 N4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OlDxnhAEHtJOXMsOXwxoIBoY1rDQfYKSPVN/Ah8CeLg=;
 b=Fj6pIMnUhELGn5tfGp0xGv2AttnU4MU7Cf5icEH7NAkwljAs0JKDck0LYcyTBxwJXM
 ssiSBHwcyapjxjV0L3+cmJsL3YRPuVwvbctA68vAMOZOLGXPIAddC/urn8Sy/rqBXHIY
 ovcP5NvJtM5ZD7VRCMLBIT3DcL1eNpPvgD0cPvTTxGIBN/GnHwRonu2la6/7H7caZe6h
 LHRIaHKbw/8cCWbJQM3W2aU8W8Qn39gE0mGKam44um9I2E0mW35pemWvVZUHupYm42Bn
 68GA8p5oxBDHkhXmZvsdGPxnimlK6oWHZL6fzvudaZVKPvXHTVqDlBhUepfXvG8JIYTM
 fjDQ==
X-Gm-Message-State: APjAAAXdv7J9Cf+kAr7eBjDs/AilNbrArcygT7djs2qfFIATQlQ3dNkA
 jrk7gTa9ivhYaF4pIoEoODcwOg==
X-Google-Smtp-Source: APXvYqxAf3lYJEH+sbHwd2TTvcOdpvXAOoN2/dYBQV7PXO00goJ8X9YeG9ZTfAtJLwQw+cyjvXdKug==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr4484684wrw.346.1575996237774; 
 Tue, 10 Dec 2019 08:43:57 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id y10sm3660456wmm.3.2019.12.10.08.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:43:57 -0800 (PST)
Date: Tue, 10 Dec 2019 17:43:52 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20191210164352.GG277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-9-eric.auger@redhat.com>
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

On Fri, Nov 22, 2019 at 07:29:31PM +0100, Eric Auger wrote:
> This patch implements the translate callback
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


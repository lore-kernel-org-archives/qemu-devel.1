Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FD4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8340B2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C37tM1vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8340B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieiiH-0007eP-KP
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieifH-0005be-AO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieifG-0005KJ-1j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:47:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieifF-0005Jp-S9
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:47:09 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so20877808wrn.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MaG2yhQk2cqVE1psdudnea3pLB+w1y+rXcyshwhvQEQ=;
 b=C37tM1vu50Xd4/4ybdT4NjFOcRVsfZpTVIze9zGBYP41ep0mVm45g8YQEQLTDqxJBY
 JIhL7ZGtRi8k7sO7n4rFRD2061F9nPLQ0ZxyuD7K4OPOWkGXt9dkl/De+mfDT56CE9PH
 Vbw2dbsVLSGzcEBApcxllDjzVxOL2STEVmOkCWzl8Svbia3N9iiHPjojElzZHX/aFrXp
 caJPrw2+ReyMjwz8QFHMLre3WY7fhdW+UDe+x04Lv/n49pRrabnwnBPwFUzC8Ae/u0bb
 mBha/aiRRvxcvcSizi4occldr3egmOeszng7i71VqLWdvZPfnFxI53AgWlORyNNYvfkJ
 9zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MaG2yhQk2cqVE1psdudnea3pLB+w1y+rXcyshwhvQEQ=;
 b=M828gUo0Ge+6Go5Wux0SyrpTRuRtl8StSunT9LmewJEcho2HGg1nPNHCokmNtl+pl4
 Wh6U8JY8U9VZFKqaEuunEHbCXFbd0AiEpW207tzgAEZS+YjfWWH2YH+AuZHmlc5vUZyz
 NAy7P+zt32+QHeHV5UzJIth/qimC+os6M8492zH8BBJSusdNgI5Ws52zEJNArtMCRa0h
 vT5AQARc7LCdmtj7I8vRvEcJUR5nQO6ez+n5/KUZgKIqCUjXUZLEJyeY9TfyoyiqQ2a4
 mqQkpnEmdtg6qY6ZRA1wDp1x0TBeNnDr7Avx5DbUTECQTqXa2PrMWh92HjYRjUZC4IXz
 s1JQ==
X-Gm-Message-State: APjAAAVOEAhRwXYMYU7mZz9/HGMq5maA+/tx61s+o2VRL82qvQ4WhQL9
 zbxx5Iz9GmjEvV2Dov9/PthiiA==
X-Google-Smtp-Source: APXvYqwTE1gZERfzuQ9NC9J5s9ebQhgK3/hg4vjz/cnsqaJRMmw2DPRSXxntXYsq0iOk8/8JT4V4ag==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr4121910wrr.32.1575996428921;
 Tue, 10 Dec 2019 08:47:08 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id f17sm2032251wmc.8.2019.12.10.08.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:47:08 -0800 (PST)
Date: Tue, 10 Dec 2019 17:47:04 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 15/20] virtio-iommu-pci: Add array of
 Interval properties
Message-ID: <20191210164704.GM277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-16-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-16-eric.auger@redhat.com>
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

On Fri, Nov 22, 2019 at 07:29:38PM +0100, Eric Auger wrote:
> The machine may need to pass reserved regions to the
> virtio-iommu-pci device (such as the MSI window on x86).
> So let's add an array of Interval properties.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C10C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1171E2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5+PyxjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1171E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieint-00066m-U6
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieieS-0004kO-3B
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieieQ-00055D-VU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:46:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieieQ-00054Z-P1
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:46:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so20902566wro.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yBKxW4v01bphY2O9YP1yA6L9FAbeDZs2B/G4JBWdu/E=;
 b=j5+PyxjGFHC0Sr3oAnZYMUkLhH3Yjf/rZSjyCb+vUWnHg8tykTdUKDwS7HlIrmy6Sk
 nNXzqKGkeyQz4ujmtDZL+im0k2nQYSoivNp3P0P3qLl8ICw4iYxyKqI5MC4Sv7S5VSam
 Mg91e5Ycs2wgJyiuysUOIHSbewI/6UvG4AN5SvtKGzvyejo3uWy+FptbcGyNll+5XAX2
 XHHAVRIUgfWyTRQZHXfPusugHkAu+UGIVgj4ISzTzgS13M/ZjdCaeHQIcseinzJGbHCS
 e1b18kluJ4WcKH6h0+vJye8COrWjl8ugB6+2WkHO2ehGnrHsFt1j/UIrzaMBdym6fj4B
 yM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yBKxW4v01bphY2O9YP1yA6L9FAbeDZs2B/G4JBWdu/E=;
 b=ochAq3Y9AYGS2jITu1WEkzrqMu2fOaF8LUoOa26pB8En76j0vUnRtjrj2aeOcUeqpp
 53SwOAcQK9Knfy02WQdA9lR7LzjW8+7NyN5AyH52vzsWtPKpZDy2U/9d9UO+9Fcv2k1T
 QOAjBQfgXq5ykK5I72lTJTNK7qGFRKjAIhEDpnEecXKpF0qVLtE8lLO1LJ0iBv/Vy27F
 hY9BPnynkRDo4KsK8N1ld4zvNqp7zIWLD7WJrhVGCMcgsTTTnUWvhFDBI3Mtr5Tc6Pqs
 lQ06qfGzbQRfEVuEv5cl9PYWW+Uc473abYdbvFSAzVOd8qzSv8ujRhf6UC90uotvYidb
 UJQg==
X-Gm-Message-State: APjAAAUAhfG2TRWzsbOZXs4wnSUZJVSE/Y6sv9GM6sD2b82VG4Qh7317
 A6vUWI3TDDiYf8s1bHuKqxFbQg==
X-Google-Smtp-Source: APXvYqyV9Ji4GM/uba2zln5kgKPeRYOqyPr4NtfEVQdW7TPMXNfhY1QwgWxO9EfqTM1PDCs4P8LDOg==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr3978876wrs.179.1575996377832; 
 Tue, 10 Dec 2019 08:46:17 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id w22sm3534503wmk.34.2019.12.10.08.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:46:17 -0800 (PST)
Date: Tue, 10 Dec 2019 17:46:12 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 13/20] virtio-iommu: Implement probe request
Message-ID: <20191210164612.GK277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-14-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-14-eric.auger@redhat.com>
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

On Fri, Nov 22, 2019 at 07:29:36PM +0100, Eric Auger wrote:
> This patch implements the PROBE request. At the moment,
> no reserved regions are returned as none are registered
> per device. Only a NONE property is returned.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


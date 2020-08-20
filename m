Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F4FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5412080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="QOSwPhO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5412080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8fYZ-0002fw-Lm
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 04:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1k8fXz-00023c-EE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:03:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1k8fXw-0001Qv-OZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:03:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id o21so746255wmc.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=rZrXVU8OPm6Oe6tEEyzcK1cLQR/3T9RyGDphW9t7p3E=;
 b=QOSwPhO3IAYgVLPlRHwQBgfUW6cZ1/xdRAtCNOS2JRAS3NxW8HRuqQ/LNBHJAgNVYF
 xgxSim6O7yJE/QYgIa6l5e0IsG3TKfNSPELRUfR/jJKP8r2BGtuLGj24VKiQb3y8vsnm
 MiU6NLQb+WnY+yW3BICc/XrWzAlYd10kc+q+/KjyPs2fWltuun7AEiWRtaoZy5d83SG5
 pk/cQxw10FNCjcM19OYBPuom1n4HlsD1phgyTgFhmHr/kCn9fGloRXZlpPHbc5mOazI4
 +I84yBmgEDmtO5UmTbLh3PV/PQVFfIbKrhZRyTiw/dyS3wq+Q9lpWntkMxDQrAv0FSHD
 BHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=rZrXVU8OPm6Oe6tEEyzcK1cLQR/3T9RyGDphW9t7p3E=;
 b=eQh4G/GGulmNRZLQFK3+AAlH3/eXbLQ4EzEYaPrwDib6zRUe9IfKFM9Jzh/UBY7Ocz
 j9GpHmu+rQC6azKI+lcobGuvnIDp+wPvi0chxMpBvondNLptF85teosWZIg1kw5x0yBo
 aqQyTtSfE3TSAVepx0vOY7Vb1Wndravw5zaQA8eN8gle/6fEOgH0BSEIqwGnCGGtPMS1
 QTtVtlb/sGzPimHBvakiVqjZ3IPo9hvM8S5BYI1xh7YYzAuHHSG09jzreKyzN45I8wT+
 Ikk28jiAL0P6V599Iu6MPo3lhDrNb+brxDhdrCWz7cQFoywAOPVP87iN62siHV28sBA1
 GJ2g==
X-Gm-Message-State: AOAM531zCWZa1B94E/5QLfs598YFxdktOKMTg5sK98J4nk/4tlCut5US
 cosPsesBEapjhaSwOODAoBgBbA==
X-Google-Smtp-Source: ABdhPJyDryXsHed3CjgScvNBdzXLBfW69ZEMMha5wLZSaHPj8ni3AWVNdVFKjThxpVpJF5QtlrNnQw==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr2157598wma.64.1597910618804; 
 Thu, 20 Aug 2020 01:03:38 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id d14sm2543302wre.44.2020.08.20.01.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 01:03:38 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 98d9f3ba;
 Thu, 20 Aug 2020 08:03:37 +0000 (UTC)
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] block: add logging facility for long standing IO
 requests
In-Reply-To: <20200810101447.7380-3-den@openvz.org>
References: <20200810101447.7380-1-den@openvz.org>
 <20200810101447.7380-3-den@openvz.org>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Thu, 20 Aug 2020 09:03:36 +0100
Message-ID: <m2tuwx217r.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::341;
 envelope-from=dme@dme.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-08-10 at 13:14:46 +03, Denis V. Lunev wrote:

> +    strftime(buf, sizeof(buf), "%m-%d %H:%M:%S",

"%F %T" would include the year, which can be useful.

> +             localtime_r(&start_time_host_s, &t));
> +
> +    bs = blk_bs(blk_stats2blk(stats));
> +    qemu_log("long %s[%ld] IO request: %d.03%d since %s.%03d bs: %s(%s, %s)\n",
> +             block_account_type(cookie->type), cookie->bytes,
> +             (int)(latency_ms / 1000), (int)(latency_ms % 1000), buf,
> +             (int)((cookie->start_time_ns / 1000000) % 1000),

Is there a reason not to use %u rather than casting?

dme.
-- 
We wanna wait, but here we go again.


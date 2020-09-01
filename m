Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E789C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C3B20767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="toOKTv3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C3B20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5KR-0005hc-8M
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5JL-0004PW-S1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:22:51 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5JK-0006wH-9g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:22:51 -0400
Received: by mail-ej1-x642.google.com with SMTP id q13so1314686ejo.9
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rdLm/Pxqqjl8rP7WR6b8uK22y9/1nHZDoovBciQjKWE=;
 b=toOKTv3U6hU49wgCrlyF+iptCOGFriFDOGxvZl93CWUK5tsxt86QWYSlypiFxALbQf
 O+OlXfsJfFrsRmt+3rBXJF6UKvJV8xW7wuJCC2U9nZ+VULUSLC1dbsD8ZSCJ1HZH1cn1
 eJEupNEQhfS4HlOcS08qcSncX3Cd/nf6VhsoSomnJ328DSmURVHJYTZzJRvUq+rPgSHM
 oMl27jzlKNkZsZuLII0fbtrShvIkKJYBVFl2+Jg+lPbhnTV5PPMkvKV7k93eggIJN5J3
 Nt67UCE4CuOtEPZryBZH7AQXh9VMXPxMhRgTRKC+fxc/KKuLi6gumVPRoJBXOmOZnGWL
 qHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rdLm/Pxqqjl8rP7WR6b8uK22y9/1nHZDoovBciQjKWE=;
 b=nl+UzZb+P4Z9+7BLjHv4Uvy/82Fm5LcRILzjIQWZnqEOo7EY7FWncdpBuXtQ4DLoav
 mXUrxthr115JYV9Va8rCxJbn16AC1R/FydEi26jV5dMKCngAiptJ6qH815w7HnX2En01
 lGxpalfbyGQE9e8UiKmtz8C00ydzWS+PkRq1PYqqLI2bIDxSxMfpVOUHIeVCGvl9gRQc
 /rZ9D+xui+7GHkjkD1KTWmeoAtNYOwyBwzAoFMiUyDONNYGv7jQPllGPjGYhpLhFGDF+
 mJJ6sw9EhAM2KwSV/ZlK2awxVrU0reGU45rz21Tmn8zkt1O91UFQawGkDw4oG3u7GlMT
 Hn8Q==
X-Gm-Message-State: AOAM532oTSR2cZYPEO4gEvOquvT4LKCYkRcLQ+bRwV7V3ih/KVMZp09q
 Z1aurrCpmue/Ltz2qrGBku+KaeITlCgzp3KSADUNBA==
X-Google-Smtp-Source: ABdhPJza3YnWkIdxYRjsZ7WVCLiv4T0gLjP3QJld/GgrxC7vDMvynBahHWXH4UUiGb+Lq2vqfu7RKvU6BIOcIqNUTl8=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr1177181ejb.407.1598962969020; 
 Tue, 01 Sep 2020 05:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827124335.30586-1-leif@nuviainc.com>
In-Reply-To: <20200827124335.30586-1-leif@nuviainc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:22:37 +0100
Message-ID: <CAFEAcA8WHi6WPzdq9Mn6M26Xo3_VDAC401OYSSg3t-g6JOL0Rg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 13:43, Leif Lindholm <leif@nuviainc.com> wrote:
>
> The sbsa-ref platform uses a minimal device tree to pass amount of memory
> as well as number of cpus to the firmware. However, when dumping that
> minimal dtb (with -M sbsa-virt,dumpdtb=<file>), the resulting blob
> generates a warning when decompiled by dtc due to lack of reg property.
>
> Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.
>
> This also ends up being cleaner than having the firmware calculating its
> own IDs for generating APCI.
>
> Signed-off-by: Leif Lindholm <leif@nuviainc.com>
> ---



Applied to target-arm.next, thanks.

-- PMM


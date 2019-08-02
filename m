Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACFDC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA63A205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mua/3pch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA63A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTk9-0002m0-Us
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htTji-0002Fi-Pg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htTjh-0003fi-Ph
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:20:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htTjh-0003f8-KA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:20:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id c15so927849oic.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41rmsWmOT87UcX1t8ggSVSIQqr51mjw8swv0gy1Enxc=;
 b=mua/3pchdlgaw/AubMTPrw4Qzo5L4tqQOqYWkmXe36rJ2KBOKXMbugejaQ0rDq+StX
 qNHYXzJhFIeyfP6tU7OIyEEMaWxkE/0PAthjeYYA8nf18FO1Ij5vddiPFO8XbvaHyMM9
 ZT+mQFaA/bBpK22aTDaAukQs8EIApKveEWynrUW9xwCIgtB/E6PQ/Ol32OS2sNOUSvVr
 OIfoWhqVtMe++g8QopKqOfAynoN4lb1Oa009PTKmLwJZ5fUg4d+mVM6HJsYqFB8PGuNy
 CaVPywx1w6bA5BA1otXl8Ld8RVf98VlxGzQ1QhAZlxlBBYTGtuFbNVxEL+bKvO0ZRM/B
 6R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41rmsWmOT87UcX1t8ggSVSIQqr51mjw8swv0gy1Enxc=;
 b=ENAWjUVpCO4BL+d0XBHvMjg8CBFxX6lB2HPKCqSMQArBM4C7CK9W3Lq8hA8Yg4pEwX
 lJF4t3C8npGMpumMLrc8WUv75OpfZ7+oNpRNtyjZ9lPT4MUdUA3Ht+50p+S7s10IjglS
 dEmLM0mtjzhqQcertRQXNVZsSozDBDBVb72b404zuGPxp6fxkuJEf+ZlN1kRPvhPSQbh
 sryo9QORJA75FzVKKmP09U11m47Z8LFGNa3+teHhSwo7p4IiuLdsok1eA5Ty0/1YFjtx
 z6E7cBVyRfBeEA+qNHrqoWFQ5ym6V+CnVLzDu5D5IjcC0MevQna+sjk3f69AhX0Xol7Y
 DwtQ==
X-Gm-Message-State: APjAAAXueLGlnZHAsxCPErBoENRUU67geGGahOvDvofmfufSHtAbLLmX
 lEceutGLDSZ2akR87smCYvYQy/YAQ6o7fyRsnl9v2A==
X-Google-Smtp-Source: APXvYqyzQqfVFIqG1MB0v/bsmKyY3iDdzc56rSmVLPQDCsubD36EXF1bMhu6kgCx54L6/LI2DJuq5PhjEZk2L66FV90=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr2183285oij.98.1564737628353; 
 Fri, 02 Aug 2019 02:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
 <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
 <9b2acff6-8c6d-3aa0-8020-d6d831222496@redhat.com>
In-Reply-To: <9b2acff6-8c6d-3aa0-8020-d6d831222496@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 10:20:17 +0100
Message-ID: <CAFEAcA9fHPpsvwXeKMnUbbHYu_=F+v+SF9ttAm+vOcXOmPVhMA@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Sergio Lopez Pascual <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 at 01:26, Laszlo Ersek <lersek@redhat.com> wrote:
> But it's extra work, not entirely risk-free (regressions), and I can't
> tell if someone out there still uses virtio-mmio (despite me thinking
> that would be unreasonable). I wouldn't like to see more work sunk into
> it either way :)

The main reasons I still see people using virtio-mmio for
the 'virt' board are:
 * still using old but working command lines
 * newer setups that were put together working from older tutorials
   that recommended virtio-mmio because they predated virtio-pci
   support being widespread
 * using older (eg distro) kernels -- for 32-bit kernels in
   particular it was a while before the virtio-pci support
   got built in the default configs I think, and then longer
   again until those got into stable distro releases

I wouldn't be surprised if some of those applied also to
via-OVMF boot setups as well as direct kernel boot. So it
depends a bit what your tolerance for breaking existing
user setups is.

thanks
-- PMM


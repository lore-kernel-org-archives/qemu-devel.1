Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C662C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4175721721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnzBN670"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4175721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEy2-0000Yf-8Q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiEwS-0007wR-Tj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiEwP-00066y-VY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:19:12 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:34563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiEv7-0005lW-BF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:19:09 -0400
Received: by mail-oi1-x234.google.com with SMTP id l12so12467459oil.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ExcpDSybs2Us67oe0TsvmpOFGBZM+gGUCA0WnyGo4lk=;
 b=YnzBN670EgyTRClqhXDEQK+UCyLmJI+IbtzLLPULpe31ALd3VIcyK7Rk2AOxOKnT6s
 +2eFocSfBMdyLT6fFTlVnbYqwmvlO/au8q2A9fcdhMDgh20WvmGRhVA+XLlGUz2zHx4h
 sOiZMgGoXKuYsCrzPXigUqV7d2N2SYk/dHiOd1rvV/2mdeK5Zdsolsk1ha9RlE9IGYSI
 Vt8uNFHtMhI6QFS2NcTwz+eYdrdvxkM7xjsUHi2r0KHWTXvAz1HcJiyN6xhurI8+3kQA
 8GRx529am2qOEKvgNviRwUdWiXXzhp11VbHTdkxtT4Sdzl+35IG+ggEjtrl8tHXJYpjh
 5lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ExcpDSybs2Us67oe0TsvmpOFGBZM+gGUCA0WnyGo4lk=;
 b=Edhje6EzvO76zMvDt/tCxsuUAAFXS5ZNCnjkhtFj01iRUqI6sLEeDVyIOcBWystJQI
 4UrTucqR9xQibl6yxi2tzLVCPOXAgf/L1ltN9qtMSmiUv2aADWtqzvJNulYjezuyDSB3
 UxHGqGGK1Wp4IfV1yIptbHtBjepYBBNUvQ4TLxenQXVfPOUQVKxVV9tKuPjDvpRAAZIh
 IpxQsaVss3jVaO9SceIRPKH1LYUKlFm34zUV703m058432PZk6CrSwYv2Se2axINjGKb
 nWijUZm+T9lB3/zCcxWJUUSr5bX3D8rMLxYV8IYjtww8ROz24l5JJSarkfJo1PkSCbHY
 QmVQ==
X-Gm-Message-State: APjAAAW9TgkJSfbwjmh0NrhhBkCqKE60plX0SW5JuhDTWWyNIRp26Jwd
 SmtX4hqco0qE2PtLB3taUx6jeUJz3Iksim2he6KSAg==
X-Google-Smtp-Source: APXvYqztsbbZ8nTLnjKd2ujgB0Zf7h6N3ki9liP6ec4kRHt8Pzu3FxQ4ByV5kVxIdWZu2V1S2hkcvmzlxndC0jOKqUk=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr2293712oie.48.1562059067492; 
 Tue, 02 Jul 2019 02:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190628103957.9504-1-kraxel@redhat.com>
In-Reply-To: <20190628103957.9504-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 10:17:36 +0100
Message-ID: <CAFEAcA9Dh2EaPkcDmErEdJN+BknuRHvZKe5veOcY_7hMVEXiVQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 0/6] Vga 20190628 patches
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 at 11:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190628-pull-request
>
> for you to fetch changes up to 263807f4e85e94f2d4e988d61d2fc0319b1dd36b:
>
>   ati-vga: switch to vgabios-ati.bin (2019-06-28 10:49:36 +0200)
>
> ----------------------------------------------------------------
> vga: ati fixes, add ati vgabios.
>
> ----------------------------------------------------------------
>
> BALATON Zoltan (3):
>   i2c: Move bitbang_i2c.h to include/hw/i2c/
>   ati-vga: Implement DDC and EDID info from monitor
>   ati-vga: Fixes to offset and pitch registers
>
> Gerd Hoffmann (3):
>   seabios: add config for ati vgabios
>   seabios: add ati vgabios binary
>   ati-vga: switch to vgabios-ati.bin
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


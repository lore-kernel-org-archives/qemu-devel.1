Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15843C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F992146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjA3JX7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F992146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsMP-0008Nb-F4
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqfy-0007Kk-2a
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqfw-0007LG-Sx
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:52:49 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDqfw-0007L2-Nd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:52:48 -0400
Received: by mail-oi1-x243.google.com with SMTP id i16so5251972oie.4
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iFxNGnMHc2gomfgmq3P5pPVF/whBRHuAE9BOwskh+hw=;
 b=IjA3JX7DIDleqxnLELS8jcb70/pCkCrV8JkN1Ujn0/mWiHUW3RvIqdY4HcEep0++BG
 YGl4jCRTQPFF28EfOQA+7S77rOPQdfUOQHdFmCKtJypx64IU3yejdn239QJ+9Q6rjbP5
 yDGJuCayFT7mG48tgi1AfoHRnMDXn+BY1fxa6jbMyaohEDzEJEN+A/YGkH1PIfZS46OF
 qU42Rco7BMGWTSjQrIlqoz3xo13kfDZxorWn5ArIvfBq+XUJKytRgI7jjgkTXLYg4Y5+
 ZOyKiqaazsNpUpX1ADbw4IsT9wGelYM03c9eubnJUp9rryKzCD0E4PtwoMBaBC6yTRq2
 d1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iFxNGnMHc2gomfgmq3P5pPVF/whBRHuAE9BOwskh+hw=;
 b=kOofJRomc67wwn+hFDECvHT1kyQ3GJa2xS/391gCwRfOTLAEbyyxcaTEPC4AYthr5e
 JjErtxbgrohHjRt+zyq/dBtS5kxowRJ4qcCHMq1CYIcQWdKkjO+L5sMKsLLfXKHWKq90
 7rt2IIn0FGvhJ9lIm69rG0DwZPsSiCOFblIcQmnLaHn0uTpqztet2XziN+trGbCjjFi9
 OEQD0X2rfxNVJYsm5BhX5dKUQ+KVW6CbvAg8SiNX6GmMo3a2xIylO94Q9/sNb+yXQ3oB
 Lw+Nj57nGUOKEpzL+0sOLEEKPSvgpknUgq6T4QgDvd/ukT7orDjjkHAHdydl1ZEtl+Sw
 yx9A==
X-Gm-Message-State: APjAAAVfo5PNCMeBLmHjevtkxyYYmwwCdXKUh/OgxZztmwXBqBkuuMd+
 MGMCCdMzNkvBmpI//Jaga/pv4bdKn2EO8Gmhcal7+b4bq3g=
X-Google-Smtp-Source: APXvYqwDPDt9mPIQ92kcFMheHLiVAE6j+R5/tVPxT/BCrfwQuGh+8a2VyWm41yGTCgfowLbEzf3hPx1IFLNiyck5dRc=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr6111829oib.48.1569581165430; 
 Fri, 27 Sep 2019 03:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190923131108.21459-1-philmd@redhat.com>
In-Reply-To: <20190923131108.21459-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 11:45:54 +0100
Message-ID: <CAFEAcA9V9LXQMDxE-QFCECJou9-7x-F8XDTCKSo9SkGT_oenuQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/boot: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 14:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> IEC binary prefixes ease code review: the unit is explicit.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Use 4*GiB in arm_load_dtb (sgarzare)



Applied to target-arm.next, thanks.

-- PMM


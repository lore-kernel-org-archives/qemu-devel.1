Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2F3C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0452166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJDbO88W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0452166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jMG-0007GU-Q8
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jLH-00065P-MD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jLG-0000mI-Go
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:34:35 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jLG-0000m3-BQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 06:34:34 -0500
Received: by mail-ot1-x342.google.com with SMTP id g96so9295616otb.13
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 03:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KTrWWnG4/ici2ugq8yxmlcpAWcIBvmRozTKVrbvCX98=;
 b=JJDbO88W9uwjGBpJuFZBUrZfbLR6GaF25okiXT052Nrmf6tJmdeCxOqm0dUBno1Kxb
 6lln248FFT1FGCaI0Jik6SqSqUfbjpBy4A7cbPRlaYdf//hOCmdVefE47qj1cq5D3FTL
 YWHW9oortHhYeM40GecrKzDCwU581//G0bmhTl2HABbSVNYtjHbHWyXy8WXDhmSaqCBW
 o/Gm0yAGEpRZOTwqCTHLxO/YcxTfPyqjIrtDyPNlX/pg0Tdn4Aa47y8KOmGMWw9a6egH
 joQriVWjM0weJ+2S63LHaRoVYb9X0KeEydaxv7mgv+IYLe6VwrG1VblOX/uzpOJhc+op
 Oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KTrWWnG4/ici2ugq8yxmlcpAWcIBvmRozTKVrbvCX98=;
 b=eGYRh+R13awZWFxSCDZkccVhKLg5SLCJMh4JVyLHr2gl1Zs5fGkBmSK09ifmCvxIXW
 wGzQ87TeXwnPqvviywgbJqK/7JSn9Q28Xxgkd5aTb0hf019H2nAZiMxKPhwtYBOb5foJ
 LfRaBZ8S5WvgjVSWyttyjYH7rJrtuZt7WxlSNw+ctx8TbpiZ7mm3zD3RWHC4yHwUYzRn
 fiZCCiPFD/Ojp7LM4MsPeKhAPbMWZnb1XVb2GjQSi//EjxGeLwjVJT6GixMmaR4b28TA
 Aryp/j/zh2FPgIu6Ib23VGML+Wd3ZqBbzLATAi2C4uMoeKDfSodDMslhrJh5w+PO3MGv
 EW6w==
X-Gm-Message-State: ANhLgQ0udCBP3owthKuOBPW0aMXjnXDikkcSXYwmEX9EIehaX0L7/bPA
 Bz4XIjbIw7nkAwbr/aYUBkzQl0nr+LVnpLOS1siF7A==
X-Google-Smtp-Source: ADFU+vthywoBtNnooD3EcLN+YXY5OP6M5DXmv1iMPIg0jSyi7bvB/QCJEnbs5Wn0jYsi7U3ZUEIsjYi6C7GIDz4fG0E=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr4613650otq.91.1583148873478;
 Mon, 02 Mar 2020 03:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20200226172628.17449-1-eric.auger@redhat.com>
 <6f82ec7a-fb74-a47a-100b-325d5de36a7d@redhat.com>
 <CAFEAcA-2DJ_Bw2NhWtJdNugkHKwAHmxiFv+tGO_y9wRm8aCp4A@mail.gmail.com>
In-Reply-To: <CAFEAcA-2DJ_Bw2NhWtJdNugkHKwAHmxiFv+tGO_y9wRm8aCp4A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 11:34:22 +0000
Message-ID: <CAFEAcA_uU-sPT3Dw2fVb7AJvMvaaFJ13QKe+CQpQ_F1m13rk_A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmu-common: a fix to smmu_find_smmu_pcibus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> Would one of you like to submit a patch that does it that way
> round, please?

Aha, I see you already did:
https://patchew.org/QEMU/20200227164728.11635-1-philmd@redhat.com/
(I process my to-review queue mostly oldest-first).

thanks
-- PMM


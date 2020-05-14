Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C28C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AE92065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArNfQkzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AE92065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDv7-0000WM-Lg
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDuZ-00087o-2F
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:28:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDuY-0002E3-7J
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:28:30 -0400
Received: by mail-oi1-x242.google.com with SMTP id s198so677420oie.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=lrUy0J28zBHHg4g5WRm2XWIMgS4FBFMxmKrKoLGt2Jw=;
 b=ArNfQkzZq7HTe13wq21uQAg69VWtIJ9StIDi6afrXI3wU1DeX+CWTm4nufozIWddXO
 B5SPglYrzCklBddPPyDOW+1ZJng4fRIGFrLdqS0BRXKQetoReYgz9HxW/Pbimke1IX2H
 c26UYuXEaYZEBvh/ZCbLmd8/KilFX9chSXETwOAmlZljyLV+Ap5d0efpNKHyPucDd9zG
 sbTaJ46C7juwwVl/mrKTA1ExT4hT9tLdbheJGZkDdTyVJwrI3Y+lI/siGRVtT09F311W
 1kD0wZFdBDaKd6ZQo/th+gauuNQPMwqVTcsjeQiFTO17xEe09LCSyMTdrpg/DKNvTiv0
 W+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=lrUy0J28zBHHg4g5WRm2XWIMgS4FBFMxmKrKoLGt2Jw=;
 b=oYgnW8rGX74vwxTtdT0QDhs1HiDSkokfo5hOaBPqQYf8vXese2GhtuH8sUM7F/+taH
 0BNpGBe8Tka5nSfr6i6roVwK76Vjbiql7fj6/MTL8W5Rn/tVYeBK6725+gBY7xIfPzyI
 2FEQCk/Y4rkZeRTAEwx6t7kE6qnI9IT7Ee/WP/PRB8nXdP+PYgbYMmHXeTqpei2q4I4p
 uxPfjnpA3U8iKWP3SKZaYT9Q5l9ERlI+o39/xP9POhDMBc71SIXwoBoAKRWsgXx5i1kp
 +/ewcM2wgqqYlquEpKgcGEs4/e3Vl+A/D7kQL9AnW2ecNJnc/4ilgU8rUG1JKlTs2q67
 WFjQ==
X-Gm-Message-State: AGi0Pube8zNJF786dZ4DaUTHtqONnxayvnWJd1a9qQ7zSP1BgOGOIUEO
 XNoKp7SQTvYCdF6zeOlBTJo4XMoCzpGXpzU78KD6Kw==
X-Google-Smtp-Source: APiQypJROvNjMEKy3gdK93N9plhGdq64rA9BbdbpE64Ffao8eUjz84Rv/Tc81RTHOseYDXntzchfTUbISWuwBTls+rM=
X-Received: by 2002:aca:895:: with SMTP id 143mr30671482oii.163.1589462909184; 
 Thu, 14 May 2020 06:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200507151819.28444-1-peter.maydell@linaro.org>
In-Reply-To: <20200507151819.28444-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 14:28:17 +0100
Message-ID: <CAFEAcA_p1x6S10yswHgOkMd=KrxcTGh9TD47+k1LRKM0xy5x+Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] docs/system: Document some arm board models
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for review?

thanks
-- PMM

On Thu, 7 May 2020 at 16:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset adds (minimal) documentation of these Arm board models:
>
> vexpress-a15         ARM Versatile Express for Cortex-A15
> vexpress-a9          ARM Versatile Express for Cortex-A9
> mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M35
> mps2-an505           ARM MPS2 with AN505 FPGA image for Cortex-M33
> mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3
> mps2-an521           ARM MPS2 with AN521 FPGA image for dual Cortex-M33
> musca-a              ARM Musca-A board (dual Cortex-M33)
> musca-b1             ARM Musca-B1 board (dual Cortex-M33)
>
> to the system emulator manual.
>
> Patches 1 and 2 are minor tidyup of the board table-of-contents
> before we start adding new entries with patches 3-5.
>
> I'm aiming more for "at least note that the boards exist" than
> "fully comprehensive" documentation here -- there are still another
> 37 Arm board models with no documentation at all...
>
> thanks
> -- PMM
>
> Peter Maydell (5):
>   docs/system: Add 'Arm' to the Integrator/CP document title
>   docs/system: Sort Arm board index into alphabetical order
>   docs/system: Document Arm Versatile Express boards
>   docs/system: Document the various MPS2 models
>   docs/system: Document Musca boards
>
>  docs/system/arm/integratorcp.rst |  4 +--
>  docs/system/arm/mps2.rst         | 29 +++++++++++++++
>  docs/system/arm/musca.rst        | 31 +++++++++++++++++
>  docs/system/arm/vexpress.rst     | 60 ++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst       | 15 ++++----
>  MAINTAINERS                      |  3 ++
>  6 files changed, 134 insertions(+), 8 deletions(-)
>  create mode 100644 docs/system/arm/mps2.rst
>  create mode 100644 docs/system/arm/musca.rst
>  create mode 100644 docs/system/arm/vexpress.rst
>
> --
> 2.20.1
>


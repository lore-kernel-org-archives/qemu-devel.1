Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ED4C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86B720709
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FSivjIPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86B720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnaq-0001Zu-Lt
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHnZV-00006W-6y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:27:01 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHnZR-0007lv-G5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:27:00 -0400
Received: by mail-ed1-x543.google.com with SMTP id g4so17401221edk.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4YJvX8r1AGHm4LXtW8381XZByd8RQjFAZBDnyxEbrMw=;
 b=FSivjIPsD4WUtqcCSO4DguzznYxJ9+kIIfV5Cg9bSBwXe+yUXLjoe9No43KJx7HaVB
 TWeblfRTuEbQNBfdCRfozLHdlT5Dyk+37AM0B1ukNMeiVj6yfxIw5KeiRE9ihnShzke/
 uOwndNqUmr4IfH4DhFBQCbonEzFmLbYRpzxm1iUWUcW3pagBPoesgNm8KzpUi/yOTaqv
 uatm0eEa2OSX9NGCOU5tK+CywxNFmGuMwEU88t3PEFJ81fGlIkOJilqo/ax4NoBmz5Al
 63BlUzWoBOJPc6gB6dZx6GvaDyN8yclTWJGydDbcrRCMv3xexhdATtJAVq8A0hA5oC1A
 7zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4YJvX8r1AGHm4LXtW8381XZByd8RQjFAZBDnyxEbrMw=;
 b=o0gxipVeTuiLRlnTN7bTqHqiD3SLssd/fxYkWYQ6Wo5Twyc++vPrrxsaQ/4j+OT2ZW
 pznTPfc6pWqlrRXJ4Y0mA9gZ+HEqvJXM/zlVMqMu58CyLXMLHtRsbzt5+srJF9wd/gbi
 SGrNkaZDOzv9FpIHathqhylIVUsKvBbLMJBL56sYHXcIfNdVyqqMlFu1YfjC+cNIu9SA
 dV8IylV2tDTd9a/nC24UYdOu7uC1k+HO8dPPGomHPPjam0j2NITqV7hKpu/LkUTieLCM
 n9DI63s5NzLkk3ltLEEB0rSAtM8gqUKliTpmJq/ynef/xLNx+j3F0J7+9Bxz+XWX1Czl
 xbGg==
X-Gm-Message-State: AOAM530+quzxlPwEdepLDvNRi5+nJewN7VxL8GFnstGcXxTutXS0mtme
 a+gBqedXu7506SjZp0/xl0SevplcxjkvyihtKg+ScA==
X-Google-Smtp-Source: ABdhPJxBH4PJUyGn+N/L+W75/b0M7uxmnR/1UZG/riBILETXbjcU90bd5qlbYyLm/lKukYBKdoqRWw3wPT90OHrYS8w=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr17594526edy.52.1600086414320; 
 Mon, 14 Sep 2020 05:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200909174647.662864-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200909174647.662864-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 13:26:43 +0100
Message-ID: <CAFEAcA9BK1z3hJL0nNjJQkX9kH0_64v81fPhOmj78DY85zYTgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] hw/arm: versal-virt: Correct the tx/rx GEM clocks
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 18:46, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> This corrects the Ethernet tx/rx clocks in the generated DTB.
> Avoids a Linux kernel warning.
>
> Cheers,
> Edgar
>
> ChangeLog:
>
> v1 -> v2:
> * Fix commit message typo, I -> It
>
> Edgar E. Iglesias (1):
>   hw/arm: versal-virt: Correct the tx/rx GEM clocks
>
>  hw/arm/xlnx-versal-virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM


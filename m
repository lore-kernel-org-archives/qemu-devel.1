Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA925C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F3D20663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpdMTxR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F3D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLuw-0005Mb-Rj
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 13:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBLuK-0004ps-9P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBLuJ-0004T1-AW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:09:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBLuJ-0004Sn-6Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:09:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id a9so4098765otl.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4YR3WLemMhh2GvPEM0MGp2LdO687Q4RFVclOD9Kaf7M=;
 b=qpdMTxR9Y7falk+VKMteP7Jm0YUVuQeqKwswC1pJQ81EHL0oZjnAwsTdCbXW4TCJLz
 XhIvh4FXklZYPNn9Gf4u+GjHXs2nwQ8JuXyRZAGARCO+s0V7ARAne8wDcLEzkrNTTRpT
 45MZ9lcqJUp+84ekceVV2AkUlIdL1NW4ThW2EBEFmP4rJ6vv3BYxF1WBrm7VatOqBujz
 O/k7ylJdH57/mRzj12BQ3ZUDFfRYBUsdCNOfJc2jxAPdqR98o7MQ3bNmQNKHxuYe6Q4Y
 6IorAJ10UcbVxBZA/cvEq/cNKNQm2/gsbxZQ7ScNgxrg0Km3AdqIYWUbrwOwkNsAlv88
 A+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4YR3WLemMhh2GvPEM0MGp2LdO687Q4RFVclOD9Kaf7M=;
 b=hZI1Uv/MKtfV5wmrXiHrIWOSWu1zEX643CBjow957epnIqnmIwDZUgkTMmGb4k+Kpz
 W2G+qnCj8Gq4Nwi6bU69SJ+YEpU7TYq/oFQE74Zsnm8pmk1MQKDaoMJl2fn5mjoJvMop
 CsMv83M8t6LRb5W68EbGnVOTsnRBMTgRlhghPmPwIF77+IXPOrzXAcRLySfl5C2V9Scy
 fAEqZt3LmjwIlwc2i1w8B6bFtoiE5KIv+7wZ4NiGh+ZZkEq0uM6YBms6zvm9M+lKSWqO
 MySk9RIqhHeiVbWRbH19kpcYwHD94hpbwl6SY/4mq7whoMugy/1Nr7zJeLSVxvOEtsA6
 Mlmw==
X-Gm-Message-State: ANhLgQ15mSURQIiNli3towTXPb8l3dQUJsJZtMdgUBioP++O3iSHp2r8
 Uoc95wjVNXJSxKdZTQOrjxKV2pEl5oQ/vfI5ISIchA==
X-Google-Smtp-Source: ADFU+vuXX2/b0QvxNbPYdQNb+Y+XG8Y7ttGPLfx/1NNqQhC8XU2LhmvPCLSNZVj0V1DDG7gtI7ralHmrZRow6NN3+BI=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr2940112otq.232.1583773773037; 
 Mon, 09 Mar 2020 10:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200301170443.12904-1-linux@roeck-us.net>
In-Reply-To: <20200301170443.12904-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 17:09:21 +0000
Message-ID: <CAFEAcA_VuY+1egn8B6=Tk8PKGuhAPuP4-=pwuWHQGQsfdXB=dw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Wire up USB controllers on fsl-imx6 and fsl-imx6ul
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Mar 2020 at 17:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch series wires up the USB controllers on fsl-imx6 and fsl-imx6ul
> emulations.
>
> The first patch is a prerequisite for the following patches. It provides
> a dummy implementation of a register widely used on i.MX systems, and
> specifically the reset behavior of this register. This is needed to make
> the USB ports operational without full implementation of an emulation
> of its PHY controller.
>
> ----------------------------------------------------------------
> Guenter Roeck (3):
>       Add dummy i.MXS STMP register support
>       arm: fsl-imx6ul: Wire up USB controllers
>       hw/arm/fsl-imx6: Wire up USB controllers

I'm not a huge fan of the "dummy device that's really just
implementing 4 registers from the middle of some other
device" approach. Unless you think we're strongly likely
to want to use it in other places, I think I'd prefer
to just implement a (minimal/no-functionality) model of
the PHY register block.

thanks
-- PMM


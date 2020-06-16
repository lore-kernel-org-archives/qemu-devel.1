Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30948C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E002220707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UN1YM6y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E002220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8ec-0001UF-UA
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8bG-0006Rr-2C
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:13:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8bD-0006hx-4q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:13:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id g5so15504788otg.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Iqf+E7Lc/C/hU/fg4UjLMNDzGzNqvCjv2hStizLZDG4=;
 b=UN1YM6y5gj69VwVeZ3YM8AQzKqEeObAoOgcyqjQnHktoI5EQ7AM8HdFG150pE3D9ht
 a15Nb+IaH7VYpNo7BgUqA9J7iekeT+aVxHkfch6OoNFOSTodF8+LzYrX1rcz7CwdF60L
 RiZYJar5PeRDS5L/pL+2/UIoCqDEL9lr5nSwCFWvvMGYJ0t2ycXmEHJPik4h67tSmmbZ
 M93+2R9ip2nfW67tYyNZKuzdxG443tymmPHIw4eVMcqyOCA9HVPQGnQhRW/tbMHjNE88
 vLy59CgZ3H04PMvPUCGPC5YsvGkZxTbT90bnOOMnFaHtrQ/mXikRvQB6k8lYWvv1u35n
 B1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Iqf+E7Lc/C/hU/fg4UjLMNDzGzNqvCjv2hStizLZDG4=;
 b=BXpALIT82EZdjua+DBXj1/DhpD+5wpo6tQsdmLMV+h3UtkILBfAcKoxdyZNO0RkRt/
 EniA2MZnNAolNY6wXUqmyLNOyVNLLQOWW4RZk+2e5MZI8p8qfnP3LGQg3528JubxOsBy
 DojuVNPE+QxADJvMTXBDF/TCPRaKgReCmvNKWyuZAoxS8r1CgfKrE513GNMhGeZRShew
 LEHolEbh4cBl64COBLDEuQtLa5aExurv5yU/M+6MAZgXg6kIp6CVlA5Bym1o+CGgk4ni
 2D4pyG/5c9J0X+toYcF/iIrRFGl4+h/zVr3nRb0PFxP7piIDR5LfvBuoo9i9NxpxbduV
 5HCQ==
X-Gm-Message-State: AOAM530DzNH5eH+kTiiR1NBpXRK+uB7q1rpf/cVg0JzwtSVytEWtlGZ1
 JZIEuUIbigBfDntmbXwS98Hm0BJpNLBSNPj9mYwFVw==
X-Google-Smtp-Source: ABdhPJzqJiXG1LwpzLm5LaKdzV9I3+8G7cO8bgzMwa+4MEEcSmXEgFOAX3u+GHl2FM3dkCo1ShuLYXsX1hq65An5RFI=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr1842558ote.135.1592302425772; 
 Tue, 16 Jun 2020 03:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-2-f4bug@amsat.org>
In-Reply-To: <20200616063157.16389-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:13:34 +0100
Message-ID: <CAFEAcA-JwBo-A9go4sHG=Gn-+fBkWBicnGNXJX0FJYwZJiuJGA@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/arm/mps2: Rename CMSDK AHB peripheral region
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> To differenciate with the CMSDK APB peripheral region,
> rename this region 'CMSDK AHB peripheral region'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282FEC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D732087E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyhucoPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i80D0-0004fK-2Y
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i80CC-00048i-Ay
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i80CA-0007im-Te
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:49:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i80CA-0007if-Oi
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:49:54 -0400
Received: by mail-ot1-x344.google.com with SMTP id g16so6910638otp.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ogSBpD6x036yqydDtTC8Bkfrmdu9ILAAteHtymvhnIU=;
 b=fyhucoPVi0Boo6kyFewyc26ZmNAfB3brpoRyOQNEmCdldYjfVnx59PJVi7oHa1Ivhs
 hvEuKcm1Z6MleloSBNrbx6P3jLah2M+c3DQ7nJrevA4oOFyDRHYFLSZgsDC2OP3pXUBu
 mT7/Wpd2mNs7FE3yvwA+OuLZVK0YqBaxKHJhsBwBWiHbeWP9x2h+9aXHns/sCN7DFzgv
 WJVKFjbmjgNR3NUvxT9Lv6urVVY8oyZyi9trTC90Wj3Zc7iQjDKW04Hj59rZNexQciJb
 3gRMtUXSNfVZINrF4bz/46lQe6nlcNpd0tkWBZ4geYXBGwxvkHHutg6+h0Z4LfMYUMwW
 WaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ogSBpD6x036yqydDtTC8Bkfrmdu9ILAAteHtymvhnIU=;
 b=H6RbShpXgliLKojaKTtqQbzBOIFastdE9mtcvklv7gDwLFcct9rG+mGeo3dOOQeIWE
 oFgmAsNFG+VNhIcu7ch2+hPVJgHaxErxAcKQvzKp0shbtZftuhpxpRVK4wEAivokeVWN
 mBx+LQfnGFR1fb3rAOr3qWKMb1OMSgqSgx8ZfzIl03iikmFKIT+WfoQqapt05Xoaprro
 en6nmw49ffKBzhCUBlr6kfPehnlfNFA/lthmSRoLYx7voudwZp9DM2VXtxH6a5OHv1wr
 3fyYQT4yzcP4LOWFE+I7wg9KV9ssT3lJTCfYoT8u20tFuuCoNQe6fpJ+gEcQQQWS1d22
 zZ9g==
X-Gm-Message-State: APjAAAUsPH/3z/YSXoFPGskVX6nf7Jix8EH9Wt/ZghCpXVhtA5IJNjtn
 f+YMfmM36x2/Uy/F6H+srtwiXJFlylgdKM4uR0qeOA==
X-Google-Smtp-Source: APXvYqwnZx51p6gaNJJzjiYUrRDEHH2TYYEHqwMGVw4toJAyvmbsFaa2DjWq0C4wBfwJPBgrzB5AdmKlhx42rn/QX+c=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr31174212oti.91.1568198993771; 
 Wed, 11 Sep 2019 03:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567750222.git.alistair@alistair23.me>
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2019 11:49:43 +0100
Message-ID: <CAFEAcA8gLzitZ8OKU+Ht79fsU1BOguxEu9FvafD0vjR9cJKx7A@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Add the STM32F405 and Netduino Plus
 2 machine
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 07:10, Alistair Francis <alistair@alistair23.me> wrote:
>
>
> Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
> Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
> and machine.
>
> v4:
>  - Rebase on master
> v3:
>  - Remove custom reset handler
>  - Add init-entry and init-sp properties
>  - Rebase on master (including Kconfig changes)
> v2:
>  - Reorder patchset
>  - Return the kernel entry point instead of using a pointer
>  - Address Peter's comments
>
>
> Alistair Francis (6):
>   armv7m: Allow entry information to be returned
>   target/arm: Allow setting M mode entry and sp
>   hw/misc: Add the STM32F4xx Sysconfig device
>   hw/misc: Add the STM32F4xx EXTI device
>   hw/arm: Add the STM32F4xx SoC
>   hw/arm: Add the Netduino Plus 2

What are the changes for setting initial SP and PC for?
Why is this SoC special? Is it different from the
stm32f205 SoC we model already?

I'm not in general a fan of individual board models having
their own custom behaviour for -kernel. The inconsistencies
between architectures and between A- and M- profile are
awkward enough as it is...

thanks
-- PMM


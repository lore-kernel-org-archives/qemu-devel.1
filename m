Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B29EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137FF2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUY0rHtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137FF2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRX1-0004SX-9O
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCRCf-0006IP-4i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCRCd-00084m-Ty
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:01:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCRCd-00084L-OH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:00:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id k21so6210685oij.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sG2XHxtL29liFM8qAyu3jpV/gaMswIfwBnXLqD75KIw=;
 b=tUY0rHtEFZga2G8zMqXXlIUYHIZ+tIEwasI8rTQMdtlszrxnH+GZ3gyv1DaUQpyy0U
 Xy7GJ3pDw0Rqp+WhO1ASz0i+TFyU1EE+RGBVR6amSqNjbVhfb/NDIQJXym+0DbFM6wt6
 eirhDm+K1X4e3rUFsDw+0TpAAMDoW0NV8YCk+6njKAqUpsJHG/n5JA6y2nTuieHyVMIq
 guR1Lcl0/aJiQljsjhtVRY3d3MGaW9KKcYE5vHpLHJv69JSqkLqa+o/q+J0B7bFsi7Gf
 7rG92FXA9u9sc7ygSEVSORBsjyh20/wDDjOfU2X2Dhbwmlj8lyq6BsDroqzQo2ecBX8z
 RbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sG2XHxtL29liFM8qAyu3jpV/gaMswIfwBnXLqD75KIw=;
 b=muyDwqzDx/1wktypjksbqQbsl2tYW+1xzGEI8D6kxUpnVBTXTf5HmRxwixeFh44rRT
 VFeFY1dh2u/nRewfFzuH/AL4an+mUwtvXMjZrJnKzXfK/3g2gIH2LlRxURN+vkkvQLV3
 4hJdXd/7C6Ah8tjprJihmARuo1dMnARiCn29iNZ1vavoyDDXy0Y1BQiZPi2uhY91p7kz
 whTTh2zp5WbqgHgPkAAg4uYnbsf/S+rsbfD4zUIspU8wU2tvSQbGtDNaqlYGb9AJ4nK+
 TqkXiFEhLqaRoX65bu/Pr0pA3F1zhojdSvj243veD2I8p2cNJeTzLU33pBwCPo1KezzV
 s3+Q==
X-Gm-Message-State: ANhLgQ1Yrra6L7qJA+YzeSwSIdjSAZWZYw4Y1TcENNFd/wja9N86VES0
 vocO5nC9eGCe9iRU/gjIiJzXQ5v9Imk+81eWtgZwPA==
X-Google-Smtp-Source: ADFU+vuJ7k8R+ip/KOjJj6uWne3Jv24J0fy4U6KiLTAI0KU+Pm2pKuhlfUf0zt76SYIITIHWtqlR9aUEXJmH+2aTEjI=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr3226853oic.48.1584032458496; 
 Thu, 12 Mar 2020 10:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200305105325.31264-1-kuhn.chenqun@huawei.com>
 <CAFEAcA8fnz2oaa-CO-EEK_vQTWfPih4PrAB3i4UUgQpv9Y_4mg@mail.gmail.com>
 <7412CDE03601674DA8197E2EBD8937E83B68019B@dggemm511-mbx.china.huawei.com>
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B68019B@dggemm511-mbx.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 17:00:46 +0000
Message-ID: <CAFEAcA-q4t3yQcHaHzOGx2GpKpuW=kti51myuFK_K3aieRY3dg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 08:08, Chenqun (kuhn) <kuhn.chenqun@huawei.com> wrote:
>
> >-----Original Message-----
> >From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >>
> >> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c index
> >> 6a124a154a..322cbdcc17 100644
> >> --- a/hw/net/imx_fec.c
> >> +++ b/hw/net/imx_fec.c
> >> @@ -855,13 +855,15 @@ static void imx_enet_write(IMXFECState *s,
> >uint32_t index, uint32_t value)
> >>          break;
> >>      case ENET_TGSR:
> >>          /* implement clear timer flag */
> >> -        value = value & 0x0000000f;
> >> +        s->regs[index] ^= s->regs[index] & value;
> >> +        s->regs[index] &= 0x0000000f;
> >>          break;
> >>      case ENET_TCSR0:
> >>      case ENET_TCSR1:
> >>      case ENET_TCSR2:
> >>      case ENET_TCSR3:
> >> -        value = value & 0x000000fd;
> >> +        s->regs[index] = (value & 0x00000080) ? (0x0000007d & value) :
> >> +                         (value & 0x000000fd);
> >>          break;
> >>      case ENET_TCCR0:
> >>      case ENET_TCCR1:
> >
> >This isn't the usual way to write W1C behaviour.
> >If all the relevant bits are W1C, as for TGSR:
> >
> >   s->regs[index] &= ~(value & 0xf); /* all bits W1C */
> >
> Yes, it looks better.
> But do we need clear the reserved bit (31 - 4 bits) explicitly ?

Not necessarily, but it seems to be how the other registers
in the device have generally been coded, and it's clearly
what the intent was here given that the original (buggy)
code was masking out reserved bits. So I think it makes
sense to continue in that style.

thanks
-- PMM


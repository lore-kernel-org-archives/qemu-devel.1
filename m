Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E3D223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAzur0CU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E3D223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzJp-0004k0-W8
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWzGX-0002AA-FZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:58:14 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWzGR-0003Vf-96
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:58:12 -0400
Received: by mail-ej1-x642.google.com with SMTP id ce10so12481743ejc.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jT576pj8dcq2AGmBURRfGB5czAu36RJjkknOlj+UOhA=;
 b=GAzur0CUJ8KwQvsK/JTz6FxETJqatHiqmIoAMKq3pmXHqpKBEiVz6l2B4zo16bcM5V
 +KGsF2msI5q5IKQaUNFgqcNc6dioLQAHPs3kbLtlie8WOSTuWypV4WKWgrT1oUa3aB7/
 ApwLRXWznS7XC+DZ68pcq4qnVF+YhWif2/1tLGnyXQg96gZrplJ3GvXVJhWjoV2SXwxH
 PFPoWsZHTsDjz6oEF9foycuowC8UbKBzBq782NDBkz+dZZjoeoNZfWFCutbW2erxrceP
 bzHatETGmS7sUiATZawUovFhkdsShF7r2b1rxdoDupr5kVycu+T0z1kq1MA73r3CMgnH
 xFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jT576pj8dcq2AGmBURRfGB5czAu36RJjkknOlj+UOhA=;
 b=BSZTx5UWeVv8P0ARKooMNKq5Q80lFmSpTXTb2JKrEqJExUp1Ig24zRtN8UQJ/YsGbP
 sguO3e4HLvIsel9BP+6ZqYz/Lr+jssthwAF5QMmEm158w6Kq4zBmSIUgzoH5Z2SEjBg3
 z0nAUM4Vc8mMhbQ4wG56aOLr5DfUvOVhHXQUv2YL1zbOWPm/VaUv51T+e08CFbjgFH/K
 PXEe+8YoXMU6GYcWDzUgqR61GmxUfJH5KtImm1QEJEOidvwyN9fTPfYOpr07P05guBic
 pIY6W+n6OEvRwmvTVa3pGMLW9nadKZ45frwpuq0cgyr2cGx+OGjQgm4OgHrpFScwK2PP
 PrWQ==
X-Gm-Message-State: AOAM531eAdl7W1WstD1aQP0VIZVnLwyUGxjoDrXDuG9s/vis10IM1ld0
 HvM3BYsAAxKMzO7QRSIAm9iJLTfxJLXH4CWZTCvsGQ==
X-Google-Smtp-Source: ABdhPJywabhM8yjFxrv/3cI3Fl0q/OtHCcq6FGX/k6HXsW6SH/L6sEGPzt2MZrd7RirCayyqKC/PjoTo10M2stuYzOo=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr14849253ejd.250.1603706284274; 
 Mon, 26 Oct 2020 02:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201023071022.24916-1-kraxel@redhat.com>
 <CAFEAcA-gEeHUJtuF9CX4XhXh6dnANNut-TJWz0nM8obAmMa3yA@mail.gmail.com>
 <20201026070117.5ovcm4ep6iohjyfh@sirius.home.kraxel.org>
In-Reply-To: <20201026070117.5ovcm4ep6iohjyfh@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 09:57:52 +0000
Message-ID: <CAFEAcA8vWzGQ3SG8bHzYwitqOat7fx71Kqs8tPQ8ZV6uWLHKXQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm/virt: add usb support
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 07:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Fri, Oct 23, 2020 at 12:36:05PM +0100, Peter Maydell wrote:
> > On Fri, 23 Oct 2020 at 08:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Bring new microvm goodies to arm virt too.  Wire up
> > > -machine usb=on, add sysbus-xhci in case it is enabled.
> >
> > So my question here is the usual one -- why can't we
> > just use a PCI USB controller ?
>
> Well, pci seems to come with some extra resource needs (see -M pc vs.
> -M q35 memory footprint differences discussed some months ago).  Thats
> why microvm started without pci support, and even now with pcie support
> added it is optional (and off by default).

I think PCI is too useful to discard. You can run anything
you want (practically) via PCI. If we make it optional then
we're going to give ourselves the task of reimplementing
memory mapped versions of all the functionality it gives us,
all of which is extra code and all of which adds to the
amount of stuff on the guest-to-QEMU security boundary.

I think to be persuaded that no-PCI was a good idea I'd
want to at least see solid figures based on doing this
for Arm and on having put a lot of effort into slimming
down the PCI handling code/overhead in the guest and still
not being able to get near an MMIO setup. That is, try the
"improve the guest" approach first.

thanks
-- PMM


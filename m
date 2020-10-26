Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349CFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35E922263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpMEIcoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35E922263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3iw-0003Jm-CJ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3YY-0005zp-AA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:33:07 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX3YW-0008IF-3t
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:33:05 -0400
Received: by mail-ej1-x644.google.com with SMTP id c15so13926476ejs.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uncv4OImQJQZbkjp9IT86wTIL1wthCu8fzrRY3mxxrs=;
 b=jpMEIcoaWp4muwFgbwl1lO1mXLUyRBqy9TuUylteqjmoKnJ+jZJoMyv1PqH0ATj4uD
 M87/5rWZsnL1CJ2d/71pvOjBlopswuUuruV1snR3AXKMoAaUKGRkrzMXELxx/7w0Hm/v
 iZBw2PnbSsPEIZUmQfxDh41KBoONOe6DhXBuRm2TN82ub4pdlwE/mnt2kGNEOPgQisua
 HXH45nQxlEqzaKYA79qDiwa/8f4sLlRNPTgINU0GmgqvPu4QLTEd77wDCyekv19BwmmX
 qC7ETYPnVDyeQhfKK8gm91alVbllmLWMdOj5rnnIFqvjwO+mVBgswoMEAiVrTZDx8Xii
 GF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uncv4OImQJQZbkjp9IT86wTIL1wthCu8fzrRY3mxxrs=;
 b=hQWDVXrKgWQDreqAV+BnIPBIfhUxMB0NlKID5Bqb9DD0CG+cqE36HtuGWxsaei+sK1
 ToyH75PwVygZqio8+WvR3EU1r//Evu3V22WbC0kPEp8+PapI9Pk4z4rI6t/TU3BkOnjK
 GTnJati6aLXFZ8CjjICRtddQpAFng7+z3z80WvyaLTN6ml1LqkSnLT587h/Vli/MXLCg
 Fboylr21ezixDp+f7xuv7LFe2PcdbW3trJG1BeKS9Pv5U/fjpfGeAvxLNByYKzC+KBTQ
 n0zyuE7lqYQ8sP+n9MDdrpEHymPt6r1/CsHKrDsFfDU8aBvyKUofJ5R83j2pNMJeGitm
 Wjkg==
X-Gm-Message-State: AOAM5312VcLx2WSs+z8j13mw2g3c7RpngaDWwDhBRz7bn8bEak/Llk8r
 RhKDhH1+PmslBFM/3Ps3bxB1QPlXCwxwL1pSxldoug==
X-Google-Smtp-Source: ABdhPJwSmA3xPZbAZ0TvXFvCnnGcZK8ygBd7tg44LKX3HO2yrNZSbq9JL7BT2JmD14IqiU94wBnS2p7Z2z4nIr9OScI=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr15912929ejb.482.1603722782244; 
 Mon, 26 Oct 2020 07:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
 <CAFEAcA9n3T5MrBp2RbOQGWBptV5ObCssF00ygK8TDieP+V1Srg@mail.gmail.com>
 <a6065386-a844-9d06-21ca-57baa98c8caf@oracle.com>
In-Reply-To: <a6065386-a844-9d06-21ca-57baa98c8caf@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 14:32:48 +0000
Message-ID: <CAFEAcA_LtW+B3EOye9STciNR+JKsh8HKQ=ecy=W+Ey-SZDSUFg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add support for pvpanic mmio device
To: Mihai Carabas <mihai.carabas@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 13:51, Mihai Carabas <mihai.carabas@oracle.com> wrote:
> On 10/22/2020 1:17 PM, Peter Maydell wrote:
> > I'm afraid the answer is still the same. You need to provide
> > a convincing argument for why this needs to be an MMIO
> > device rather than a PCI device. I really don't want to
> > add MMIO devices to the virt board if I can avoid it,
> > because they're all extra code and potential extra
> > security boundary attack surface. PCI devices are guest
> > probeable and user-pluggable so they're almost always
> > nicer to use than MMIO.
> >
>
> Thank you for your input.
>
> The reason why pvpanic should be MMIO is that is a special device which
> is not used commonly by the user (aka VM), it is not need to be
> hot-plugable and it does not have a hardware correspondent to be a PCI
> device.

"Not used commonly by the user" is a good argument for
"just use PCI" -- users who want the functionality can add
it to their QEMU command line or VM config, and the bulk of
users who don't don't have to worry about it.

PCI devices don't have to support hotplug; I agree you don't
need hotplug for this use case.

Using a PCI device would match up with the way the x86 pvpanic
device is an ISA bus device.

> Another reason is that MMIO support was accepted in the kernel
> driver and it is pretty useless there without a device.

> I know it seems that I want to get this on the short-path, but at this
> point having a kernel driver in the upstream and no device to test it
> against it is pretty weird.

That's the kernel folks' problem to deal with, because they accepted
the kernel driver without having confirmed that QEMU was going to
implement it. If I were them I'd deprecate and delete that driver code.
(They should certainly fix the bit of the documentation that claims
that QEMU implements it.)

thanks
-- PMM


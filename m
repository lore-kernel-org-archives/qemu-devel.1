Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7565BC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409FE2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bk605mYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409FE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzSq-0003u3-BZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzDy-0002vb-H8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:14:30 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:34131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzDw-0006z8-Vr
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:14:30 -0400
Received: by mail-oi1-x22b.google.com with SMTP id e4so11110154oib.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TkmNh43NVj3WoGJiiu5k0+TZepufATIpLLYtyyvfeCA=;
 b=bk605mYyvKAA845UqY6TeMb9Hh/sg3og69Pf6mnbfpE6BaeqYgiriMacoxWMF3arFj
 zjpZvJyB7PNSZ3/yPghNn5khUMoLTquU1P6BolL77UVBLvjFHVN8C4ex3WcbV3oB0ffL
 6HJ3pXh0cDTlbcyR3kIE0suyDI/OJHr4Tn9cXAi9nN7Hon8ArP33LnYIXtFReUMvIJGC
 ojU2n6FEnSrW8keObRKUUcfessKc6dcUgHSyOAqydvXuxTP5xtxMq0eRkCPpOOJKUNTQ
 eGLCaNAz9LP76UeS3mhk+Ib3oKdCbRutheLCmmUYv2r6q3XW9DE+ZJ3BIhspt3RYZcdB
 sLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TkmNh43NVj3WoGJiiu5k0+TZepufATIpLLYtyyvfeCA=;
 b=l/NjfZCjdHP7Yxmzb5hYyT7msxNGU3hsvK8iOf5F4L501poHlACOBK77NbakR+2ser
 7HJcYR61CwRGM9OgLqgdfVxh8X7O5g0LfYmsiBcppL0fZKX68AEt26GZJJFHp0f8EJF4
 185VzEeo5rDNiX/9s9jSDf4MCnclY7E40T90aWcaLkChAQ9MoXgrviQL97KCbvHhrtsK
 hhO/mvthkZwu5d0CwkCRV1tAj8LLAnvTOSmVPsSpFN43CAcXhZiaHkQ2M7aHcYiAenht
 raTASBhDSymAYR2jou/NmotTlqADswDBWvgDygShwZhjm+5SWV1F7Nypcx1qE1Iezqee
 BrNQ==
X-Gm-Message-State: AOAM530hLI4UTN1LIXiPxeVx6ay97EpMe/2HOr7q60kWawvuxJficLXn
 LmUjWVGurPZE3nrQzZUkzLFhyji0/o1aNbz1itWC+g==
X-Google-Smtp-Source: ABdhPJwVceFp+jDRDqXs1b/MRBaRgaqxBSor6Bmbpl49whTxjh/RPSFkWPmH0OOW/SPy4hF0VvmlJviOqSHXGUTiGl8=
X-Received: by 2002:aca:2819:: with SMTP id 25mr88788oix.48.1594649667728;
 Mon, 13 Jul 2020 07:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200713141049.2241-1-kraxel@redhat.com>
 <20200713141049.2241-3-kraxel@redhat.com>
In-Reply-To: <20200713141049.2241-3-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 15:14:16 +0100
Message-ID: <CAFEAcA_dBoVh+OYThkJvBPqDs+PY1kAXv1EWZs5B7w9F1yW9Yw@mail.gmail.com>
Subject: Re: [PULL 2/4] docs/qdev-device-use: Clean up the sentences related
 to -usbdevice
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 15:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Most of the -usbdevice paramaters have been removed already. Update
> the doc accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-id: 20200710065520.24784-1-thuth@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/qdev-device-use.txt | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Side note: ideally we should roll this info into the
proper docs/system manual at some point...

thanks
-- PMM


Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F0FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ECE20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzCxMPIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ECE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jab1T-0004zV-5j
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jab0a-0003oO-Th
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:20:24 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jab0Z-0002rj-CB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:20:24 -0400
Received: by mail-lj1-x243.google.com with SMTP id g4so8841732ljl.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cWBQhzz5kxNoR9BFp0TP6Ch5JEPPhK+boe7luhQX8WE=;
 b=lzCxMPImw8Rt7qwkKQvXvs4yHXPUCBcSFgZgVKQ1O//DYIZLFdU0vSKui/Goai4MKT
 xzGOdXpFC6fBYraQ5/bglOKFm4zvdR+GQlFCVvUpk2HQXfwDAcFh1u70fVOJ6VXLasU+
 yjC4ArpFTAt05MznUJpxxFnr4qaGbzevmpirg+pnHZQf3hyxYA50KaYPvFy8M4Ix9Vsw
 7CmNiCNqtZExlHmmBkup0WtdyjuF+RwTNb9qxejk1O74cyIWT47Mx0yUrBpBhB0w0N/p
 7DpB2eYveOkZ4EyHcs+xZJHU8763ij0ME6GnBRSzZ8iCJ3Xg9989Oe0v34IPE6J4mp6U
 wGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cWBQhzz5kxNoR9BFp0TP6Ch5JEPPhK+boe7luhQX8WE=;
 b=f0AkH8AFI6+i8e9IPdtZ9nlXLj6FUMGUfIg3MBVRQckR/S51WjX+YgAUTf8LeAM+3n
 qDVK3ycDZypuBfJpyfY8RZLiqJDFuHmNhqSS+VreE3Wnx3MF5H9EkmdycNU96STGZ+RB
 5M7SiQ0kTKx0woVXBH6N8rfjIv43w7f65lAxHMXPuio4TI1dVwl3lmsFIH9z26SpjPVW
 Ucc6J86d8oBKUmqbK0By0woqoOt60Pfha5WYGPAAxj3TPC6lcefSlzJrcanNH1NK2ZV9
 VOqcdXKh6H7ipEMr2HB75b5ji6KND32Xy1bfNTSSQ6EkabQpCsgCUqIJuTbLRcD46WUn
 WJeA==
X-Gm-Message-State: AOAM531tGayCINy2Cdu8TuJKjPMm+sbWO4f5ZtJ7NHvCRJ8ol52JkRUW
 IQQHaKEMFsaFGLphNguDDdNdkkyWtsHqdcgxPmwRRg==
X-Google-Smtp-Source: ABdhPJy23lR0seQjYixD1vitkrbudfUoFZ0cFs0uEBn+vezhL4JCCG9kC3sBTizi/2x2WCOoPPUTf8nffzPSq1nM6JE=
X-Received: by 2002:a2e:a209:: with SMTP id h9mr10157090ljm.39.1589790021698; 
 Mon, 18 May 2020 01:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
 <20200511145257.22970-4-geert+renesas@glider.be>
In-Reply-To: <20200511145257.22970-4-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 May 2020 10:20:10 +0200
Message-ID: <CACRpkdaqSQ4++mhR03pqi0i=uhSyf51WhtE5VOobGNEcMmf09g@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] gpiolib: Add support for GPIO lookup by line name
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=linus.walleij@linaro.org; helo=mail-lj1-x243.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 4:53 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently a GPIO lookup table can only refer to a specific GPIO by a
> tuple, consisting of a GPIO controller label and a GPIO offset inside
> the controller.
>
> However, a GPIO may also carry a line name, defined by DT or ACPI.
> If present, the line name is the most use-centric way to refer to a
> GPIO.  Hence add support for looking up GPIOs by line name.
> Note that there is no guarantee that GPIO line names are globally
> unique, so this will use the first match found.
>
> Implement this by reusing the existing gpiod_lookup infrastructure.
> Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
> that this field can have two meanings, and update the kerneldoc and
> GPIO_LOOKUP*() macros.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v7:
>   - Document non-uniqueness of line names,
>   - Rebase on top of commit a0b66a73785ccc8f ("gpio: Rename variable in

This is likely the most controversial patch of this series but since
noone seems to be especially upset, I think I just accept this
heuristic.

It is pretty clearly cut I think, and fits very well with the
aggregator use case, which is an important one.

Yours,
Linus Walleij

